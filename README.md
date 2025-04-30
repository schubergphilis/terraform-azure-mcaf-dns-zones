# Azure DNS Zone Terraform Module

This Terraform module creates an Azure DNS Zone with support for both public and private zones, including all DNS record types.

## Features

- Create public or private DNS zones
- Configure SOA records
- Support for all DNS record types:
  - A records (IPv4)
  - AAAA records (IPv6)
  - CAA records (Certificate Authority Authorization)
  - CNAME records (Canonical Name)
  - MX records (Mail Exchange)
  - NS records (Name Server)
  - PTR records (Pointer)
  - SRV records (Service)
  - TXT records (Text)
- Comprehensive variable documentation
- Example configurations

## Usage

```hcl
module "dns_zone" {
  source = "path/to/module"

  name                = "example.com"
  resource_group_name = "my-resource-group"
  location            = "westeurope"
  zone_type          = "Public"

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

    # MX Record - Mail Exchange
    "mail" = {
      type    = "MX"
      ttl     = 300
      records = [
        "10 mail1.example.com",
        "20 mail2.example.com"
      ]
    }

    # TXT Record - Text
    "txt" = {
      type    = "TXT"
      ttl     = 300
      records = [
        "v=spf1 include:_spf.example.com ~all"
      ]
    }
  }

  tags = {
    Environment = "Production"
    Project     = "DNS"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the DNS Zone. Must be a valid domain name. | `string` | n/a | yes |
| resource_group_name | The name of the resource group in which to create the DNS zone. | `string` | n/a | yes |
| location | Specifies the Azure Region where the DNS Zone should exist. | `string` | n/a | yes |
| zone_type | Specifies the type of the DNS zone. Possible values are "Public" or "Private". | `string` | `"Public"` | no |
| soa_record | An SOA record block configuration. | `object` | `null` | no |
| records | Map of DNS records to create in the zone. Supports all record types. | `map(object)` | `{}` | no |
| tags | A mapping of tags to assign to the DNS zone. | `map(string)` | `{}` | no |

### Record Types

The `records` variable supports the following record types:

#### A Record
```hcl
"www" = {
  type    = "A"
  ttl     = 300
  records = ["192.168.0.1"]
}
```

#### AAAA Record
```hcl
"ipv6" = {
  type    = "AAAA"
  ttl     = 300
  records = ["2001:db8::1"]
}
```

#### CAA Record
```hcl
"caa" = {
  type    = "CAA"
  ttl     = 300
  records = ["0 issue \"letsencrypt.org\""]
}
```

#### CNAME Record
```hcl
"blog" = {
  type    = "CNAME"
  ttl     = 300
  records = ["www.example.com"]
}
```

#### MX Record
```hcl
"mail" = {
  type    = "MX"
  ttl     = 300
  records = [
    "10 mail1.example.com",
    "20 mail2.example.com"
  ]
}
```

#### NS Record
```hcl
"ns" = {
  type    = "NS"
  ttl     = 300
  records = [
    "ns1.example.com",
    "ns2.example.com"
  ]
}
```

#### PTR Record
```hcl
"1.0.168.192.in-addr.arpa" = {
  type    = "PTR"
  ttl     = 300
  records = ["www.example.com"]
}
```

#### SRV Record
```hcl
"_sip._tcp" = {
  type    = "SRV"
  ttl     = 300
  records = [
    "10 60 5060 sipserver1.example.com",
    "20 40 5060 sipserver2.example.com"
  ]
}
```

#### TXT Record
```hcl
"txt" = {
  type    = "TXT"
  ttl     = 300
  records = [
    "v=spf1 include:_spf.example.com ~all",
    "google-site-verification=1234567890"
  ]
}
```

## Outputs

| Name | Description |
|------|-------------|
| id | The DNS Zone ID. |
| name | The name of the DNS Zone. |
| name_servers | A list of values that make up the NS record for the zone. |
| number_of_record_sets | The current number of record sets in this DNS zone. |
| max_number_of_record_sets | Maximum number of records in the zone. |
| max_number_of_virtual_network_links | Maximum number of virtual networks that can be linked to this zone. |
| max_number_of_virtual_network_links_with_registration | Maximum number of virtual networks that can be linked to this zone with registration enabled. |

## License

MIT Licensed. See LICENSE for full details. 