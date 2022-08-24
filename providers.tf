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
  # Needs full path to kubeconfig file provided by Harvester
  kubeconfig = var.harvester_kubeconfig_path
}
