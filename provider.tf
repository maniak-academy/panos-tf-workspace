terraform {
  required_providers {
    panos = {
      source = "PaloAltoNetworks/panos"
      version = "1.10.1"
    }
  }
}

provider "panos" {
  hostname = var.hostname
  username = var.username
  password = var.password
}
