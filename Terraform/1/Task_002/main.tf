terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
  required_version = "~>1.9.7"
}
provider "docker" {
  host     = "ssh://lesnykh@89.169.168.199:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
resource "random_password" "root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
resource "random_password" "mysql_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
resource "docker_image" "mysql_image" {
  name         = "mysql:8"
  keep_locally = false
}
resource "docker_container" "mysql" {
  image = docker_image.mysql_image.image_id
  name  = "mysql"
  must_run = true
  env = [ "MYSQL_ROOT_PASSWORD=${random_password.root_password.result}", 
          "MYSQL_DATABASE=wordpress", 
          "MYSQL_USER=wordpress", 
          "MYSQL_PASSWORD=${random_password.mysql_password.result}", 
          "MYSQL_ROOT_HOST=%"
          ]
  ports {
    internal = 3306
    external = 3306
    ip = "127.0.0.1"
  }
  restart = "always"

}
