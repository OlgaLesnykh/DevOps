output "network_id" {
  value = module.vpc_dev.network_id
}


output "subnet_ids" {
  value = module.vpc_dev.subnet_ids[*]
}