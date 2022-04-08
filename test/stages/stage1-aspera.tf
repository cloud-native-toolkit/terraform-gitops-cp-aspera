module gitops-cp-aspera {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-aspera-operator.git"

  gitops_config   = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  namespace       = module.gitops_namespace.name
  server_name     = module.gitops.server_name
  catalog         = module.cp_catalogs.catalog_ibmoperators
  channel         = module.cp4i-dependencies.aspera.channel
}
