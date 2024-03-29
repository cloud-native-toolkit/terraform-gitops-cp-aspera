module "aspera_instance" {
  source = "./module"
  #source = "C:\/Users\/JYOTIRANI//Desktop\terraform\ES_instance\terraform-gitops-cp-event-streams-instance"

  depends_on = [
    module.gitops-cp-aspera
  ]

  gitops_config   = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name     = module.gitops.server_name
  namespace       = module.gitops_namespace.name
  kubeseal_cert   = module.gitops.sealed_secrets_cert
  entitlement_key = module.cp_catalogs.entitlement_key
  license_use     = module.cp4i-dependencies.aspera.license_use
  asperaversion   = module.cp4i-dependencies.aspera.version
  #asperaversion = "4.4.0"
  license_key = var.license_key
  #  version = "4.0.0"
}
