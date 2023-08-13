using './keyvault-access-policies.bicep'

param keyvault_name = 'kv-permissions-001'
param resource_group_name = 'rg-permissions-001'
param logicapp_names = ['logic-getpassword-01', 'logic-getpassword-02']
