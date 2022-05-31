
resource "panos_security_rule_group" "egress-web-secure-outside" {
  depends_on = [
    panos_address_group.cts-addr-grp-webfrontend
  ]
  rule {
    name                  = "egress-web-secure-outside"
    source_zones          = [panos_zone.web.name, panos_zone.secure.name]
    source_addresses      = ["any"]
    source_users          = ["any"]
    destination_zones     = [panos_zone.untrust.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}


resource "panos_security_rule_group" "web-secure" {
  depends_on = [
    panos_address_group.cts-addr-grp-webfrontend
  ]
  rule {
    name                  = "Allow web to talk to secure"
    source_zones          = [panos_zone.web.name]
    source_addresses      = [panos_address_group.cts-addr-grp-webfrontend.name]
    source_users          = ["any"]
    destination_zones     = [panos_zone.secure.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}



resource "panos_security_rule_group" "secure-db-web" {
  depends_on = [
    panos_address_group.cts-addr-grp-webfrontend
  ]
  rule {
    name                  = "Allow secure db to talk to web"
    source_zones          = [panos_zone.secure.name]
    source_addresses      = ["any"]
    source_users          = ["any"]
    destination_zones     = [panos_zone.web.name]
    destination_addresses = [panos_address_group.cts-addr-grp-webfrontend.name]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}

resource "panos_security_rule_group" "consul-web" {
  rule {
    name                  = "Allow consul to talk to front end"
    source_zones          = [panos_zone.untrust.name]
    source_addresses      = ["any"]
    source_users          = ["any"]
    destination_zones     = [panos_zone.web.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}


resource "panos_security_rule_group" "consul-secure" {
  rule {
    name                  = "Allow consul to talk to secure zone"
    source_zones          = [panos_zone.untrust.name]
    source_addresses      = [panos_address_group.consul-servers.name]
    source_users          = ["any"]
    destination_zones     = [panos_zone.secure.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}

resource "panos_security_rule_group" "shared-infra-internal" {
  rule {
    name                  = "Allow tf agent to talk to frontend and secure zones"
    source_zones          = [panos_zone.untrust.name]
    source_addresses      = [panos_address_group.shared-infra.name]
    source_users          = ["any"]
    destination_zones     = [panos_zone.secure.name, panos_zone.web.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
}
