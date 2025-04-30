# Azure DNS Zone Terraform Module

This Terraform module creates an Azure DNS Zone with support for both public and private zones, including all DNS record types. 

## Features

- Create public or private DNS zones
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the DNS Zone. Must be a valid domain name.<br/>Example: "example.com" | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the DNS zone.<br/>This must be an existing resource group. | `string` | n/a | yes |
| <a name="input_records"></a> [records](#input\_records) | Map of DNS records to create in the zone. Supports the following record types:<br/>- A records: Maps a domain name to an IPv4 address<br/>- AAAA records: Maps a domain name to an IPv6 address<br/>- CAA records: Specifies which certificate authorities are allowed to issue certificates for a domain<br/>- CNAME records: Maps a domain name to another domain name<br/>- MX records: Specifies mail exchange servers for a domain<br/>- NS records: Specifies authoritative name servers for a domain<br/>- PTR records: Maps an IP address to a domain name<br/>- SRV records: Specifies information about available services<br/>- TXT records: Contains arbitrary text information<br/><br/>Example:<pre>hcl<br/>records = {<br/>  "www" = {<br/>    type = "A"<br/>    ttl  = 300<br/>    records = ["192.168.0.1"]<br/>  }<br/>  "mail" = {<br/>    type = "MX"<br/>    ttl  = 300<br/>    records = [<br/>      "10 mail1.example.com",<br/>      "20 mail2.example.com"<br/>    ]<br/>  }<br/>}</pre> | <pre>map(object({<br/>    type    = string<br/>    ttl     = number<br/>    records = list(string)<br/>    tags    = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | An SOA record block. Supports the following:<br/>- email: The email contact for the SOA record.<br/>- host\_name: The domain name of the authoritative name server for this SOA record.<br/>- expire\_time: The expire time for the SOA record.<br/>- minimum\_ttl: The minimum Time To Live for the SOA record.<br/>- refresh\_time: The refresh time for the SOA record.<br/>- retry\_time: The retry time for the SOA record.<br/>- serial\_number: The serial number for the SOA record.<br/>- ttl: The Time To Live of the SOA record.<br/>- tags: A mapping of tags to assign to the SOA record. | <pre>object({<br/>    email         = string<br/>    host_name     = string<br/>    expire_time   = optional(number)<br/>    minimum_ttl   = optional(number)<br/>    refresh_time  = optional(number)<br/>    retry_time    = optional(number)<br/>    serial_number = optional(number)<br/>    ttl           = optional(number)<br/>    tags          = optional(map(string))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the DNS zone.<br/>Example: { "environment" = "production", "cost-center" = "12345" } | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The DNS Zone ID. |
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | Maximum number of records in the zone. |
| <a name="output_name"></a> [name](#output\_name) | The name of the DNS Zone. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | A list of values that make up the NS record for the zone. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The current number of record sets in this DNS zone. |
<!-- END_TF_DOCS -->
