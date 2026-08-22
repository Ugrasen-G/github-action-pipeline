publicip = {
  publicip1 = {
    name                = "lbpublicip"
    location            = "eastasia"
    resource_group_name = "kp2"
    allocation_method   = "Static"
  }
}

loadbalancer = {
  lb1 = {
  name                = "azureLoadBalancer"
  location            = "eastasia"
  resource_group_name = "kp2"
}
}
