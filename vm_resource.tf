## VMs to provision in Harvester

resource "harvester_virtualmachine" "ubuntu20-dev" {
  name                 = "ubuntu-dev"
  namespace            = "default"
  #restart_after_update = true

  description = "test raw image"
  tags = {
    ssh-user = "ubuntu"
  }

  cpu    = 2
  memory = "2Gi"

  run_strategy = "RerunOnFailure"
  hostname     = "ubuntu-dev"
  machine_type = "q35"

#  ssh_keys = [
#    harvester_ssh_key.mysshkey.id
#  ]

  network_interface {
    name           = "nic-1"
    network_name   = "default/vlan-65"
    #wait_for_lease = true
  }

#  network_interface {
#    name         = "nic-2"
#    model        = "virtio"
#    type         = "bridge"
#    network_name = harvester_network.vlan2.id
#  }

#  network_interface {
#    name         = "nic-3"
#    model        = "e1000"
#    type         = "bridge"
#    network_name = harvester_network.vlan3.id
#  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "10Gi"
    bus        = "virtio"
    boot_order = 1

    image       = harvester_image.ubuntu20.id
    auto_delete = true
  }

  disk {
    name        = "emptydisk"
    type        = "disk"
    size        = "20Gi"
    bus         = "virtio"
    auto_delete = true
  }

#  disk {
#    name = "mount-disk"
#    type = "disk"
#    bus  = "scsi"
#
#    existing_volume_name = harvester_volume.ubuntu20-dev-mount-disk.name
#    auto_delete          = false
#    hot_plug             = true
#  }

  cloudinit {
    user_data    = <<-EOF
      #cloud-config
      user: ubuntu
      password: myP4$$w0rd
      chpasswd:
        expire: false
      ssh_pwauth: true
      package_update: true
      packages:
        - qemu-guest-agent
      runcmd:
        - - systemctl
          - enable
          - '--now'
          - qemu-guest-agent
      EOF
    network_data = ""
  }
}
