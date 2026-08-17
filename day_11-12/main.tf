locals {
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
  new_tag = merge(var.default_tags,var.environment_tags)
  formatted_bucket_name = replace(substr(lower
  (replace(var.bucket_name, " ", "-")),0,63), "!", "")

  port_list = split(",", var.allowed_ports)

  sg_rules = [ for port in local.port_list :
  {
    name = "port-${port}"
    port = port
    description = "Allow traffic on port ${port}"
  }
  ]

  instance_size = lookup(var.instance_sizes,var.environment,"t2.micro")

  all_locations = concat(var.user_locations,var.default_locations)
  unique_locations = toset(local.all_locations)

  positive_cost = [ for cost in var.monthly_costs :  abs(cost) ]
  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
  total_cost = sum(local.positive_cost)
  avg_cost = local.total_cost / length(local.positive_cost)

  current_timestamp = timestamp()
  format1 = formatdate("yyyyMMdd", local.current_timestamp)
  format2 = formatdate("YYYY-MM-DD", local.current_timestamp)
  timestamp_name = "backup-${local.format1}"
}

resource "aws_s3_bucket" "demo_s3" {
  bucket = local.formatted_bucket_name
  tags = local.new_tag
}