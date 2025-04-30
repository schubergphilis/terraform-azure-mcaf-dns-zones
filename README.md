# Azure DNS Zone Terraform Module

This Terraform module creates an Azure DNS Zone with support for both public and private zones.

## Features

- Create public or private DNS zones
- Configure SOA records
- Support for all Azure DNS Zone features
- Comprehensive variable documentation
- Example configurations

## Usage

```hcl
module "dns_zone" {
  source = "path/to/module"

  name                = "example.com"
  resource_group_name = "my-resource-group"
  location            = "westeurope"
  zone_type          = "Public"

  soa_record = {
    email     = "admin@example.com"
    host_name = "ns1.example.com"
    ttl       = 3600
  }

  tags = {
    Environment = "Production"
    Project     = "DNS"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the DNS Zone. Must be a valid domain name. | `string` | n/a | yes |
| resource_group_name | The name of the resource group in which to create the DNS zone. | `string` | n/a | yes |
| location | Specifies the Azure Region where the DNS Zone should exist. | `string` | n/a | yes |
| zone_type | Specifies the type of the DNS zone. Possible values are "Public" or "Private". | `string` | `"Public"` | no |
| soa_record | An SOA record block configuration. | `object` | `null` | no |
| tags | A mapping of tags to assign to the DNS zone. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The DNS Zone ID. |
| name | The name of the DNS Zone. |
| name_servers | A list of values that make up the NS record for the zone. |
| number_of_record_sets | The current number of record sets in this DNS zone. |
| max_number_of_record_sets | Maximum number of records in the zone. |
| max_number_of_virtual_network_links | Maximum number of virtual networks that can be linked to this zone. |
| max_number_of_virtual_network_links_with_registration | Maximum number of virtual networks that can be linked to this zone with registration enabled. |

## License

MIT Licensed. See LICENSE for full details. 