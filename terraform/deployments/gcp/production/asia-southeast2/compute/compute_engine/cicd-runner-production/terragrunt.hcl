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
    name         = "cicd-runner-production"
    machine_type = "e2-medium"
    ip_public    = true
    spot         = false
    subnetwork   = "vpc-subnet-services-production"
  }

  boot_disk = {
    image       = "ubuntu-2204-jammy-v20240614"
    size        = 50
    type        = "pd-ssd"
  }

  data_disk = {
    // "class-balanced" = {
    //   size    = 200
    //   type    = "pd-balanced"
    //   zone    = "asia-southeast2-b"
    // }
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
    component     = "cicd"
    lifecycle     = "standard"
  }
}