resource "harvester_network" "vm-vlan" {
  name      = "vm-vlan"
  namespace = "default"
  vlan_id = 33
  route_dhcp_server_ip = ""
}