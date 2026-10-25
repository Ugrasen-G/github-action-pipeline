variable "rgs" {}
variable "stg" {}
variable "vnet" {}
variable "subnet" {}
variable "nic" {}
# variable "nic_name" {}
variable "natgw" {}
variable "bastion_host" {}
variable "linuxvm" {}
variable "bastionpublicip" {}
variable "appgw" {}
variable "keyvault" {}
variable "security_group" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    nic_name            = list(string)
  }))
}

variable "security_rules" {}

variable "vm_username" {
  description = "vm username"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "vm password"
  type        = string
  sensitive   = true
}
variable "dns_zone" {}