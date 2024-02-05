# #########################################################
# # Global & Common Variables for Application
# #########################################################
variable "m_location" {
  type        = string
  description = "Location where resources should be deployed"
  default     = "East US"
}

variable "http_trigger" {
  description = "Mapa de desencadenadores HTTP para la función Python"
  type = map(object({
    name           = string
    methods        = list(string)
    route          = string
    route_template = string
  }))
  default = {
    http_trigger = {
      name           = "MyHttpTrigger"
      methods        = ["GET", "POST"]
      route          = "MyHttpTrigger"
      route_template = "MyHttpTrigger/{param1?}"
    }
  }
}




