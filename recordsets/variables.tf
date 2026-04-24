variable "dns_zone_name" {
  type        = string
  description = "The DNS zone object containing the zone name"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the DNS records"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the DNS records"
  type        = map(string)
  default     = {}
}

variable "a_records" {
  description = "Map of DNS A records to create. Key is the record name, value is an object containing ttl and records list"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "aaaa_records" {
  description = "Map of DNS AAAA records to create. Key is the record name, value is an object containing ttl and records list"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "caa_records" {
  description = "Map of DNS CAA records to create. Key is the record name, value is an object containing ttl and records list. Records should be in format: 'flags tag value'"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "cname_records" {
  description = "Map of DNS CNAME records to create. Key is the record name, value is an object containing ttl and a record (single CNAME target)"
  type = map(object({
    ttl    = number
    record = string
  }))
  default = {}
}

variable "mx_records" {
  description = "Map of DNS MX records to create. Key is the record name, value is an object containing ttl and records list. Records should be in format: 'preference exchange'"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "ns_records" {
  description = "Map of DNS NS records to create. Key is the record name, value is an object containing ttl and records list"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "ptr_records" {
  description = "Map of DNS PTR records to create. Key is the record name, value is an object containing ttl and records list"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "srv_records" {
  description = "Map of DNS SRV records to create. Key is the record name, value is an object containing ttl and records list. Records should be in format: 'priority weight port target'"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}

variable "txt_records" {
  description = "Map of DNS TXT records to create. Key is the record name, value is an object containing ttl and records list"
  type = map(object({
    ttl     = number
    records = set(string)
  }))
  default = {}
}
