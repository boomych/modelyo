terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.35.0"
    }
  }
  backend "gcs" {
    bucket = "modelyo-tf-states-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
