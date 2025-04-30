locals {
  a_records = {
    for k, v in var.records : k => v if v.type == "A"
  }
  aaaa_records = {
    for k, v in var.records : k => v if v.type == "AAAA"
  }
  caa_records = {
    for k, v in var.records : k => v if v.type == "CAA"
  }
  cname_records = {
    for k, v in var.records : k => v if v.type == "CNAME"
  }
  mx_records = {
    for k, v in var.records : k => v if v.type == "MX"
  }
  ns_records = {
    for k, v in var.records : k => v if v.type == "NS"
  }
  ptr_records = {
    for k, v in var.records : k => v if v.type == "PTR"
  }
  srv_records = {
    for k, v in var.records : k => v if v.type == "SRV"
  }
  txt_records = {
    for k, v in var.records : k => v if v.type == "TXT"
  }

  tags = merge(var.tags, var.tags, {
    "Resource Type" = "DNS Zone"
  })
}