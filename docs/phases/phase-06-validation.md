# Phase 06 – Validation & Documentation

## Objective
Validate all deployed resources and ensure the infrastructure behaves as expected.

## Validation Steps

### Resource Group
- Confirmed creation in Azure Portal
- Verified location and naming

### Networking
- Verified VNet and subnet segmentation (web, app, db, bastion)
- Confirmed correct IP ranges

### Security (NSG)
- Checked inbound rules for HTTP (80) and RDP (3389)
- Verified NSG association with web subnet

### Compute
- Verified deployment of:
  - Web VM (public access)
  - App VM (private)
  - DB VM (private)
- Confirmed VM status: Running

### Connectivity
- Verified public access to Web VM
- Confirmed no public exposure for App and DB tiers

### Infrastructure as Code
- Ran `terraform plan` → no changes
- Confirmed state consistency

## Documentation
- Captured screenshots for each phase
- Organized project into structured folders
- Maintained clean commit history

## Outcome
All infrastructure components were successfully validated.  
The environment reflects a production-style 3-tier architecture with proper segmentation, security, and deployment practices.