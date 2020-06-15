terraform {
  required_version = ">= 0.12.6"
}

data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
  loadbalancer_provider = "amphora"
  flavor_id = var.lb_flavors[var.lb_flavor_name]
  //flavor_id = "708d9866-c946-4c45-aaaa-a31fa432c5a0"
}

resource "openstack_lb_listener_v2" "listener" {
  for_each        = var.listeners
  name            = "${each.key}_listener"
  protocol        = each.value["proto"]
  protocol_port   = each.value["port"]
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
}

resource "openstack_lb_pool_v2" "pool" {
  for_each    = var.listeners
  name        = "${each.key}_pool"
  protocol    = each.value["proto"]
  lb_method   = each.value["lb_method"]
  listener_id = openstack_lb_listener_v2.listener[each.key].id
}

resource "openstack_lb_monitor_v2" "monitor" {
  for_each       = var.listeners
  name           = "${each.key}_monitor"
  pool_id        = openstack_lb_pool_v2.pool[each.key].id
  type           = each.value["mon_proto"]
  delay          = each.value["mon_delay"]
  timeout        = each.value["mon_timeout"]
  max_retries    = each.value["mon_retries"]
  admin_state_up = each.value["mon_admin_state"]
}

resource "openstack_networking_floatingip_associate_v2" "fip" {
  count       = var.lb_floating_ip ? 1 : 0
  floating_ip = var.lb_floating_ip
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
}