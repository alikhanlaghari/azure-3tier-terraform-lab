# Phase 11 — Availability Zones (Datacenter-Level High Availability)

---

## 🎯 Objective
Enhance the web tier to survive **datacenter-level failures** by distributing VMs across multiple Azure Availability Zones.

---

## 🏗️ Architecture Upgrade
- Deployed **vm-web-01 → Zone 1**
- Deployed **vm-web-02 → Zone 2**
- Both VMs attached to **Azure Standard Load Balancer**
- Health probe configured on **HTTP (port 80)**

---

## ⚙️ Implementation

### 1. Terraform Changes (Availability Zones)

Added zone configuration inside VM resources:

```hcl
resource "azurerm_windows_virtual_machine" "web_vm" {
  name     = "vm-web-01"
  zone     = "1"
  ...
}

resource "azurerm_windows_virtual_machine" "web_vm_02" {
  name     = "vm-web-02"
  zone     = "2"
  ...
}
```

---

### 2. Infrastructure Deployment

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

### 3. IIS Configuration (Manual – via Bastion)

Installed IIS on both VMs:

```powershell
Install-WindowsFeature -name Web-Server -IncludeManagementTools
```

---

### 4. Create Unique Test Pages (CRITICAL)

#### On vm-web-01 (Zone 1):

```powershell
echo "<h1>WEB-VM-01 ZONE-01</h1>" > C:\inetpub\wwwroot\iisstart.htm
```

#### On vm-web-02 (Zone 2):

```powershell
echo "<h1>WEB-VM-02 ZONE-02</h1>" > C:\inetpub\wwwroot\iisstart.htm
```

---

## 🔍 Validation Steps

### ✅ Step 1 — Verify Zone Placement

Confirmed via Azure Portal:

- vm-web-01 → Zone 1  
- vm-web-02 → Zone 2  

📸 Evidence:

![VM Zone 1](screenshots/phase-11/vm-web-01-zone-1-overview.png)  
![VM Zone 2](screenshots/phase-11/vm-web-02-zone-2-overview.png)

---

### ✅ Step 2 — Verify Load Balancer Backend

Confirmed both VMs are part of backend pool:

📸 Evidence:

![Backend Pool](screenshots/phase-11/lb-backend-health-status.png)

---

### ✅ Step 3 — Validate Load Balancer Traffic

Accessed Load Balancer Public IP in browser:

```
http://20.61.218.172
```

Refreshed multiple times:

- Response switches between VMs  
- Confirms traffic distribution  

📸 Evidence:

![VM 1 Response](screenshots/phase-11/lb-vm01-response.png)  
![VM 2 Response](screenshots/phase-11/lb-vm02-response.png)

---

### ✅ Step 4 — Monitor Backend Health (DipAvailability)

Checked metric:

- Metric: **DipAvailability**
- Expected: ~100% when healthy

📸 Evidence:

![DipAvailability](screenshots/phase-11/lb-health-dipavailability.png)

---

## 📊 Results

- Traffic successfully distributed across **multiple zones**
- Load Balancer correctly routes to **healthy instances**
- System remains available even if:
  - One VM fails  
  - One zone becomes unavailable  

---

## 🧠 Key Learning

- Availability Zones provide **datacenter-level resilience**
- Load Balancer ensures **continuous service**
- Health probes enable **automatic failover**

---

## 🏥 Real-World Relevance

This architecture pattern is used in:

- Healthcare systems (Helse Nord / hospitals)
- Public sector infrastructure (kommuner)
- Banking & telecom platforms
- Enterprise cloud applications requiring high uptime

---

## 📸 Screenshots (Evidence Mapping)

| Screenshot | Purpose |
|----------|--------|
| vm-web-01-zone-1-overview.png | VM deployed in Zone 1 |
| vm-web-02-zone-2-overview.png | VM deployed in Zone 2 |
| lb-backend-health-status.png | Backend pool configuration |
| lb-vm01-response.png | Load balancer routing to VM 1 |
| lb-vm02-response.png | Load balancer routing to VM 2 |
| lb-health-dipavailability.png | Health monitoring proof |

---

## 🚀 Conclusion

This phase demonstrates a transition from:

👉 Basic High Availability  
➡️ **Enterprise-grade Resilience (Zone-aware design)**

---

## 🔜 Next Step

👉 VM Scale Set (Auto-scaling + self-healing)

This will introduce:
- automatic scaling
- automatic recovery
- production-grade cloud behavior