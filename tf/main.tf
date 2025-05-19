
resource "google_compute_network" "vpc" {
  name = "${var.env_name}-openstack-vpc"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.env_name}-openstack-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow-ssh-http-openstack" {
  name    = "allow-ssh-http-openstack"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = var.firewall_ports
  }

  source_ranges = var.source_ranges
}

resource "google_compute_instance" "controller" {
  name         = "${var.env_name}-openstack-controller"
  machine_type = var.controller_type.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.name
      size  = var.controller_type.instance_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }

  tags = ["openstack", "${var.env_name}"]
}

resource "google_compute_instance" "compute" {
  count = var.compute_type.instance_count

  name         = "${var.env_name}-openstack-compute-${count.index}"
  machine_type = var.compute_type.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.name
      size  = var.compute_type.instance_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }

  tags = ["openstack", "${var.env_name}"]
}
