resource "aws_s3_bucket" "yentelenspublic" {
  bucket = "yentelenspublic"
  force_destroy = true
}

resource "aws_s3_account_public_access_block" "account" {
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.yentelenspublic.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.yentelenspublic.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.yentelenspublic.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_account_public_access_block.account,
    aws_s3_bucket_public_access_block.public_access
  ]  
}

resource "aws_s3_bucket_object" "upload_php" {
  key = "upload.php"
  bucket = aws_s3_bucket.yentelenspublic.id
  source = "./upload.php"
  acl = "private"
}