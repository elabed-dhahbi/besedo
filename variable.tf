variable "region" {
  type = string
  description = "The region to deploy resource to"
  default = "us-east-1"
}
variable "default_tags" {
  type  = map(string)
  description = "Map of default tags to apply to resources"
  default = {
    project = "Besedo"
  }
}
variable "vpc_cidr" {
  type = string
  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}
