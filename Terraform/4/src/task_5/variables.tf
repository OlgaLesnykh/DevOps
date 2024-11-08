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
variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cluster_name" {
  type    = string
  default = "example"
  description = "cluster mysql name"
}
variable "env" {
  type        = string
  default     = "PRESTABLE"
  description = "environment"
}
variable "disk_size" {
  description = "Disk size for hosts"
  type        = number
  default     = 20
}
variable "resource_preset_id" {
  description = "Preset for hosts"
  type        = string
  default     = "s2.micro"
}
variable "db_name" {
  type    = string
  default = "test"
  description = "DB name"
}
variable "ha" {
  type        = bool
  default     = true
  description = "high availability cluster"
}
variable "db_user_name" {
  type    = string
  default = "app"
  description = "DB user name"
}
variable "db_user_password" {
  type    = string
  default = "test123ghgfhfhfghfe5673"
  description = "DB user name"
}