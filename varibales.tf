variable "aws_region" {
  type = string
  description = "This is our main region wher we gonna deploy resources in aws"
  default = "us-east-1" 
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Enablinhg hostnames in our VPC "
  default = true
}

variable "cidr_block" {
  type = string
  description = "This is our cidr block for vpc"
  default = "10.0.0.0/16"
}

variable "subnets_cidr_block" {
    type = list(string)
    description = "This is from we will use the cidr blocks for our subnets"
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "map_public_ip_on_launch" {
    type = bool
    description = "We want to have out ec2s to have public Ips when they are getting launched inside a subnet"
    default = true
}

variable "instance_type" {
    type = string
    description = "We want this type of Ec2 for our project "
    default = "t3.medium"
}

variable "company" {
    type = string
    description = "Company name of the resource tagging"
    default = "spglobalci"
}

variable "project" {
    type = string
    description = "This is the project in company for tagging"
    default = "devopsdemo"
}

variable "billing_code" {
    type = string
    description = "billing code for resource tagging"
    default = "democode_learning"
  
}
