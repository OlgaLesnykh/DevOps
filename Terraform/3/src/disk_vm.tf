resource "yandex_compute_disk" "disk" {
  count      = var.disk_count
  name       = "disk-${count.index+1}"
  type       = var.disk_type
  size       = var.disk_size
}

data "yandex_compute_image" "storage_OS" {
  family = var.vm_storage_image_family
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage_resources.storage_name
  platform_id = var.storage_resources.storage_platform_id
  resources {
    cores         = var.storage_resources.cores
    memory        = var.storage_resources.memory
    core_fraction = var.storage_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.storage_OS.image_id
    }
  }
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
      disk_id     = secondary_disk.value.id
    }
  }

  scheduling_policy {
    preemptible = var.storage_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.storage_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}