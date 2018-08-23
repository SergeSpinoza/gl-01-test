variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable ssh_connections {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-1533720855"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-1533721204"
}


variable provisions {
  description = "enter true or false"
  default = "false"
}