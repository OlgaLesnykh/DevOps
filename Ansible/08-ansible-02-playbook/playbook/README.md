## Installation

This ansible playbook supports the following,

- Can be deployed on VMs
- Supports **Linux distributions** Centos7
- Install and configure the Clickhouse and Vector

### Prerequisite

- **Ansible 2.9+**

### Configure

Refer the file `group_vars/vars.yml` to change the default values.

For example if we need to change the version of clickhouse and vector,

    clickhouse_version: "22.10.6.3"
    vector_version: "0.15.0-1"

In `inventory/prod.yml` file, you can configure the node details.
`ansible_host` is used for ansible to connect the nodes to run this playbook.
```
ansible_host=<Elastic/Public IP>
```

### Install

    ansible-playbook -i inventory/prod.yml site.yml

## Getting Help

If you find a bug, or have a feature request, please don't hesitate to open an issue in this repository.

## Code of Conduct