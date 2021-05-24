terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.25.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

# Provided using the TF_VAR_DO_TOKEN env variable
variable DO_TOKEN {}

provider "digitalocean" {
  token = var.DO_TOKEN
}

provider "azurerm" {
  features {}
}