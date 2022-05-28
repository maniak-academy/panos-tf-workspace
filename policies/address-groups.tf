
resource "panos_address_group" "consul-servers" {
    name = "consul-servers"
    description = "Consul-servers"
    static_addresses = [
        panos_address_object.consul1.name,
        panos_address_object.consul2.name,
        panos_address_object.consul3.name
    ]
}

resource "panos_address_object" "consul1" {
    name = "consul1"
    value = "192.168.86.70"
}

resource "panos_address_object" "consul2" {
    name = "consul2"
    value = "192.168.86.71"
}

resource "panos_address_object" "consul3" {
    name = "consul3"
    value = "192.168.86.72"
}


resource "panos_address_group" "shared-infra" {
    name = "shared infra servers"
    description = "shared infra servers"
    static_addresses = [
        panos_address_object.tfagent.name
    ]
}

resource "panos_address_object" "tfagent" {
    name = "tfagent"
    value = "192.168.86.42"
}
