# Phase 07 – Load Balancer (High Availability)

## Objective
Introduce high availability for the web tier using Azure Load Balancer.

## Resources Deployed
- Public IP: `pip-lb`
- Load Balancer: `lb-web`
- Backend Pool: `web-backend-pool`

## Configuration Details
- Frontend: Public IP (Static)
- Backend: Web VM (`vm-web-01`)
- Protocol: HTTP (Port 80)
- Health Probe: HTTP probe on port 80

## Terraform Actions
- Defined Public IP for Load Balancer
- Created Load Balancer resource
- Created backend address pool
- Associated web NIC to backend pool
- Created health probe
- Created load balancing rule
- Ran `terraform plan`
- Ran `terraform apply`

## Validation
- Verified Load Balancer in Azure Portal
- Confirmed backend pool association
- Confirmed health probe and rule configuration

## Outcome
This phase introduces high availability by routing traffic through a centralized Load Balancer instead of direct VM access.