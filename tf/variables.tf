variable "project_id" {
  type        = string
  default     = "promising-flash-460213-k1"
  description = "GCP project name"
}

variable "region" {
  default     = "me-west1"
  description = "Default gcp compute region"
}

variable "zone" {
  default     = "me-west1-a"
  description = "Default gcp compute zone"
}

variable "env_name" {
  default     = "dev"
  description = "Default environment"
}

variable "controller_type" {
  type = object({
    instance_type = string
    instance_size = number
  })
  default = {
    instance_type = "e2-medium"
    instance_size = 20
  }

  validation {
    condition     = contains(["e2-medium", "e2-standard-4"], var.controller_type.instance_type)
    error_message = "“Only e2-medium and e2-standard-4 instances are supported."
  }
  description = "Default instance type for Controller VM"
}

variable "compute_type" {
  type = object({
    instance_type = string
    # instance size for VM
    instance_size = number
    # number of Compute VM instances
    instance_count = number
  })
  default = {
    instance_type  = "e2-medium"
    instance_size  = 20
    instance_count = 1
  }

  validation {
    condition     = contains(["e2-medium", "e2-standard-4"], var.compute_type.instance_type)
    error_message = "“Only e2-medium and e2-standard-4 instances are supported."
  }
  description = "Default instance type for Compute VM"
}

variable "firewall_ports" {
  default = ["22", "80", "5000-5999"]
}

variable "source_ranges" {
  default = ["0.0.0.0/0"]
}

variable "os_image" {
  type = object({
    project = string
    family  = string
  })
  default = {
    project = "ubuntu-os-cloud"
    family  = "ubuntu-2204-lts"
  }
  description = "Image to be used in as guest OS for gcp VM"
}
