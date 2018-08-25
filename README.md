# Templates for VCS Fitcycle App for AWS

_Software required to use these templates:_ Ansible, Ansible EC2 dynamic inventory script (included in repository), Terraform

## Limitations

** You'll need to ensure the correct AMIs are available in the region where you want to turn up the application. Currently the AMIs are available in us-west-1 and us-east-1 only.

## AMI Information

** us-east-1

    *api  - ami-db266ea4
    *app  - ami-1b3a7264
    *db   - ami-b7256dc8
    *dblb - ami-4c387033
    *mgmt - ami-e531799a
    *webx - ami-b43971cd

** us-west-1

    *api  - ami-2330d740
    *app  - ami-1630d775
    *db   - ami-0a3ed969
    *dblb - ami-1830d77b
    *mgmt - ami-1c33d47f
    *webx - ami-9635d2f5

** us-west-2

    *api  - ami-d8357aa0
    *app  - ami-43347b3b
    *db   - ami-3e256a46
    *dblb - ami-5436792c
    *mgmt - ami-2339765b
    *webx - ami-e438779c    

## Instructions for Use

1. Clone this repository to your local system.

2. Create a file named `terraform.tfvars` in the repository (don't worry, Git will ignore it) and populate it with values for the following variables:

    *akey (your AWS access key)
    *skey (your AWS secret access key)
    *awsregion (the AWS region to use; currently, only us-west-1 or us-east-1)
    *keypair (the name of an AWS SSH keypair to inject into instances)
    *vpcname (the name you'd like assigned to the new VPC)
    *cidr (the network block _without_ subnet mask)
    *product (the name of the product)
    *team (the name of the team)
    *owner (the name of the team)
    *environment (the name of the environment)
    *organization (the name of the organiation)
    *costcenter (the name of the cost center)


3. Create tf file by adding ".tf" to bigapp or smallapp depending on the deployment type

4. Run `terraform init` to ensure there are no errors in the Terraform configuration. If any errors are reported, fix them before proceeding.

4. Run `terraform validate` to ensure there are no errors in the Terraform configuration. If any errors are reported, fix them before proceeding.

5. Run `terraform plan` to evaluate the current infrastructure and prepare a plan for creating the desired configuration.

6. Run `terraform apply` to create the desired infrastructure.

7. When Terraform is completed, wait a couple of minutes and then run `hosts/ec2.py --refresh-cache` to refresh the dynamic Ansible inventory.

## Running Multiple Instances

To run multiple instances of this application, make multiple copies of this repository and follow the instructions for each.

## Destroying the Infrastructure

Simply run `terraform destroy` to tear down the AWS infrastructure.
