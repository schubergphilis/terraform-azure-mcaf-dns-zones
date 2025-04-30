provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-dns-rg"
  location = "West Europe"
}

module "dns_zone" {
  source = "../"

  name                = "example.com"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  soa_record = {
    email     = "admin@example.com"
    host_name = "ns1.example.com"
    ttl       = 3600
  }

  records = {
    # A Record - Maps domain to IPv4
    "www" = {
      type    = "A"
      ttl     = 300
      records = ["192.168.0.1"]
    }

    # AAAA Record - Maps domain to IPv6
    "ipv6" = {
      type    = "AAAA"
      ttl     = 300
      records = ["2001:db8::1"]
    }

    # CAA Record - Certificate Authority Authorization
    "caa" = {
      type    = "CAA"
      ttl     = 300
      records = ["0 issue \"letsencrypt.org\""]
    }

    # CNAME Record - Canonical Name
    "blog" = {
      type    = "CNAME"
      ttl     = 300
      records = ["www.example.com"]
    }

    # MX Record - Mail Exchange
    "mail" = {
      type    = "MX"
      ttl     = 300
      records = [
        "10 mail1.example.com",
        "20 mail2.example.com"
      ]
    }

    # NS Record - Name Server
    "ns" = {
      type    = "NS"
      ttl     = 300
      records = [
        "ns1.example.com",
        "ns2.example.com"
      ]
    }

    # PTR Record - Pointer
    "1.0.168.192.in-addr.arpa" = {
      type    = "PTR"
      ttl     = 300
      records = ["www.example.com"]
    }

    # SRV Record - Service
    "_sip._tcp" = {
      type    = "SRV"
      ttl     = 300
      records = [
        "10 60 5060 sipserver1.example.com",
        "20 40 5060 sipserver2.example.com"
      ]
    }

    # TXT Record - Text
    "txt" = {
      type    = "TXT"
      ttl     = 300
      records = [
        "v=spf1 include:_spf.example.com ~all",
        "google-site-verification=1234567890"
      ]
    }
  }

  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
}
