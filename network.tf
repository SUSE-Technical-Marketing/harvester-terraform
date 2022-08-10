resource "harvester_network" "vm-vlan" {
  name      = "vm-vlan"
  namespace = "default"
  vlan_id   = vlan-1 #Change for whatever you want
}