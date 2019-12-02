variable "az-subnet-mapping" {
  type        = "list"
  description = "Lists the subnets to be created in their respective AZ."

  default = [
    {
      name      = "ovs"
      az        = "us-west-2"
      cidr      = "10.0.1.0/24"
      isPublic  = false
    },
    {
      name      = "storage"
      az        = "us-west-2"
      cidr      = "10.0.2.0/24"
      isPublic  = false
    },
  ]
}

variable "cidr" {
  type         = "string"
  description  = "Host networking cidr"
  default      = "10.0.0.0/16"
}
