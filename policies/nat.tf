




resource "panos_nat_rule_group" "egress-web-secure-untrust-nat" {
    rule {
        name = "egress-web-untrust-nat"
        audit_comment = "Ticket 12345"
        original_packet {
            source_zones = [panos_zone.web.name, panos_zone.secure.name]
            destination_zone = panos_zone.untrust.name
            destination_interface = panos_ethernet_interface.e1.name
            source_addresses = ["any"]
            destination_addresses = ["any"]
        }
        translated_packet {
            source {
                dynamic_ip_and_port {
                    interface_address {
                        interface = panos_ethernet_interface.e1.name
                    }
                }
            }
            destination {}
        }
    }
}

