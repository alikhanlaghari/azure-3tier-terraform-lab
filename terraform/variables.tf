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