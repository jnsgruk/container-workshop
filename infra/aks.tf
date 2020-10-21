resource "azurerm_kubernetes_cluster" "aks" {
  name                            = "aks-js-wksp"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  dns_prefix                      = "aks-js-wksp"
  api_server_authorized_ip_ranges = [chomp(data.http.icanhazip.body)]
  kubernetes_version              = "1.18.6"
  node_resource_group             = "aks-js-wksp-nodes"

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
    }
  }

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  linux_profile {
    admin_username = "azure_admin"
    ssh_key {
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      role_based_access_control
    ]
  }

}

resource "azurerm_public_ip" "lb_static_ip" {
  name                = "pip-aks-lb-js-wksp"
  resource_group_name = "aks-js-wksp-nodes"
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = "pip-aks-lb-js-wksp"
  depends_on          = [azurerm_kubernetes_cluster.aks]
}
