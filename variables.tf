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
