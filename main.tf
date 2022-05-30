module "policies" {
  source = "./policies"
}


# resource "null_resource" "panos_config" {
#   depends_on = [module.policies]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command = "./commit/panos-commit -config ./commit/panos-commit.json -force"
#   }
# }