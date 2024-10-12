locals {

  vm_names = [
    { tag = "web", name = "${var.vm_db_name}-${var.project_owner}" },
    { tag = "db", name = "${var.vm_web_name}-${var.project_owner}" },
  ]
}