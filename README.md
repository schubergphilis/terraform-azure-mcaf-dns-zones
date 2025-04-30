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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_netbox"></a> [netbox](#requirement\_netbox) | ~> 3.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_netbox"></a> [netbox](#provider\_netbox) | ~> 3.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [netbox_ip_address.additional_addresses](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/resources/ip_address) | resource |
| [netbox_prefix.additional_prefixes](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/resources/prefix) | resource |
| [netbox_prefix.subnet](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/resources/prefix) | resource |
| [netbox_prefix.vnet](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/resources/prefix) | resource |
| [netbox_tenant.this](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/data-sources/tenant) | data source |
| [netbox_vrf.this](https://registry.terraform.io/providers/e-breuninger/netbox/latest/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_netbox_tenant_name"></a> [netbox\_tenant\_name](#input\_netbox\_tenant\_name) | The name of the netbox tenant | `string` | n/a | yes |
| <a name="input_additional_ip_addresses"></a> [additional\_ip\_addresses](#input\_additional\_ip\_addresses) | additional IP addresses to reserve | <pre>map(object({<br/>    ip_address    = string<br/>    custom_fields = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_additional_ip_prefixes"></a> [additional\_ip\_prefixes](#input\_additional\_ip\_prefixes) | additional IP prefixes to reserve | <pre>map(object({<br/>    address_prefix = string<br/>    is_pool        = optional(bool, true)<br/>    mark_utilized  = optional(bool, false)<br/>    custom_fields  = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | This object describes the subnets to create within the virtual network.<br/><br/>- `address_prefix`   = (Optional) - The address prefix to use for the subnet. Changing this forces a new resource to be created.<br/>- `address_prefixes` = (Optional) - The address prefixes to use for the subnet. Changing this forces a new resource to be created.<br/>- `name`             = (Optional) - The name of the subnet. Changing this forces a new resource to be created.<br/>- `create_network_security_group` = (Optional) - Whether to create a specific Network Security Group for the subnet. Defaults to false.<br/>- `network_security_group_config` = (Optional) - The configuration for the Network Security Group. Changing this forces a new resource to be created.<br/>  `azure_default` = (Optional) - Whether to use the Azure default Network Security Group rules. Defaults to false.<br/>- `network_security_group_id` = (Optional) - The ID of the Network Security Group to associate with the subnet. Changing this forces a new resource to be created.<br/>- `no_nsg_association` = (Optional) - Whether to associate a Network Security Group with the subnet. Defaults to false.<br/>- `nat_gateway`      = (Optional) - The NAT Gateway to associate with the subnet. Changing this forces a new resource to be created.<br/>- `network_security_group` = (Optional) - The Network Security Group to associate with the subnet. Changing this forces a new resource to be created.<br/>- `private_endpoint_network_policies` = (Optional) - The network policies for private endpoints on the subnet. Possible values are Enabled and Disabled. Defaults to Enabled.<br/>- `private_link_service_network_policies_enabled` = (Optional) - Enable or disable network policies for private link service on the subnet. Defaults to true.<br/>- `route_table` = (Optional) - The Route Table to associate with the subnet. Changing this forces a new resource to be created.<br/>- `service_endpoint_policies` = (Optional) - The service endpoint policies to associate with the subnet. Changing this forces a new resource to be created.<br/>- `service_endpoints` = (Optional) - The service endpoints to associate with the subnet. Changing this forces a new resource to be created.<br/>- `default_outbound_access_enabled` = (Optional) - Whether to allow outbound traffic from the subnet. Defaults to false.<br/>- `sharing_scope` = (Optional) - The sharing scope of the subnet. Possible values are None, Shared, and Service. Defaults to None.<br/>- `delegate_to` = (Optional) - The service to delegate to. Changing this forces a new resource to be created.<br/>- `timeouts` = (Optional) - The timeouts for the subnet.<br/>- `role_assignments` = (Optional) - The role assignments for the subnet.<br/><br/>  Example Inputs:<pre>hcl<br/>subnets = {<br/>  "CoreSubnet" = {<br/>    address_prefixes                = ["100.0.1.0/24"]<br/>    default_outbound_access_enabled = false<br/>  }<br/>  "DevopsSubnet" = {<br/>    address_prefixes                = ["100.0.2.0/24"]<br/>    default_outbound_access_enabled = false<br/>    delegate_to                     = "Microsoft.ContainerInstance/containerGroups"<br/>    create_network_security_group   = true<br/>  }<br/>  "ToolingSubnet" = {<br/>    address_prefixes                = ["100.0.3.0/24"]<br/>    default_outbound_access_enabled = false<br/>    create_network_security_group   = true<br/>    network_security_group_config = {<br/>      azure_default = true<br/>    }<br/>  }<br/>  "OtherSubnet" = {<br/>    address_prefixes                = ["100.0.4.0/24"]<br/>    default_outbound_access_enabled = false<br/>    no_nsg_association              = true<br/>  }<br/>  "AzureBastionSubnet" = {<br/>    address_prefixes                = ["100.0.5.0/24"]<br/>    default_outbound_access_enabled = false<br/>  }<br/>}</pre>hcl | <pre>map(object({<br/>    name                            = optional(string)<br/>    address_prefix                  = optional(string)<br/>    address_prefixes                = optional(list(string))<br/>    default_outbound_access_enabled = optional(bool, false)<br/>    delegate_to                     = optional(string, null)<br/>    nat_gateway = optional(object({<br/>      id = string<br/>    }))<br/>    no_nsg_association            = optional(bool, false)<br/>    create_network_security_group = optional(bool, false)<br/>    network_security_group_config = optional(object({<br/>      azure_default = optional(bool, false)<br/>    }), null)<br/>    network_security_group_id                     = optional(string, null)<br/>    private_endpoint_network_policies             = optional(string, "Enabled")<br/>    private_link_service_network_policies_enabled = optional(bool, true)<br/>    role_assignments = optional(map(object({<br/>      role_definition_id_or_name             = string<br/>      principal_id                           = string<br/>      description                            = optional(string, null)<br/>      skip_service_principal_aad_check       = optional(bool, false)<br/>      condition                              = optional(string, null)<br/>      condition_version                      = optional(string, null)<br/>      delegated_managed_identity_resource_id = optional(string, null)<br/>      principal_type                         = optional(string, null)<br/>    })))<br/>    route_table = optional(object({<br/>      id = string<br/>    }))<br/>    service_endpoint_policies = optional(map(object({<br/>      id = string<br/>    })))<br/>    service_endpoints = optional(set(string))<br/>    sharing_scope     = optional(string, null)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      delete = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space that is used by the virtual network. | `list(string)` | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | optional name to use as a suffix in the description | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->