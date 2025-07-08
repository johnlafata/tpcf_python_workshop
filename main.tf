# The configuration for the `remote` backend.
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

variable "cf_user_password" {}
module "cf" {
  source = "./providers/cf"
  cf_user_password = var.cf_user_password
}


 