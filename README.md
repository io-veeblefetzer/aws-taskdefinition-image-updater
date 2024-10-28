# Bitbucket Pipelines Pipe: AWS Taskdefinition Image Updater

This pipe retreives an existing taskdefinition and creates a new version of the taskdefinition where **only**
the image has been updated on JSON path `.containerDefinitions[0].image`. Currently, this is a very rudymentary 
pipe for a specific use case only.

## Use case example
We have a scheduled task in ECS and just want to update the image tag. Our task definition is provided by infrastructure as code.
The latter also provides the correct environment variables, based on some other IaC-controlled resources. So whereas IaC
is the owner of the infrastructure. A deployment pipeline just has to update the image to the latest `image:tag`.  That
is where this pipe comes in to play to do exactly that. 

# YAML Definition
Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:


```yaml
- pipe: .../aws-taskdefinition-image-updater:0.0.1
  variables:
    AWS_ACCESS_KEY_ID: '<string>' # Mandatory
    AWS_SECRET_ACCESS_KEY: '<string>' # Mandatory
    AWS_DEFAULT_REGION: '<string>' # Best to define
    IMAGE: '<string>' # Mandatory image:tag combination
    TASK_DEFINITION_NAME: '<string>' # Mandatory: the name of the taskdefinition to update
```