
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable zone {
  description = "zone"
  default     = "europe-west1-b"
}
variable app_disk_image {
description = "Disk image for reddit app"
default = "reddit-app-1533720855"
}

variable ssh_connections {
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/google"
}