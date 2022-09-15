
variable "harvester_kubeconfig_path" {
  description = "Harvester cluster Kubeconfig file name with full path"
  type        = string
  default = "/home/johndoe/harvester/harvester-cluster.yaml"
}

variable "vm_data" {

  description = "Virtual machine data"

  type = object({
    name = string
    hostname = string
    namespace = string
    description = string
    tags = map(string)


    cpus = number
    memory = string

    disks = list (object({
      name = string
      size = string
      boot_order = number   
    }))

  })

  default = {
    name        = "opensuse-dev"
    hostname    = "opensuse-dev"
    namespace   = "default"
    description = "openSUSE test virtual machine"
    tags        = {"ssh-user"="opensuse"}
    cpus        = 2
    memory      = "2Gi"
    disks = [
        {
            name = "rootdisk"
            size = "40Gi"
            boot_order = 1
        },
        {
            name = "emptydisk"
            size = "10Gi"
            boot_order = 2
        }        
    ]
  } 
}

variable "vm_network" {
  description = "VLAN for virtual machine service interfaces"
  type = object({
    vlanid = string
    namespace = string
  })
  default = {
    #Remember, I'm using a value here because we already had a vlan I wanted to use. If not you'd have to create one
    vlanid = "vlan-65"
    namespace = "default"
  }
}

variable "os_image" {
  description = "OS image for virtual machines"
  type = object({
    name = string
    namespace = string
    display_name = string
    description = string
    source_type = string
    url = string
    tags = map(string)
  })  
  default = {
    name = "opensuse-15-sp4-cloudinit"
    namespace = "default"
    display_name = "openSUSE Leap 15.4"
    description = ""
    source_type = "download"
    url = "https://download.opensuse.org/repositories/Cloud:/Images:/Leap_15.4/images/openSUSE-Leap-15.4.x86_64-NoCloud.qcow2"
    tags = {"format"= "qcow2","qemu_gest_agent_enabled"="true"}
  }   
}