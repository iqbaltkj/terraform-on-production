// include "root" {
//   path = find_in_parent_folders()
// }

terraform {
    source = "../../../../../../modules/gcp/compute/compute_engine"
}

inputs = {

  general = {
    project      = "efishery-infra-production"
    name         = "nfs-server-production"
    machine_type = "e2-highcpu-4"
    ip_public    = "false"
    spot         = false
    subnetwork   = "ase1-infra-production-gce"
  }

  boot_disk = {
    image       = "ubuntu-22-04"
    size        = 20
    type        = "pd-ssd"
  }

  data_disk = {
    "class-balanced" = {
      size    = 200
      type    = "pd-balanced"
      zone    = "asia-southeast1-b"
    }
    // "class-ssd" = {
    //   size    = 100
    //   type    = "pd-ssd"
    //   zone    = "asia-southeast1-b"
    // }
  }

  snapshot_schedule = {
    name              = "daily-bu005-production"
    snapshot_disk     = "all"              # all (root & additional) & additional. Default value is additional.
  }

  labels = {
    country           = "id"
    region            = "asia-southeast1"
    zone              = "asia-southeast1-b"
    environment       = "production"
    business_unit     = "bu005"
    team              = "platform--infra"
    type              = "server"
    component         = "data"
    lifecycle         = "standard"
    instance_type     = "e2-highcpu-4"
  }
}