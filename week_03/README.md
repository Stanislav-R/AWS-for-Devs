# Week 3 – Databases: RDS, Dynamo DB

### Tasks:

*  Create a simple SQL script rds-script.sql which will perform next things:
    - Database creation
    - Creation of one simple table for tests
    - Adding some dummy data to the table
    - A simple select statement which will return all entries from the table
*  Create a simple dynamodb-script.sh which will do the next things (via AWS CLI commands):
    - Display existing Dynamo DB tables
    - Add a few entries in the table
    - Read entries from the table 
*  Create a init-s3.sh script which will do the next things:
    - Create AWS S3 bucket
    - Upload the rds-script.sql and the dynamodb-script.sh to an S3 bucket
*  Create a Terraform script which will create the next infrastructure:
    - One Dynamo DB table
    - One RDS database (postgres)
    - Create an EC2 instance with all needful access permissions (to S3, DynamoDB and RDS)
    - All scripts from S3 should be copied to the instance during startup
    - Add access permissions for HTTP, SSH, and to selected RDS database
    - An RDS endpoint and port should be available in the script output
    - As usual please put as much customization as possible via input variables to the script
*  SSH to a created EC2 instance and execute both scripts in order to test your solution

* For connecting to your VM:
    - ssh -i ~/.ssh/YourKeyName.pem ec2-user@YourMachinesPublicDns.com

* For connecting to your DB (RDS):
    - psql -Upsql -U{USERNAME} -h{HOST_NAME} -d{DB_NAME}
  
* For running rds script:
    - psql -U{USERNAME} -h{HOST_NAME} -d{DB_NAME} -f YOUR_RDS_SCRIPT
