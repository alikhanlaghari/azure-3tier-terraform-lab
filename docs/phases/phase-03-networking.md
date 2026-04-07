# Phase 03 – Virtual Network and Subnets

## Objective
Design and deploy a structured virtual network with segmented subnets for a 3-tier architecture.

## Resources Deployed
- Virtual Network: `vnet-3tier-lab`
- Address Space: `10.0.0.0/16`

### Subnets
- Web Tier: `snet-web` → 10.0.1.0/24
- App Tier: `snet-app` → 10.0.2.0/24
- Database Tier: `snet-db` → 10.0.3.0/24
- Bastion Subnet: `AzureBastionSubnet` → 10.0.10.0/26

## Terraform Actions
- Updated `main.tf` to include VNet and subnet resources
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
Verified VNet and subnets in Azure Portal.

## Outcome
This phase establishes network segmentation and prepares the foundation for secure multi-tier deployment.