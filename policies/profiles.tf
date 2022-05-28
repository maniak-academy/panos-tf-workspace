resource "panos_management_profile" "mymgmtprofile" {
  name = "allow stuff"
  ssh  = true
  ping = true
  permitted_ips = ["10.1.1.0/24", "10.1.2.0/24", "192.168.86.0/24"]
}