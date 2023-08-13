## PART-04
az deployment group create -g rg-permissions-001 -f '.\keyvault-setup.bicep' -p '.\keyvault-setup.bicepparam'
az deployment group create -g rg-permissions-001 -f '.\keyvault-access-policies.bicep' -p '.\keyvault-access-policies.bicepparam'


>keyvault-setup.bicepparam(1,1) : Error BCP336: Using a Bicep Parameters file requires enabling EXPERIMENTAL feature "ParamsFiles". [https://aka.ms/bicep/config]