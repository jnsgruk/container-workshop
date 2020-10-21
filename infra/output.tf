output "vm1" {
  value = azurerm_public_ip.pip[0].ip_address
}
output "vm2" {
  value = azurerm_public_ip.pip[1].ip_address
}
output "vm3" {
  value = azurerm_public_ip.pip[2].ip_address
}