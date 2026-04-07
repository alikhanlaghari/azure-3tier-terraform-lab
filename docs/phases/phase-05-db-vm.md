# Phase 05 – Database Tier Virtual Machine

## Objective
Deploy the database VM as the final layer in the 3-tier architecture using Terraform.

## Resources Deployed
- Network Interface: `nic-db-vm`
- Virtual Machine: `vm-db-01`

## Configuration Details
- OS: Windows Server 2022 Datacenter Azure Edition
- Size: Standard_D2ads_v7
- Subnet: `snet-db`
- Public Access: Disabled (fully private)

## Terraform Actions
- Defined NIC for database tier
- Defined Windows Virtual Machine resource
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified VM status in Azure Portal
- Confirmed private IP assignment
- Confirmed no public IP exposure

## Outcome
This phase completes the 3-tier architecture with a secure database layer isolated from public access.