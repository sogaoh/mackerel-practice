provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
  version     = "~> 3.31.0"
}
