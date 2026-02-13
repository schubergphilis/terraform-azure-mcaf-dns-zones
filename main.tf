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

resource "azurerm_dns_a_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.a_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_aaaa_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.aaaa_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_caa_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.caa_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      flags = split(" ", record.value)[0]
      tag   = split(" ", record.value)[1]
      value = split(" ", record.value)[2]
    }
  }
}

resource "azurerm_dns_cname_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.cname_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.records[0]
  tags                = var.tags
}

resource "azurerm_dns_mx_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.mx_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      preference = split(" ", record.value)[0]
      exchange   = split(" ", record.value)[1]
    }
  }
}

resource "azurerm_dns_ns_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.ns_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_ptr_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.ptr_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_srv_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.srv_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      priority = split(" ", record.value)[0]
      weight   = split(" ", record.value)[1]
      port     = split(" ", record.value)[2]
      target   = split(" ", record.value)[3]
    }
  }
}

resource "azurerm_dns_txt_record" "this" {
  depends_on = [azurerm_dns_zone.this]

  for_each = local.txt_records

  name                = each.key
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  tags                = var.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}
