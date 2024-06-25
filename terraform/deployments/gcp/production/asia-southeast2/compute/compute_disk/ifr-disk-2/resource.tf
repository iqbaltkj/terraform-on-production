resource "google_compute_disk" "root_disk" {
  project = "eternal-reserve-323019"
  name  = "ifr-instance-root-disk"
  size  = 100
  type  = "pd-ssd"
  zone  = "asia-southeast2-b"
}