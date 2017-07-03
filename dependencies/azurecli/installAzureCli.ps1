$azureCliWindowsMsi = "https://aka.ms/InstallAzureCliWindows"
Invoke-WebRequest -Uri $azureCliWindowsMsi -Method Get -OutFile azure-cli.msi
Invoke-Expression "msiexec.exe /i azure-cli.msi /qb"