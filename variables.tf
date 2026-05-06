variable "name" {
  type        = string
  description = "DNS Zone name"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the DNS resources"
  type        = string
}

variable "parent_zone_id" {
  description = "(Optional) Full Azure resource ID of the parent DNS zone, used for automatic delegation. The parent zone may live in a different resource group or subscription."
  type        = string
  default     = null
}

variable "dnssec_enabled" {
  description = "Set this to false to disable the automatic creation of DS records based on parent zones"
  type        = bool
  default     = true
}

variable "soa_record" {
  description = <<-EOT
    An SOA record block. Supports the following:
    - email: The email contact for the SOA record.
    - host_name: The domain name of the authoritative name server for this SOA record.
    - expire_time: The expire time for the SOA record.
    - minimum_ttl: The minimum Time To Live for the SOA record.
    - refresh_time: The refresh time for the SOA record.
    - retry_time: The retry time for the SOA record.
    - serial_number: The serial number for the SOA record.
    - ttl: The Time To Live of the SOA record.
    - tags: A mapping of tags to assign to the SOA record.
  EOT
  type = object({
    email         = string
    host_name     = string
    expire_time   = optional(number)
    minimum_ttl   = optional(number)
    refresh_time  = optional(number)
    retry_time    = optional(number)
    serial_number = optional(number)
    ttl           = optional(number)
    tags          = optional(map(string))
  })
  default = null
}

variable "records" {
  description = "Object containing all DNS record types to create"
  type = object({
    a = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    aaaa = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    caa = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    cname = optional(map(object({
      ttl    = optional(number)
      record = string
    })), {})

    mx = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    ns = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    ptr = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    srv = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})

    txt = optional(map(object({
      ttl     = optional(number)
      records = set(string)
    })), {})
  })
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
