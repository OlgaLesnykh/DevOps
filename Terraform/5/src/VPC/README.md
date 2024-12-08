## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >1.8.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.131.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.develop](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.develop_subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | n/a | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | for dynamic block 'labels' | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network name | `string` | `"develop"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | VPC subnet name | `string` | `"develop-ru-central1-a"` | no |
| <a name="input_vpc_vars"></a> [vpc\_vars](#input\_vpc\_vars) | zone, cidr for create subnets | <pre>list(object({<br>    zone  = string<br>    cidr  = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr": "10.0.1.0/24",<br>    "zone": "ru-central1-a"<br>  },<br>  {<br>    "cidr": "10.0.2.0/24",<br>    "zone": "ru-central1-b"<br>  },<br>  {<br>    "cidr": "10.0.3.0/24",<br>    "zone": "ru-central1-d"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | n/a |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
