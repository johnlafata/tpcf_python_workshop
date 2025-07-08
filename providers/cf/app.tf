## from this reference:
#https://github.com/cloudfoundry/terraform-provider-cloudfoundry/blob/main/examples/resources/cloudfoundry_app/resource.tf

terraform {
  required_providers {
    cloudfoundry = {
      source = "cloudfoundry/cloudfoundry"
    }
  }
}

provider "cloudfoundry" {
  api_url  = "https://api.sys.agi-explorer.com"
  user     = "admin"
  password = "${var.cf_user_password}"
  skip_ssl_validation = true

}

resource "null_resource" "download_repo" {
  provisioner "local-exec" {
    command = "rm -rf ${path.module}/repo && git clone git@github.com:johnlafata/tpcf_python_workshop.git ${path.module}/repo" # Clean directory and clone repo
  }
  
  # Add a trigger to force recreation
  triggers = {
    always_run = "${timestamp()}"
  }
}

data "archive_file" "git_repo_zip" {
  type        = "zip"
  source_dir  = "${path.module}/repo"  # The path where the repo was cloned
  output_path = "${path.module}/repo.zip"
  depends_on = [null_resource.download_repo] # Ensure the download is complete before zipping
}

resource "cloudfoundry_app" "test-books-api" {
  name             = "test-books-api"
  space_name       = "test-space"
  org_name         = "test"
  path             = data.archive_file.git_repo_zip.output_path
  instances        = 1
  environment = {
    MY_ENV = "stage",
  }
  strategy = "rolling"
  routes = [
    {
      route = "test-books-api.apps.agi-explorer.com"
    }
  ]
}



