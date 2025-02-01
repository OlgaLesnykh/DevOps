terraform {
  backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    shared_config_files = ["~/.aws/config"]
    profile = "default"
    region= "ru-central1"

    bucket     = "lesnykh-bucket"
    key = "production/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  endpoints ={
    dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gnmn6d1boubivf2i66/etnv2i5hsdbe0l09l8cv"
    s3 = "https://storage.yandexcloud.net"
  }

    dynamodb_table              = "lesnykh"
  }
  required_providers {
    template = {
      source  = "hashicorp/template"
      version = "~> 2"
    }
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.134.0"
    }
  }
  required_version = ">1.8.4"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  #service_account_key_file = file("~/.authorized_key.json")
  zone      = var.zone
}