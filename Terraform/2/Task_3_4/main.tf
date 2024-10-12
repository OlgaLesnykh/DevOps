resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_web" {
  name           = var.vpc_name_web
  network_id     = yandex_vpc_network.develop.id
  zone = var.default_zone
  v4_cidr_blocks = var.default_cidr-1
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  network_id     = yandex_vpc_network.develop.id
  zone = var.zone_b
  v4_cidr_blocks = var.default_cidr-2
}
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "web_platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_web.id
    nat       = var.vm_web_nat
  }
  metadata = {
    serial-port-enable = var.vm_web_serial_port_enable
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

resource "yandex_compute_instance" "db_platform" {
  name        = var.vm_db_name
  zone = var.zone_b
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_nat
  }
  metadata = {
    serial-port-enable = var.vm_db_serial_port_enable
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
