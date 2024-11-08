# To always have a unique bucket name in this example
resource "random_string" "unique_id" {
  length  = var.length
  upper   = var.upper
  lower   = var.lower
  numeric = var.numeric
  special = var.special
}
module "s3" {
  source      = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git"
  bucket_name = "${var.bucket_name}-${random_string.unique_id.result}"
  max_size    = var.max_size
}