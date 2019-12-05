variable "lb_floating_ip" {
  description = "The (optional) floating ip to assign to the load balancer as a VIP"
  type        = string
  default     = false
}

variable "lb_name" {
  description = "Name of the loadbalancer"
  type        = string
}

variable "lb_flavors" {
  description = "Name of the loadbalancer flavor to use"
  type        = map(string)
  default = {
    "small"  = "a26c5b7b-b6fe-48f0-a165-5a35e2474541"
    "medium" = "776aec9e-e7ea-49bc-aec3-5b9913251bcd"
    "large"  = "5ed6eaac-5653-4eb0-b1a8-7b8716591fb7"
  }
}

variable "lb_flavor_name" {
  description = "Name of the loadbalancer flavor to use"
  type        = string
  default     = "small"
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
  type        = string
  default     = ""
}

variable "openstack_app_id" {
  description = "Openstack application credential ID"
  type        = string
  default     = ""
}

variable "openstack_app_secret" {
  description = "Openstack application credential secret token"
  type        = string
  default     = ""
}

variable "openstack_region" {
  description = "Openstack tenant region"
  type        = string
  default     = "RegionOne"
}

variable "create_senlin_policy" {
  description = "Set to 'true' to create Senlin LB policy to be used with application VMs cluster"
  type        = bool
  default     = false
}

