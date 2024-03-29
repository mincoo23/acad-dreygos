variable "region" {
  type        = string
  description = "The AWS region to launch infrastructure in."
  default     = "eu-central-1"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to associate with the subnet."
  default     = "eu-central-1a"
}

variable "prefix" {
  type        = string
  description = "Prefix used to append in front of resource names."
  default     = "acad-dreygosi"
}

variable "creator" {
  type        = string
  description = "The person who created the resource."
  default     = "dreygosi"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance."
  default     = "t2.micro"
}

variable "instance_count" {
  type        = number
  description = "The number of EC2 instances to be launched."
  default     = 3
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the instances VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type        = string
  description = "The CIDR block of the public subnet."
  default     = "10.0.0.0/24"
}

variable "own_ip" {
  type        = string
  description = "Office IP."
  default     = "212.250.145.34/32"
}

variable "everywhere" {
  type        = string
  description = "CIDR block representing the internet everywhere."
  default     = "0.0.0.0/0"
}
