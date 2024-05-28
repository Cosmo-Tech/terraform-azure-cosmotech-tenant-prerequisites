variable "audience" {
  description = "The App Registration audience type"
  type        = string
  validation {
    condition = contains([
      "AzureADMyOrg",
      "AzureADMultipleOrgs"
    ], var.audience)
    error_message = "Only AzureADMyOrg and AzureADMultipleOrgs are supported for audience."
  }
}

variable "pre_name" {
  type = string
}

variable "post_name" {
  type = string
}

variable "network_resource_group" {
  type = string
}

variable "identifier_uri" {
  type = string
}

variable "image_path" {
  type = string
}

variable "project_stage" {
  description = "The Project stage"
  type        = string
  validation {
    condition = contains([
      "OnBoarding",
      "Dev",
      "QA",
      "IA",
      "EA",
      "Doc",
      "Support",
      "Demo",
      "Prod",
      "PreProd"
    ], var.project_stage)
    error_message = "Stage must be either: OnBoarding, Dev, QA, IA, EA, Demo, Prod, PreProd, Doc, Support."
  }
}

variable "customer_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "platform_url" {
  type = string
}

variable "api_version_path" {
  type = string
}

variable "owner_list" {
  description = "List of mail addresses for App Registration owners"
  type        = list(string)
}

variable "user_app_role" {
  type = list(object({
    description  = string
    display_name = string
    id           = string
    role_value   = string
  }))
  description = "App role for azuread_application"
}

variable "tenant_resource_group" {
  description = "Resource group to create which will contain created Azure resources for this tenant"
  type        = string
}

variable "create_restish" {
  description = "Create the Azure Active Directory Application for Restish"
  type        = bool
}

variable "create_powerbi" {
  description = "Create the Azure Active Directory Application for PowerBI"
  type        = bool
}

variable "create_babylon" {
  description = "Create the Azure Active Directory Application for Babylon"
  type        = bool
}

variable "create_secret_platform" {
  type    = bool
  default = false
}

variable "create_secret_network" {
  type    = bool
  default = false
}

variable "tenant_namespace" {
  type = string
}

variable "create_secret_restish" {
  type    = bool
  default = false
}

variable "create_secret_powerbi" {
  type    = bool
  default = false
}

variable "create_secret_babylon" {
  type    = bool
}

variable "tenant_resource_group_object" {
}

variable "use_identifier_uri_appId" {
  type = bool
}