[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup
)

az acs kubernetes get-credentials --resource-group=$ResourceGroup --name="containerservice-$ResourceGroup"