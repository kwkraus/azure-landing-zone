targetScope = 'managementGroup'

metadata name = 'Azure Landing Zone - Empty Pattern'
metadata description = 'This Bicep file deploys an empty Azure Landing Zone using the Azure Verified Modules (AVM) pattern module avm/ptn/alz/empty.'
metadata owner = 'Azure Landing Zone Team'

// ========== //
// Parameters //
// ========== //

@description('Required. The unique identifier for the root management group.')
param managementGroupId string

@description('Optional. The display name for the root management group. Defaults to the managementGroupId.')
param managementGroupDisplayName string = managementGroupId

@description('Optional. The parent management group ID. If not specified, the tenant root management group will be used.')
param parentManagementGroupId string = ''

@description('Optional. Array of subscription IDs to associate with the management group.')
param subscriptionIds array = []

@description('Optional. Array of custom role definitions to create at the management group scope.')
param roleDefinitions array = []

@description('Optional. Array of role assignments to create at the management group scope.')
param roleAssignments array = []

@description('Optional. Array of custom policy definitions to create.')
param policyDefinitions array = []

@description('Optional. Array of policy set definitions (initiatives) to create.')
param policySetDefinitions array = []

@description('Optional. Array of policy assignments to create.')
param policyAssignments array = []

@description('Optional. Location for deployment metadata.')
param location string = deployment().location

// ========= //
// Variables //
// ========= //

// Construct the parent management group ID if provided
var parentMgId = !empty(parentManagementGroupId) ? parentManagementGroupId : tenant().tenantId

// ========= //
// Resources //
// ========= //

@description('Deploy the empty Azure Landing Zone pattern using AVM module')
module alzEmpty 'br/public:avm/ptn/alz/empty:0.1.0' = {
  name: 'alz-empty-${uniqueString(managementGroupId)}'
  params: {
    managementGroupId: managementGroupId
    managementGroupDisplayName: managementGroupDisplayName
    parentManagementGroupId: parentMgId
    subscriptionIds: subscriptionIds
    roleDefinitions: roleDefinitions
    roleAssignments: roleAssignments
    policyDefinitions: policyDefinitions
    policySetDefinitions: policySetDefinitions
    policyAssignments: policyAssignments
    location: location
  }
}

// ======= //
// Outputs //
// ======= //

@description('The resource ID of the created management group.')
output managementGroupResourceId string = alzEmpty.outputs.managementGroupResourceId

@description('The name/ID of the created management group.')
output managementGroupName string = alzEmpty.outputs.managementGroupName
