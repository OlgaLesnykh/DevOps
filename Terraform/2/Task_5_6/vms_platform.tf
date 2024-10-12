###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr-1" {
  type        = list(string)
  default     = ["10.1.0.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr-2" {
  type        = list(string)
  default     = ["10.2.0.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "vpc_name_web" {
  type        = string
  default     = "develop_web"
  description = "VPC subnet name"
}

variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC subnet name"
}

variable "project_owner" {
  type        = string
  default     = "lesnykh"
  description = "Project owner name"
}


###ssh vars

/*variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfmIk9pLPprAdDxEHXwCQ9+Qv7jYChLUTHrjOtbWUTk lesnykh@debian"
  description = "ssh-keygen -t ed25519"
}*/

###resource vars

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

/*variable "vm_web_cores" {
  type        = number
  default     = 2
}

variable "vm_web_memory" {
  type        = number
  default     = 1
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
}*/

variable "vm_web_preemptible" {
  type        = bool
  default     = true
}

variable "vm_web_nat" {
  type        = bool
  default     = true
}

/*variable "vm_web_serial_port_enable" {
  type        = number
  default     = 1
}*/


variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
}

/*variable "vm_db_cores" {
  type        = number
  default     = 2
}

variable "vm_db_memory" {
  type        = number
  default     = 2
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
}*/

variable "vm_db_preemptible" {
  type        = bool
  default     = true
}

variable "vm_db_nat" {
  type        = bool
  default     = true
}

/*variable "vm_db_serial_port_enable" {
  type        = number
  default     = 1
}*/


variable "vms_resources" {
  type = map(object({
    cores  = number
    memory  = number
    core_fraction  = number
  }))
  default = {
    "web" = {
      cores = 2
      memory = 1
      core_fraction = 5
    },
    "db" = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
  }
}

variable "metadata" {
  type = map(object({
    serial-port-enable  = number
    ssh-keys  = string
  }))
  default = {
    "vm" = {
      serial-port-enable  = 1
      ssh-keys  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfmIk9pLPprAdDxEHXwCQ9+Qv7jYChLUTHrjOtbWUTk lesnykh@debian"
    }
  }
}