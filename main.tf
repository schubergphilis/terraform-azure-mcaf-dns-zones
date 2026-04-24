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
  count               = var.parent_zone != null ? 1 : 0
  name                = split(".", var.name)[0]
  zone_name           = var.parent_zone
  resource_group_name = var.resource_group_name
  records             = azurerm_dns_zone.this.name_servers
  ttl                 = 86400
  tags                = var.tags
}

resource "azapi_resource" "parent_ds_record" {
  count     = var.parent_zone != null && var.dnssec_enabled ? 1 : 0
  type      = "Microsoft.Network/dnsZones/DS@2023-07-01-preview"
  name      = split(".", var.name)[0]
  parent_id = "/subscriptions/${local.parsed_resource_id["subscription_id"]}/resourceGroups/${local.parsed_resource_id["resource_group_name"]}/providers/Microsoft.Network/dnsZones/${var.parent_zone}"
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

module "dns_records" {
  source              = "./recordsets"
  dns_zone_name       = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  a_records           = var.records.a_records
  aaaa_records        = var.records.aaaa_records
  caa_records         = var.records.caa_records
  cname_records       = var.records.cname_records
  mx_records          = var.records.mx_records
  ns_records          = var.records.ns_records
  ptr_records         = var.records.ptr_records
  srv_records         = var.records.srv_records
  txt_records         = var.records.txt_records
  tags                = var.tags
}
