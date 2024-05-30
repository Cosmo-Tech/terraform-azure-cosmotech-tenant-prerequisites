output "out_platform_name" {
  value = azuread_application.platform.display_name
}

output "out_platform_client_id" {
  value = azuread_application.platform.client_id
}

output "out_platform_sp_object_id" {
  value = azuread_service_principal.platform.id
}

output "out_platform_password" {
  value     = var.create_secret_platform ? azuread_application_password.platform_password[0].value : null
  sensitive = true
}

output "out_nerwork_name" {
  value = azuread_application.network_adt.display_name
}

output "out_network_client_id" {
  value = azuread_application.network_adt.client_id
}

output "out_network_sp_object_id" {
  value = azuread_service_principal.network_adt.object_id
}

output "out_network_password" {
  value     = var.create_secret_network ? azuread_application_password.network_adt_password[0].value : null
  sensitive = true
}

output "out_swagger_name" {
  value = azuread_application.swagger.display_name
}

output "out_swagger_client_id" {
  value = azuread_application.swagger.client_id
}

output "out_restish_name" {
  value = var.create_restish ? azuread_application.restish.0.display_name : null
}

output "out_restish_client_id" {
  value = var.create_restish ? azuread_application.restish.0.client_id : null
}

output "out_restish_password" {
  value     = var.create_secret_restish ? azuread_application_password.restish_password[0].value : null
  sensitive = true
}

output "out_powerbi_name" {
  value = var.create_powerbi ? azuread_application.powerbi.0.display_name : null
}

output "out_powerbi_client_id" {
  value = var.create_powerbi ? azuread_application.powerbi.0.client_id : null
}

output "out_powerbi_password" {
  value     = var.create_powerbi && var.create_secret_powerbi ? azuread_application_password.powerbi_password[0].value : null
  sensitive = true
}

output "out_babylon_client_id" {
  value = var.create_babylon ? azuread_application.babylon.0.client_id : null
}

output "out_babylon_sp_ojbect_id" {
  value = var.create_babylon ? azuread_service_principal.babylon.0.object_id : null
}

output "out_babylon_secret" {
  value     = var.create_secret_babylon ? azuread_application_password.babylon_password.0.value : null
  sensitive = true
}

output "out_cosmo_api_uri" {
  value = var.use_identifier_uri_appId ? "api://${azuread_application.platform.client_id}" : var.identifier_uri
}
