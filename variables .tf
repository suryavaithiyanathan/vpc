variable "sg_list" {
    type = map(any)
    description = "Details of the Security Group to allow traffic"
}

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