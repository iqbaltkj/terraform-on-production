resource "google_compute_disk" "root_disk" {
  project = "ifr-project"
  name  = "ifr-instance-root-disk"
  image = "ubuntu-22-04"
  size  = 100
  type  = "pd-ssd"
  zone  = "asia-southeast-1"
}