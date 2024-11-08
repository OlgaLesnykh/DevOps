terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
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
provider "aws" {
  region    = var.aws_region
  skip_credentials_validation = var.skip_credentials_validation
  skip_requesting_account_id  = var.skip_requesting_account_id
  skip_metadata_api_check     = var.skip_metadata_api_check
  access_key                  = var.access_key
  secret_key                  = var.secret_key
}