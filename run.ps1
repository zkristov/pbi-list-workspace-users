#Requires -Modules @{ ModuleName="MicrosoftPowerBIMgmt.Profile"; ModuleVersion="1.2.1111"}

$ErrorActionPreference = "Stop"
$VerbosePreference = "SilentlyContinue"

$servicePrincipalId = ""
$servicePrincipalSecret = ""
$servicePrincipalTenantId = ""

# Connect to the Power BI Service
if ($servicePrincipalId)
{
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $servicePrincipalId, ($servicePrincipalSecret | ConvertTo-SecureString -AsPlainText -Force)

    Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $servicePrincipalTenantId -Credential $credential
}
else {
    Connect-PowerBIServiceAccount
}

# Get a list of all premium Workspaces & Users on the tenant (up to 5000)
#https://api.powerbi.com/v1.0/myorg/admin/groups?$expand=users

$url = "admin/groups?`$expand=users&`$filter=isOnDedicatedCapacity eq true and tolower(state) eq 'active'&`$top=5000&`$skip=0"
$workspaceResults = Invoke-PowerBIRestMethod -Url $url -Method Get | ConvertFrom-Json
$workspaceResults = $workspaceResults.value 

# Create output directory
$outputFilePath = "./output/workspace_users.json"
New-Item -Path (Split-Path $outputFilePath -Parent) -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

# Save as json file
ConvertTo-Json $workspaceResults -Depth 10 -Compress | Out-File $outputFilePath -force