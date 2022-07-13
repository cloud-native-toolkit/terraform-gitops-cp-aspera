
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.aspera_instance.name
        branch      = module.aspera_instance.branch
        namespace   = module.aspera_instance.namespace
        server_name = module.aspera_instance.server_name
        layer       = module.aspera_instance.layer
        layer_dir   = module.aspera_instance.layer == "infrastructure" ? "1-infrastructure" : (module.aspera_instance.layer == "services" ? "2-services" : "3-applications")
        type        = module.aspera_instance.type
      })
    }
  }
}
