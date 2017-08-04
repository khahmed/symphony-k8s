# Symphony: This is Spectrum Symphony chart

IBM® Spectrum Symphony software delivers powerful enterprise-class management for running compute- and data-intensive distributed applications on a scalable, shared grid. It accelerates dozens of parallel applications for faster results and better utilization of all available resources. With Spectrum Symphony, you can improve IT performance, reduce infrastructure costs and expenses, and quickly meet business demands.

The chart installs a Symphony master nnd worker node according to the following
pattern:

- A `Deployment` is used to create a Replica Set of Symphony master and worker pods.
  ([templates/deployment.yaml](templates/deployment.yaml))
- A `Service` is used to create a gateway to the pods running in the
  replica set ([templates/service.yaml](templates/svc.yaml)) so that end user
  access to Symphony dashboard.

The [values.yaml](values.yaml) exposes a few of the configuration options in the
charts, though there are some that are not exposed there.


Parameters
----------


| Value                     | Description                                   | Default          |
|---------------------------|-----------------------------------------------|------------------|
| cluster.image.repository   | The image to use for this deployment          | master.cfc:8500/default/spectrum-symphony |
| cluster.image.tag          | The image tag to use for this deployment      | 7.2 |
| cluster.master             | Master name of the Symphony master | icp-worker1 |
| cluster.pvc                | Master shared storage | symphony |
| master.cpu                | Master container CPU limit      | 1000 |
| master.memory             | Master container memory limit      | 4096Mb |
| slave.cpu                 | Slave container CPU limit      | 1000 |
| slave.memory              | Slave container memory limit      | 2048Mb |
| slave.minReplicas         | Minimum number of replicas     | 1|
| slave.maxReplicas         | Maximum  number of replicas     | 1|
| slave.maxReplicasForAs   |  Maximum number of replicas for auto-scaling policy  | 1|
| slave.targetCPUUtilizationPercentage| Target CPU utilization of worker containers to trigger auto-scale   | 50|
| license.key1              | License feature for ego_base     | n/a |
| license.key2              | License feature for sym_adv_entitlement     | n/a |


