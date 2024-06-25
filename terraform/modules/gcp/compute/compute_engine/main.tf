locals {
  enable_spot_value = "${lookup(var.general, "spot", "false")}" ? "SPOT" : var.disable_spot
  automatic_restart_value = "${lookup(var.general, "spot", "false")}" ? "false" : var.enable_automatic_restart
}

data "template_file" "user_data_server" {
  template = file("startup.sh")
}

# ------------------------------------------------------------------------------
# CREATE ROOT DISK
# ------------------------------------------------------------------------------

resource "google_compute_disk" "root_disk" {
  project = var.general.project
  name  = "${lookup(var.general, "name")}-root-disk"
  image = "${lookup(var.boot_disk, "image")}"
  size  = var.boot_disk.size
  type  = var.boot_disk.type
  zone  = var.general.zone
  labels = var.labels
}

# ------------------------------------------------------------------------------
# CREATE ADDITIONAL DISK
# ------------------------------------------------------------------------------

resource "google_compute_disk" "compute_disk" {
  for_each = length(var.data_disk) > 0 ? var.data_disk : {}
  project = var.general.project
  name    = "${lookup(var.general, "name")}-${each.key}"
  size    = each.value.size
  zone    = var.general.zone
  type    = each.value.type
  labels  = var.labels
}

# ------------------------------------------------------------------------------
# CREATE GCE INSTANCE
# ------------------------------------------------------------------------------

data "google_compute_address" "static_address" {
  name    = "${lookup(var.general, "name")}-ip-public"
  # name    = "pritunl-server-1-ip-public"
  project = var.general.project
  region  = var.general.region
}

data "google_compute_subnetwork" "subnet" {
  name    = var.general.subnetwork
  project = var.general.project
  region  = var.general.region
}

resource "google_compute_instance" "compute_instance" {
  project                   = var.general.project
  name                      = "${lookup(var.general, "name")}"
  machine_type              = "${lookup(var.general, "machine_type")}"
  zone                      = var.general.zone
  deletion_protection       = var.deletion_protection

  scheduling {
    preemptible = var.general.spot
    automatic_restart = local.automatic_restart_value
    provisioning_model = local.enable_spot_value
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }

  boot_disk {
    source = google_compute_disk.root_disk.self_link
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
    dynamic "access_config" {
      for_each = var.general.ip_public == true ? [1] : []
      content {
        nat_ip = data.google_compute_address.static_address.address
      }
    }
  }

  metadata = {
    enable-guest-attributes = "True"
  }

  allow_stopping_for_update = true
  labels                    = "${var.labels}"
  
  dynamic "attached_disk" {
    for_each = var.data_disk

    content {
      source = google_compute_disk.compute_disk[attached_disk.key].self_link
    }
  }
  metadata_startup_script = data.template_file.user_data_server.rendered

  depends_on = [
    google_compute_disk.compute_disk
  ]
}