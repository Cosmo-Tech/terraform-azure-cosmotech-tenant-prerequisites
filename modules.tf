module "create-apps" {
  source = "./create-apps"

  audience                     = var.audience
  pre_name                     = local.pre_name
  post_name                    = local.post_name
  identifier_uri               = var.identifier_uri
  image_path                   = var.image_path
  project_stage                = var.project_stage
  customer_name                = var.customer_name
  project_name                 = var.project_name
  platform_url                 = var.platform_url
  api_version_path             = var.api_version_path
  user_app_role                = var.user_app_role
  tenant_namespace             = var.tenant_namespace
  tenant_resource_group        = var.tenant_resource_group
  network_resource_group       = var.network_resource_group
  create_restish               = var.create_restish
  create_powerbi               = var.create_powerbi
  create_babylon               = var.create_babylon
  create_secret_platform       = var.create_secret_platform
  create_secret_network        = var.create_secret_network
  create_secret_restish        = var.create_secret_restish
  create_secret_powerbi        = var.create_secret_powerbi
  create_secret_babylon        = var.create_secret_babylon
  owner_list                   = var.owner_list
  tenant_resource_group_object = azurerm_resource_group.tenant_rg
}

module "create-vnet" {
  source = "./create-vnet"

  vnet_iprange         = var.vnet_iprange
  project_stage        = var.project_stage
  customer_name        = var.customer_name
  project_name         = var.project_name
  vnet_location        = var.vnet_location
  cost_center          = var.cost_center
  subscription_id      = var.subscription_id
  vnet_name            = var.vnet_name
  subnet_name          = var.subnet_name
  subnet_iprange       = var.subnet_iprange
  vnet_resource_group  = var.vnet_resource_group
  network_sp_object_id = module.create-apps.out_network_sp_object_id

  depends_on = [module.create-apps]
}

module "create-publicip" {
  source = "./create-publicip"

  publicip_name           = var.publicip_name
  create_publicip         = var.create_publicip
  create_dns_record       = var.create_dns_record
  customer_name           = var.customer_name
  publicip_location       = var.publicip_location
  cost_center             = var.cost_center
  project_name            = var.project_name
  project_stage           = var.project_stage
  dns_record              = var.dns_record
  dns_zone_name           = var.dns_zone_name
  dns_zone_resource_group = var.dns_zone_resource_group
  publicip_resource_group = azurerm_resource_group.network_rg
  network_sp_object_id    = module.create-apps.out_network_sp_object_id
  platform_sp_object_id   = module.create-apps.out_platform_sp_object_id

  depends_on = [module.create-apps]
}
