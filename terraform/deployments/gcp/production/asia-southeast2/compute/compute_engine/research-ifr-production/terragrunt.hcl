include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../../modules/gcp/compute/compute_engine"
}

inputs = {

  general = {
    zone         = "asia-southeast2-b"
    region       = "asia-southeast2"
    project      = "eternal-reserve-323019"
    name         = "research-ifr-production"
    machine_type = "e2-medium"
    ip_public    = true
    spot         = false
    subnetwork   = "vpc-subnet-services-production"
  }

  boot_disk = {
    image       = "ubuntu-22-04"
    size        = 20
    type        = "pd-ssd"
  }

  data_disk = {
    "class-balanced" = {
      size    = 20
      type    = "pd-balanced"
      zone    = "asia-southeast2-b"
    }
    // "class-ssd" = {
    //   size    = 100
    //   type    = "pd-ssd"
    //   zone    = "asia-southeast1-b"
    // }
  }

  labels = {
    country       = "id"
    region        = "asia-southeast2"
    zone          = "asia-southeast2-b"
    environment   = "production"
    team          = "platform"
    type          = "server"
    component     = "research"
    lifecycle     = "standard"
  }
}