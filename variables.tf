variable "default" {
  type    = string
  default = "default"
}

variable "location" {
  type = string
}

variable "vm_count" {
  default = 1
}

variable "subnet_counter" {
  default = 1
}


variable "admin_username" {
  type = string
}

variable "rg_tag" {
  type = string
}


variable "rgname" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "storage_image_reference" { default = [] }


variable "local_public_ssh_key" {
  type = string
}


variable "public_ssh_key_path" {
  type = string
}

variable "storage_os_disk" { default = [] }



variable "virtual_network_name" {
  type = string
}


