[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ADApplicationName,
    [Parameter(Mandatory=$true)]    
    [string[]]$ADApplicationIdentifierUris,
    [Parameter(Mandatory=$true)]    
    [SecureString]$ADApplicationPassword
    )

# Login
$app = New-AzureRmADApplication -DisplayName $ADApplicationName -IdentifierUris $ADApplicationIdentifierUris -Password ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ADApplicationPassword)))

# Create the Service Principal
New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId
Write-Host "Giving Azure a moment to create the Service Principal"
Start-Sleep 15

# Assign the Role to the Service Principal
New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $app.ApplicationId