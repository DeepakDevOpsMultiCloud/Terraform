module "s3_bucket" {
  source             = "./modules/"
  bucket_name        = var.bucket_name
  versioning_enabled = var.versioning_enabled
  tags               = var.tags
}