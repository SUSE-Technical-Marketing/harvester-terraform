## IMAGES to be present in Harvester ##

##Use data instead of resource to reuse images!!!

# resource "harvester_image" "opensuse" {
#   name         = "opensuse"
#   namespace    = "default"
#   display_name = "opensuse"
#   source_type  = "download"

#   #url = "https://download.opensuse.org/distribution/leap/15.4/appliances/openSUSE-Leap-15.4-JeOS.x86_64-kvm-and-xen.qcow2"
#   #url = "http://192.168.200.19/iso/sles15-sp3.qcow2"
#   url = "https://download.opensuse.org/repositories/Cloud:/Images:/Leap_15.4/images/openSUSE-Leap-15.4.x86_64-NoCloud.qcow2"
# }

resource "harvester_image" "os_image" {
  name         = var.os_image.name
  namespace    = var.os_image.namespace
  display_name = var.os_image.display_name
  source_type  = var.os_image.source_type
  url          = var.os_image.url
  tags         = var.os_image.tags
}

#resource "harvester_image" "ubuntu20" {
#  name         = "ubuntu20"
#  namespace    = "default"
#  display_name = "ubuntu20"
#  source_type  = "download"
#  url          = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#}

#https://download.opensuse.org/repositories/Cloud:/Images:/Leap_15.4/images/openSUSE-Leap-15.4.x86_64-NoCloud.qcow2
