# Cloudformation Stack for creating EC2 Instance with security groups

* aws cloudformation create-stack --stack-name week00 --template-body file:///{"full_path"}/week00_template_ec2_cfg.yml
* aws cloudformation describe-stacks --stack-name week00
* aws cloudformation delete-stack --stack-name week00
* ssh ssh -i my-key-us-west-2.pem ec2-user@publicIp