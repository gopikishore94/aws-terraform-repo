provider "aws" {
  region = var.region
}
# terraform {
#   backend "s3" {
#     bucket = "onlineshop-terraformstate"
#     key    = "onlineshop/modules/terraform.tfstate"
#     region = "us-east-1"

#   }
# }