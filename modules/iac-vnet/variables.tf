#########################################################
# Global & Common Variables for Application
#########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "France Central"
}

variable "m_appinsights_isrequired" {
  type        = bool
  description = "Creates application insights when set as True"
  default     = true
}


#########################################################
# Private endpoints Subnet Variables for Application    #
#########################################################
variable "m_vnet_resource_group" {
  type        = string
  description = "Name of the VNET Resource Group"
}

variable "m_virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "m_subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "m_route_table_name" {
  type        = string
  description = "Name of the Route Table"
}

variable "m_nsg_pub_name" {
  description = "The Network Security Group name"
  type        = string
}

variable "m_nsg_priv_name" {
  description = "The Network Security Group name"
  type        = string
}
