# Phase 04 – Network Security Groups (NSG)

## Objective
Implement basic network security controls for the web tier using Azure Network Security Groups.

## Resources Deployed
- Network Security Group: `nsg-web`

## Security Rules
- Allow HTTP (Port 80) → for web traffic
- Allow RDP (Port 3389) → for administrative access

## Terraform Actions
- Added NSG resource
- Added inbound security rules
- Associated NSG with web subnet (`snet-web`)
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified NSG rules in Azure Portal
- Confirmed NSG association with web subnet

## Outcome
This phase introduces network-level security and prepares the web tier for controlled access and management.