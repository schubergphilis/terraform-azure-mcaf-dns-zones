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

output "number_of_record_sets" {
  description = "The current number of record sets in this DNS zone."
  value       = azurerm_dns_zone.this.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "Maximum number of records in the zone."
  value       = azurerm_dns_zone.this.max_number_of_record_sets
}
 