# Phase 05 – Web Tier Virtual Machine

## Objective
Deploy the first compute resource (Web VM) in the 3-tier architecture using Terraform.

## Resources Deployed
- Public IP: `pip-web-vm`
- Network Interface: `nic-web-vm`
- Virtual Machine: `vm-web-01`

## Configuration Details
- OS: Windows Server 2022 Datacenter Azure Edition
- Size: Standard_D2ads_v7
- Subnet: `snet-web`
- NSG: `nsg-web`
- Public Access: Enabled via static public IP

## Terraform Actions
- Defined Public IP resource
- Defined Network Interface (NIC)
- Defined Windows Virtual Machine resource
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified VM status in Azure Portal
- Confirmed public IP assignment
- Confirmed subnet and NSG association

## Outcome
This phase introduces the web tier compute layer and prepares the environment for application hosting.