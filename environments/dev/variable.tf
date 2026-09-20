variable "rgs" {}
variable "stg" {}
variable "vnet" {}
variable "subnet" {}
variable "natgw" {}
variable "bastion_host" {}
variable "linuxvm" {}
variable "bastionpublicip" {}
variable "appgw" {}
variable "keyvault" {}
variable "security_group" {}
variable "security_group_association" {}
variable "security_rules" {}
variable "vm_password" {
  description = "vm password"
  type        = string
  sensitive   = true
}