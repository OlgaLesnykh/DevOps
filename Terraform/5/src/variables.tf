###cloud vars

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
variable "vpc_env_name" {
  type        = string
  default     = "develop"
  description = "VPC subnet name"
}
variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "vpc_subnet_name" {
  type        = list(string)
  default     = ["develop-ru-central1-a", "develop-ru-central1-b"]
  description = "VPC subnet name"
}
variable "remote_state_path" {
  type        = string
  default     = "./task_8/terraform.tfstate"
}
variable "shared_credentials_files" {
  type        = list(string)
  default     = ["/home/lesnykh/.aws/credentials"]
}
variable "shared_config_files" {
  type        = list(string)
  default     = ["/home/lesnykh/.aws/config"]
}
variable "profile" {
  type        = string
  default     = "default"
}


###resource vars

variable "env_name" {
  type        = list(string)
  default     = ["develop", "stage"]
  description = "VPC subnet name"
}
variable "instance_name" {
  type        = list(string)
  default     = ["webs", "web-stage"]
  description = "VPC subnet name"
}
variable "instance_count" {
  type        = list(number)
  default     = [1, 1]
  description = "VPC subnet name"
}
variable "image_family" {
  type        = string
  default     = "centos-7"
}
variable "public_ip" {
  type        = list(bool)
  default     = [true, true]
}
variable "project" {
  type        = list(string)
  default     = ["marketing", "analytics"]
  description = "Project labels"
}

###metadata vars

variable username {
  type = string
}

variable ssh_public_key {
  type = string
  description = "Location of SSH public key."
}

variable packages {
  type    = list
  default = []
}