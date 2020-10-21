# Provided using the TF_VAR_DO_TOKEN env variable
variable DO_TOKEN {}

# Configure the terraform provider for DO
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

resource "digitalocean_record" "gitlab" {
  domain = "jon0.co.uk"
  type   = "A"
  name   = "gitlab"
  value  = azurerm_public_ip.lb_static_ip.ip_address
}
resource "digitalocean_record" "minio" {
  domain = "jon0.co.uk"
  type   = "A"
  name   = "minio"
  value  = azurerm_public_ip.lb_static_ip.ip_address
}
resource "digitalocean_record" "registry" {
  domain = "jon0.co.uk"
  type   = "A"
  name   = "registry"
  value  = azurerm_public_ip.lb_static_ip.ip_address
}