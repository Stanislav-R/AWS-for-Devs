# Cloudformation Stack for creating an autoscaling group with EC2 instances. Java Software added to startup EC2

* aws cloudformation create-stack --stack-name week01 --template-body file:///{"full_path"}/week01_template_asg_cfg.yml
* aws cloudformation describe-stacks --stack-name week01
* aws cloudformation describe-stack-events --stack-name week01 - logging events
* aws cloudformation delete-stack --stack-name week01
* ssh ssh -i my-key-us-west-2.pem ec2-user@publicIp
* Checking java version of EC2 instances
    #!/bin/bash
    java -version