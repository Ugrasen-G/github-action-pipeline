
rgs = {
  rg2 = {
    name       = "kp2"
    location   = "eastasia"
    managed_by = "terraform"
    tags = {
      environment = "pro"
    }
  }
}

stg = {
  storage1 = {
    name                     = "krishn2026"
    resource_group_name      = "kp2"
    location                 = "eastasia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_access_type    = "private"
    container_name           = "container1"
  }
}

vnet = {
  vnet2 = {
    name                = "vnet1234"
    location            = "Eastasia"
    resource_group_name = "kp2"
    address_space       = ["10.1.0.0/16"]
  }
}
subnet = {
  sub1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.1.0/24"]
  }

  sub2 = {
    name                 = "Backend-subnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.2.0/24"]
  }
  sub3 = {
    name                 = "appgwsubnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.3.0/24"]
  }
  sub4 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.4.0/24"]
  }
}

security_group = {
  securitygroup1 = {
    name                 = "NSG1"
    location             = "eastasia"
    resource_group_name  = "kp2"
  }
}

security_group_association = {
  subnet_to_nsg = {
    name                = "NSG1"
    subnet_name         = "frontend-subnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
  }
}

security_rules = {
  # Inbound Rules
  rdp = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule1"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    network_security_group_name = "NSG1"
  }

  ssh = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule2"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    network_security_group_name = "NSG1"
  }

  http = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule3"
    priority                    = 120
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    network_security_group_name = "NSG1"
  }

  https = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule4"
    priority                    = 130
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    network_security_group_name = "NSG1"
  }

  # Outbound Rules

  internet = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule5"
    priority                    = 140
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "Internet"
    network_security_group_name = "NSG1"
  }

  vnet = {
    resource_group_name         = "kp2"
    name                        = "nsg-rule6"
    priority                    = 150
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    network_security_group_name = "NSG1"
  }
}

keyvault = {
  vault1 = {
    name                = "kp2026"
    location            = "eastasia"
    resource_group_name = "kp2"
    sku_name            = "standard"
  }
}

natgw = {
  natgw1 = {
    name                = "nat-gateway"
    location            = "eastasia"
    resource_group_name = "kp2"
  }
}


linuxvm = {
  vm1 = {
    name                 = "frontend-vm1"
    nic_name             = "frontendvmnic"
    publicip_name        = "Publicipvm1"
    resource_group_name  = "kp2"
    location             = "eastasia"
    virtual_network_name = "vnet1234"
    size                 = "Standard_B2ats_v2"
    admin_username       = "devopsadmin"
    key_name             = "vm1-password"
    vault_name           = "kp2026"
  }

  vm2 = {
    name                 = "frontend-vm2"
    nic_name             = "backendvmnic"
    publicip_name        = "Publicipvm2"
    resource_group_name  = "kp2"
    location             = "eastasia"
    virtual_network_name = "vnet1234"
    size                 = "Standard_B2ats_v2"
    admin_username       = "devopsadmin"
    key_name             = "vm2-password"
    vault_name           = "kp2026"
  }
}


bastionpublicip = {
  publicip1 = {
    name                = "Publicipvm1"
    location            = "eastasia"
    resource_group_name = "kp2"
    allocation_method   = "Static"
  }
  publicip2 = {
    name                = "Publicipvm2"
    location            = "eastasia"
    resource_group_name = "kp2"
    allocation_method   = "Static"
  }
}

bastion_host = {
  bastion = {
    name                 = "firstbastion"
    location             = "eastasia"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
  }
}

appgw = {
  appgw1 = {
    name                 = "applicationgateway"
    location             = "eastasia"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    backend_ips          = ["10.1.1.4", "10.1.1.5"]
  }
}