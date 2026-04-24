moved {
  from = azurerm_dns_a_record.this
  to   = module.dns_records.azurerm_dns_a_record.this
}

moved {
  from = azurerm_dns_aaaa_record.this
  to   = module.dns_records.azurerm_dns_aaaa_record.this
}

moved {
  from = azurerm_dns_caa_record.this
  to   = module.dns_records.azurerm_dns_caa_record.this
}

moved {
  from = azurerm_dns_cname_record.this
  to   = module.dns_records.azurerm_dns_cname_record.this
}

moved {
  from = azurerm_dns_mx_record.this
  to   = module.dns_records.azurerm_dns_mx_record.this
}

moved {
  from = azurerm_dns_ns_record.this
  to   = module.dns_records.azurerm_dns_ns_record.this
}

moved {
  from = azurerm_dns_ptr_record.this
  to   = module.dns_records.azurerm_dns_ptr_record.this
}

moved {
  from = azurerm_dns_srv_record.this
  to   = module.dns_records.azurerm_dns_srv_record.this
}

moved {
  from = azurerm_dns_txt_record.this
  to   = module.dns_records.azurerm_dns_txt_record.this
}