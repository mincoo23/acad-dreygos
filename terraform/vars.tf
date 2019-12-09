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