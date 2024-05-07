locals {
  pre_name     = "Cosmo Tech "
  post_name    = " ${var.network_resource_group} For ${var.tenant_resource_group}"
  subnet_name  = "default"
  vnetname     = var.vnet_name != "" ? var.vnet_name : substr("CosmoTech${var.customer_name}${var.project_name}${var.project_stage}VNet", 0, 80)
  vnet_iprange = var.vnet_iprange != "" ? var.vnet_iprange : "10.21.0.0/16"
  tags = {
    vendor      = "cosmotech"
    stage       = var.project_stage
    customer    = var.customer_name
    project     = var.project_name
    cost_center = var.cost_center
  }
}

# Resource group network
resource "azurerm_resource_group" "network_rg" {
  name     = var.vnet_resource_group
  location = var.location
  tags     = local.tags
}

# Resource group
resource "azurerm_resource_group" "tenant_rg" {
  name     = var.tenant_resource_group
  location = var.location
  tags     = local.tags
}
