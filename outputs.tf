output "loadbalancer_id" {
  value       = openstack_lb_loadbalancer_v2.lb.id
  description = "The ID of the created load balancer"
}

output "vip_address" {
  value = openstack_lb_loadbalancer_v2.lb.vip_address
  description = "The VIP Address of the load balancer"
}
