variable "cloud_id" { type = string }
variable "folder_id" { type = string }
variable "sa_key_file" { type = string }

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b"]
}

variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
