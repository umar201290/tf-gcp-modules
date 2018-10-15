// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
}
resource "google_compute_instance" "vminstance" {
  #depends_on    = "${module.networking.google_compute_network.vpc}"
  name         = "${var.vmname}"
  machine_type = "${var.vmsize}"
  zone         = "${var.region}-a"

  tags = ["prep"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    #network = "prep-vpc"
    subnetwork = "${var.subnetname}"
    #subnetwork = "prep-subnet"


    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

}