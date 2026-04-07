# Phase 08 – Azure Bastion (Secure Access)

## Objective
Enable secure access to virtual machines without exposing them to the public internet.

## Resources Deployed
- Public IP: `pip-bastion`
- Azure Bastion Host: `bas-3tier-lab`

## Configuration Details
- Subnet: `AzureBastionSubnet`
- Access Method: Browser-based RDP/SSH via Azure Portal
- Public Exposure: Only Bastion is exposed, not VMs

## Terraform Actions
- Defined Public IP for Bastion
- Created Azure Bastion resource
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified Bastion host in Azure Portal
- Confirmed successful provisioning state
- Confirmed connectivity capability to private VMs

## Outcome
This phase secures administrative access by eliminating direct public exposure of virtual machines, aligning with enterprise security best practices.