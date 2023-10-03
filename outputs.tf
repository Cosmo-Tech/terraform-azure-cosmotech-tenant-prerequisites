output "out_platform_name" {
  value = azuread_application.platform.display_name
}

output "out_tenant_id" {
  value = var.tenant_id
}

output "out_platform_clientid" {
  value = azuread_application.platform.application_id
}

output "out_platform_sp_object_id" {
  value = azuread_service_principal.platform.id
}

output "out_platform_password" {
  value     = var.create_secrets ? azuread_application_password.platform_password[0].value : null
  sensitive = true
}

output "out_nerworkadt_name" {
  value = azuread_application.network_adt.display_name
}

output "out_networkadt_sp_objectid" {
  value = azuread_service_principal.network_adt.object_id
}

output "out_networkadt_clientid" {
  value = azuread_application.network_adt.application_id
}

output "out_network_adt_password" {
  value     = var.create_secrets ? azuread_application_password.network_adt_password[0].value : null
  sensitive = true
}

output "out_platform_url" {
  value = var.platform_url
}

output "out_identifier_uri" {
  value = var.identifier_uri
}

output "out_swagger_name" {
  value = azuread_application.swagger.display_name
}

output "out_swagger_clientid" {
  value = azuread_application.swagger.application_id
}

output "out_restish_password" {
  value     = var.create_secrets ? azuread_application_password.restish_password[0].value : null
  sensitive = true
}

output "out_restish_name" {
  value = azuread_application.restish[0].display_name
}

output "out_restish_clientid" {
  value = azuread_application.restish[0].application_id
}

output "out_powerbi_name" {
  value = var.create_powerbi ? azuread_application.powerbi[0].display_name : null
}

output "out_powerbi_clientid" {
  value = var.create_powerbi ? azuread_application.powerbi[0].application_id : null
}

output "out_powerbi_password" {
  value     = var.create_powerbi && var.create_secrets ? azuread_application_password.powerbi_password[0].value : null
  sensitive = true
}

output "out_webapp_name" {
  value = var.create_webapp ? azuread_application.webapp[0].display_name : null
}

output "out_webapp_clientid" {
  value = var.create_webapp ? azuread_application.webapp[0].application_id : null
}

output "out_ip_resource_group" {
  value = azurerm_resource_group.tenant_rg.name
}

output "out_vnet" {
  value = azurerm_virtual_network.tenant_vnet.name
}

output "out_vnet_resource_group" {
  value = azurerm_resource_group.tenant_rg.name
}

output "out_platform_resource_group_id" {
  value = azurerm_resource_group.tenant_rg.id
}

output "out_subnet_name" {
  value = local.subnet_name
}

locals {
  subscription = "/subscriptions/${var.subscription_id}"
  rg_name      = "resourceGroups/${var.tenant_resource_group}"
  vnet_name    = "${azurerm_virtual_network.tenant_vnet.name}/subnets/${local.subnet_name}"
}

output "out_subnet_id" {
  value = "${local.subscription}/${local.rg_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}"
}

output "out_private_dns_zone_id" {
  value = data.azurerm_private_dns_zone.platform.id
}

output "out_platform_sp_client_id" {
  value = azuread_application.platform.application_id
}

output "out_platform_sp_client_secret" {
  value = var.create_secrets ? azuread_application_password.platform_password.0.value : null
}

output "out_babylon_client_id" {
  value = var.create_babylon ? azuread_application.babylon.application_id : null
}

output "out_babylon_principal_id" {
  value = var.create_babylon ? azuread_service_principal.babylon.object_id : null
}

output "out_babylon_principal_secret" {
  value = var.create_secrets ? azuread_application_password.babylon_password.0.value : null
}

output "out_cosmos_api_url" {
  value = local.identifier_uri
}