resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "gangybas:${file(var.public_key_path)}"
  }

  #  connection {
  #    type        = "ssh"
  #    user        = "gangybas"
  #    agent       = false
  #    private_key = "${file(var.ssh_connections)}"
  #  }

  #   provisioner "file" {
  #    content     = "${data.template_file.init-db.rendered}"
  #    destination = "/tmp/puma.service"
  #  }

  #  provisioner "remote-exec" {
  #    script = "../modules/app/files//deploy.sh"
  #  }
}

resource "null_resource" "null_instance" {
  count = "${var.provisions ? 1:0}"

  connection {
    host        = "${element(google_compute_instance.app.*.network_interface.0.access_config.0.assigned_nat_ip, 0)}"
    type        = "ssh"
    user        = "gangybas"
    agent       = false
    private_key = "${file(var.ssh_connections)}"
  }

  provisioner "file" {
    content     = "${data.template_file.init-db.rendered}"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "../modules/app/files//deploy.sh"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

data "template_file" "init-db" {
  template = "${file("../modules/app/files//puma.service.tpl")}"

  vars {
    ip_db = "${var.ip_db}"
  }
}
