terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}

resource "yandex_mdb_mysql_database" "test" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "app" {
  cluster_id = var.cluster_id
  name       = var.db_user_name
  password   = var.db_user_password
  permission {
    database_name = yandex_mdb_mysql_database.test.name
    roles         = ["ALL"]
  }
}