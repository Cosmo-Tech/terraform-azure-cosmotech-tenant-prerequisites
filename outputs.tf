output "out_platform_name" {
  value = module.create-apps.out_platform_name
}

output "out_platform_client_id" {
  value = module.create-apps.out_platform_client_id
}

output "out_platform_sp_object_id" {
  value = module.create-apps.out_platform_sp_object_id
}

output "out_platform_password" {
  value     = var.create_secret_platform ? module.create-apps.out_platform_password : null
  sensitive = true
}

output "out_nerwork_name" {
  value = module.create-apps.out_nerwork_name
}

output "out_network_client_id" {
  value = module.create-apps.out_network_client_id
}

output "out_network_sp_object_id" {
  value = module.create-apps.out_network_sp_object_id
}

output "out_network_password" {
  value     = var.create_secret_network ? module.create-apps.out_network_password : null
  sensitive = true
}

output "out_swagger_name" {
  value = module.create-apps.out_swagger_name
}

output "out_swagger_client_id" {
  value = module.create-apps.out_swagger_client_id
}

output "out_restish_name" {
  value = module.create-apps.out_restish_name
}

output "out_restish_client_id" {
  value = module.create-apps.out_restish_client_id
}

output "out_restish_password" {
  value     = var.create_secret_restish ? module.create-apps.out_restish_password : null
  sensitive = true
}

output "out_powerbi_name" {
  value = var.create_powerbi ? module.create-apps.out_powerbi_name : null
}

output "out_powerbi_client_id" {
  value = var.create_powerbi ? module.create-apps.out_powerbi_client_id : null
}

output "out_powerbi_password" {
  value     = var.create_powerbi && var.create_secret_powerbi ? module.create-apps.out_powerbi_password : null
  sensitive = true
}

output "out_babylon_client_id" {
  value = var.create_babylon ? module.create-apps.out_babylon_client_id : null
}

output "out_babylon_sp_ojbect_id" {
  value = var.create_babylon ? module.create-apps.out_babylon_sp_ojbect_id : null
}

output "out_babylon_secret" {
  value     = var.create_secret_babylon ? module.create-apps.out_babylon_secret : null
  sensitive = true
}

output "out_cosmo_api_uri" {
  value = module.create-apps.out_cosmo_api_uri
}