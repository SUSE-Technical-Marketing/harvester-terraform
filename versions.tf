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
  #kubeconfig = "/tmp/Kubeconfig/harvester-nue.yaml"
  kubeconfig = "/Users/avalero/harvester-nue.yaml"
}
