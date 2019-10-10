terraform {
  required_version = ">= 0.12.6"
}

locals {
    os_cloud_env = { 
      OS_AUTH_TYPE = "v3applicationcredential"
      OS_AUTH_URL = "${var.openstack_auth_url}"
      OS_IDENTITY_API_VERSION = "3" 
      OS_REGION_NAME = "${var.openstack_region}"
      OS_INTERFACE = "public"
      OS_APPLICATION_CREDENTIAL_ID = "${var.openstack_app_id}"
      OS_APPLICATION_CREDENTIAL_SECRET = "${var.openstack_app_secret}"
    }   
}

data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  name          = var.lb_name
  vip_subnet_id = data.openstack_networking_subnet_v2.subnet.id
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

resource "local_file" "lb_policy" {
  for_each    = var.create_senlin_policy ? var.listeners : {}
  content = templatefile("${path.module}/templates/lb-policy.tpl", {
    loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id,
    pool_id = openstack_lb_pool_v2.pool[each.key].id,
    pool_subnet = data.openstack_networking_subnet_v2.subnet.id,
    vip_subnet = data.openstack_networking_subnet_v2.subnet.id
  })  
  filename = "/tmp/${openstack_lb_pool_v2.pool[each.key].id}.yaml"

  provisioner "local-exec" {
    environment = local.os_cloud_env
    command = "openstack cluster policy create --spec-file=${self.filename} ${var.lb_name}_${each.key}_policy"
  }

  provisioner "local-exec" {
    when = "destroy"
    environment = local.os_cloud_env
    command = "openstack cluster policy delete ${var.lb_name}_${each.key}_policy"
  }
}

