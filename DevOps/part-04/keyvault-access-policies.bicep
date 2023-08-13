param keyvault_name string
param resource_group_name string
param logicapp_names array

var logicapp_schema_ver = '2017-07-01'
var logicapp_permission = {
  keys: []
  secrets: [
    'Get'
    'List'
  ]
  certificates: []
  storage: []
}

resource keyvault 'Microsoft.KeyVault/vaults@2021-10-01' existing = {
  name: keyvault_name
}

resource keyvault_access_policy 'Microsoft.KeyVault/vaults/accessPolicies@2019-09-01' = {
  parent: keyvault
  name: 'add'
  properties: {
    accessPolicies: [for logicapp_name in logicapp_names: {
      tenantId: subscription().tenantId
      objectId: reference(resourceId(subscription().subscriptionId, resource_group_name, 'Microsoft.Logic/workflows', logicapp_name), logicapp_schema_ver, 'full').identity.principalId
      permissions: logicapp_permission
    }]
  }
}
