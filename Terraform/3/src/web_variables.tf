###resource vars

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_resources" {
  type = object({
    vm_name = string
    vm_platform_id = string
    cores  = number
    memory  = number
    core_fraction  = number
  })
  default = {
      vm_name="web"
      vm_platform_id = "standard-v1"
      cores = 2
      memory = 1
      core_fraction = 5
    }
  }

  variable "vm_preemptible" {
  type        = bool
  default     = true
}

variable "vm_nat" {
  type        = bool
  default     = true
}

variable "instance_count" {
  type        = number
  default     = 2
}