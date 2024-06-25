output "gce_instances" {
  value = "${google_compute_instance.compute_instance.*.network_interface.0.network_ip}"
}

output "disk_ids" {
  value = { for name, disk in google_compute_disk.compute_disk : name => disk.id }
}