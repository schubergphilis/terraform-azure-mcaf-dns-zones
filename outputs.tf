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
  value       = module.dns_records.recordsets
}