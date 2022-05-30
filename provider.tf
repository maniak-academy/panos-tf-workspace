terraform {
  required_providers {
    panos = {
      source = "PaloAltoNetworks/panos"
      version = "1.10.1"
    }
  }
}

provider "panos" {
  hostname = var.panos.hostname
  username = var.panos.username
  password = var.panos.password
}
