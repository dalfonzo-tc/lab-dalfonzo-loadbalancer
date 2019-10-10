module "loadbalancer" {
  source = "../"
  #source = "git@github.com:tucowsinc/terraform-openstack-loadbalancer.git?ref=v0.1.3"
  listeners = { "test01" = { "proto" = "HTTP"
    "port"            = "80"
    "lb_method"       = "ROUND_ROBIN"
    "mon_proto"       = "TCP"
    "mon_proto"       = "TCP"
    "mon_delay"       = "5"
    "mon_retries"     = "3"
    "mon_admin_state" = "true"
    "mon_timeout"     = "3"
    }
    "test02" = { "proto" = "TCP"
      "port"            = "6443"
      "lb_method"       = "ROUND_ROBIN"
      "mon_proto"       = "TCP"
      "mon_proto"       = "TCP"
      "mon_delay"       = "5"
      "mon_retries"     = "3"
      "mon_admin_state" = "true"
      "mon_timeout"     = "3"
    }
  }
  //lb_floating_ip = "10.151.201.215"
  subnet_name = "dev_cicd"
  lb_name     = "terraform01"
  create_senlin_policy  = true
  openstack_auth_url = "https://openstack01.mow.dev.tucows.cloud:5000/v3"
  openstack_region  = "RegionOne"
  openstack_app_id = "xxxxxxxxxxxxxxxxxxxx"
  openstack_app_secret = "XXXXXXXXXXXXXXXXxxxxxxxxxxxxxxXXXXXXXXXXXXX"
}
