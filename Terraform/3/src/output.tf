output "my_output" {
  value = [
    concat(local.web, local.db)
    ]
  }