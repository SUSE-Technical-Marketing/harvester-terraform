## IMAGES to be present in Harvester ##
resource "harvester_image" "opensuse" {
  name         = "opensuse"
  namespace    = "default"
  display_name = "opensuse"
  source_type  = "download"

  url = "https://download.opensuse.org/distribution/leap/15.4/appliances/openSUSE-Leap-15.4-JeOS.x86_64-kvm-and-xen.qcow2"
}

#resource "harvester_image" "ubuntu20" {
#  name         = "ubuntu20"
#  namespace    = "default"
#  display_name = "ubuntu20"
#  source_type  = "download"
#  url          = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#}

