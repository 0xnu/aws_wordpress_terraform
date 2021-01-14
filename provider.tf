# provider details
provider "aws" {
  version = "~> 2.0"

  # region selection
  region = var.my_region

  # Shared file authentication
  shared_credentials_file = "./config/aws-credentials"
}
