terraform {
  backend "s3" {
    bucket = "mystatebucket1"
    key    = "terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "locktable"
  }
}