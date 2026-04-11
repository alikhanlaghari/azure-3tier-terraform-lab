# ---------------------------------------
# Get current subscription details
# ---------------------------------------
data "azurerm_client_config" "current" {}

# ---------------------------------------
# Log Analytics Workspace
# ---------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-az3tier-lab"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  depends_on = [
    azurerm_resource_group.main
  ]
}

# ---------------------------------------
# Action Group (Alert Notification)
# ---------------------------------------
resource "azurerm_monitor_action_group" "main" {
  name                = "ag-az3tier-lab"
  resource_group_name = var.resource_group_name
  short_name          = "aglab"

  depends_on = [
    azurerm_resource_group.main
  ]

  email_receiver {
    name          = "admin-email"
    email_address = "khanlaghari@gmail.com"
  }
}

# ---------------------------------------
# Alert 1 — VM Heartbeat (keep disabled for now)
# ---------------------------------------
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "web_vm_heartbeat_alert" {
  name                = "alert-web-vm-heartbeat-missing"
  resource_group_name = var.resource_group_name
  location            = var.location

  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"
  scopes               = [azurerm_log_analytics_workspace.law.id]
  severity             = 1
  enabled              = false

  criteria {
    query = <<-QUERY
Heartbeat
| where Computer contains "web"
| summarize LastHeartbeat = max(TimeGenerated) by Computer
| where LastHeartbeat < ago(10m)
QUERY

    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0
  }

  action {
    action_groups = [azurerm_monitor_action_group.main.id]
  }

  description = "Alert when the Web VM stops sending heartbeat data."

  depends_on = [
    azurerm_log_analytics_workspace.law,
    azurerm_monitor_action_group.main
  ]
}

# ---------------------------------------
# Alert 2 — CPU on Web VM
# ---------------------------------------
resource "azurerm_monitor_metric_alert" "web_vm_cpu_high" {
  name                = "alert-web-vm-high-cpu"
  resource_group_name = var.resource_group_name

  scopes = [
    azurerm_windows_virtual_machine.web_vm.id
  ]

  description = "Alert when Web VM CPU exceeds 80%"
  severity    = 2
  enabled     = true

  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  depends_on = [
    azurerm_windows_virtual_machine.web_vm,
    azurerm_monitor_action_group.main
  ]
}

# ---------------------------------------
# Alert 3 — Load Balancer Health
# ---------------------------------------
resource "azurerm_monitor_metric_alert" "lb_health_alert" {
  name                = "alert-lb-backend-health"
  resource_group_name = var.resource_group_name

  scopes = [
    azurerm_lb.web_lb.id
  ]

  description = "Alert when Load Balancer backend availability drops"
  severity    = 1
  enabled     = true

  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Network/loadBalancers"
    metric_name      = "DipAvailability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  depends_on = [
    azurerm_lb.web_lb,
    azurerm_monitor_action_group.main
  ]
}

# ---------------------------------------
# Alert 4 — Activity Log (Resource Group Delete Detection)
# ---------------------------------------
resource "azurerm_monitor_activity_log_alert" "resource_delete_alert" {
  name                = "alert-resource-group-delete"
  resource_group_name = var.resource_group_name

  scopes = [
    "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  ]

  enabled = true

  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.Resources/subscriptions/resourceGroups/delete"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  description = "Alert when a resource group delete operation is triggered in the subscription."

  depends_on = [
    azurerm_monitor_action_group.main
  ]
}