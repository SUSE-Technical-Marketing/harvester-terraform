variable "harv_kube" {
  type        = string
  description = "Harvester Kubeconfig, needed to access the platform"
  sensitive   = true
}
