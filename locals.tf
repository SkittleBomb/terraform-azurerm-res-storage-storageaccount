locals {
  resource_group_location            = try(data.azurerm_resource_group.parent[0].location, null)
  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
}

# Private endpoint application security group associations
locals {
  private_endpoint_application_security_group_associations = { for assoc in flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for asg_k, asg_v in pe_v.application_security_group_associations : {
        asg_key         = asg_k
        pe_key          = pe_k
        asg_resource_id = asg_v
      }
    ]
  ]) : "${assoc.pe_key}-${assoc.asg_key}" => assoc }
}

locals {
  containers_role_assignments = flatten([
    for ck, cv in var.containers : [
      for rak, rav in cv.role_assignments : {
        container_key       = ck
        role_assignment_key = rak
        role_assignment     = rav
      }
    ]
  ])
}
