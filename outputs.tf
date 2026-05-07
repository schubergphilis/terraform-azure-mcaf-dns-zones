output "id" {
  description = "The DNS Zone ID."
  value       = azurerm_dns_zone.this.id
}

output "name" {
  description = "The name of the DNS Zone."
  value       = azurerm_dns_zone.this.name
}

output "name_servers" {
  description = "A list of values that make up the NS record for the zone."
  value       = azurerm_dns_zone.this.name_servers
}

output "dnssec_signing_key" {
  description = "Required information to register DNSSEC info with the Domain Provider"
  value       = local.dnssec_signing_key
}

output "recordsets" {
  description = "recordsets and their resource_ids"
  value = {
    a     = { for k, v in azurerm_dns_a_record.this : k => v.id }
    aaaa  = { for k, v in azurerm_dns_aaaa_record.this : k => v.id }
    caa   = { for k, v in azurerm_dns_caa_record.this : k => v.id }
    cname = { for k, v in azurerm_dns_cname_record.this : k => v.id }
    mx    = { for k, v in azurerm_dns_mx_record.this : k => v.id }
    ns    = { for k, v in azurerm_dns_ns_record.this : k => v.id }
    ptr   = { for k, v in azurerm_dns_ptr_record.this : k => v.id }
    srv   = { for k, v in azurerm_dns_srv_record.this : k => v.id }
    txt   = { for k, v in azurerm_dns_txt_record.this : k => v.id }
  }
}
