# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "Ramesh-RG"
  location = "centralindia"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "Ramesh-Test-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "Ramesh-Test-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "Test-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# Output the AKS cluster kubeconfig
output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.*.kube_config_raw
  sensitive = true
}
