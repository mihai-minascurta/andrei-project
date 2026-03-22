#The part of code to create S3 Bucket, far away from main to avoid complications

resource "aws_s3_bucket" "terraform_state" {
  bucket = "andrei-terraform-state-2026"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
