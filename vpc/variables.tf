variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"

}


variable "private_subnet_cidrs" {
  type = list(string)
}
