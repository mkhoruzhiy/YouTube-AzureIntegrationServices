# Manual deployment
az login --tenant 69673b67-0659-481d-9974-ea953b4018df <!-- theitadvisorhotmail.onmicrosoft.com -->
az account set --subscription 794e6bb7-9748-431a-95d9-867c28c13de4 <!-- Demo subscription -->
az group list

## PART-04
az deployment group create -g rg-permissions-001 -f '.\keyvault-setup.bicep' -p '.\keyvault-setup.bicepparam'
az deployment group create -g rg-permissions-001 -f '.\keyvault-access-policies.bicep' -p '.\keyvault-access-policies.bicepparam'


>keyvault-setup.bicepparam(1,1) : Error BCP336: Using a Bicep Parameters file requires enabling EXPERIMENTAL feature "ParamsFiles". [https://aka.ms/bicep/config]