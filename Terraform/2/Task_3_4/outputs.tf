output "my_output" {
  value = [
    { web = [yandex_compute_instance.web_platform.name, yandex_compute_instance.web_platform.network_interface[0].ip_address, yandex_compute_instance.web_platform.fqdn] },
    { db = [yandex_compute_instance.db_platform.name, yandex_compute_instance.db_platform.network_interface[0].ip_address, yandex_compute_instance.db_platform.fqdn] },
  ]
}