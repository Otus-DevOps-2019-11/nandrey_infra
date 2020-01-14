terraform {
  required_version = "0.12.18"
}

provider "google" {
  version = "2.15"
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app", "balance-me"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "rootbe"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  metadata = {
    ssh-keys = "rootbe:${file(var.public_key_path)}"
  }

  network_interface {
    network = "default"
    access_config {}
  }
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

resource "google_compute_project_metadata_item" "default" {
  key = "ssh-keys"
  value = <<EOF
  appuser1:${file(var.public_key_path)}
  appuser2:${file(var.public_key_path)}
  appuser3:${file(var.public_key_path)}
  EOF
}
