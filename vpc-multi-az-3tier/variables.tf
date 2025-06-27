
variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  #wherever you prefer
  #default = "ap-southeast-1"
}

variable "vpc_cidr_block" {
  description = "CIDR Block for vpc.It should be private ip ranges for rfc 1918."
  type        = string
}

variable "public-subnet-za-1" {
  description = "public subnet deploy on az a."
  type        = string
}

variable "api-subnet-za-2" {
  description = "api subnet deploy on az a.the subnet attached on nat gateway"
  type        = string
}

variable "private-subnet-za-3" {
  description = "private subnet deploy on az a.dnz for database"
  type        = string
}

variable "public-subnet-zb-4" {
  description = "public subnet deploy on az b."
  type        = string
}

variable "api-subnet-zb-5" {
  description = "api subnet deploy on az b.the subnet attached on nat gateway"
  type        = string
}

variable "private-subnet-zb-6" {
  description = "private subnet deploy on az b.dnz for database"
  type        = string
}

variable "public-subnet-zc-7" {
  description = "public subnet deploy on az c."
  type        = string
}

variable "api-subnet-zc-8" {
  description = "api subnet deploy on az b.the subnet attached on nat gateway."
  type        = string
}

variable "private-subnet-zc-9" {
  description = "private subnet deploy on az b.dnz for database"
  type        = string
}

variable "az1" {
  description = "availability zone a."
  type        = string
}

variable "az2" {
  description = "availability zone b."
  type        = string
}

variable "az3" {
  description = "availability zone b."
  type        = string
}
