terraform {
  backend "s3" {
    bucket = "dmeszaro-tf-statebucket01"
    key    = "tfadventure"
    region = "eu-west-1"
  }
}
