resource "harvester_network" "vm-vlan" {
  name      = "vm-vlan"
  namespace = "default"
  vlan_id = 33 # Check the ids on Harvester and change it accordingly
  route_dhcp_server_ip = ""
}
