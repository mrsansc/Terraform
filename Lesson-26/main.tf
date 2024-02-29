#----------------------------------------------------------
# My Terraform
#
# Use Terraform with GCP - Google Cloud Platform
#
# Made by Sanzhar Urazaliyev
#
#-----------------------------------------------------------
//export GOOGLE_CLOUD_KEYFILE_JSON="gcp-creds.json"

provider "google" {
  credentials = file("mygcp-creds.json")
  project     = "fifth-composite-415515"
  region      = "us-west1"
  zone        = "us-west1-b"
}

resource "google_compute_instance" "blablabla" {
  name         = "my-gcp-server"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20240213"
    }
  }

  network_interface {
    network = "default"
  }
}
