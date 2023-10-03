locals {
  pre_name         = "Cosmo Tech "
  post_name        = " ${var.platform_resource_group} For ${var.tenant_resource_group}"
  subnet_name      = "default"
  identifier_uri   = "https://${var.dns_record}.${var.dns_zone_name}/${var.tenant_resource_group}"
  platform_url     = var.platform_url != "" ? var.platform_url : "https://${var.dns_record}.${var.dns_zone_name}"
  webapp_url       = var.webapp_url != "" ? var.webapp_url : "https://${var.dns_record}.app.cosmotech.com"
  vnet_iprange     = var.vnet_iprange != "" ? var.vnet_iprange : "10.10.0.0/16"
  api_version_path = substr(var.chart_package_version, 0, 1)
  tags = {
    vendor      = "cosmotech"
    stage       = var.project_stage
    customer    = var.customer_name
    project     = var.project_name
    cost_center = var.cost_center
  }
}

data "azuread_users" "owners" {
  user_principal_names = var.owner_list
}

# Azure AD
resource "azuread_application" "platform" {
  display_name     = "${local.pre_name}Platform${local.post_name}"
  identifier_uris  = var.identifier_uri != "" ? [var.identifier_uri] : [local.identifier_uri]
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = var.audience

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = ["${local.platform_url}${var.api_version_path}swagger-ui/oauth2-redirect.html"]
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
    }
  }

  api {
    requested_access_token_version = 2
    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to use the Cosmo Tech Platform with user account"
      admin_consent_display_name = "Cosmo Tech Platform Impersonate"
      enabled                    = true
      id                         = "6332363e-bcba-4c4a-a605-c25f23117400"
      type                       = "User"
      user_consent_description   = "Allow the application to use the Cosmo Tech Platform with your account"
      user_consent_display_name  = "Cosmo Tech Platform Usage"
      value                      = "platform"
    }
  }

  dynamic "app_role" {
    for_each = toset(var.user_app_role)
    iterator = app_role

    content {
      allowed_member_types = [
        "User",
        "Application"
      ]
      description  = app_role.value.description
      display_name = app_role.value.display_name
      id           = app_role.value.id
      enabled      = true
      value        = app_role.value.role_value
    }
  }

  lifecycle {
    ignore_changes = [
      owners,
    ]
  }
}

resource "azuread_service_principal" "platform" {
  application_id = azuread_application.platform.application_id
  # assignment required to secure Function Apps using thi App Registration as identity provider
  app_role_assignment_required = true

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

resource "azuread_application_password" "platform_password" {
  display_name          = "platform_secret"
  count                 = var.create_secrets ? 1 : 0
  application_object_id = azuread_application.platform.object_id
  end_date_relative     = "4464h"
}


resource "azuread_application" "network_adt" {
  display_name     = "${local.pre_name}Network and ADT${local.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = "AzureADMyOrg"
  tags             = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]
}

resource "azuread_service_principal" "network_adt" {
  depends_on                   = [azuread_service_principal.platform]
  application_id               = azuread_application.network_adt.application_id
  app_role_assignment_required = false

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

resource "azuread_application_password" "network_adt_password" {
  display_name          = "network_adt_secret"
  count                 = var.create_secrets ? 1 : 0
  application_object_id = azuread_application.network_adt.object_id
  end_date_relative     = "4464h"
}

resource "azuread_application" "swagger" {
  display_name     = "${local.pre_name}Swagger${local.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = var.audience

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.platform.application_id # Cosmo Tech Platform

    resource_access {
      id   = "6332363e-bcba-4c4a-a605-c25f23117400" # platform
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = [
      "${local.platform_url}/cosmotech-api/${var.tenant_resource_group}/v${local.api_version_path}/swagger-ui/oauth2-redirect.html"
    ]
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
    }
  }
}

resource "azuread_service_principal" "swagger" {
  depends_on                   = [azuread_service_principal.network_adt]
  application_id               = azuread_application.swagger.application_id
  app_role_assignment_required = false

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}


resource "azuread_application" "restish" {
  count            = var.create_restish ? 1 : 0
  display_name     = "${local.pre_name}Restish${local.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = var.audience
  tags             = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.platform.application_id # Cosmo Tech Platform

    resource_access {
      id   = "6332363e-bcba-4c4a-a605-c25f23117400" # platform
      type = "Scope"
    }
  }

  public_client {
    redirect_uris = ["http://localhost:8484/"]
  }
}

resource "azuread_service_principal" "restish" {
  depends_on                   = [azuread_service_principal.swagger]
  count                        = var.create_restish ? 1 : 0
  application_id               = azuread_application.restish[0].application_id
  app_role_assignment_required = false

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

resource "azuread_application_password" "restish_password" {
  display_name          = "restish_secret"
  count                 = var.create_restish && var.create_secrets ? 1 : 0
  application_object_id = azuread_application.restish[0].object_id
  end_date_relative     = "4464h"
}

resource "azuread_application" "powerbi" {
  count            = var.create_powerbi ? 1 : 0
  display_name     = "${local.pre_name}PowerBI${local.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = "AzureADMyOrg"
  tags             = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]
}

resource "azuread_service_principal" "powerbi" {
  depends_on                   = [azuread_service_principal.restish]
  count                        = var.create_powerbi ? 1 : 0
  application_id               = azuread_application.powerbi[0].application_id
  app_role_assignment_required = false

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

resource "azuread_application_password" "powerbi_password" {
  display_name          = "powerbi_secret"
  count                 = var.create_powerbi && var.create_secrets ? 1 : 0
  application_object_id = azuread_application.powerbi[0].object_id
  end_date_relative     = "4464h"
}

resource "azuread_application" "webapp" {
  display_name     = "${local.pre_name}Web App${local.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = var.audience
  count            = var.create_webapp ? 1 : 0

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.platform.application_id # Cosmo Tech Platform

    resource_access {
      id   = "6332363e-bcba-4c4a-a605-c25f23117400" # platform
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = ["http://localhost:3000/scenario", "${local.webapp_url}/platform", "${local.webapp_url}/sign-in"]
  }
}

resource "azuread_service_principal" "webapp" {
  depends_on                   = [azuread_service_principal.webapp]
  application_id               = azuread_application.webapp[0].application_id
  app_role_assignment_required = false
  count                        = var.create_webapp ? 1 : 0

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

# create the Azure AD resource group
resource "azuread_group" "platform_group" {
  display_name     = "Cosmotech-Platform-${var.tenant_resource_group}-${var.platform_resource_group}"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
  members          = data.azuread_users.owners.object_ids
}

resource "azuread_application_password" "babylon_password" {
  display_name          = "babylon_secret"
  count                 = var.create_babylon && var.create_secrets ? 1 : 0
  application_object_id = azuread_application.babylon[0].object_id
  end_date_relative     = "4464h"
}

resource "azuread_application" "babylon" {
  count            = var.create_babylon ? 1 : 0
  display_name     = "${local.pre_name}Babylon${local.post_name}"
  logo_image       = filebase64("cosmotech.png")
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = var.audience

  tags = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = azuread_application.platform.application_id # Cosmo Tech Platform

    resource_access {
      id   = "6332363e-bcba-4c4a-a605-c25f23117400" # platform
      type = "Scope"
    }
  }

  public_client {
    redirect_uris = ["http://localhost:8484/"]
  }

  lifecycle {
    ignore_changes = [
      owners, required_resource_access,
    ]
  }
}

resource "azuread_service_principal" "babylon" {
  count                        = var.create_babylon ? 1 : 0
  depends_on                   = [azuread_service_principal.swagger]
  application_id               = azuread_application.babylon[0].application_id
  app_role_assignment_required = false

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

# Resource group
resource "azurerm_resource_group" "tenant_rg" {
  name     = var.tenant_resource_group
  location = var.location
  tags     = local.tags
}

resource "azurerm_role_assignment" "rg_owner" {
  scope                = azurerm_resource_group.tenant_rg.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.platform_group.object_id
}

resource "azurerm_role_assignment" "publicip_contributor" {
  scope                = azurerm_resource_group.tenant_rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.network_adt.id
}

resource "azurerm_role_assignment" "publicip_owner" {
  scope                = var.platform_public_ip
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.platform.id
}

# Virtual Network
resource "azurerm_virtual_network" "tenant_vnet" {
  name                = "Cosmotech-VNET-${var.tenant_resource_group}-${var.platform_resource_group}"
  location            = var.location
  resource_group_name = azurerm_resource_group.tenant_rg.name
  address_space       = [local.vnet_iprange]

  subnet {
    name           = local.subnet_name
    address_prefix = local.vnet_iprange
  }
  tags = local.tags
}

resource "azurerm_virtual_network_peering" "vnet_tenant_to_platform" {
  name                      = "peer${var.tenant_resource_group}vnet1"
  resource_group_name       = var.tenant_resource_group
  virtual_network_name      = azurerm_virtual_network.tenant_vnet.name
  remote_virtual_network_id = var.platform_vnet.id
}

resource "azurerm_virtual_network_peering" "vnet_platform_to_tenant" {
  name                      = "peer${var.tenant_resource_group}vnet2"
  resource_group_name       = var.platform_resource_group
  virtual_network_name      = var.platform_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.tenant_vnet.id
}

resource "azurerm_role_assignment" "vnet_network_contributor" {
  scope                = azurerm_virtual_network.tenant_vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.network_adt.id
}

data "azurerm_private_dns_zone" "platform" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.platform_resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_link" {
  name                  = "${var.tenant_resource_group}-vnet-link"
  resource_group_name   = var.platform_resource_group
  private_dns_zone_name = data.azurerm_private_dns_zone.platform.name
  virtual_network_id    = azurerm_virtual_network.tenant_vnet.id
}