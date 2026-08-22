resource "azurerm_public_ip" "example" {
  for_each            = var.publicip
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
}

resource "azurerm_lb" "loadbalancer" {
    for_each = var.loadbalancer
  name                = "azureLoadBalancer"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example["lbpublicip"].id
  }
}
