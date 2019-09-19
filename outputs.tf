output "loadbalancer_id" {
  value       = openstack_lb_loadbalancer_v2.lb.id
  description = "The ID of the created load balancer"
}
