module "vpc_dev" {
  source       = "../VPC"
  env_name     = var.vpc_env_name
}
