#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop_a" {
  name           = var.vpc_subnet_name[0]
  zone           = var.zone[0]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr_a
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_subnet_name[1]
  zone           = var.zone[1]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.cidr_b
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env_name[0]
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = var.zone
  subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
  instance_name  = var.instance_name[0]
  instance_count = var.instance_count[0]
  image_family   = var.image_family
  public_ip      = var.public_ip[0]

  labels = { 
    project = var.project[0]
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env_name[1]
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = var.zone
  subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  instance_name  = var.instance_name[1]
  instance_count = var.instance_count[1]
  image_family   = var.image_family
  public_ip      = var.public_ip[1]

  labels = { 
    project = var.project[1]
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = jsonencode(var.packages)
  }
}
