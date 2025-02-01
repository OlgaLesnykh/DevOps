###cloud vars

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
  default     = [false, false]
}
variable "project" {
  type        = list(string)
  default     = ["marketing", "analytics"]
  description = "Project labels"
}
variable "security_group_ids" {
  type        = string
  default     = "enp5lbojnj5j1g9a9dam"
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