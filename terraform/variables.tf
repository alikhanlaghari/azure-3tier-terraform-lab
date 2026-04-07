variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "rg-azure-3tier-lab"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "westeurope"
}

variable "admin_username" {
  description = "Admin username for virtual machines"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for virtual machines"
  type        = string
  sensitive   = true
  default     = "Azure@123456!"
}

