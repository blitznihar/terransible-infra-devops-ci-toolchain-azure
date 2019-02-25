output "resource_group_devops_location" {
  value = "${azurerm_resource_group.resource_group_devops.location}"
}

output "resource_group_devops_name" {
  value = "${azurerm_resource_group.resource_group_devops.name}"
}

output "network_security_group_devops_id" {
  value = "${azurerm_network_security_group.network_security_group_devops.id}"
}

output "subnet_A_devops_id" {
  value = "${azurerm_subnet.subnet_A_devops.id}"
}

output "subnet_B_devops_id" {
  value = "${azurerm_subnet.subnet_B_devops.id}"
}

output "subnet_C_devops_id" {
  value = "${azurerm_subnet.subnet_C_devops.id}"
}
