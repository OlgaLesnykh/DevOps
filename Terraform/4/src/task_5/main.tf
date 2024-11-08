module "MySQL_cluster" {
  source             = "./MySQL_cluster"
  cluster_name       = var.cluster_name
  disk_size          = var.disk_size
  resource_preset_id = var.resource_preset_id
  ha                 = var.ha
}
module "MySQL_db" {
  source       = "./MySQL_db"
  cluster_id   = module.MySQL_cluster.cluster_id
  db_name      = var.db_name
  db_user_name = var.db_user_name
  db_user_password = var.db_user_password
}
