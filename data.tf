data "terraform_remote_state" "this" {
  for_each = var.remote_data_sources
  backend  = "s3"
  config = {
    bucket = each.value.bucket
    key    = each.value.key
    region = var.region
  }
}

data "aws_vpc" "this" {
  for_each = var.vpc_data_source
  dynamic "filter" {
    for_each = each.value.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

data "aws_subnet" "this" {
  for_each = var.subnet_data_source
  dynamic "filter" {
    for_each = each.value.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}


data "aws_security_group" "this" {
  for_each = var.sg_data_source
  dynamic "filter" {
    for_each = each.value.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}


data "aws_ami" "this" {
  for_each    = var.ami_data_source
  owners      = each.value.owners
  most_recent = each.value.most_recent
  dynamic "filter" {
    for_each = each.value.filters
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

