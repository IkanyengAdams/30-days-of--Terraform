output "formatted_project_name" {
  value = local.formatted_project_name
}

output "port_list" {
  value = local.port_list
}

output "sg_rules" {
  value = local.sg_rules 
}

output "instance_size" {
  value = local.instance_size
}

output "credentials" {
  value = var.credentials
  sensitive = true
}

output "all_locations" {
  value = local.all_locations
}

output "unique_locations" {
  value = local.unique_locations
}

output "positive_cost" {
  value = local.positive_cost
}

output "max_cost" {
  description = "Maximum monthly cost"
  value       = local.max_cost
}

output "total_cost" {
  description = "Total monthly cost"
  value       = local.total_cost
}

output "average_cost" {
  description = "Average monthly cost"
  value       = local.avg_cost
}

output "time" {
  value = local.current_timestamp
}