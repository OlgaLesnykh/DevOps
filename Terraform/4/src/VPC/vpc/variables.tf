variable "env_name" {
  type    = string
  default = null
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}
variable "vpc_subnet_name" {
  type        = string
  default     = "develop-ru-central1-a"
  description = "VPC subnet name"
}
/*variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}*/
variable "labels" {
  description = "for dynamic block 'labels' "
  type        = map(string)
  default = {}
}

variable "vpc_vars" {
  description = "zone, cidr for create subnets"
  type        = list(object({
    zone  = string
    cidr  = string
  }))
  default     = [{
    zone  = "ru-central1-a"
    cidr  = "10.0.1.0/24"
  },
  {
    zone  = "ru-central1-b"
    cidr  = "10.0.2.0/24"
  },
  {
    zone  = "ru-central1-d"
    cidr  = "10.0.3.0/24"
  }
  ]
}