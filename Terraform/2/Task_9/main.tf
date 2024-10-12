resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop_web" {
  name           = var.vpc_name_web
  network_id     = yandex_vpc_network.develop.id
  zone = var.default_zone
  v4_cidr_blocks = var.default_cidr-1
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  network_id     = yandex_vpc_network.develop.id
  zone = var.zone_b
  v4_cidr_blocks = var.default_cidr-2
  route_table_id = yandex_vpc_route_table.rt.id
}
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "web_platform" {
  name        = local.vm_names[0].name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
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
    serial-port-enable = var.metadata["vm"].serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata["vm"].ssh-keys}"
  }
}

resource "yandex_compute_instance" "db_platform" {
  name        = local.vm_names[1].name
  zone = var.zone_b
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
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
    serial-port-enable = var.metadata["vm"].serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata["vm"].ssh-keys}"
  }
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = var.gateway_name
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = var.route_table
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}