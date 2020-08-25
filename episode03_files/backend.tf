terraform {
  backend "s3" {
    #bucket = "dmeszaro-tf-statebucket01"
    #key    = "tf-adventure/${var.environment}-terraform.tfstate"
    #region = "eu-west-1"
  }
}
