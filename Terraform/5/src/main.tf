module "vpc_dev" {
  source       = "./VPC"
  env_name     = var.vpc_env_name
}

module "marketing-vm" {
  depends_on     = [module.vpc_dev]
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = var.env_name[0]
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.zone]
  subnet_ids     = [module.vpc_dev.subnet_ids[0]]
  instance_name  = var.instance_name[0]
  instance_count = var.instance_count[0]
  image_family   = var.image_family
  public_ip      = var.public_ip[0]
  security_group_ids = [var.security_group_ids]
  labels = { 
    project = var.project[0]
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  depends_on     = [module.vpc_dev]
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = var.env_name[1]
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.zone]
  subnet_ids     = [module.vpc_dev.subnet_ids[0]]
  instance_name  = var.instance_name[1]
  instance_count = var.instance_count[1]
  image_family   = var.image_family
  public_ip      = var.public_ip[1]
  security_group_ids = [var.security_group_ids]

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