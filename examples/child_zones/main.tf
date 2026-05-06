terraform {
  required_version = ">= 1.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.54"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-dns-rg"
  location = "West Europe"
}

module "parent_zone_with_soa" {
  source = "../.."
  name   = "example.com"
  soa_record = {
    email         = "admin@example.com"
    host_name     = "ns1-01.azure-dns.com."
    expire_time   = 2419200
    minimum_ttl   = 300
    refresh_time  = 3600
    retry_time    = 300
    serial_number = 1
    ttl           = 3600
    tags          = {}
  }
  resource_group_name = azurerm_resource_group.example.name
  records = {
    a = {
      "www" = {
        ttl     = 300
        records = ["192.168.0.1"]
      }
    }
    aaaa = {
      "ipv6" = {
        ttl     = 300
        records = ["2001:db8::1"]
      }
    }
    caa = {
      "caa" = {
        ttl     = 300
        records = ["0 issue \"letsencrypt.org\""]
      }
    }
    cname = {
      "blog" = {
        ttl    = 300
        record = "www.example.com"
      }
    }
    mx = {
      "mail" = {
        ttl = 300
        records = [
          "10 mail1.example.com",
          "20 mail2.example.com"
        ]
      }
    }
    ns = {
      "ns" = {
        ttl = 300
        records = [
          "ns1.example.com",
          "ns2.example.com"
        ]
      }
    }
    ptr = {
      "1.0.168.192.in-addr.arpa" = {
        ttl     = 300
        records = ["www.test.example.com"]
      }
    }
    srv = {
      "_sip._tcp" = {
        ttl     = 300
        records = ["10 60 5060 sipserver.example.com"]
      }
    }
    txt = {
      "txt" = {
        ttl     = 300
        records = ["v=spf1 include:_spf.google.com ~all"]
      }
    }
  }
  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
}


module "example_child_zone" {
  source              = "../.."
  name                = "test.example.com"
  resource_group_name = azurerm_resource_group.example.name
  parent_zone_id      = module.parent_zone_with_soa.id
  records = {
    txt = {
      "txt" = {
        ttl     = 300
        records = ["v=spf1 include:_spf.google.com ~all"]
      }
    }
  }
  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
}

module "zone_with_dnssec_disabled" {
  source              = "../.."
  name                = "nodnssec.example.com"
  resource_group_name = azurerm_resource_group.example.name
  dnssec_enabled      = false
  records = {
    txt = {
      "txt" = {
        ttl     = 300
        records = ["v=spf1 include:_spf.google.com ~all"]
      }
    }
  }
  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
}
