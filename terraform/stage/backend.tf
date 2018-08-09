terraform {
  backend "gcs" {
    bucket  = "r2d2test1"
    prefix  = "prod"
  }
}