locals {
  web = [
    for vm in yandex_compute_instance.web: {name = vm.name, id = vm.id, fqdn = vm.fqdn }
  ]
}

locals {
  db = [
    for vm in yandex_compute_instance.db: {name = vm.name, id = vm.id, fqdn = vm.fqdn }
  ]
}