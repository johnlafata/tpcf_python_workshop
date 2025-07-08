# The configuration for the `remote` backend.
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
  #   backend "remote" {
  #    cloud {
  #        # The name of your Terraform Cloud organization.
  #        organization = "jl-sandbox"
  #
  #        workspaces {
  #          name = "jl-sandbox-workflow"
  #        }
  #   }
}

resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}

#variable "bucket_name" {}
#module "aws" {
#    source = "./providers/aws"
#    bucket_name = "${var.bucket_name}"
# }

variable "cf_user_password" {}
module "cf" {
  source = "./providers/cf"
  cf_user_password = var.cf_user_password
}


 