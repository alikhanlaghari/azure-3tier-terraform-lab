# Phase 09 — Monitoring and Alerting

## Monitoring Architecture Design

The monitoring design follows a centralized observability model:

- A single Log Analytics Workspace is used as the central data store  
- Azure Monitor collects metrics and logs from all resources  
- Diagnostic settings send logs to the workspace  
- Alerts are configured based on key operational signals  

### Data Flow

Resources → Azure Monitor → Log Analytics Workspace → Alerts / Dashboards

### Design Principles

- Centralized logging  
- Minimal overhead  
- Production-style observability  
- Separation of deployment and operations phases  

---

## Monitoring Signals and Alert Strategy

The monitoring baseline for this lab focuses on operationally important signals that reflect real-world infrastructure support and cloud operations practices.

### Key Monitoring Signals

#### 1. VM Heartbeat  
Used to verify that each virtual machine is actively reporting to Azure Monitor.  
A missing heartbeat may indicate:

- The VM is powered off  
- The VM is unreachable  
- The monitoring agent is not functioning correctly  
- Connectivity or platform issues  

---

#### 2. High CPU Utilization  
Used to detect resource pressure or abnormal workload behavior.  
Helps identify performance issues before they become service outages.

---

#### 3. Load Balancer Health  
Used to monitor backend availability through health probe status.  
Helps detect application-side availability problems even when the VM itself is still running.

---

#### 4. Azure Activity Logs  
Used to track administrative actions and configuration changes such as:

- VM start/stop events  
- NSG changes  
- Resource deletion  

---

### Initial Alerting Plan

- Alert if VM heartbeat is missing  
- Alert if CPU is above threshold  
- Alert if load balancer backend becomes unhealthy  
- Review activity logs for administrative changes  

---

### Operational Value

This monitoring strategy improves visibility across:

- Infrastructure health  
- Performance  
- Availability  
- Operational change tracking  

It reflects how real-world cloud environments are monitored in production scenarios.

---

## Alert Notification Strategy

An Azure Monitor Action Group is used to define how alerts are delivered.

### Configuration

- Email notification is configured for alert delivery  
- Action group is reusable across multiple alert rules  

### Purpose

Ensures that when a monitoring alert is triggered, the operator is notified and can take action.

This reflects real-world operational practices where alerts are centrally managed and routed.

---

## Alert Rule 1 — VM Heartbeat Missing

### Purpose

Detect when a virtual machine stops sending heartbeat data to Azure Monitor.

---

### Why It Matters

A missing heartbeat may indicate:

- VM is powered off  
- VM is unreachable  
- Monitoring agent failure  
- Connectivity or platform issues  

---

### Initial Scope

The first implementation targets the Web VM.  
This pattern can later be extended to App and DB tiers.

---

### Alert Logic

- Signal: Log Analytics (Custom log search)  
- Measurement: Table rows  
- Operator: Equal to  
- Threshold: 0  
- Evaluation Frequency: 5 minutes  

---

### KQL Query

```kql
Heartbeat
| where Computer == "vm-web-01"
| where TimeGenerated > ago(5m)
```
## Validation (Test Performed)

- Web VM was manually stopped  
- Heartbeat data stopped flowing  
- Query returned zero rows  
- Alert condition was met  
- Alert triggered successfully  

---

## Evidence

*(Add screenshot here)*

---

## Operational Response

If this alert fires:

1. Check whether the VM is running  
2. Review Azure Activity Logs for stop/deallocate events  
3. Test connectivity (Bastion / RDP / SSH)  
4. Verify monitoring agent health  
5. Check NSG and network configuration  

---

## Alert Rule 2 — High CPU on Web VM

### Purpose

Detect high CPU usage indicating performance issues.

---

### Why It Matters

High CPU can lead to:

- Slow application response  
- Degraded user experience  
- Potential service outages  

---

### Alert Logic

- Metric: Percentage CPU  
- Threshold: Greater than 80%  
- Duration: 5 minutes  

---

### Operational Response

1. Check running processes  
2. Verify workload behavior  
3. Review recent deployments  
4. Consider scaling or optimization  

---

## Alert Rule 3 — Load Balancer Backend Health

### Purpose

Monitor backend availability through Azure Load Balancer.

---

### Why It Matters

Application may fail even if VM is running due to:

- Application crash  
- Misconfiguration  
- Port or NSG issues  
- Failed health probes  

---

### Alert Logic

- Metric: DipAvailability  
- Threshold: Less than 100%  
- Duration: 5 minutes  

---

### Operational Response

1. Check backend VM health  
2. Verify application service  
3. Validate health probe configuration  
4. Review NSG rules  
5. Test connectivity manually  

---

### Operational Value

Provides service-level monitoring, not just infrastructure-level visibility.

---

## Alert Rule 4 — Administrative Change Detection

### Purpose

Detect critical administrative actions such as resource deletion.

---

### Why It Matters

Many incidents are caused by:

- Configuration changes  
- Accidental deletions  
- Administrative actions  

---

### Initial Scope

Monitor resource group for delete operations.

---

### Operational Response

1. Review Azure Activity Log  
2. Identify affected resource  
3. Confirm who performed the action  
4. Evaluate service impact  
5. Decide recovery actions  

---

### Operational Value

Improves audit visibility, troubleshooting, and operational control.

---

## KQL Queries for Troubleshooting

### VM Heartbeat Status

```kql
Heartbeat
| summarize LastHeartbeat = max(TimeGenerated) by Computer
| sort by LastHeartbeat desc
```



## Incident Playbook 

### Severity Model

- **P1 (Critical):** Service down / user impact across system → Immediate action  
- **P2 (High):** Degraded performance / partial outage → Action within 15 minutes  
- **P3 (Medium):** No immediate user impact → Investigate within business hours  

---

### Scenario 1 — VM Heartbeat Missing

**Alert:** VM Heartbeat Missing  
**Severity:** P1 (Critical)  

#### Possible Causes

- VM stopped or deallocated  
- Network connectivity issue  
- Monitoring agent failure  

#### Detection Signal

- Log Analytics query returns **0 rows** (no heartbeat)  

#### Immediate Actions (0–5 min)

1. Check VM status in Azure Portal  
2. Review Activity Logs for stop/deallocate events  
3. Attempt connection (Bastion / RDP / SSH)  

#### Investigation (5–15 min)

1. Verify Azure Monitor Agent status  
2. Check NSG rules and subnet routing  
3. Validate DNS / connectivity  

#### Resolution

- Start VM if stopped  
- Fix NSG / routing issue  
- Restart monitoring agent  

#### Escalation

- Escalate to Cloud / Platform team if VM is unresponsive  

---

### Scenario 2 — Application Not Reachable (Load Balancer Health)

**Alert:** Load Balancer Backend Health  
**Severity:** P1 / P2  

#### Possible Causes

- Application service down  
- Health probe failure  
- NSG blocking traffic  

#### Detection Signal

- DipAvailability < 100%  

#### Immediate Actions (0–5 min)

1. Check Load Balancer backend pool status  
2. Verify health probe configuration  

#### Investigation (5–15 min)

1. Check application service on VM (IIS / app process)  
2. Test direct VM access (bypass LB)  
3. Review NSG rules and ports  

#### Resolution

- Restart application service  
- Fix probe path/port  
- Correct NSG rules  

#### Escalation

- Escalate to Application team if service is failing  

---

### Scenario 3 — High CPU Usage

**Alert:** High CPU on Web VM  
**Severity:** P2 (High)  

#### Possible Causes

- High application load  
- Inefficient processes  
- Background tasks  

#### Detection Signal

- CPU > 80% for 5 minutes  

#### Immediate Actions (0–5 min)

1. Check CPU metrics in Azure Monitor  
2. Identify top processes on VM  

#### Investigation (5–15 min)

1. Review application logs  
2. Check recent deployments or changes  
3. Analyze traffic patterns  

#### Resolution

- Restart affected service  
- Optimize workload  
- Scale VM if required  

#### Escalation

- Escalate to Application / DevOps team if recurring  

---

### Scenario 4 — Administrative Change Detection

**Alert:** Resource Group Delete Activity  
**Severity:** P1 (Critical)  

#### Possible Causes

- Accidental deletion  
- Unauthorized change  
- Planned maintenance  

#### Detection Signal

- Activity Log event: Resource Group delete  

#### Immediate Actions (0–5 min)

1. Open Activity Logs  
2. Identify affected resource(s)  
3. Confirm user/action  

#### Investigation (5–15 min)

1. Assess service impact  
2. Check dependencies  
3. Review audit trail  

#### Resolution

- Restore from backup (if applicable)  
- Redeploy infrastructure via Terraform  

#### Escalation

- Escalate to Security / Platform team if suspicious  

---

### SLA & Response Expectations

| Severity | Response Time | Resolution Target |
|----------|-------------|------------------|
| P1       | Immediate   | < 1 hour         |
| P2       | < 15 min    | < 4 hours        |
| P3       | Business hrs| Best effort      |

---

### Operational Notes

- Alert evaluation may take **5–10 minutes**  
- Log ingestion delay should be considered  
- Always validate alerts with test scenarios  

