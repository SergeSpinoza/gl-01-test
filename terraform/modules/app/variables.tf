variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = " reddit-app-1550422365"
}

variable ssh_connections {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/google"
}

variable ip_db {
  description = "enter your ip db"
}

variable provisions {
  description = "enter true or false"
}
