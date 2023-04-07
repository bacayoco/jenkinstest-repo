variable  pub_subnet_cidr{
    type = string
    description = "cidr block for my pup_subnet"
    default = "10.0.2.0/24"
}

variable  priv_subnet_cidr{
    type = string
    description = "cidr block for my priv_subnet"
    default = "10.0.1.0/24"
}

variable  priv_subnet_AZ{
    type = string
    description = "cidr block for my priv_subnet"
    default = "us-east-1a"
}

variable  pub_subnet_AZ{
    type = string
    description = "cidr block for my priv_subnet"
    default = "us-east-1a"
}

variable  demo_vpc{
    type = string
    description = "vpc cidr block"
    default = "10.0.0.0/16"
}