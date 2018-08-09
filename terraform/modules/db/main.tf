resource "google_compute_instance" "db" {
name = "reddit-db"
machine_type = "g1-small"
zone = "${var.zone}"
tags = ["reddit-db"]
boot_disk {
initialize_params {
image = "${var.db_disk_image}"
}
}
network_interface {
network = "default"
access_config = {}
}
metadata {
ssh-keys = "gangybas:${file(var.public_key_path)}"
}

connection {
    type        = "ssh"
    user        = "gangybas"
    agent       = false
    private_key = "${file(var.ssh_connections)}"
  }

  provisioner "file" {
    source      = "../modules/db/files//mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "../modules/db/files//db.sh"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
name = "allow-mongo-default"
network = "default"

allow {
protocol = "tcp"
ports = ["27017"]
}
source_ranges = ["0.0.0.0/0"]
target_tags = ["reddit-db"]
}