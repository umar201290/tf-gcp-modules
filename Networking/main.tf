// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
}
// Create VPC
resource "google_compute_network" "vpc" {
 name                    = "${var.vpcname}-vpc"
 auto_create_subnetworks = "false"
}

// Create Subnet
resource "google_compute_subnetwork" "subnet" {
 name          = "${var.subnetname}-subnet"
 ip_cidr_range = "${var.subnet_cidr}"
 network       = "${var.vpcname}-vpc"
 depends_on    = ["google_compute_network.vpc"]
 region      = "${var.region}"
}
