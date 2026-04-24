resource "azurerm_dns_a_record" "this" {
  for_each = var.a_records

  name                = each.key
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.dns_zone_name
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_aaaa_record" "this" {
  for_each = var.aaaa_records

  name                = each.key
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.dns_zone_name
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_caa_record" "this" {
  for_each = var.caa_records

  name                = each.key
  zone_name           = var.dns_zone_name
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
  for_each = var.cname_records

  name                = each.key
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = var.tags
}

resource "azurerm_dns_mx_record" "this" {
  for_each = var.mx_records

  name                = each.key
  zone_name           = var.dns_zone_name
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
  for_each = var.ns_records

  name                = each.key
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_ptr_record" "this" {
  for_each = var.ptr_records

  name                = each.key
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_dns_srv_record" "this" {
  for_each = var.srv_records

  name                = each.key
  zone_name           = var.dns_zone_name
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
  for_each = var.txt_records

  name                = each.key
  zone_name           = var.dns_zone_name
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
