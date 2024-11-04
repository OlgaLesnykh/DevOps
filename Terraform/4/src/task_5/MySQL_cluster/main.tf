terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}
module "vpc_dev" {
  source       = "/home/lesnykh/DevOps/Terraform/4/src/VPC"
}
resource "yandex_mdb_mysql_cluster" "example" {
  name                = var.cluster_name
  environment         = var.env
  network_id          = "${module.vpc_dev.network_id}"
  version             = var.mysql_version
  
  resources {
    disk_size          = var.disk_size
    disk_type_id       = var.disk_type
    resource_preset_id = var.resource_preset_id
  }

  dynamic "host" {
    for_each = (var.ha ? range(var.count_ha) : [1])
    content {
      zone             = element(var.subnet_zones, host.key)
      subnet_id        = element(local.subnet_ids, host.key)
      name             = "${var.cluster_name}-db-host-${host.key + 1}"
      priority         = host.key * 10
      assign_public_ip = var.assign_public_ip
      backup_priority  = host.key
}
  }
}
locals {
  subnet_ids = module.vpc_dev.subnet_ids
}