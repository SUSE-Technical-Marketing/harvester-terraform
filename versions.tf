terraform {
  required_version = ">= 0.13"
  required_providers {
    harvester = {
      source = "harvester/harvester"
      version = "0.4.0"
    }
  }
}

provider "harvester" {
  # Harvester access using kubeconfig
  kubeconfig = "/Users/avalero/harvester-nue.yaml"
  #kubeconfig = var.harv_kube
}
