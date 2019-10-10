type: senlin.policy.loadbalance
version: 1.1
description: A policy for load-balancing the nodes in a cluster.
properties:
  # Name or ID of loadbalancer for the cluster on which nodes can be connected.
  loadbalancer: ${loadbalancer_id}
  pool:
    subnet: ${pool_subnet}
    # ID of pool for the cluster on which nodes can be connected.
    id: ${pool_id}

  vip:
    subnet: ${vip_subnet}

