variable "dns_zone" {}

# . Create a Public Azure DNS Zone
# Use this for internet-facing domain routing
resource "azurerm_private_dns_zone" "zone" {
    for_each = var.dns_zone
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Example: Add an A Record to the Public DNS Zone
resource "azurerm_dns_a_record" "web" {
    for_each = var.dns_zone
  name                = each.value.record_name
  zone_name           = azurerm_dns_zone.public_zone[each.key].name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
}

# Example: Add a CNAME Record to the Public DNS Zone
# resource "azurerm_dns_cname_record" "cdn" {
#   name                = "assets"
#   zone_name           = azurerm_dns_zone.public_zone.name
#   resource_group_name = azurerm_resource_group.dns_rg.name
#   ttl                 = 300
#   record              = "mystorageaccount.blob.core.windows.net"
# }

# 4. Create a Private Azure DNS Zone (Optional)
# Use this for internal VNet resolution (e.g., Azure Private Endpoints)
# resource "azurerm_private_dns_zone" "private_zone" {
#   name                = "privatelink.database.windows.net"
#   resource_group_name = azurerm_resource_group.dns_rg.name
# }

# Link the Private DNS Zone to an existing Virtual Network
# (Required for the VNet to resolve names inside this private zone)
# resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
#   name                  = "vnet-dns-link"
#   resource_group_name   = azurerm_resource_group.dns_rg.name
#   private_dns_zone_name = azurerm_private_dns_zone.private_zone.name
#   virtual_network_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-network-rg/providers/Microsoft.Network/virtualNetworks/my-vnet"
#   registration_enabled  = false
# }
