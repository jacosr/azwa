if (Test-Path .\ajwa.zip) { Remove-Item .\ajwa.zip -Force }
Compress-Archive -Path .\app.js, .\package.json, .\package-lock.json -DestinationPath .\ajwa.zip

