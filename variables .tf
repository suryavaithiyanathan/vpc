variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress      = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  default = {
    "web" = {
      name        = "web-sg"
      description = "Security group for web servers"
      ingress = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    "db" = {
      name        = "db-sg"
      description = "Security group for databases"
      ingress = [
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/16"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
##################################################################
#subnet variable 
#######################################################################

variable "subnetlist" {
  type = map(object({
    cidr_block               = string
    availability_zone        = string
    map_public_ip_on_launch  = bool
    tags                     = map(string)
  }))
  default = {
    "public-subnet-1" = {
      cidr_block               = "10.0.1.0/24"
      availability_zone        = "us-west-2a"
      map_public_ip_on_launch  = true
      tags                     = {
        Name = "public-subnet-1"
      }
    },
    "public-subnet-2" = {
      cidr_block               = "10.0.2.0/24"
      availability_zone        = "us-west-2b"
      map_public_ip_on_launch  = true
      tags                     = {
        Name = "public-subnet-2"
      }
    },
    "private-subnet-1" = {
      cidr_block               = "10.0.3.0/24"
      availability_zone        = "us-west-2a"
      map_public_ip_on_launch  = false
      tags                     = {
        Name = "private-subnet-1"
      }
    },
    "private-subnet-2" = {
      cidr_block               = "10.0.4.0/24"
      availability_zone        = "us-west-2b"
      map_public_ip_on_launch  = false
      tags                     = {
        Name = "private-subnet-2"
      }
    }
  }
}
