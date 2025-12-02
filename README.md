# Azure Landing Zone

This repository contains an Azure Landing Zone implementation based on the [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/) Bicep pattern modules.

## Overview

The Azure Landing Zone is implemented using the `avm/ptn/alz/empty` pattern module, which provides a flexible and customizable foundation for deploying Azure Landing Zones. The "empty" archetype allows complete control over the configuration without any pre-configured policies or role assignments.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) version 2.20.0 or later
- [Bicep CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) version 0.4.0 or later
- Azure subscription with Owner or Contributor access
- Management Group write permissions at the tenant level

## Repository Structure

```
azure-landing-zone/
├── README.md
└── infra-as-code/
    └── bicep/
        ├── bicepconfig.json          # Bicep configuration
        ├── main.bicep                 # Main deployment template
        ├── modules/                   # Custom Bicep modules
        ├── orchestrators/             # Orchestration templates
        └── parameters/
            └── main.parameters.json   # Deployment parameters
```

## Features

The `avm/ptn/alz/empty` module supports the following capabilities:

- **Management Groups**: Create or target existing management groups
- **Subscription Association**: Move subscriptions into management groups
- **Role Definitions**: Create custom RBAC role definitions
- **Role Assignments**: Assign roles at the management group scope
- **Policy Definitions**: Create custom Azure Policy definitions
- **Policy Set Definitions**: Create policy initiatives
- **Policy Assignments**: Assign policies at the management group scope

## Deployment

### Option 1: Azure CLI

```bash
# Login to Azure
az login

# Set the target management group (or use tenant root)
MANAGEMENT_GROUP_ID="your-management-group-id"

# Deploy the landing zone
az deployment mg create \
  --location eastus \
  --management-group-id $MANAGEMENT_GROUP_ID \
  --template-file infra-as-code/bicep/main.bicep \
  --parameters @infra-as-code/bicep/parameters/main.parameters.json
```

### Option 2: PowerShell

```powershell
# Login to Azure
Connect-AzAccount

# Set the target management group
$ManagementGroupId = "your-management-group-id"

# Deploy the landing zone
New-AzManagementGroupDeployment `
  -Location "eastus" `
  -ManagementGroupId $ManagementGroupId `
  -TemplateFile "infra-as-code/bicep/main.bicep" `
  -TemplateParameterFile "infra-as-code/bicep/parameters/main.parameters.json"
```

## Configuration

Edit the `infra-as-code/bicep/parameters/main.parameters.json` file to customize your deployment:

| Parameter | Description | Required |
|-----------|-------------|----------|
| `managementGroupId` | Unique identifier for the management group | Yes |
| `managementGroupDisplayName` | Display name for the management group | No |
| `parentManagementGroupId` | Parent management group ID | No |
| `subscriptionIds` | Array of subscription IDs to associate | No |
| `roleDefinitions` | Custom role definitions | No |
| `roleAssignments` | Role assignments | No |
| `policyDefinitions` | Custom policy definitions | No |
| `policySetDefinitions` | Policy initiatives | No |
| `policyAssignments` | Policy assignments | No |
| `location` | Deployment location | No |

## Resources

- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Bicep Pattern Modules](https://azure.github.io/Azure-Verified-Modules/indexes/bicep/bicep-pattern-modules/)
- [Azure Landing Zones Documentation](https://azure.github.io/Azure-Landing-Zones/)
- [Azure/bicep-registry-modules Repository](https://github.com/Azure/bicep-registry-modules)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
