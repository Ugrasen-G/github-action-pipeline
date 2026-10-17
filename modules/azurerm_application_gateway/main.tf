variable "appgw" {}

data "azurerm_public_ip" "appgwpublicip" {
    for_each = var.appgw
    name = "appgwpublicip1"
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "appsubnet" {
    for_each = var.appgw
    name = "appgwsubnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_application_gateway" "appgw" {
  for_each = var.appgw
  name                = each.value.name
  location            =  each.value.location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = data.azurerm_subnet.appsubnet[each.key].id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = data.azurerm_public_ip.appgwpublicip[each.key].id
  }

  backend_address_pool {
    name = "frontend-subnet"
    ip_addresses = [azurerm_network_interface.nic[each.key].ip_configuration[0].private_ip_address]
}
  

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "frontend-subnet"
    backend_http_settings_name = "http-setting"
    priority                   = 100
  }
}
