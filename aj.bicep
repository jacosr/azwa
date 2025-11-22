targetScope = 'subscription'

param loc string

@allowed([
  'dev'
  'test'
  'prod'
])
param env string


resource ajrg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'ajrg'
  location: loc
}


module ajrecs 'ajrecs.bicep' = {
  name: 'ajrecs'
  scope: ajrg
  params: { 
    loc: loc
    env: env
  }
}



