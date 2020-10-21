data "http" "icanhazip" {
  url = "http://ifconfig.co"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-js-wksp"
  location = "UK South"
}
