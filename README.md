<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-res-storage-storageaccount

Module to deploy storage accounts in Azure.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (1.9.0, < 2.0.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.71.0, < 4.0.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.0, < 4.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (1.9.0, < 2.0.0)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.71.0, < 4.0.0)

## Resources

The following resources are used by this module:

- [azapi_resource.containers](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)
- [azurerm_private_endpoint_application_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [azurerm_storage_queue.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_queue) (resource)
- [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) (resource)
- [azurerm_storage_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) (resource)
- [azurerm_resource_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the storage account

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The name of the resource group in which to create the storage account

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier)

Description: The access tier for BlobStorage, FileStorage, and StorageV2 accounts. Valid options are Hot and Cool.

Type: `string`

Default: `"Hot"`

### <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind)

Description: The kind of the storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage, and StorageV2.

Type: `string`

Default: `"StorageV2"`

### <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type)

Description: The type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, and ZRS.

Type: `string`

Default: `"LRS"`

### <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier)

Description: Defines the Tier to use for this storage account. Valid options are Standard and Premium.

Type: `string`

Default: `"Standard"`

### <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public)

Description: Allow or disallow public access to nested items within the storage account

Type: `bool`

Default: `false`

### <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope)

Description: The allowed copy scope for the storage account.

Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink.

Type: `string`

Default: `null`

### <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication)

Description:  - `directory_type` - (Required) Specifies the directory service used. Possible values are `AADDS`, `AD` and `AADKERB`.

 ---
 `active_directory` block supports the following:
 - `domain_guid` - (Required) Specifies the domain GUID.
 - `domain_name` - (Required) Specifies the primary domain that the AD DNS server is authoritative for.
 - `domain_sid` - (Required) Specifies the security identifier (SID).
 - `forest_name` - (Required) Specifies the Active Directory forest.
 - `netbios_domain_name` - (Required) Specifies the NetBIOS domain name.
 - `storage_sid` - (Required) Specifies the security identifier (SID) for Azure Storage.

Type:

```hcl
object({
    directory_type = string
    active_directory = optional(object({
      domain_guid         = string
      domain_name         = string
      domain_sid          = string
      forest_name         = string
      netbios_domain_name = string
      storage_sid         = string
    }))
  })
```

Default: `null`

### <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties)

Description:  - `change_feed_enabled` - (Optional) Is the blob service properties for change feed events enabled? Default to `false`.
 - `change_feed_retention_in_days` - (Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
 - `default_service_version` - (Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version.
 - `last_access_time_enabled` - (Optional) Is the last access time based tracking enabled? Default to `false`.
 - `versioning_enabled` - (Optional) Is versioning enabled? Default to `false`.

 ---
 `container_delete_retention_policy` block supports the following:
 - `days` - (Optional) Specifies the number of days that the container should be retained, between `1` and `365` days. Defaults to `7`.

 ---
 `cors_rule` block supports the following:
 - `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
 - `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
 - `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
 - `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
 - `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

 ---
 `delete_retention_policy` block supports the following:
 - `days` - (Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`.

 ---
 `restore_policy` block supports the following:
 - `days` - (Required) Specifies the number of days that the blob can be restored, between `1` and `365` days. This must be less than the `days` specified for `delete_retention_policy`.

Type:

```hcl
object({
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)
    versioning_enabled            = optional(bool)
    container_delete_retention_policy = optional(object({
      days = optional(number)
    }))
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    delete_retention_policy = optional(object({
      days = optional(number)
    }))
    restore_policy = optional(object({
      days = number
    }))
  })
```

Default: `null`

### <a name="input_containers"></a> [containers](#input\_containers)

Description: - `container_access_type` - (Optional) The Access Level configured for this Container. Possible values are `Blob`, `Container` or `None`. Defaults to `None`.
- `metadata` - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase.
- `name` - (Required) The name of the Container which should be created within the Storage Account. Changing this forces a new resource to be created.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Storage Container.
- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Container.
- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Container.
- `update` - (Defaults to 30 minutes) Used when updating the Storage Container.

Type:

```hcl
map(object({
    public_access = optional(string, "None")
    metadata      = optional(map(string))
    name          = string

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled)

Description: Whether cross-tenant replication is enabled for the storage account

Type: `bool`

Default: `false`

### <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain)

Description:  - `name` - (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
 - `use_subdomain` - (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?

Type:

```hcl
object({
    name          = string
    use_subdomain = optional(bool)
  })
```

Default: `null`

### <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication)

Description: Indicates whether the storage account defaults to using OAuth authentication

Type: `bool`

Default: `false`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create on the storage account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name           = string
    log_categories = optional(set(string), [])
    log_groups     = optional(set(string), [])
    metric_categories = optional(list(object({
      category = string
      enabled  = bool
    })), [])
    log_analytics_destination_type           = optional(string)
    use_log_categories                       = optional(bool, true)
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
    service_type                             = optional(string, "blobServices/default")

  }))
```

Default: `{}`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: The Edge Zone within the Azure region where the storage account should be created.

Type: `string`

Default: `null`

### <a name="input_identity"></a> [identity](#input\_identity)

Description:  - `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account.
 - `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).

Type:

```hcl
object({
    identity_ids = optional(map(string))
    type         = string
  })
```

Default:

```json
{
  "identity_ids": {},
  "type": "SystemAssigned"
}
```

### <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled)

Description: Indicates whether infrastructure encryption is enabled for the storage account.

This can only be true when account\_kind is StorageV2 or when account\_tier is Premium and account\_kind is one of BlockBlobStorage or FileStorage.

Infrastructure encryption adds a second layer of encryption to your storage account’s data. This option can only be enabled during the storage account creation. Defaults to false.

Type: `bool`

Default: `false`

### <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled)

Description: Indicates whether Hierarchical Namespace (HNS) is enabled.

This can only be true when account\_tier is Standard or when account\_tier is Premium and account\_kind is BlockBlobStorage.

Type: `bool`

Default: `false`

### <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled)

Description: Indicates whether Large File Share is enabled for the storage account

Type: `bool`

Default: `false`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location.

Type: `string`

Default: `null`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: The lock level to apply to the storage account. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.

Type:

```hcl
object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
```

Default: `{}`

### <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules)

Description: Network rule configurations for the storage account.

- `default_action` - (Required) Specifies the default action of allow or deny when no other rules match. Valid options are 'Deny' or 'Allow'. Default is 'Deny'.
- `bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of 'Logging', 'Metrics', 'AzureServices', or 'None'. Default is ["AzureServices", "Logging", "Metrics"].
- `ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. /31 CIDRs, /32 CIDRs, and Private IP address ranges (as defined in RFC 1918), are not allowed. No IP rules by default.
- `virtual_network_subnet_ids` - (Optional) List of resource ids for subnets. No virtual network subnets by default.
- `private_link_access` - (Optional) One or more private\_link\_access block as defined below. Each configuration is an object with 'endpoint\_resource\_id' (The resource id of the private link) and 'endpoint\_tenant\_id' (The tenant id of the private link). No private link access by default.

Type:

```hcl
object({
    default_action             = optional(string)
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
  })
```

Default:

```json
{
  "bypass": [
    "None"
  ],
  "default_action": "Deny",
  "ip_rules": [],
  "private_link_access": [],
  "virtual_network_subnet_ids": []
}
```

### <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled)

Description: Indicates whether NFSv3 protocol is enabled for the storage account.

This can only be true when account\_tier is Standard and account\_kind is StorageV2, or account\_tier is Premium and account\_kind is BlockBlobStorage.  
Additionally, the is\_hns\_enabled is true and account\_replication\_type must be LRS or RAGRS.

Note: For an NFS enabled account, the NetworkAcls default action must be set to Deny.

Type: `bool`

Default: `false`

### <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints)

Description: A map of private endpoints to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `subresource_name` - The subresource name for the private endpoint. Must be one of the supported subresource names for storage account private endpoints, such as "blob", "file", "queue", "table", "dfs" or "web".
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the Key Vault.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.

Type:

```hcl
map(object({
    name             = optional(string, null)
    subresource_name = string
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    lock = optional(object({
      name = optional(string, null)
      kind = optional(string, "None")
    }), {})
    tags                                    = optional(map(any), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
```

Default: `{}`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: Indicate whether the storage account is accessible from the public network

Type: `bool`

Default: `false`

### <a name="input_queue"></a> [queue](#input\_queue)

Description:  - `metadata` - (Optional) A mapping of MetaData which should be assigned to this Storage Queue.
 - `name` - (Required) The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Queue.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Queue.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Queue.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Queue.

Type:

```hcl
map(object({
    metadata = optional(map(string))
    name     = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type)

Description: The encryption key type to be used for the queue service

Type: `string`

Default: `"Service"`

### <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties)

Description:
 ---
 `cors_rule` block supports the following:
 - `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
 - `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
 - `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
 - `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
 - `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

 ---
 `hour_metrics` block supports the following:
 - `enabled` - (Required) Indicates whether hour metrics are enabled for the Queue service.
 - `include_apis` - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
 - `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
 - `version` - (Required) The version of storage analytics to configure.

 ---
 `logging` block supports the following:
 - `delete` - (Required) Indicates whether all delete requests should be logged.
 - `read` - (Required) Indicates whether all read requests should be logged.
 - `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
 - `version` - (Required) The version of storage analytics to configure.
 - `write` - (Required) Indicates whether all write requests should be logged.

 ---
 `minute_metrics` block supports the following:
 - `enabled` - (Required) Indicates whether minute metrics are enabled for the Queue service.
 - `include_apis` - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
 - `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
 - `version` - (Required) The version of storage analytics to configure.

Type:

```hcl
object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    hour_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
    logging = optional(object({
      delete                = bool
      read                  = bool
      retention_policy_days = optional(number)
      version               = string
      write                 = bool
    }))
    minute_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
  })
```

Default: `null`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on the storage account . The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. If you are using a condition, valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_routing"></a> [routing](#input\_routing)

Description: - `choice` - (Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.

- `publish_internet_endpoints` - (Optional) Should internet routing storage endpoints be published? Defaults to false.

- `publish_microsoft_endpoints` - (Optional) Should Microsoft routing storage endpoints be published? Defaults to false.

Type:

```hcl
object({
    choice                      = optional(string)
    publish_internet_endpoints  = optional(bool)
    publish_microsoft_endpoints = optional(bool)
  })
```

Default:

```json
{
  "choice": "MicrosoftRouting",
  "publish_internet_endpoints": false,
  "publish_microsoft_endpoints": false
}
```

### <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled)

Description:    "Indicates whether SFTP support is enabled for the storage account.   

  SFTP support requires is\_hns\_enabled set to true. More information on SFTP support can be found here. Defaults to false."

Type: `bool`

Default: `false`

### <a name="input_share"></a> [share](#input\_share)

Description:  - `access_tier` - (Optional) The access tier of the File Share. Possible values are `Hot`, `Cool` and `TransactionOptimized`, `Premium`.
 - `enabled_protocol` - (Optional) The protocol used for the share. Possible values are `SMB` and `NFS`. The `SMB` indicates the share can be accessed by SMBv3.0, SMBv2.1 and REST. The `NFS` indicates the share can be accessed by NFSv4.1. Defaults to `SMB`. Changing this forces a new resource to be created.
 - `metadata` - (Optional) A mapping of MetaData for this File Share.
 - `name` - (Required) The name of the share. Must be unique within the storage account where the share is located. Changing this forces a new resource to be created.
 - `quota` - (Required) The maximum size of the share, in gigabytes. For Standard storage accounts, this must be `1`GB (or higher) and at most `5120` GB (`5` TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most `102400` GB (`100` TB).

 ---
 `acl` block supports the following:
 - `id` - (Required) The ID which should be used for this Shared Identifier.

 ---
 `access_policy` block supports the following:
 - `expiry` - (Optional) The time at which this Access Policy should be valid until, in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format.
 - `permissions` - (Required) The permissions which should be associated with this Shared Identifier. Possible value is combination of `r` (read), `w` (write), `d` (delete), and `l` (list).
 - `start` - (Optional) The time at which this Access Policy should be valid from, in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Share.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Share.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Share.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Share.

Type:

```hcl
map(object({
    access_tier      = optional(string)
    enabled_protocol = optional(string)
    metadata         = optional(map(string))
    name             = string
    quota            = number
    acl = optional(set(object({
      id = string
      access_policy = optional(list(object({
        expiry      = optional(string)
        permissions = string
        start       = optional(string)
      })))
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties)

Description:
 ---
 `cors_rule` block supports the following:
 - `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
 - `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
 - `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
 - `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
 - `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

 ---
 `retention_policy` block supports the following:
 - `days` - (Optional) Specifies the number of days that the `azurerm_storage_share` should be retained, between `1` and `365` days. Defaults to `7`.

 ---
 `smb` block supports the following:
 - `authentication_types` - (Optional) A set of SMB authentication methods. Possible values are `NTLMv2`, and `Kerberos`.
 - `channel_encryption_type` - (Optional) A set of SMB channel encryption. Possible values are `AES-128-CCM`, `AES-128-GCM`, and `AES-256-GCM`.
 - `kerberos_ticket_encryption_type` - (Optional) A set of Kerberos ticket encryption. Possible values are `RC4-HMAC`, and `AES-256`.
 - `multichannel_enabled` - (Optional) Indicates whether multichannel is enabled. Defaults to `false`. This is only supported on Premium storage accounts.
 - `versions` - (Optional) A set of SMB protocol versions. Possible values are `SMB2.1`, `SMB3.0`, and `SMB3.1.1`.

Type:

```hcl
object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      authentication_types            = optional(set(string))
      channel_encryption_type         = optional(set(string))
      kerberos_ticket_encryption_type = optional(set(string))
      multichannel_enabled            = optional(bool)
      versions                        = optional(set(string))
    }))
  })
```

Default: `null`

### <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled)

Description: Indicates whether the storage account permits requests to be authorized with the account access key

Type: `bool`

Default: `true`

### <a name="input_static_website"></a> [static\_website](#input\_static\_website)

Description:  - `error_404_document` - (Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
 - `index_document` - (Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.

Type:

```hcl
object({
    error_404_document = optional(string)
    index_document     = optional(string)
  })
```

Default: `null`

### <a name="input_table"></a> [table](#input\_table)

Description:  - `name` - (Required) The name of the storage table. Only Alphanumeric characters allowed, starting with a letter. Must be unique within the storage account the table is located. Changing this forces a new resource to be created.

 ---
 `acl` block supports the following:
 - `id` - (Required) The ID which should be used for this Shared Identifier.

 ---
 `access_policy` block supports the following:
 - `expiry` - (Required) The ISO8061 UTC time at which this Access Policy should be valid until.
 - `permissions` - (Required) The permissions which should associated with this Shared Identifier.
 - `start` - (Required) The ISO8061 UTC time at which this Access Policy should be valid from.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Table.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Table.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Table.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Table.

Type:

```hcl
map(object({
    name = string
    acl = optional(set(object({
      id = string
      access_policy = optional(list(object({
        expiry      = string
        permissions = string
        start       = string
      })))
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type)

Description: The encryption key type to be used for the table service

Type: `string`

Default: `"Service"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Map of tags to assign to the storage account resource.

Type: `map(any)`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full output for the resource.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft.
Microsoft may use this information to provide services and improve our products and services.
You may turn off the telemetry as described in the repository.
There are also some features in the software that may enable you and Microsoft to collect data from users of your applications.
If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement.
Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>.
You can learn more about data collection and use in the help documentation and our privacy statement.
Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->