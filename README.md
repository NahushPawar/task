# This code we can execute in below sequesce step #

#Step 1. Launch the VPC with subnets, ruote-table , IGW and NAT.

Go to the directory of "vpc" and run the below command in sequesce.

terraform init
terraform plan
terraform.exe apply -auto-approve

## You will get output like below , just save this details somewhere because we need this. When we launch ec2 , sg and elb.
Output : 

database_subnets = []
nat_public_ips = [
  "34.206.46.97",
]
private_subnets = [
  "subnet-090a68ff58f29c7ee",
  "subnet-0457cd4826368f208",
]
public_subnets = [
  "subnet-04d880c8f0a8cec15",
  "subnet-00d2fb89e2f8a15e7",
]
vpc_id = "vpc-067798a4183535af0"


# Step 2. Create Security Group

Go to the directory  of security group  which is "sg"

Verify the security group ports and name.

terraform init
terraform plan
terraform.exe apply -auto-approve

# Output ::

Please note down the security-group-id so we can use it in ec2. 

#Step 3. Launch Ec2 machine 

goto the directory "ec2" , verify and update the subnet-id, key-pair, security-group-id, vpc-id and run below command.

terraform init
terraform plan
terraform.exe apply -auto-approve

# Step 4. Launch Load Balacner 

Go to the directory "elb" and update the subnet-id, ec2-instace id, security-group-id and run the below command.

terraform init
terraform plan
terraform.exe apply -auto-approve

# Step 5. Launch the RT-53 with record set. 

Go to the directory  "rt53" update the detials for record like for alias update the ip address of instance and for CNAME update the loadbalancer dns. 
Than run the below command. 

terraform init
terraform plan
terraform.exe apply -auto-approve

