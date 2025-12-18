# Setup guide

1. Install terraform and add to PATH variable
2. Install AWS CLI and run aws configure, then configure a user with EC2FullAccess and S3FullAccess
3. Create a directory and run git init
4. run: git remote add origin https://github.com/YenteLens/TerraformCloud.git
5. Pull the repo to this directory: git pull origin main
6. Run terraform init
7. Run terraform apply
8. after this is done run: terraform state show aws_instance.example
9. copy the public ip address and visit the webpage after around 90 seconds when the instance is done setting up
10. after uploading a file you can visit the list.php page on the same ip


# For multi-user
1. It's very important you change the bucket name in the following files: bucket.tf,upload.php,list.php,user-data.sh
