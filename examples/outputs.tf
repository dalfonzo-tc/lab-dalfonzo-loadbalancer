output "loadbalancer_id" {
  value       = module.loadbalancer.loadbalancer_id
  description = "The ID of the created load balancer"
}

output "vip_address" {
  value = module.loadbalancer.vip_address
  description = "The VIP Address of the load balancer"
}

output "pools" {
  value = module.loadbalancer.pools
  description = "map of pool names to id's, consumable by other modules to add members to pools"
}

output "pool_map" {
  value = module.loadbalancer.pools_raw
}

