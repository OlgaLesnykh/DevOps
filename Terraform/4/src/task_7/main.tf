data "vault_generic_secret" "vault_example" {
  path = var.vault_example_path
}
output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data).test_secret_data
}

resource "vault_generic_secret" "vault_test" {
  path = var.vault_test_path
  data_json = <<EOT
{
  "TEST_PASSWORD": "${var.my_pass}"
}
EOT
}

variable "my_pass" {
  type        = string
  default     = "123gfgtFDfdR@123gfgfhtfsd"
}

variable "vault_example_path" {
  type        = string
  default     = "secret/example"
}

variable "vault_test_path" {
  type        = string
  default     = "secret/test"
}

