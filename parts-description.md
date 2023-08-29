# DevOps videos
## Part 01

## Part 04

## Part 05 - Depoyment of json schemas with use of bicep and loadJsonContent()
- Part 1
    - Deployment of Logic App with HTTP trigger and schema validation
    - Bicep code for deployment is ready
    - Show how the Logic App is deployed and the schema validation works
- Part 2
    - Introduce the function loadJsonContent(); [File functions for Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-files)
    - Create a json file with json schema as a content
    - Modify the bicep file:
        - add loading of the json schema from the file
        - explain that one file may contain multiple schemas and the function allows for loading a particular element
    - Run deployment and show the result
    - Reasonong of file usage:
        - simplified editing
        - usage of the same schema in multiple places: several logic apps, APIM
        - the file may contain JSON object of parameters 