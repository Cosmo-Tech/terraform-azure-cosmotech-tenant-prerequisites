<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application.babylon](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.network_adt](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.platform](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.powerbi](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.restish](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.swagger](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application.webapp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.babylon_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_application_password.network_adt_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_application_password.platform_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_application_password.powerbi_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_application_password.restish_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_group.platform_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_service_principal.babylon](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.network_adt](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.platform](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.powerbi](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.restish](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.swagger](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal.webapp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.tenant_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.publicip_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.publicip_owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rg_owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vnet_network_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_network.tenant_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.vnet_platform_to_tenant](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_tenant_to_platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azuread_users.owners](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azurerm_private_dns_zone.platform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_package_version"></a> [chart\_package\_version](#input\_chart\_package\_version) | n/a | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client id | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | The client secret | `string` | n/a | yes |
| <a name="input_customer_name"></a> [customer\_name](#input\_customer\_name) | The customer name | `string` | n/a | yes |
| <a name="input_dns_record"></a> [dns\_record](#input\_dns\_record) | The DNS zone name to create platform subdomain. Example: myplatform | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The DNS zone name to create platform subdomain. Example: api.cosmotech.com | `string` | n/a | yes |
| <a name="input_dns_zone_rg"></a> [dns\_zone\_rg](#input\_dns\_zone\_rg) | The DNS zone resource group | `string` | n/a | yes |
| <a name="input_identifier_uri"></a> [identifier\_uri](#input\_identifier\_uri) | The platform identifier uri | `string` | n/a | yes |
| <a name="input_owner_list"></a> [owner\_list](#input\_owner\_list) | List of mail addresses for App Registration owners | `list(string)` | n/a | yes |
| <a name="input_platform_public_ip"></a> [platform\_public\_ip](#input\_platform\_public\_ip) | n/a | `string` | n/a | yes |
| <a name="input_platform_resource_group"></a> [platform\_resource\_group](#input\_platform\_resource\_group) | Existing Resource group which contain common platform resources | `string` | n/a | yes |
| <a name="input_platform_vnet"></a> [platform\_vnet](#input\_platform\_vnet) | n/a | `any` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name | `string` | n/a | yes |
| <a name="input_project_stage"></a> [project\_stage](#input\_project\_stage) | The Project stage | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription id | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant id | `string` | n/a | yes |
| <a name="input_tenant_resource_group"></a> [tenant\_resource\_group](#input\_tenant\_resource\_group) | Resource group to create which will contain created Azure resources for this tenant | `string` | n/a | yes |
| <a name="input_user_app_role"></a> [user\_app\_role](#input\_user\_app\_role) | App role for azuread\_application | <pre>list(object({<br>    description  = string<br>    display_name = string<br>    id           = string<br>    role_value   = string<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_iprange"></a> [vnet\_iprange](#input\_vnet\_iprange) | The Virtual Network IP range. Minimum /26 NetMaskLength | `string` | n/a | yes |
| <a name="input_webapp_url"></a> [webapp\_url](#input\_webapp\_url) | The Web Application URL | `string` | n/a | yes |
| <a name="input_api_version_path"></a> [api\_version\_path](#input\_api\_version\_path) | The API version path | `string` | `"/"` | no |
| <a name="input_audience"></a> [audience](#input\_audience) | The App Registration audience type | `string` | `"AzureADMultipleOrgs"` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | n/a | `string` | `"NA"` | no |
| <a name="input_create_babylon"></a> [create\_babylon](#input\_create\_babylon) | Create the Azure Active Directory Application for Babylon | `bool` | `true` | no |
| <a name="input_create_powerbi"></a> [create\_powerbi](#input\_create\_powerbi) | Create the Azure Active Directory Application for PowerBI | `bool` | `true` | no |
| <a name="input_create_restish"></a> [create\_restish](#input\_create\_restish) | Create the Azure Active Directory Application for Restish | `bool` | `true` | no |
| <a name="input_create_secrets"></a> [create\_secrets](#input\_create\_secrets) | Create secret for application registrations | `bool` | `true` | no |
| <a name="input_create_webapp"></a> [create\_webapp](#input\_create\_webapp) | Create the Azure Active Directory Application for WebApp | `bool` | `true` | no |
| <a name="input_image_path"></a> [image\_path](#input\_image\_path) | n/a | `string` | `"./cosmotech.png"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location | `string` | `"West Europe"` | no |
| <a name="input_platform_url"></a> [platform\_url](#input\_platform\_url) | The platform url | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out_babylon_client_id"></a> [out\_babylon\_client\_id](#output\_out\_babylon\_client\_id) | n/a |
| <a name="output_out_babylon_principal_id"></a> [out\_babylon\_principal\_id](#output\_out\_babylon\_principal\_id) | n/a |
| <a name="output_out_babylon_principal_secret"></a> [out\_babylon\_principal\_secret](#output\_out\_babylon\_principal\_secret) | n/a |
| <a name="output_out_cosmos_api_url"></a> [out\_cosmos\_api\_url](#output\_out\_cosmos\_api\_url) | n/a |
| <a name="output_out_identifier_uri"></a> [out\_identifier\_uri](#output\_out\_identifier\_uri) | n/a |
| <a name="output_out_ip_resource_group"></a> [out\_ip\_resource\_group](#output\_out\_ip\_resource\_group) | n/a |
| <a name="output_out_nerworkadt_name"></a> [out\_nerworkadt\_name](#output\_out\_nerworkadt\_name) | n/a |
| <a name="output_out_network_adt_password"></a> [out\_network\_adt\_password](#output\_out\_network\_adt\_password) | n/a |
| <a name="output_out_networkadt_clientid"></a> [out\_networkadt\_clientid](#output\_out\_networkadt\_clientid) | n/a |
| <a name="output_out_networkadt_sp_objectid"></a> [out\_networkadt\_sp\_objectid](#output\_out\_networkadt\_sp\_objectid) | n/a |
| <a name="output_out_platform_clientid"></a> [out\_platform\_clientid](#output\_out\_platform\_clientid) | n/a |
| <a name="output_out_platform_name"></a> [out\_platform\_name](#output\_out\_platform\_name) | n/a |
| <a name="output_out_platform_password"></a> [out\_platform\_password](#output\_out\_platform\_password) | n/a |
| <a name="output_out_platform_resource_group_id"></a> [out\_platform\_resource\_group\_id](#output\_out\_platform\_resource\_group\_id) | n/a |
| <a name="output_out_platform_sp_client_id"></a> [out\_platform\_sp\_client\_id](#output\_out\_platform\_sp\_client\_id) | n/a |
| <a name="output_out_platform_sp_client_secret"></a> [out\_platform\_sp\_client\_secret](#output\_out\_platform\_sp\_client\_secret) | n/a |
| <a name="output_out_platform_sp_object_id"></a> [out\_platform\_sp\_object\_id](#output\_out\_platform\_sp\_object\_id) | n/a |
| <a name="output_out_platform_url"></a> [out\_platform\_url](#output\_out\_platform\_url) | n/a |
| <a name="output_out_powerbi_clientid"></a> [out\_powerbi\_clientid](#output\_out\_powerbi\_clientid) | n/a |
| <a name="output_out_powerbi_name"></a> [out\_powerbi\_name](#output\_out\_powerbi\_name) | n/a |
| <a name="output_out_powerbi_password"></a> [out\_powerbi\_password](#output\_out\_powerbi\_password) | n/a |
| <a name="output_out_private_dns_zone_id"></a> [out\_private\_dns\_zone\_id](#output\_out\_private\_dns\_zone\_id) | n/a |
| <a name="output_out_restish_clientid"></a> [out\_restish\_clientid](#output\_out\_restish\_clientid) | n/a |
| <a name="output_out_restish_name"></a> [out\_restish\_name](#output\_out\_restish\_name) | n/a |
| <a name="output_out_restish_password"></a> [out\_restish\_password](#output\_out\_restish\_password) | n/a |
| <a name="output_out_subnet_id"></a> [out\_subnet\_id](#output\_out\_subnet\_id) | n/a |
| <a name="output_out_subnet_name"></a> [out\_subnet\_name](#output\_out\_subnet\_name) | n/a |
| <a name="output_out_swagger_clientid"></a> [out\_swagger\_clientid](#output\_out\_swagger\_clientid) | n/a |
| <a name="output_out_swagger_name"></a> [out\_swagger\_name](#output\_out\_swagger\_name) | n/a |
| <a name="output_out_tenant_id"></a> [out\_tenant\_id](#output\_out\_tenant\_id) | n/a |
| <a name="output_out_vnet"></a> [out\_vnet](#output\_out\_vnet) | n/a |
| <a name="output_out_vnet_resource_group"></a> [out\_vnet\_resource\_group](#output\_out\_vnet\_resource\_group) | n/a |
| <a name="output_out_webapp_clientid"></a> [out\_webapp\_clientid](#output\_out\_webapp\_clientid) | n/a |
| <a name="output_out_webapp_name"></a> [out\_webapp\_name](#output\_out\_webapp\_name) | n/a |
<!-- END_TF_DOCS -->