variable "vpc_cidr" {
  type        = string
  description = "vpc network cidr address for kojitechs vpc"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = list(any)
  description = "List of public subnet"
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
  type        = list(any)
  description = "List of public subnet"
  default = ["10.0.5.0/24", "10.0.7.0/24"]
}
