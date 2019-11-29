variable "region" {
    type = string
    description = "The AWS region to launch infrastructure in."
    default = "eu-central-1"
}

variable "prefix" {
    type = string
    description = "Prefix used to append in front of resource names."
    default = "acad-dreygosi"
}

variable "creator" {
    type = string
    description = "The person who created the resource."
    default = "dreygosi"
}
