### VMs to provision in Harvester
#
#resource "harvester_virtualmachine" "ubuntu20-dev" {
#  name                 = "ubuntu-dev"
#  namespace            = "default"
#  description = "test ubuntu image"
#  tags = {
#    ssh-user = "ubuntu"
#  }
#
#  cpu    = 2
#  memory = "2Gi"
#
#  run_strategy = "RerunOnFailure"
#  hostname     = "ubuntu-dev"
#
#  network_interface {
#    name           = "nic-1"
#    network_name   = harvester_network.vm-vlan.id
#  }
#
#  disk {
#    name       = "rootdisk"
#    type       = "disk"
#    size       = "10Gi"
#    bus        = "virtio"
#    boot_order = 1
#    image       = harvester_image.ubuntu20.id
#    auto_delete = true
#  }
#
#  disk {
#    name        = "emptydisk"
#    type        = "disk"
#    size        = "20Gi"
#    bus         = "virtio"
#    auto_delete = true
#  }
#
#  cloudinit {
#    user_data    = <<-EOF
#      #cloud-config
#      user: ubuntu
#      password: myP4$$w0rd
#      chpasswd:
#        expire: false
#      ssh_pwauth: true
#      package_update: true
#      packages:
#        - qemu-guest-agent
#      runcmd:
#        - - systemctl
#          - enable
#          - '--now'
#          - qemu-guest-agent
#      EOF
#    network_data = ""
#  }
#}
resource "harvester_virtualmachine" "opensuse" {
  name                 = "opensuse-dev"
  namespace            = "default"
  description = "test opensuse image"
  tags = {
    ssh-user = "opensuse"
  }

  cpu    = 2
  memory = "2Gi"

  run_strategy = "RerunOnFailure"
  hostname     = "opensuse-dev"

  network_interface {
    name           = "nic-1"
    network_name   = "vlan-65"
    #network_name   = harvester_network.vm-vlan.id
  }

  disk {
    name       = "cdrom-disk"
    type       = "cd-rom"
    size       = "10Gi"
    bus        = "sata"
    boot_order = 1
    image       = harvester_image.opensuse.id
    auto_delete = true
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "40Gi"
    bus        = "virtio"
    boot_order = 2
    #image       = harvester_image.opensuse.id
    auto_delete = true
  }

#  disk {
#    name        = "emptydisk"
#    type        = "disk"
#    size        = "10Gi"
#    bus         = "virtio"
#    auto_delete = true
#  }

#  cloudinit {
#    user_data    = <<-EOF
#      #cloud-config
#      user: opensuse
#      password: myP4$$w0rd
#      chpasswd:
#        expire: false
#      ssh_pwauth: true
#      package_update: true
#      packages:
#        - qemu-guest-agent
#      runcmd:
#        - - systemctl
#          - enable
#          - '--now'
#          - qemu-guest-agent
#      EOF
#    network_data = ""
#  }
  cloudinit {
    user_data    = <<-EOF
      #cloud-config
      package_update: false
      packages:
        - qemu-guest-agent
      runcmd:
        - systemctl enable qemu-guest-agent.service
        - systemctl start --no-block qemu-guest-agent.service
      users:
        - default
        - name: opensuse
          shell: /bin/bash
          groups: users
          lock_passwd: false
          passwd: myP4$$w0rd
          sudo: ALL=(ALL) ALL:ALL
      EOF
    network_data = ""
  }

}
