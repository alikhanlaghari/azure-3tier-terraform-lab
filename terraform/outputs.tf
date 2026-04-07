output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "resource_group_location" {
  value = azurerm_resource_group.main.location
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "web_subnet_name" {
  value = azurerm_subnet.web.name
}

output "app_subnet_name" {
  value = azurerm_subnet.app.name
}

output "db_subnet_name" {
  value = azurerm_subnet.db.name
}

output "bastion_subnet_name" {
  value = azurerm_subnet.bastion.name
}

output "web_nsg_name" {
  value = azurerm_network_security_group.web_nsg.name
}

output "web_vm_public_ip_name" {
  value = azurerm_public_ip.web_pip.name
}

output "app_nic_name" {
  value = azurerm_network_interface.app_nic.name
}

output "db_nic_name" {
  value = azurerm_network_interface.db_nic.name
}