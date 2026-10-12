output "alb_dns_name" {
  description = "Open this in your browser to reach the app"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "db_endpoint" {
  value = module.database.db_endpoint
}