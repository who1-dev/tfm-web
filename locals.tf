locals {
  default_tags = merge(var.default_tags, { "AppRole" : var.app_role, "Environment" : upper(var.env), "Project" : var.namespace })
  name_prefix  = "${var.namespace}-${var.env}"

  # Remote state data coming from backend
  remote_data = { for k, v in data.terraform_remote_state.this : k => v.outputs }
  # Remote data fetched from data sources
  data_sources = merge(
    length(var.vpc_data_source) > 0 ? { "vpcs" : { for k, v in data.aws_vpc.this : k => v } } : {},
    length(var.subnet_data_source) > 0 ? { "subnets" : { for k, v in data.aws_subnet.this : k => v } } : {},
    length(var.sg_data_source) > 0 ? { "security_groups" : { for k, v in data.aws_security_group.this : k => v } } : {},
    length(var.ami_data_source) > 0 ? { "amis" : { for k, v in data.aws_ami.this : k => v } } : {}
  )
  remote_states = merge(local.remote_data, length(local.data_sources) > 0 ? { "data" : local.data_sources } : {})

}