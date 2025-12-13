
# Final project documentation 

## Initial setup and configuration

- install terraform on your machine
- add the installation dir to path environment variable
- install git bash for windows
- verify if terraform/aws commands can be used in git bash cli
- create project dir
- git init
- set the remote repo up and connect to local repository
- run terraform init
- run aws configure and enter your aws admin credentials
- create main.tf to declare provider

## What needs to be made

- 2 applications
 - API: to upload files to. files are stored with a name and description
 - APP: app that lists all files and allows you to download them

### API

- EC2 instance with apache/nginx and mysql db.
- S3 bucket to also store the files

### APP 

- a php website that displays all the files and allows us to download them