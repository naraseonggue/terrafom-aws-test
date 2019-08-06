variable "amazon_ami_id" {
    # AWS ubuntu 16.04 free tier
    default     =   "ami-096c57cee908da809"
}

variable "public_instance_name" {}
variable "private_instance_name" {}

variable "public_subnet_ids" {
    type        =   "list"
}

variable "private_subnet_ids" {
    type        =   "list"
}

variable "instance_type" {
    default     =   "t2.micro"
}

variable "ec2_keypair" {}
variable "public_security_group_id" {}
variable "private_security_group_id" {}

