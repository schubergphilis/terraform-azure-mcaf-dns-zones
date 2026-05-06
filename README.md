# Azure DNS Zone Terraform Module

This Terraform module creates an Azure DNS Zone with support for public zones, including all DNS record types. 

## Features

- Create public DNS zones
- Configure SOA records
- Support for all DNS record types:
  - A records (IPv4)
  - AAAA records (IPv6)
  - CAA records (Certificate Authority Authorization)
  - CNAME records (Canonical Name)
  - MX records (Mail Exchange)
  - NS records (Name Server)
  - PTR records (Pointer)
  - SRV records (Service)
  - TXT records (Text)
- Comprehensive variable documentation
- Example configurations

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>2.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.54 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~>2.8 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.54 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.dnssec](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.parent_ds_record](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.parent_ns_record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ns_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | DNS Zone name | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the DNS resources | `string` | n/a | yes |
| <a name="input_dnssec_enabled"></a> [dnssec\_enabled](#input\_dnssec\_enabled) | Set this to false to disable the automatic creation of DS records based on parent zones | `bool` | `true` | no |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id) | (Optional) Full Azure resource ID of the parent DNS zone, used for automatic delegation. The parent zone may live in a different resource group or subscription. | `string` | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | Object containing all DNS record types to create | <pre>object({<br/>    a = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    aaaa = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    caa = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    cname = optional(map(object({<br/>      ttl    = optional(number)<br/>      record = string<br/>    })), {})<br/><br/>    mx = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    ns = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    ptr = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    srv = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/><br/>    txt = optional(map(object({<br/>      ttl     = optional(number)<br/>      records = set(string)<br/>    })), {})<br/>  })</pre> | `{}` | no |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | An SOA record block. Supports the following:<br/>- email: The email contact for the SOA record.<br/>- host\_name: The domain name of the authoritative name server for this SOA record.<br/>- expire\_time: The expire time for the SOA record.<br/>- minimum\_ttl: The minimum Time To Live for the SOA record.<br/>- refresh\_time: The refresh time for the SOA record.<br/>- retry\_time: The retry time for the SOA record.<br/>- serial\_number: The serial number for the SOA record.<br/>- ttl: The Time To Live of the SOA record.<br/>- tags: A mapping of tags to assign to the SOA record. | <pre>object({<br/>    email         = string<br/>    host_name     = string<br/>    expire_time   = optional(number)<br/>    minimum_ttl   = optional(number)<br/>    refresh_time  = optional(number)<br/>    retry_time    = optional(number)<br/>    serial_number = optional(number)<br/>    ttl           = optional(number)<br/>    tags          = optional(map(string))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dnssec_signing_key"></a> [dnssec\_signing\_key](#output\_dnssec\_signing\_key) | Required information to register DNSSEC info with the Domain Provider |
| <a name="output_id"></a> [id](#output\_id) | The DNS Zone ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the DNS Zone. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | A list of values that make up the NS record for the zone. |
| <a name="output_recordsets"></a> [recordsets](#output\_recordsets) | recordsets and their resource\_ids |
<!-- END_TF_DOCS -->
