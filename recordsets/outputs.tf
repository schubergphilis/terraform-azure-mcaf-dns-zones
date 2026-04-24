output "recordsets" {
  description = "All DNS records created by this module, organized by record type"
  value = {
    a_records     = { for k, v in azurerm_dns_a_record.this : k => v.id }
    aaaa_records  = { for k, v in azurerm_dns_aaaa_record.this : k => v.id }
    caa_records   = { for k, v in azurerm_dns_caa_record.this : k => v.id }
    cname_records = { for k, v in azurerm_dns_cname_record.this : k => v.id }
    mx_records    = { for k, v in azurerm_dns_mx_record.this : k => v.id }
    ns_records    = { for k, v in azurerm_dns_ns_record.this : k => v.id }
    ptr_records   = { for k, v in azurerm_dns_ptr_record.this : k => v.id }
    srv_records   = { for k, v in azurerm_dns_srv_record.this : k => v.id }
    txt_records   = { for k, v in azurerm_dns_txt_record.this : k => v.id }
  }
}