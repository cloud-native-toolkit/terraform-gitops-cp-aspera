
variable "gitops_config" {
  type = object({
    boostrap = object({
      argocd-config = object({
        project = string
        repo    = string
        url     = string
        path    = string
      })
    })
    infrastructure = object({
      argocd-config = object({
        project = string
        repo    = string
        url     = string
        path    = string
      })
      payload = object({
        repo = string
        url  = string
        path = string
      })
    })
    services = object({
      argocd-config = object({
        project = string
        repo    = string
        url     = string
        path    = string
      })
      payload = object({
        repo = string
        url  = string
        path = string
      })
    })
    applications = object({
      argocd-config = object({
        project = string
        repo    = string
        url     = string
        path    = string
      })
      payload = object({
        repo = string
        url  = string
        path = string
      })
    })
  })
  description = "Config information regarding the gitops repo structure"
}

variable "git_credentials" {
  type = list(object({
    repo     = string
    url      = string
    username = string
    token    = string
  }))
  description = "The credentials for the gitops repo(s)"
  sensitive   = true
}

variable "namespace" {
  type        = string
  description = "The namespace where the application should be deployed"
}

variable "kubeseal_cert" {
  type        = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default     = ""
}

variable "server_name" {
  type        = string
  description = "The name of the server"
  default     = "default"
}

variable "entitlement_key" {
  type        = string
  description = "The entitlement key required to access Cloud Pak images"
  sensitive   = true
}

variable "license_key" {
  type        = string
  description = "License key for Aspera HSTS"
}

variable "license_use" {
  type        = string
  description = "Usage for Production or Non-Production"
  default     = "CloudPakForIntegrationNonProduction"
}

variable "asperaversion" {
  type        = string
  description = "Version of Aspera to be installed"
  default     = "4.0.0"
}
variable "service_name" {
  type        = string
  description = "Aspera HSTS instance name"
  default     = "ibm-aspera"
}

variable "claim_size" {
  type        = string
  description = "Size of the persistent volume claim"
  default     = "20Gi"
}

variable "mountPath" {
  type        = string
  description = "Storage mount path"
  default     = "/data/"
}

variable "deleteClaim" {
  type        = bool
  description = "Delete persistent volume claim"
  default     = true
}

variable "storageClass" {
  type        = string
  description = "Stroage class for Aspera HSTS instance"
  default     = "portworx-rwx-gp3-sc"
}

variable "claim_name" {
  type        = string
  description = "Persistent volume claim name to be used"
  default     = "hsts-transfer-pvc"
}

variable "deployment_replicas" {
  type        = number
  description = "Number of deployment replicas for Aspera"
  default     = 1
}

variable "redis_storageClass" {
  type        = string
  description = "Storage class for redis"
  default     = "portworx-rwx-gp3-sc"
}

variable "redis_persistence_enabled" {
  type        = bool
  description = "Persistence is enabled or disabled for redis db"
  default     = false
}

variable "redis_cpu_requests" {
  type        = string
  description = "CPU request for redis"
  default     = "1000m"
}

variable "redis_memory_requests" {
  type        = string
  description = "Memory request for redis"
  default     = "8Gi"
}


variable "ascp_cpu_requests" {
  type        = string
  description = "CPU request for ascp"
  default     = "100m"
}

variable "ascp_memory_requests" {
  type        = string
  description = "Memory request for ascp"
  default     = "512Mi"
}

variable "ascp_cpu_limits" {
  type        = string
  description = "CPU request for ascp"
  default     = "1000m"
}

variable "ascp_memory_limits" {
  type        = string
  description = "Memory request for ascp"
  default     = "2048Mi"
}

variable "asperanoded_cpu_requests" {
  type        = string
  description = "CPU request for asperanoded"
  default     = "500m"
}

variable "asperanoded_memory_requests" {
  type        = string
  description = "Memory request for asperanoded"
  default     = "512Mi"
}

variable "asperanoded_cpu_limits" {
  type        = string
  description = "CPU request for asperanoded"
  default     = "2000m"
}

variable "asperanoded_memory_limits" {
  type        = string
  description = "Memory request for asperanoded"
  default     = "1024Mi"
}

variable "default_cpu_requests" {
  type        = string
  description = "Default CPU request "
  default     = "100m"
}

variable "default_memory_requests" {
  type        = string
  description = "Default Memory request"
  default     = "250Mi"
}

variable "default_cpu_limits" {
  type        = string
  description = "Default CPU request"
  default     = "500m"
}

variable "default_memory_limits" {
  type        = string
  description = "Default Memory request "
  default     = "512Mi"
}
