variable "cluster_name" {
  type    = string
  description = "cluster mysql name"
  default = "example"
}
variable "env" {
  type        = string
  default     = "PRESTABLE"
  description = "environment"
}
variable "mysql_version" {
  type        = string
  default     = "8.0"
  description = "mysql version"
}
variable "disk_size" {
  description = "Disk size for hosts"
  type        = number
  default     = 20
}
variable "disk_type" {
  description = "Disk type for hosts"
  type        = string
  default     = "network-ssd"
}
variable "resource_preset_id" {
  description = "Preset for hosts"
  type        = string
  default     = "s2.micro"
}
variable "ha" {
  type        = bool
  default     = true
  description = "high availability cluster"
}
variable "count_ha" {
  type        = number
  default     = 2
  description = "Number of hosts in a high availability cluster"
}
variable "subnet_zones" {
  type        = list(string)
  description = "(Optional) Zones name of the network, to which the MySQL cluster belongs."
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}
variable "assign_public_ip" {
  type        = bool
  description = "Sets whether the host should get a public IP address. It can be changed on the fly only when name is set."
  default     = false
}