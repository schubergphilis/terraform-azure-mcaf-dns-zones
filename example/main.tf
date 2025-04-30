provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-dns-rg"
  location = "West Europe"
}

module "public_dns_zone" {
  source = "../"

  name                = "example.com"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  zone_type          = "Public"

  soa_record = {
    email     = "admin@example.com"
    host_name = "ns1.example.com"
    ttl       = 3600
  }

  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
}

module "private_dns_zone" {
  source = "../"

  name                = "private.example.com"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  zone_type          = "Private"

  tags = {
    Environment = "Example"
    Project     = "DNS"
  }
} 