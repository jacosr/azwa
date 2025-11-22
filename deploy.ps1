param(
	[switch]$Zip = $true
)

Import-Module Az

if ($Zip) {
	if (Test-Path .\ajwa.zip) { Remove-Item .\ajwa.zip -Force }
	Compress-Archive -Path .\app.js, .\package.json, .\package-lock.json -DestinationPath .\ajwa.zip
	Write-Host "ajwa.zip recreated."
} 

$ctx = Get-AzContext
if ($ctx.Account -eq $null) {
    Connect-AzAccount 
}
else {
    Write-Host "using azure account $($ctx.Account)"
}

Set-AzContext -Subscription "aef7fae9-c3c7-49ca-aab8-00c6f4aa79d3"

New-AzSubscriptionDeployment -Location 'eastus' -TemplateFile .\aj.bicep

Write-Host "Deployment complete."

