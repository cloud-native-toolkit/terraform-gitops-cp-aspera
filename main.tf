locals {
  name               = var.service_name
  bin_dir            = module.setup_clis.bin_dir
  yaml_dir           = "${path.cwd}/.tmp/${local.name}/chart/${local.name}"
  service_url        = "http://${local.name}.${var.namespace}"
  layer              = "services"
  type               = "base"
  application_branch = "main"
  namespace          = var.namespace
  layer_config       = var.gitops_config[local.layer]
  values_file        = "values.yaml"
  values_content = {
    name                      = var.service_name
    namespace                 = var.namespace
    version                   = var.version
    license_use               = var.license_use
    key                       = var.license_key
    redis_persistence_enabled = var.redis_persistence_enabled
    redis_storageClass        = var.redis_storageClass
    deployment_replicas       = var.deployment_replicas
    claim_name                = var.claim_name
    storageClass              = var.storageClass
    deleteClaim               = var.deleteClaim
    mountPath                 = var.mountPath
    claim_size                = var.claim_size
    redis_resources = {
      requests = {
        cpu    = var.redis_cpu_requests
        memory = var.redis_memory_requests
      }
    }
    containers = {
      ascp = {
        resources = {
          limits = {
            cpu    = var.ascp_cpu_limits
            memory = var.ascp_memory_limits
          }
          requests = {
            cpu    = var.ascp_cpu_requests
            memory = var.ascp_memory_requests
          }
        }
      }
      asperanoded = {
        resources = {
          limits = {
            cpu    = var.asperanoded_cpu_limits
            memory = var.asperanoded_memory_limits
          }
          requests = {
            cpu    = var.asperanoded_cpu_requests
            memory = var.asperanoded_memory_requests
          }
        }
      }
      default = {
        resources = {
          limits = {
            cpu    = var.default_cpu_limits
            memory = var.default_memory_limits
          }
          requests = {
            cpu    = var.default_cpu_requests
            memory = var.default_memory_requests
          }
        }
      }
    }
  }
}

module setup_clis {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"
}

module pull_secret {
  source = "github.com/cloud-native-toolkit/terraform-gitops-pull-secret"

  gitops_config   = var.gitops_config
  git_credentials = var.git_credentials
  server_name     = var.server_name
  kubeseal_cert   = var.kubeseal_cert
  namespace       = var.namespace
  docker_username = "cp"
  docker_password = var.entitlement_key
  docker_server   = "cp.icr.io"
  secret_name     = "ibm-entitlement-key"
}

resource null_resource create_yaml {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create-yaml.sh '${local.name}' '${local.yaml_dir}'"

    environment = {
      VALUES_CONTENT = yamlencode(local.values_content)
    }
  }
}

resource null_resource setup_gitops {
  depends_on = [null_resource.create_yaml]

  triggers = {
    name            = local.name
    namespace       = var.namespace
    yaml_dir        = local.yaml_dir
    server_name     = var.server_name
    layer           = local.layer
    type            = local.type
    git_credentials = yamlencode(var.git_credentials)
    gitops_config   = yamlencode(var.gitops_config)
    bin_dir         = local.bin_dir
  }

  provisioner "local-exec" {
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --contentDir '${self.triggers.yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${self.triggers.bin_dir}/igc gitops-module '${self.triggers.name}' -n '${self.triggers.namespace}' --delete --contentDir '${self.triggers.yaml_dir}' --serverName '${self.triggers.server_name}' -l '${self.triggers.layer}' --type '${self.triggers.type}'"

    environment = {
      GIT_CREDENTIALS = nonsensitive(self.triggers.git_credentials)
      GITOPS_CONFIG   = self.triggers.gitops_config
    }
  }
}
