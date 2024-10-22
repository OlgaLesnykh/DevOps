data "yandex_compute_image" "web_OS" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count = var.instance_count
  name        = "${var.vm_resources.vm_name}-${count.index+1}"
  platform_id = var.vm_resources.vm_platform_id
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.web_OS.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}