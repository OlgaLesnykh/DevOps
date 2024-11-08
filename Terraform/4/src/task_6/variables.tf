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
variable "aws_region" {
  type        = string
  default     = "us-east-1"
}
variable "skip_credentials_validation" {
  type        = bool
  default     = true
}
variable "skip_requesting_account_id" {
  type        = bool
  default     = true
}
variable "skip_metadata_api_check" {
  type        = bool
  default     = true
}
variable "access_key" {
  type        = string
  default     = "mock_access_key"
}
variable "secret_key" {
  type        = string
  default     = "mock_secret_key"
}
variable "length" {
  type        = number
  default     = 8
}
variable "upper" {
  type        = bool
  default     = false
}
variable "lower" {
  type        = bool
  default     = true
}
variable "numeric" {
  type        = bool
  default     = true
}
variable "special" {
  type        = bool
  default     = false
}
variable "max_size" {
  type        = number
  default     = 1073741824
}
variable "bucket_name" {
  type        = string
  default     = "bucket-lesnykh"
}