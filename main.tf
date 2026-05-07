resource "azurerm_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [var.soa_record] : []
    content {
      email         = soa_record.value.email
      host_name     = soa_record.value.host_name
      expire_time   = soa_record.value.expire_time
      minimum_ttl   = soa_record.value.minimum_ttl
      refresh_time  = soa_record.value.refresh_time
      retry_time    = soa_record.value.retry_time
      serial_number = soa_record.value.serial_number
      ttl           = soa_record.value.ttl
      tags          = soa_record.value.tags
    }
  }
  tags = var.tags
}

resource "azapi_resource" "dnssec" {
  count     = var.dnssec_enabled ? 1 : 0
  name      = "default"
  parent_id = azurerm_dns_zone.this.id
  type      = "Microsoft.Network/dnsZones/dnssecConfigs@2023-07-01-preview"
}

resource "azurerm_dns_ns_record" "parent_ns_record" {
  count               = var.parent_zone_id != null ? 1 : 0
  name                = trimsuffix(var.name, ".${local.parsed_parent_zone.resource_name}")
  zone_name           = local.parsed_parent_zone.resource_name
  resource_group_name = local.parsed_parent_zone.resource_group_name
  records             = azurerm_dns_zone.this.name_servers
  ttl                 = 86400
  tags                = var.tags
}

resource "azapi_resource" "parent_ds_record" {
  count     = var.parent_zone_id != null && var.dnssec_enabled ? 1 : 0
  type      = "Microsoft.Network/dnsZones/DS@2023-07-01-preview"
  name      = trimsuffix(var.name, ".${local.parsed_parent_zone.resource_name}")
  parent_id = var.parent_zone_id
  body = {
    properties = {
      DSRecords = [
        {
          algorithm = local.dnssec_signing_key.securityAlgorithmType
          digest = {
            algorithmType = local.dnssec_signing_key.delegationSignerInfo[0].digestAlgorithmType
            value         = local.dnssec_signing_key.delegationSignerInfo[0].digestValue
          }
          keyTag = local.dnssec_signing_key.keyTag
        }
      ]
      TTL = 3600
    }
  }
}
