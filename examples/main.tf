module "loadbalancer" {
  source = "../"
  #source = "git@github.com:tucowsinc/terraform-openstack-loadbalancer.git?ref=v0.1.3"
  listeners = {
    "consul" = {
      "proto"           = "TCP"
      "port"            = "8501"
      "lb_method"       = "ROUND_ROBIN"
      "mon_proto"       = "TCP"
      "mon_delay"       = "5"
      "mon_retries"     = "3"
      "mon_admin_state" = "true"
      "mon_timeout"     = "3"
    }
    "vault" = {
      "proto"           = "HTTPS"
      "port"            = "8200"
      "lb_method"       = "ROUND_ROBIN"
      "mon_proto"       = "TCP"
      "mon_delay"       = "5"
      "mon_retries"     = "3"
      "mon_admin_state" = "true"
      "mon_timeout"     = "3"
    }
  }
  //lb_floating_ip = "10.151.201.215"
  subnet_name = "lab_k8s_teeuwes"
  lb_name     = "terraform01"
  create_senlin_policy  = false
}
