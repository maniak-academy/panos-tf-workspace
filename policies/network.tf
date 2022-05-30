

resource "panos_ethernet_interface" "untrust" {
  name                      = "ethernet1/1"
  vsys                      = "vsys1"
  mode                      = "layer3"
  enable_dhcp               = true
  create_dhcp_default_route = true
  management_profile        = panos_management_profile.mymgmtprofile.id

}


resource "panos_ethernet_interface" "web" {
  name               = "ethernet1/2"
  vsys               = "vsys1"
  mode               = "layer3"
  static_ips         = ["10.1.1.1/24"]
  enable_dhcp        = false
  management_profile = panos_management_profile.mymgmtprofile.id
}

resource "panos_ethernet_interface" "secure" {
  name               = "ethernet1/3"
  vsys               = "vsys1"
  mode               = "layer3"
  static_ips         = ["10.1.2.1/24"]
  enable_dhcp        = false
  management_profile = panos_management_profile.mymgmtprofile.id

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


resource "panos_zone" "secure" {
  name           = "secure"
  mode           = "layer3"
  interfaces     = ["${panos_ethernet_interface.e3.name}"]
  enable_user_id = true
}

resource "panos_ethernet_interface" "e3" {
  name = "ethernet1/3"
  mode = "layer3"
}
