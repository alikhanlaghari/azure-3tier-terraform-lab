# Phase 10 — Load Balancer Failover & High Availability Validation

## Objective

Validate Azure Load Balancer high availability behavior by simulating a backend failure and observing:

- Health probe detection  
- Automatic traffic failover  
- Monitoring metrics response  

---

## Architecture Overview

- 2 Web VMs:
  - vm-web-01
  - vm-web-02  
- Azure Load Balancer (lb-web)  
- Backend pool with both VMs  
- Health Probe (HTTP / IIS)  
- Load Balancing Rule (Port 80)  

---

## Step 1 — IIS Installation on Both VMs

IIS was installed on both backend virtual machines.

### Evidence

![IIS Installed VM Web 01](../screenshots/phase-10/01-iis-installed-vm-web-01.png)  
![IIS Installed VM Web 02](../screenshots/phase-10/02-iis-installed-vm-web-02.png)

---

## Step 2 — VM Identity Pages

Custom index pages were created on each VM to identify traffic routing:

- vm-web-01 → "Hello from vm-web-01"  
- vm-web-02 → "Hello from vm-web-02"  

### Evidence

![VM Identity Pages](../screenshots/phase-10/03-vm-identity-pages.png)

---

## Step 3 — Load Balancer Working

Verified that the Load Balancer distributes traffic across both VMs.

### Evidence

![Load Balancer Working](../screenshots/phase-10/04-lb-working.png)

---

## Step 4 — Simulating Backend Failure

To simulate application-level failure, IIS was stopped on **vm-web-01**:

```powershell
Stop-Service W3SVC
```
---

## Step 5 — Failover Validation

### Observations

- Azure Load Balancer health probe marked **vm-web-01** as unhealthy  
- Traffic was automatically redirected to **vm-web-02**  

### Expected Behavior

- Only **vm-web-02** should respond  
- No downtime observed  

### Evidence

![IIS Stopped VM Web 01](../screenshots/phase-10/05-iis-stopped-vm-web-01.png)  
![Failover Success](../screenshots/phase-10/07-failover-success.png)

---

## Step 6 — Monitoring & Metrics Validation

Azure Monitor was used to validate backend health behavior.

### Metric Used

- **Health Probe Status (Average)**  

### Observations

- Initial state: ~100% (both VMs healthy)  
- After stopping IIS: ~50% (one VM unhealthy)  
- Confirms health probe detection and failover behavior  

### Evidence

![Health Probe Drop](../screenshots/phase-10/06-health-probe-drop.png)

---

## Key Outcomes

- Successfully simulated backend application failure using PowerShell  
- Azure Load Balancer detected failure using health probes  
- Traffic automatically redirected to healthy VM  
- No service downtime observed  
- Monitoring metrics reflected real-time backend health changes  

---

## Conclusion

This phase demonstrates a **production-style high availability pattern in Azure**:

- Fault detection via health probes  
- Automatic failover  
- Real-time monitoring visibility  

This validates that the architecture can handle backend failures gracefully without impacting end users.

---

## Skills Demonstrated

- Azure Load Balancer configuration  
- Health probe design and validation  
- Failure simulation using PowerShell  
- High Availability architecture understanding  
- Azure Monitor metrics analysis  