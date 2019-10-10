variable "lb_floating_ip" {
  description = "The (optional) floating ip to assign to the load balancer as a VIP"
  type        = string
  default     = false
}

variable "lb_name" {
  description = "Name of the loadbalancer"
  type        = string
}

variable "listeners" {
  description = "This maps a loadbalancer name to its implementation details. Key is used as the name in the lb, listener, pool and monitor"
  type        = map(map(string))
}

variable "subnet_name" {
  description = "The name of the subnet (*NOT* the network name, although they can sometimes be the same)"
  type        = string
}

variable "openstack_auth_url" {
  description = "Openstack API URL"
  type = string
}

variable "openstack_app_id" {
  description = "Openstack application credential ID"
  type = string
}

variable "openstack_app_secret" {
  description = "Openstack application credential secret token"
  type = string
}

variable "openstack_region" {
  description = "Openstack tenant region"
  type = string
}

variable "create_senlin_policy" {
  description = "Set to 'true' to create Senlin LB policy to be used with application VMs cluster"
  type = bool
  default = false
}

