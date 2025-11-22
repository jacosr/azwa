param loc string

@allowed([
  'dev'
  'test'
  'prod'
])
param env string


var sku = env == 'prod' ? {
  name: 'S1'
  tier: 'Standard'
} : {
  name: 'B1'
  tier: 'Basic'
}

resource ajwsp 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: 'ajwasp'
  location: loc
  sku: sku
  properties: {
    reserved: false
  }
}

resource ajwa 'Microsoft.Web/sites@2024-11-01' = {
  name: 'ajwa'
  location: loc
  properties: {
    serverFarmId: ajwsp.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~20'
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '0'
        }
        {
          name: 'STARTUP_COMMAND'
          value: 'node app.js'
        }
        {
          name: 'environment'
          value: env
        }
        {
          name: 'Property' 
          value: '1'
        }
      ]
    }
  }
}


// Define slot-specific settings as a separate config resource
resource slotConfigNames 'Microsoft.Web/sites/config@2024-11-01' = if (env == 'Production') {
  name: 'slotConfigNames'
  parent: ajwa
  properties: {
    appSettingNames: [
      'Property'
    ]
  }
}

resource stagingSlot 'Microsoft.Web/sites/slots@2024-11-01' = if (env == 'Production') {
  name: 'staging'
  parent: ajwa
  location: loc
  properties: {
    serverFarmId: ajwsp.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'Property' 
          value: '0'
        }
      ]
    }
  }
}
