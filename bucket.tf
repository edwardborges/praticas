resource "aws_s3_bucket" "dev4" {
  bucket = "edwardlabs-dev4"
  acl    = "private"

  tags = {
    Name = "edwardlabs-dev4"

  }


}