param logicapp_name string
param backend_url string = 'https://webhook.site/0ff6b328-347a-44af-bb10-1877c5e0b8fa'
param location string = resourceGroup().location

var tags = { workload: 'integration', provider: 'Advania Norge' }

resource logic_app_resource 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicapp_name
  location: location
  tags: tags
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      triggers: {
        When_an_HTTP_request_is_received: {
          type: 'Request'
          kind: 'Http'
          inputs: {
            schema: {
              type: 'object'
              properties: {
                customerId: {
                  type: 'string'
                }
                firstName: {
                  type: 'string'
                }
                lastName: {
                  type: 'string'
                }
                email: {
                  type: 'string'
                }
                phone: {
                  type: 'string'
                }
                billingAddress: {
                  type: 'object'
                  properties: {
                    street: {
                      type: 'string'
                    }
                    city: {
                      type: 'string'
                    }
                    state: {
                      type: 'string'
                    }
                    postalCode: {
                      type: 'string'
                    }
                    country: {
                      type: 'string'
                    }
                  }
                }
                shippingAddress: {
                  type: 'object'
                  properties: {
                    street: {
                      type: 'string'
                    }
                    city: {
                      type: 'string'
                    }
                    state: {
                      type: 'string'
                    }
                    postalCode: {
                      type: 'string'
                    }
                    country: {
                      type: 'string'
                    }
                  }
                }
              }
            }
          }
        }
      }
      actions: {
        Compose_Customer: {
          runAfter: {}
          type: 'Compose'
          inputs: {
            id: '@triggerBody()?[\'customerId\']'
            fullName: {
              given: '@triggerBody()?[\'firstName\']'
              family: '@triggerBody()?[\'lastName\']'
            }
            contact: {
              emailAddress: '@triggerBody()?[\'email\']'
              phoneNumber: '@triggerBody()?[\'phone\']'
            }
            addresses: [
              {
                type: 'Billing'
                street: '@triggerBody()?[\'billingAddress\']?[\'street\']'
                city: '@ triggerBody()?[\'billingAddress\']?[\'city\']'
                state: '@ triggerBody()?[\'billingAddress\']?[\'state\']'
                postalCode: '@ triggerBody()?[\'billingAddress\']?[\'postalCode\']'
                country: '@ triggerBody()?[\'billingAddress\']?[\'country\']'
              }
              {
                type: 'Shipping'
                street: '@triggerBody()?[\'shippingAddress\']?[\'street\']'
                city: '@triggerBody()?[\'shippingAddress\']?[\'city\']'
                state: '@triggerBody()?[\'shippingAddress\']?[\'state\']'
                postalCode: '@triggerBody()?[\'shippingAddress\']?[\'postalCode\']'
                country: '@triggerBody()?[\'shippingAddress\']?[\'country\']'
              }
            ]
          }
        }
        PostToBackEnd: {
          runAfter: {
            Compose_Customer: [
              'Succeeded'
            ]
          }
          type: 'Http'
          inputs: {
            uri: backend_url
            method: 'POST'
            body: '@outputs(\'Compose_Customer\')'
          }
          runtimeConfiguration: {
            contentTransfer: {
              transferMode: 'Chunked'
            }
          }
        }
        Response: {
          runAfter: {
            PostToBackEnd: [
              'Succeeded'
            ]
          }
          type: 'Response'
          kind: 'Http'
          inputs: {
            statusCode: 200
          }
        }
      }
      outputs: {}
    }
    parameters: {
      '$connections': {
        value: {}
      }
    }
  }
}
