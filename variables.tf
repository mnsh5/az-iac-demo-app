#########################################################
# Global & Common Variables for Application
#########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "East US"
}

variable "m_appinsights_isrequired" {
  type        = bool
  description = "Creates application insights when set as True"
  default     = true
}

#########################################################
# Private endpoints Subnet Variables for Application    #
#########################################################
variable "m_virtual_network_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "vnet-iasp-eus-lz-network"
}

variable "m_subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "vnet-iasp-eus"
}

variable "m_nsg_pub_name" {
  description = "The Network Security Group name"
  type        = string
  default     = "vnet-iasp-eus"
}