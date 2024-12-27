variable "default_tags" {
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

variable "namespace" {
  type = string
}

variable "env" {
  type    = string
  default = "dev"
}

variable "app_role" {
  type    = string
  default = "Compute"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "remote_data_sources" {
  type = map(object({
    bucket = string
    key    = string
    region = string
  }))
  validation {
    condition     = alltrue([for k in keys(var.remote_data_sources) : k != "data"])
    error_message = "key 'DATA' is a reserved keyword for data source variables. Please use a different key name."
  }
  default = {
  }
}

#_______________________________________________ <Data Source Variables> _______________________________________________
variable "vpc_data_source" {
  description = "Fetch data from VPC's using filters for Data Source"
  type = map(object({
    filters = list(object({
      name   = string
      values = list(string)
    }))
  }))
  default = {} #https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcs.html
}

variable "subnet_data_source" {
  description = "Fetch data from SUBNET's using filters for Data Source"
  type = map(object({
    filters = list(object({
      name   = string
      values = list(string)
    }))
  }))
  default = {} #https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSubnets.html
}

variable "sg_data_source" {
  description = "Fetch data from Security Group using filters for Data Source"
  type = map(object({
    filters = list(object({
      name   = string
      values = list(string)
    }))
  }))
  default = {} #https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html
}


variable "ami_data_source" {
  description = "Fetch data from AMI's using filters for Data Source"
  type = map(object({
    owners      = list(string)
    most_recent = bool
    filters = list(object({
      name   = string
      values = list(string)
    }))
  }))
  default = {} #https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImages.html
}
#_______________________________________________ <Data Source Variables/> _______________________________________________

variable "key_pairs" {
  type = map(object({
    key_name            = string
    public_key_location = string
    name                = string
  }))
  default = {
  }
}