provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  version = "1.4.0"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  ip_db           = "${module.db.db_internal_ip}"
  provisions      = "true"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source = "../modules/vpc"
}
