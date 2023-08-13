param keyvault_name string
param resource_group_name string
param logicapp_names array

module api_operation_deployment 'keyvault-access-policies.bicep' = {
  name: 'Deploy-KeyVault-Access-Policies-For-LogicApps'
  params: {
    keyvault_name: keyvault_name
    resource_group_name: resource_group_name
    logicapp_names: logicapp_names
  }
}
