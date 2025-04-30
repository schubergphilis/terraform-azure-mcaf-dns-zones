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

output "max_number_of_virtual_network_links" {
  description = "Maximum number of virtual networks that can be linked to this zone."
  value       = azurerm_dns_zone.this.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  description = "Maximum number of virtual networks that can be linked to this zone with registration enabled."
  value       = azurerm_dns_zone.this.max_number_of_virtual_network_links_with_registration
} 