$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent -Path $MyInvocation.MyCommand.Path 

$ResourceGroup = "GoCD-JvB"
$K8sName = "$ResourceGroup-K8s"
$ServicePrincipalClientId = "http://$K8sName"
$sshRSAPublicKeyPath = "D:\ssh\jvb public"

#$windowsAdminCredentials = Get-Credential -Message "Enter username and password for the Windows Agent Admin"
$ServicePrincipalPassword = Read-Host -Prompt "Enter a password for the Azure AD Service Principal." -AsSecureString

# Login 
try {
    Get-AzureRmContext
} catch {
    Login-AzureRmAccount
}

$subscriptionId = Get-AzureRmSubscription -SubscriptionName "Visual Studio Enterprise with MSDN" | Select-Object -ExpandProperty Id

Push-Location $here
# Create Service Principal
if((Get-AzureRmADServicePrincipal -ServicePrincipalName $ServicePrincipalClientId) -eq $null)
{
    .\Create-ServicePrincipal.ps1 -ADApplicationName $K8sName -ADApplicationIdentifierUris $ServicePrincipalClientId -ADApplicationPassword $ServicePrincipalPassword
}

# Create the Parameters file
.\Create-Parameters.ps1 `
    -MasterDNSNamePrefix $K8sName `
    -AgentDNSNamePrefix "$($K8sName)Agent" `
    -AgentCount 2 `
    -AgentVMSize "Standard_D2_v2" `
    -LinuxAdminUsername "linuxAdmin" `
    -OrchestratorType "Kubernetes" `
    -MasterCount 1 `
    -SshRsaPublicKey (Get-Content $sshRSAPublicKeyPath -Raw) `
    -ADServicePrincipalClientId $ServicePrincipalClientId `
    -ADServicePrincipalClientSecret $ServicePrincipalPassword `
    -OsType "Linux" 

# Deploy the template
.\Deploy-AzureRmTemplate.ps1 -SubscriptionId $subscriptionId -ResourceGroupName $ResourceGroup -DeploymentName $K8sName -TemplateFilePath "$here\template.json" -ParametersFilePath "$here\parameters.json"

# Get Kuberentes Client
.\Get-KubeCtl.ps1

# Get the Kubernetes Configuration File
.\Get-Kubeconfig.ps1 -ResourceGroup $ResourceGroup

# Cleanup
Remove-Item ./parameters.json