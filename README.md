# Azure 3-Tier Architecture Lab (Terraform)

## Overview
This project demonstrates a production-style Azure 3-tier architecture using Terraform.

The lab is designed to simulate real-world enterprise infrastructure with proper networking, security, and scalability practices.

## Architecture
- Web Tier (Frontend)
- App Tier (Backend)
- Database Tier

## Technologies Used
- Microsoft Azure
- Terraform (AzureRM Provider)
- Git & GitHub
- Azure Portal (validation)

## Project Structure
- terraform/ → Infrastructure as Code
- docs/ → Documentation per phase
- screenshots/ → Evidence and validation

## Lab Phases
- Phase 0 – Setup & Repo Initialization
- Phase 1 – Terraform Base Configuration
- Phase 2 – Resource Group
- Phase 3 – Networking
- Phase 4 – Security
- Phase 5 – Compute
- Phase 6 – Validation & Documentation
- Phase 7 – Load Balancer
- Phase 8 – Azure Bastion
- Phase 9 – Monitoring

## 🚀 Deployed Components
- Resource Group
- Virtual Network with segmented subnets (Web, App, DB, Bastion)
- Network Security Group for Web tier
- Web VM (Public)
- App VM (Private)
- DB VM (Private)
- Azure Load Balancer (High Availability)
- Azure Bastion (Secure Access)

---

## 🏗️ Architecture Diagram

```mermaid
flowchart TD
    U[Users / Internet] --> PIPLB[Public IP - Load Balancer]
    PIPLB --> LB[Azure Load Balancer]
    LB --> WEB[Web VM - vm-web-01]

    WEB --> APP[App VM - vm-app-01]
    APP --> DB[DB VM - vm-db-01]

    subgraph RG[Resource Group: rg-azure-3tier-lab]
        subgraph VNET[Virtual Network: vnet-3tier-lab | 10.0.0.0/16]
            subgraph WEBNET[Web Subnet: snet-web | 10.0.1.0/24]
                WEB
                NSG[NSG: nsg-web]
            end

            subgraph APPNET[App Subnet: snet-app | 10.0.2.0/24]
                APP
            end

            subgraph DBNET[DB Subnet: snet-db | 10.0.3.0/24]
                DB
            end

            subgraph BASTIONNET[AzureBastionSubnet | 10.0.10.0/26]
                BAS[Azure Bastion: bas-3tier-lab]
            end
        end
    end

    BAS --> WEB
    BAS --> APP
    BAS --> DB
    NSG --> WEB

---

##  How to Deploy

### Prerequisites:
- Azure subscription
- Terraform installed
- Azure CLI installed
- Git installed

### Steps:
- git clone https://github.com/alikhanlaghari/azure-3tier-terraform-lab.git
- cd azure-3tier-terraform-lab
- az login
- cd terraform
- terraform init
- terraform plan
- terraform apply and Type: yes

---

This lab is built step-by-step with a focus on clarity, structure, and real-world practices.