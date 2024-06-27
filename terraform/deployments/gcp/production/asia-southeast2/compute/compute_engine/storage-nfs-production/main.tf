terraform {

#   source = "../../../../../../modules/gcp/compute/compute_engine"
}

provider "google" {
  project = "eternal-reserve-323019"
  region  = "asia-southeast2"
}

module "compute_engine" {
  source = "../../../../../../../modules/gcp/compute/compute_engine"

  general = {
    zone         = "asia-southeast2-b"
    region       = "asia-southeast2"
    project      = "eternal-reserve-323019"
    name         = "storage-nfs-production"
    machine_type = "e2-medium"
    ip_public    = true
    spot         = false
    subnetwork   = "vpc-subnet-services-production"
  }

  boot_disk = {
    image = "ubuntu-2204-lts"
    size  = 20
    type  = "pd-ssd"
  }

  data_disk = {
    "class-balanced" = {
      size = 200
      type = "pd-balanced"
      zone = "asia-southeast2-b"
    }
    // "class-ssd" = {
    //   size = 100
    //   type = "pd-ssd"
    //   zone = "asia-southeast1-b"
    // }
  }

  labels = {
    country       = "id"
    region        = "asia-southeast2"
    zone          = "asia-southeast2-b"
    environment   = "production"
    team          = "platform"
    type          = "server"
    component     = "data"
    lifecycle     = "standard"
  }
}
