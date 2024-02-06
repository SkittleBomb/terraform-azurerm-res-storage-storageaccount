terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = ">= 0.3.0"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  min = 0
  max = length(module.regions.regions) - 1
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name_unique
  location = module.regions.regions[random_integer.region_index.result].name
}

# A vnet is required for the storage account
resource "azurerm_virtual_network" "this" {
  name                = module.naming.virtual_network.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = module.naming.subnet.name_unique
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/27"]

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_private_dns_zone" "table" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_private_dns_zone" "queue" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}
resource "azurerm_private_dns_zone" "file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "test" {
  source = "../../"

  name                = module.naming.storage_account.name_unique
  resource_group_name = azurerm_resource_group.this.name

  account_tier                      = "Standard"  # (Optional) Defines the Tier to use for this storage account. Valid options are Standard and Premium. Defaults to Standard.
  account_replication_type          = "GRS"       # (Optional) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS. Defaults to LRS.
  account_kind                      = "StorageV2" # (Optional) Defines the Kind to use for this storage account. Valid options are Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage. Defaults to StorageV2.
  access_tier                       = "Hot"       # (Optional) Defines the access tier to use for this storage account. Valid options are Hot and Cool. Defaults to Hot.
  is_hns_enabled                    = false       # (Optional) Defines whether or not Hierarchical Namespace is enabled for this storage account. Defaults to false
  public_network_access_enabled     = true        # (Optional) Defines whether or not public network access is allowed for this storage account. Defaults to false.
  shared_access_key_enabled         = false       # (Optional) Defines whether or not shared access key is enabled for this storage account. Defaults to false.
  infrastructure_encryption_enabled = false       # (Optional) Defines whether or not infrastructure encryption is enabled for this storage account. Defaults to false.
  default_to_oauth_authentication   = true

  network_rules = {
    default_action             = "Deny"                   # (Required) Defines the default action for network rules. Valid options are Allow and Deny.
    ip_rules                   = []                       # (Optional) Defines the list of IP rules to apply to the storage account. Defaults to [].
    virtual_network_subnet_ids = [azurerm_subnet.this.id] # (Optional) Defines the list of virtual network subnet IDs to apply to the storage account. Defaults to [].
    bypass                     = ["AzureServices"]        # (Optional) Defines which traffic can bypass the network rules. Valid options are AzureServices and None. Defaults to [].
  }

  private_endpoints = {
    blob = {
      subresource_name                = "blob"
      private_dns_zone_resource_ids   = [azurerm_private_dns_zone.blob.id]
      subnet_resource_id              = azurerm_subnet.this.id
    },
    queue = {
      subresource_name                = "queue"
      private_dns_zone_resource_ids   = [azurerm_private_dns_zone.queue.id]
      subnet_resource_id              = azurerm_subnet.this.id
    },
    table = {
      subresource_name                = "table"
      private_dns_zone_resource_ids   = [azurerm_private_dns_zone.table.id]
      subnet_resource_id              = azurerm_subnet.this.id
    },
    file = {
      subresource_name                = "file"
      private_dns_zone_resource_ids   = [azurerm_private_dns_zone.file.id]
      subnet_resource_id              = azurerm_subnet.this.id
    }
  }

  tags = {
    environment = "staging"
  }
}
