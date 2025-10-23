targetScope = 'subscription'

param location string

@allowed(['Production', 'Development'])
param environment string

resource ajrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'ajrg'
  location: location
}


module ajrecs 'ajrecs.bicep' = {
  name: 'ajrecs'
  scope: ajrg
  params: { 
    location: location
    environment: environment 
  }
}



