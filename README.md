AWS Terraform Infrastructure for Technical Test
Overview
This Terraform project provisions an AWS infrastructure with the following components:

A VPC (technical-test-vpc) with public and private subnets.
Three EC2 instances:
Ariane (technical-test-ariane) – frontend instance in the public subnet.
Falcon (technical-test-falcon) – backend instance in the private subnet.
Redis (technical-test-redis) – database instance in the private subnet.
Networking resources:
Internet Gateway for the public subnet.
NAT Gateway for the private subnet to access the internet.
Routing tables for public and private subnets.
Security groups:
Ariane Security Group – allows HTTPS (443) from office, VPN, and home.
Falcon Security Group – allows HTTP (4000) only from Ariane.
Redis Security Group – allows HTTP (6399) only from Falcon.
Architecture Diagram

          Internet
             |
    ---------------------
    |    Internet GW    |
    ---------------------
          |        
    ---------------------
    | Public Subnet     |  (10.0.1.0/24)
    | - Ariane EC2      |
    | - NAT Gateway     |
    ---------------------
          |
    ---------------------
    | Private Subnet    |  (10.0.2.0/24)
    | - Falcon EC2      |
    | - Redis EC2       |
    ---------------------
Terraform Resources
Resource	Description
aws_vpc	Creates the VPC named technical-test-vpc.
aws_subnet	Defines public and private subnets.
aws_internet_gateway	Enables internet access for the public subnet.
aws_nat_gateway	Allows private subnet instances to access the internet.
aws_route_table	Manages routing for public and private subnets.
aws_security_group	Configures firewall rules for Ariane, Falcon, and Redis instances.
aws_instance	Deploys EC2 instances for Ariane, Falcon, and Redis.
Installation & Deployment
1. Prerequisites
Before running Terraform, ensure you have:

Terraform v1.0+
AWS CLI configured with valid credentials (aws configure)
An AWS account with access to create EC2 instances.
2. Clone the Repository

git clone https://github.com/elabed-dhahbi/besedo.git
cd aws-terraform-infra
3. Initialize Terraform

terraform init
4. Preview Changes (Optional)

terraform plan
5. Apply Terraform Configuration

terraform apply -auto-approve
6. Retrieve Deployed Resources
After a successful deployment, Terraform will output the Ariane (public), Falcon (private), and Redis (private) instance IPs.


terraform output
Variables
This setup allows customization using Terraform variables.

Variable	Description	Default Value
region	AWS region for deployment	us-east-1
vpc_cidr	CIDR block for VPC	10.0.0.0/16
public_subnet_cidr	CIDR block for public subnet	10.0.1.0/24
private_subnet_cidr	CIDR block for private subnet	10.0.2.0/24
Destroy Infrastructure
To tear down the entire infrastructure, run:


terraform destroy -auto-approve
Notes
Ariane (technical-test-ariane) has a public Elastic IP for external access.
Falcon (technical-test-falcon) and Redis (technical-test-redis) are in the private subnet.
The NAT Gateway allows outbound internet access for private subnet instances
