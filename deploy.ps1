# preliminaries
param(
	[switch]$Zip = $true
)
Import-Module Az

# constants
$rg = "ajrg"
$wa = "ajwa"

# Create a zip of the application files
if ($Zip) {
	if (Test-Path .\ajwa.zip) { Remove-Item .\ajwa.zip -Force }
	Compress-Archive -Path .\app.js, .\package.json, .\package-lock.json -DestinationPath .\ajwa.zip
	Write-Host "ajwa.zip recreated."
} 

# Authenticate to Azure and set the context
$ctx = Get-AzContext
if ($ctx.Account -eq $null) {
    Connect-AzAccount 
}
else {
    Write-Host "using azure account $($ctx.Account)"
}
Set-AzContext -Subscription "aef7fae9-c3c7-49ca-aab8-00c6f4aa79d3"

# Deploy the infrastructure
New-AzSubscriptionDeployment -Location 'eastus' -TemplateFile .\aj.bicep

# Deploy the application
Publish-AzWebApp -ArchivePath ".\$wa.zip" -Name $wa -ResourceGroupName $rg -Type zip -Force

# Restart the web app to ensure changes take effect
Restart-AzWebApp -ResourceGroupName $rg -Name $wa

Write-Host "Deployment complete. Your app should be available at https://$wa.azurewebsites.net"
Write-Host "Check logs at: https://$wa.scm.azurewebsites.net/api/logstream"

