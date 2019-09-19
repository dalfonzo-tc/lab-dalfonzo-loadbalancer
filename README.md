# Loadbalancer Openstack Module

## Features and Assumptions

- [x] Creates a Single LoadBalancer
- [x] Creates as many listeners as desired
- [x] Creates identical number of pools as listeners, in 1-to-1 relationship of name/proto/port
- [X] Creates a health monitor per listener/pool 

* This module does **not** create pool members. This is left to the caller, another module, or perhaps something outside Terraform entirely. 
## How to use this module's example

  1. You must be able to clone this modules repository as the user running terraform. Setup appropriate git credentials or ssh keys ahead of time.
  2. Clone this repository
  3. Inside the [examples](./examples/) directory add the following:
     * 'provider_openstack.tf' with your Openstack credentials (example_provider_openstack.txt provided as sample)
  4. Review [main.tf](./examples/main.tf) and adjust the variables if required.
  5. Run `terraform init` to download any required modules to your local examples path
  6. Run `terraform plan` to review what terraform intends to deploy
  7. Run `terraform apply` to deploy the infrastructure contained within this module
  
## Using this module in your project

Using this module from within your project is similar to what the [example](./examples/) shows. However a few points to keep in mind:
* Generally your variables would come from an external variables.tf file, perhaps specific to your environment. If so, the values listed in the example would instead reference the variable names from your file

## Input variables

| Variable               |  Type  |  Default        | Description                                                      |
|------------------------|:------:|:---------------:|------------------------------------------------------------------|
| lb_floating_ip         | string |       false     | A floating IP to attach to the LB. Leave false for no floating ip|
| lb_name                | string |                 | Name of the created load balancer                                |
| listeners              |  map   |                 | Map of listener/pool name to their details. See notes            |
| subnet_name            | string |                 | Name of the subnet the LB will be attached to                    |
 
## Output variables

| Variable             |  Type  | Description                                  |
|----------------------|:------:|----------------------------------------------|
| loadbalancer_id         | string | ID of the created loadbalancer            |


## Listeners

* The map for listeners contains all the configuration info for your load balancer. A listener, pool and monitor will be deployed
for each top-level key in the map, using the key as part of the names for each.  It uses the enclosed values depending on which
resource  it is.  See the example for what this map might look  like.
