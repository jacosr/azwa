param(
	[switch]$Zip = $true
)

if ($Zip) {
	if (Test-Path .\ajwa.zip) { Remove-Item .\ajwa.zip -Force }
	Compress-Archive -Path .\app.js, .\package.json, .\package-lock.json -DestinationPath .\ajwa.zip
	Write-Host "ajwa.zip recreated."
} 