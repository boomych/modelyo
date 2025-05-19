output "controller_ip" {
  value = google_compute_instance.controller.network_interface[0].access_config[0].nat_ip
}

output "compute_ips" {
  description = "External IPs of all compute instances"
  value = tolist([
    for instance in google_compute_instance.compute : instance.network_interface[0].access_config[0].nat_ip
  ])
}
