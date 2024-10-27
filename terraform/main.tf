terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "iac_dataset_1"
  friendly_name = "IaC Dataset 1"
  description   = "Dataset created by IaC, it is the first one, assuming there might be more. It will remain here for a while as a test of the IaC, a walking skeleton."
  location      = var.location
  project       = var.project_id

  labels = {
    env      = "dev"
    tutorial = true
  }
}
