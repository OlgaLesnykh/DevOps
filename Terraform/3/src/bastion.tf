data "yandex_compute_image" "bastion_OS" {
  family = var.bastion_image_family
}

resource "yandex_compute_instance" "bastion" {
  name        = var.bastion_resources.bastion_name
  platform_id = var.bastion_resources.bastion_platform_id
  resources {
    cores         = var.bastion_resources.cores
    memory        = var.bastion_resources.memory
    core_fraction = var.bastion_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.bastion_OS.image_id
    }
  }

  scheduling_policy {
    preemptible = var.bastion_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.bastion_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

variable "bastion_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "bastion_resources" {
  type = object({
    bastion_name = string
    bastion_platform_id = string
    cores  = number
    memory  = number
    core_fraction  = number
  })
  default = {
      bastion_name="bastion"
      bastion_platform_id = "standard-v1"
      cores = 2
      memory = 1
      core_fraction = 5
    }
  }

  variable "bastion_preemptible" {
  type        = bool
  default     = true
}

variable "bastion_nat" {
  type        = bool
  default     = true
}