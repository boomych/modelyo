data "google_compute_image" "ubuntu_image" {
  family  = var.os_image.family
  project = var.os_image.project
}
