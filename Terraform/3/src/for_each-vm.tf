data "yandex_compute_image" "db_OS" {
  family = var.vm_db_image_family
}
resource "yandex_compute_instance" "db" {
  for_each = var.each_vm
  name        = each.value.vm_name
  platform_id = each.value.platform_id
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.db_OS.image_id
      size = each.value.size
    }
  }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}