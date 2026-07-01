output "resource_group_name" {
  description = "Resource group containing the VM"
  value       = azurerm_resource_group.vm_rg.name
}

output "vm_name" {
  description = "Name of the created virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip_address" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}