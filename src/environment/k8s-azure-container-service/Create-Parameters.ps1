[CmdletBinding()]
param(
    [string]$MasterDNSNamePrefix,
    [string]$AgentDNSNamePrefix,
    [int]$AgentCount = 1,
    [string]$AgentVMSize = "Standard_D2_v2",
    [string]$LinuxAdminUsername,
    [PSCredential]$WindowsAgentAdminCredentials,
    [string]$OrchestratorType = "Kubernetes",
    [int]$MasterCount = 1,
    [string]$SshRsaPublicKey,
    [string]$ADServicePrincipalClientId,
    [SecureString]$ADServicePrincipalClientSecret,
    [string]$OsType = "linux"
)

$here = Split-Path -Path $MyInvocation.MyCommand.Path -Parent 

$parameters = (Get-Content "$here\parametersTemplate.json" -Raw |  ConvertFrom-Json)

$parameters.parameters.masterDnsNamePrefix.value = $MasterDNSNamePrefix
$parameters.parameters.agentDnsNamePrefix.value = $AgentDNSNamePrefix
$parameters.parameters.agentCount.value = $AgentCount
$parameters.parameters.agentVMSize.value = $AgentVMSize
$parameters.parameters.linuxAdminUsername.value = $LinuxAdminUsername
#$parameters.parameters.windowsAgentAdminUsername = $WindowsAgentAdminCredentials.UserName
#$parameters.parameters.windowsAgentAdminPassword = $WindowsAgentAdminCredentials.GetNetworkCredential().Password
$parameters.parameters.orchestratorType.value = $OrchestratorType
$parameters.parameters.masterCount.value = $MasterCount
$parameters.parameters.sshRSAPublicKey.value = $SshRsaPublicKey
$parameters.parameters.servicePrincipalClientId.value = $ADServicePrincipalClientId
$parameters.parameters.servicePrincipalClientSecret.value = ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ADServicePrincipalClientSecret)))
$parameters.parameters.osType.value = $OsType

$parameters | ConvertTo-Json | Set-Content "$here\parameters.json" -Force
