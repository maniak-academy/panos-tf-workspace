terraform {
  required_providers {
    panos = {
      source  = "PaloAltoNetworks/panos"
      version = "1.10.1"
    }
  }
}

provider "panos" {
  hostname = var.hostname
  username = var.username
  password = var.password
}

resource "panos_management_profile" "ssh" {
  name = "allow ssh"
  ssh  = true
}


resource "panos_ethernet_interface" "untrust" {
  name                      = "ethernet1/1"
  vsys                      = "vsys1"
  mode                      = "layer3"
  static_ips                = ["192.168.86.252/24"]
  enable_dhcp               = false
}

resource "panos_ethernet_interface" "web" {
  name        = "ethernet1/2"
  vsys        = "vsys1"
  mode        = "layer3"
  static_ips  = ["10.1.1.1/24"]
  enable_dhcp = false
}

resource "panos_ethernet_interface" "db" {
  name        = "ethernet1/3"
  vsys        = "vsys1"
  mode        = "layer3"
  static_ips  = ["10.1.2.1/24"]
  enable_dhcp = false
}

resource "panos_virtual_router" "vtr" {
  name        = "my virtual router"
  static_dist = 15
  interfaces  = ["ethernet1/1", "ethernet1/2", "ethernet1/3"]
}

resource "panos_zone" "untrust" {
  name           = "untrust"
  mode           = "layer3"
  interfaces     = ["${panos_ethernet_interface.e1.name}"]
  enable_user_id = true
}

resource "panos_ethernet_interface" "e1" {
  name = "ethernet1/1"
  mode = "layer3"
}

resource "panos_zone" "web" {
  name           = "web"
  mode           = "layer3"
  interfaces     = ["${panos_ethernet_interface.e2.name}"]
  enable_user_id = true
}

resource "panos_ethernet_interface" "e2" {
  name = "ethernet1/2"
  mode = "layer3"
}



resource "panos_zone" "db" {
  name           = "db"
  mode           = "layer3"
  interfaces     = ["${panos_ethernet_interface.e3.name}"]
  enable_user_id = true
}

resource "panos_ethernet_interface" "e3" {
  name = "ethernet1/3"
  mode = "layer3"
}
