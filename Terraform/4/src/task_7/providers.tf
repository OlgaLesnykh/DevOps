terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

provider "vault" {
  address         = var.vault_address
  skip_tls_verify = var.vault_skip_tls_verify
  token           = var.vault_token
}