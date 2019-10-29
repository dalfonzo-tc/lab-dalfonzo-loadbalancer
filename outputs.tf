output "loadbalancer_id" {
  value       = openstack_lb_loadbalancer_v2.lb.id
  description = "The ID of the created load balancer"
}

output "vip_address" {
  value = openstack_lb_loadbalancer_v2.lb.vip_address
  description = "The VIP Address of the load balancer"
}

output "pools" {
  value = [
    for name, v in openstack_lb_pool_v2.pool:
      map(name, openstack_lb_pool_v2.pool[name].id)
  ]
  description = "map of pool names to id's, consumable by other modules to add members to pools"
}

