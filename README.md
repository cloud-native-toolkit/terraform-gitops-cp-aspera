# IBM Cloud Pak Aspera HSTS module

Module to populate a gitops repository with the Aspera HSTS operator from IBM Cloud Pak for Integration.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v15

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- Catalogs - github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git
- Cp4i-Dependency - github.com/cloud-native-toolkit/terraform-cp4i-dependency-management.git
- Aspera Operator - github.com/cloud-native-toolkit/terraform-gitops-cp-aspera-operator.git

## Example usage

```hcl-terraform
module "aspera" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-aspera.git"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  kubeseal_cert = module.argocd-bootstrap.sealed_secrets_cert
  catalog = module.cp_catalogs.catalog_ibmoperators    
}
```
