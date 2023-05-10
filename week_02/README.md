# Week 2 – Storage: Simple Storage Service (S3), Terraform

### Tasks:

*  Create an init-s3.sh script which will do the next things:
    - Create a simple small text file 
    - Create AWS S3 bucket (via AWS CLI commands)
    - Add versioning to S3 bucket (via AWS CLI commands)
    - Upload file to S3 (via AWS CLI commands)

*  Verify that uploaded file is not publicly available (you could not rich it from your working machine)

*  Create a Terraform script which will deploy the next infrastructure:
    - EC2 instance with access to S3 service.
    - Implement file downloading from S3 bucket during instance startup (bucket and file should be created by init-s3.sh script).
    - Allow HTTP and SSH access to the EC2 instance
---
* For launching config:
    - terraform init
    - terraform plan
    - terraform apply
* For deleting config:
    - terraform destroy

* For connecting to your VM:
    - ssh -i ~/.ssh/YourKeyName.pem ec2-user@YourMachinesPublicDns.com
