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

variable "records" {
  description = <<-EOT
    Map of DNS records to create in the zone. Supports the following record types:
    - A records: Maps a domain name to an IPv4 address
    - AAAA records: Maps a domain name to an IPv6 address
    - CAA records: Specifies which certificate authorities are allowed to issue certificates for a domain
    - CNAME records: Maps a domain name to another domain name
    - MX records: Specifies mail exchange servers for a domain
    - NS records: Specifies authoritative name servers for a domain
    - PTR records: Maps an IP address to a domain name
    - SRV records: Specifies information about available services
    - TXT records: Contains arbitrary text information

    Example:
    ```hcl
    records = {
      "www" = {
        type = "A"
        ttl  = 300
        records = ["192.168.0.1"]
      }
      "mail" = {
        type = "MX"
        ttl  = 300
        records = [
          "10 mail1.example.com",
          "20 mail2.example.com"
        ]
      }
    }
    ```
  EOT
  type = map(object({
    type    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string))
  }))
  default = {}
} 