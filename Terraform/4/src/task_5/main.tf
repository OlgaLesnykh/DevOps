module "MySQL_cluster" {
  source       = "./MySQL_cluster"
}
module "MySQL_db" {
  source       = "./MySQL_db"
  cluster_id   = module.MySQL_cluster.cluster_id
}
