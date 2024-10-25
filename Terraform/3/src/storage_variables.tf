###resource vars

variable "disk_count" {
  type        = number
  default     = 3
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  type        = number
  default     = 1
}

variable "vm_storage_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "storage_resources" {
  type = object({
    storage_name = string
    storage_platform_id = string
    cores  = number
    memory  = number
    core_fraction  = number
  })
  default = {
      storage_name="storage"
      storage_platform_id = "standard-v1"
      cores = 2
      memory = 1
      core_fraction = 5
    }
  }

  variable "storage_preemptible" {
  type        = bool
  default     = true
}

variable "storage_nat" {
  type        = bool
  default     = true
}