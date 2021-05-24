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