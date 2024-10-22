###resource vars

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "each_vm" {
  type = map(object({  vm_name=string, platform_id=string, cores=number, memory=number, core_fraction=number, vm_image_family=string, size=number, preemptible=bool, nat=bool}))
  default = {
    "vm1" = {
      vm_name = "main"
      platform_id = "standard-v1"
      cores = 2
      memory = 1
      core_fraction = 5
      vm_image_family = "ubuntu-2004-lts"
      size = 10
      preemptible = true
      nat = true
  },
    "vm2" = {
      vm_name = "replica"
      platform_id = "standard-v3"
      cores = 2
      memory = 2
      core_fraction = 20
      vm_image_family = "ubuntu-2004-lts"
      size = 15
      preemptible = true
      nat = true
    },
}
}