output "network_id" {
  value = yandex_vpc_network.develop.id
}
output "subnet_id" {
  value = zipmap([for i, v in yandex_vpc_subnet.develop_subnet : v.name], [for i, v in yandex_vpc_subnet.develop_subnet : yandex_vpc_subnet.develop_subnet[v.name].id])
}

output "subnet_ids" {
  value = [for i, v in yandex_vpc_subnet.develop_subnet : yandex_vpc_subnet.develop_subnet[v.name].id]
}