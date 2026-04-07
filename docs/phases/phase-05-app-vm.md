# Phase 05 – Application Tier Virtual Machine

## Objective
Deploy the backend application VM as part of the 3-tier architecture using Terraform.

## Resources Deployed
- Network Interface: `nic-app-vm`
- Virtual Machine: `vm-app-01`

## Configuration Details
- OS: Windows Server 2022 Datacenter Azure Edition
- Size: Standard_D2ads_v7
- Subnet: `snet-app`
- Public Access: Disabled (private subnet only)

## Terraform Actions
- Defined NIC for app tier (no public IP)
- Defined Windows Virtual Machine resource
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified VM status in Azure Portal
- Confirmed private IP assignment
- Confirmed no public IP exposure

## Outcome
This phase introduces the application layer, following secure enterprise design principles with no direct public access.