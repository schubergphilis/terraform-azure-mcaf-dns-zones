locals {
  # Select the correct signing key for DNSSEC:
  dnssec_signing_key = var.dnssec_enabled ? [for signingKey in azapi_resource.dnssec[0].output.properties.signingKeys : signingKey if can(signingKey.delegationSignerInfo)][0] : null

  parsed_parent_zone = var.parent_zone_id != null ? provider::azurerm::parse_resource_id(var.parent_zone_id) : null
}
