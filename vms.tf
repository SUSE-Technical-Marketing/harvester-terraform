### VM to be created on Harvester

resource "harvester_virtualmachine" "opensuse" {
  
  #Wait until the chosen image is imported and ready for consumption
  depends_on = [
    harvester_image.os_image
  ]

  name        = var.vm_data.name
  namespace   = var.vm_data.namespace
  description = var.vm_data.description

  hostname    = var.vm_data.hostname

  tags = var.vm_data.tags

  cpu    = var.vm_data.cpus
  memory = var.vm_data.memory

  run_strategy = "RerunOnFailure"
  
  network_interface {
    name           = "nic-0"
    #network_name   = "default/vlan-65"
    network_name   = data.harvester_network.vm_network.name
  }

  disk {
    name       = var.vm_data.disks[0].name
    type       = "disk"
    size       = var.vm_data.disks[0].size
    bus        = "virtio"
    boot_order = var.vm_data.disks[0].boot_order
    image       = harvester_image.os_image.id
    auto_delete = true
  }

  disk {
    name        = var.vm_data.disks[1].name
    type        = "disk"
    size        = var.vm_data.disks[1].size
    bus         = "virtio"
    boot_order = var.vm_data.disks[1].boot_order
    auto_delete = true
  }

  cloudinit {
    user_data    = <<-EOF
    #cloud-config
    #Used password for quick testing purposes. Should add ssh key instead
    password: $Changeme1st
    chpasswd:
      expire: false
    ssh_pwauth: true
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent.service
      - systemctl start --no-block qemu-guest-agent.service

    EOF
    network_data = ""
  }

}
