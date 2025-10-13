targetScope = 'subscription'

param location string = 'eastus'

resource ajrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'ajrg'
  location: location
}


module ajrecs 'ajrecs.bicep' = {
  name: 'ajrecs'
  scope: ajrg
  params: { 
    location: location 
  }
}



