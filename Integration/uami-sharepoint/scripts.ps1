Install-Module Microsoft.Graph -Scope CurrentUser -Force 
Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "Application.ReadWrite.All"

# ------- Grant the Managed Identity Microsoft Graph API permissions -------
# Get the service principal for the Logic App's managed identity
$sp = Get-MgServicePrincipal -Filter "displayName eq 'mi-sharepoint-agent'"

# Find the Sites.Selected permission
$graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'" # Microsoft Graph appId
$perm = $graphSp.AppRoles | Where-Object { $_.Value -eq "Sites.Selected" -and $_.AllowedMemberTypes -contains "Application" }

# Assign Sites.Selected to the Logic App's managed identity
New-MgServicePrincipalAppRoleAssignment `
    -ServicePrincipalId $sp.Id `
    -PrincipalId $sp.Id `
    -ResourceId $graphSp.Id `
    -AppRoleId $perm.Id

# ------- Grant access to a specific SharePoint site -------
# Get the site
$site = Get-MgSite -SiteId "demodomain.sharepoint.com:/sites/MkhDemoSite"

# Grant your app (Logic App MI or SPN) Write access
New-MgSitePermission -SiteId $site.Id -Roles write -GrantedToIdentities @(
    @{ application = @{ id = $sp.appId; displayName = $sp.displayName } }
)

$permission = Get-MgSitePermission -SiteId $site.Id
$permission | ConvertTo-Json -Depth 10
