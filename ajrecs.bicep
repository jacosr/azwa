param location string = 'eastus'


resource ajwsp 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'ajwasp'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  properties: {
    reserved: false
  }
}

resource ajwa 'Microsoft.Web/sites@2024-11-01' = {
  name: 'ajwa'
  location: location
  properties: {
    serverFarmId: ajwsp.id
    httpsOnly: true
  }
}


