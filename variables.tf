variable "name" {
  description = <<-EOT
    The name of the DNS Zone. Must be a valid domain name.
    Example: "example.com"
  EOT
  type        = string
}

variable "resource_group_name" {
  description = <<-EOT
    The name of the resource group in which to create the DNS zone.
    This must be an existing resource group.
  EOT
  type        = string
}

variable "location" {
  description = <<-EOT
    Specifies the Azure Region where the DNS Zone should exist.
    Changing this forces a new resource to be created.
  EOT
  type        = string
}

variable "zone_type" {
  description = <<-EOT
    Specifies the type of the DNS zone. Possible values are:
    - "Public" - A public DNS zone
    - "Private" - A private DNS zone
    Defaults to "Public".
  EOT
  type        = string
  default     = "Public"
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

variable "tags" {
  description = <<-EOT
    A mapping of tags to assign to the DNS zone.
    Example: { "environment" = "production", "cost-center" = "12345" }
  EOT
  type        = map(string)
  default     = {}
} 