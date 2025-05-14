# store the terraform state file in s3 and lock with s3 lock
terraform {
  backend "s3" {
    bucket       = "minecraft-state-file"
    key          = "envs/prod/terraform.tfstate"
    region       = var.region
    encrypt      = true
    use_lockfile = true
  }
}