terraform {
  backend "s3" {
    bucket = "company-terraform-state"
    key    = "test/terraform.tfstate"
    region = "ap-south-1"
  }
}
