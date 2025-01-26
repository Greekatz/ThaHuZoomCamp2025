terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  project = "extreme-pixel-449005-n1"
  region  = "us-central1"
}


resource "google_storage_bucket" "auto-expire" {
  name          = "extreme-pixel-449005-n1-terra-bucket"
  location      = "US"
  force_destroy = true

  

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}