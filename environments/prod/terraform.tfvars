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
vnet = {
  vnet2 = {
    name                = "vnet1234"
    location            = "Eastasia"
    resource_group_name = "kp2"
    address_space       = ["10.1.0.0/16"]
  }
}
subnet = {
  sub5 = {
    name                 = "frontend-subnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.1.0/24"]
  }

  sub6 = {
    name                 = "Backend-subnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.2.0/24"]
  }
  sub7 = {
    name                 = "AppGWsubnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.3.0/24"]
  }
  sub8 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "kp2"
    virtual_network_name = "vnet1234"
    address_prefixes     = ["10.1.4.0/24"]
  }
}

security_group = {
  nsg1 = {
    name                = "frontend-nsg"
    location            = "Eastasia"
    resource_group_name = "kp2"

    security_rules = [

      # Inbound Rules

      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      {
        name                       = "Allow-HTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      {
        name                       = "Allow-HTTPS"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      {
        name                       = "Allow-RDP"
        priority                   = 130
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      # Outbound Rules

      {
        name                       = "Allow-Internet-HTTPS"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
      },

      {
        name                       = "Allow-DNS"
        priority                   = 210
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Udp"
        source_port_range          = "*"
        destination_port_range     = "53"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

linuxvm = {
  vm1 = {
    name                 = "frontend-vm1"
    nic_name             = "frontendvmnic"
    resource_group_name  = "kp2"
    location             = "eastasia"
    virtual_network_name = "vnet1234"
    size                 = "Standard_D2_v3"
    admin_username       = "devopsadmin"
    admin_password       = "Devops@123456"
  }
  vm2 = {
    name                 = "frontend-vm2"
    nic_name             = "backendvmnic"
    resource_group_name  = "kp2"
    location             = "eastasia"
    virtual_network_name = "vnet1234"
    size                 = "Standard_D2_v3"
    admin_username       = "devopsadmin"
    admin_password       = "Devops@123456"
  }
}
