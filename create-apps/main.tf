data "azuread_users" "owners" {
  user_principal_names = var.owner_list
}

# Azure AD
resource "azuread_application" "platform" {
  display_name     = "${var.pre_name}Platform${var.post_name}"
  logo_image       = filebase64(var.image_path)
  sign_in_audience = var.audience
  owners           = data.azuread_users.owners.object_ids
  tags = [
    "HideApp",
    "WindowsAzureActiveDirectoryIntegratedApp",
    var.project_stage,
    var.customer_name,
    var.project_name,
    "terraformed"
  ]

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = [
      "${var.platform_url}${var.api_version_path}/swagger-ui/oauth2-redirect.html"
    ]
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

resource "azuread_application_identifier_uri" "example" {
  application_id = azuread_application.platform.id
  identifier_uri = var.use_identifier_uri_appId ? "api://${azuread_application.platform.client_id}" : var.identifier_uri
}

resource "azuread_service_principal" "platform" {
  client_id = azuread_application.platform.client_id
  # assignment required to secure Function Apps using thi App Registration as identity provider
  app_role_assignment_required = true

  tags = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
}

resource "azuread_application_api_access" "add_role_api" {
  application_id = "/applications/${azuread_application.platform.object_id}"
  api_client_id  = azuread_application.platform.client_id
  role_ids       = ["bb49d61f-8b6a-4a19-b5bd-06a29d6b8e60"]

  depends_on = [azuread_service_principal.platform]
}

resource "azuread_app_role_assignment" "add_user_admin_platform" {
  app_role_id         = azuread_service_principal.platform.app_role_ids["Platform.Admin"]
  for_each = toset(data.azuread_users.owners.object_ids)
  principal_object_id = each.key
  resource_object_id  = azuread_service_principal.platform.object_id
  depends_on = [ azuread_application_api_access.add_role_api ]
}

resource "azuread_application_password" "platform_password" {
  display_name      = "platform_secret"
  count             = var.create_secret_platform ? 1 : 0
  application_id    = azuread_application.platform.id
  end_date_relative = "4464h"
}

resource "azuread_application" "network_adt" {
  display_name     = "${var.pre_name}Network ${title(var.network_resource_group)}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = "AzureADMyOrg"
  tags             = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]
}

resource "azuread_service_principal" "network_adt" {
  client_id                    = azuread_application.network_adt.client_id
  app_role_assignment_required = false
  tags                         = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
  depends_on                   = [azuread_service_principal.platform]
}

resource "azuread_application_password" "network_adt_password" {
  display_name      = "network_secret"
  count             = var.create_secret_network ? 1 : 0
  application_id    = azuread_application.network_adt.id
  end_date_relative = "4464h"
}

resource "azuread_application" "swagger" {
  display_name     = "${var.pre_name}Swagger${var.post_name}"
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
    resource_app_id = azuread_service_principal.platform.client_id # Cosmo Tech Platform

    resource_access {
      id   = "6332363e-bcba-4c4a-a605-c25f23117400" # platform
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = [
      "${var.platform_url}/cosmotech-api/${var.tenant_namespace}${var.api_version_path}/swagger-ui/oauth2-redirect.html"
    ]
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
    }
  }

}

resource "azuread_service_principal" "swagger" {
  client_id                    = azuread_application.swagger.client_id
  app_role_assignment_required = false

  tags       = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
  depends_on = [azuread_service_principal.network_adt]
}


resource "azuread_application" "restish" {
  count            = var.create_restish ? 1 : 0
  display_name     = "${var.pre_name}Restish${var.post_name}"
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
    resource_app_id = azuread_service_principal.platform.client_id # Cosmo Tech Platform

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
  count                        = var.create_restish ? 1 : 0
  client_id                    = azuread_application.restish[0].client_id
  app_role_assignment_required = false
  tags                         = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
  depends_on                   = [azuread_service_principal.swagger]
}

resource "azuread_application_password" "restish_password" {
  count             = var.create_restish && var.create_secret_restish ? 1 : 0
  display_name      = "restish_secret"
  application_id    = azuread_application.restish[0].id
  end_date_relative = "4464h"
}

resource "azuread_application" "powerbi" {
  count            = var.create_powerbi ? 1 : 0
  display_name     = "${var.pre_name}PowerBI${var.post_name}"
  logo_image       = filebase64(var.image_path)
  owners           = data.azuread_users.owners.object_ids
  sign_in_audience = "AzureADMyOrg"
  tags             = ["HideApp", "WindowsAzureActiveDirectoryIntegratedApp", var.project_stage, var.customer_name, var.project_name, "terraformed"]
}

resource "azuread_service_principal" "powerbi" {
  count                        = var.create_powerbi ? 1 : 0
  client_id                    = azuread_application.powerbi[0].client_id
  app_role_assignment_required = false
  tags                         = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
  depends_on                   = [azuread_service_principal.restish]
}

resource "azuread_application_password" "powerbi_password" {
  display_name      = "powerbi_secret"
  count             = var.create_powerbi && var.create_secret_powerbi ? 1 : 0
  application_id    = azuread_application.powerbi[0].id
  end_date_relative = "4464h"
}

# create the Azure AD Group
resource "azuread_group" "platform_group" {
  display_name     = "Cosmotech Group Platform ${var.network_resource_group} For ${var.tenant_namespace}"
  security_enabled = true
  owners           = data.azuread_users.owners.object_ids
  members          = data.azuread_users.owners.object_ids
}

resource "azuread_application_password" "babylon_password" {
  display_name      = "babylon_secret"
  count             = var.create_babylon && var.create_secret_babylon ? 1 : 0
  application_id    = azuread_application.babylon[0].id
  end_date_relative = "4464h"
}

resource "azuread_application" "babylon" {
  count            = var.create_babylon ? 1 : 0
  display_name     = "${var.pre_name}Babylon${var.post_name}"
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
    resource_app_id = azuread_service_principal.platform.client_id # Cosmo Tech Platform

    resource_access {
      id   = "bb49d61f-8b6a-4a19-b5bd-06a29d6b8e60" # platform impersonate
      type = "Role"
    }
  }

  lifecycle {
    ignore_changes = [
      owners, required_resource_access,
    ]
  }
}

resource "azuread_service_principal" "babylon" {
  count                        = var.create_babylon ? 1 : 0
  client_id                    = azuread_application.babylon[0].client_id
  app_role_assignment_required = false

  tags       = ["cosmotech", var.project_stage, var.customer_name, var.project_name, "HideApp", "WindowsAzureActiveDirectoryIntegratedApp", "terraformed"]
  depends_on = [azuread_service_principal.swagger]
}

resource "azurerm_role_assignment" "tenant_contributor" {
  scope                = var.tenant_resource_group_object.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.platform.object_id
}

resource "azurerm_role_assignment" "network_owner" {
  scope                = var.tenant_resource_group_object.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.network_adt.object_id
}