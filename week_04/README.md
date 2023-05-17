# Week 4 – Networking: VPC, ELB

### Tasks:

*  Create a Terraform script which will create the next infrastructure:
    - Virtual Public Cloud (VPC) with two subnets private and public, each with one EC2 instance with Apache Web server installed and with simple index.html
    - NAT EC2 instance which will give HTTP access for the private subnet. ATTENTION. AWS suggests to use NAT GATEWAY, but it costs. 
    - Application Load Balancer targeting to both private and public subnets

*  Use load balancer HTTP URL to check your solution - load balancer should return as a response these pages per extern HTTP-request. So you have to see pages from both servers.
---
* For launching config:
    - terraform init
    - terraform plan
    - terraform apply -auto-approve 
* For deleting config:
    - terraform destroy -auto-approve