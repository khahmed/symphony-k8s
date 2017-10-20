# Symphony: This is Spectrum Symphony chart

IBM® Spectrum Symphony software delivers powerful enterprise-class management for running compute- and data-intensive distributed applications on a scalable, shared grid. It accelerates dozens of parallel applications for faster results and better utilization of all available resources. With Spectrum Symphony, you can improve IT performance, reduce infrastructure costs and expenses, and quickly meet business demands.

The chart installs a Symphony master and worker node according to the following
pattern:

- A `Deployment` is used to create a Replica Set of Symphony master and worker pods.
  ([templates/deployment.yaml](templates/deployment.yaml))
- A `Service` is used to create a gateway to the pods running in the
  replica set ([templates/service.yaml](templates/svc.yaml)) so that end user
  access to Symphony dashboard.

The [values.yaml](values.yaml) exposes a few of the configuration options in the
charts, though there are some that are not exposed there.

Quick Start
-----------

0. Build Symphony Image

The chart assumes that the Symphony image is built and is available in a Docker registry. See https://github.com/khahmed/symphony-k8s

1. Create a Persistent Volume


The Symphony chart requires access to storage in order to persist the cluster state, which is performed through the Kubernetes Volume Claim mechanism. The storage can be allocated in the private cloud admin console.

~~~
apiVersion: v1
kind: PersistentVolume
metadata:
   name: vol01
spec:
   capacity:
      storage: 10Gi
   accessModes:
      - ReadWriteMany
   persistentVolumeReclaimPolicy: Recycle
   nfs:
      path: /var/nfs/share1
      server: 9.21.58.21

~~~

2.  Label Nodes for Running Symphony components

Nodes must be labeled as targets for Symphony deployment. The current chart uses hostNetwork so that only one Symphony container per node. Symphony can use all the resources on a node to run analytics workloads. 

~~~
kubectl label --overwrite  node 9.21.58.21  deploy_sym_master="true"
kubectl label --overwrite  node 9.21.58.33  deploy_sym_master="false"
~~~

3. Install the chart

You can use the  ICp App Center to deploy a Symphony cluster including master and workers using the deployment wizard
to enter the values. Alternatively use the helm CLI:

~~~
helm repo add symphony https://raw.githubusercontent.com/khahmed/symphony-k8s/master/
helm install --name symphony  --set cluster.master=master-node --set cluster.pvc=symphony --set cluster.image.repository=master.cfc:8500/default/spectrum-symphony --set cluster.image.tag=7.2 --set license.key1="license key 1" --set license.key2="license key 2" symphony/spectrum-symphony
~~~

NOTE: You need to obtain a license for Symphony 

The following parameters can be modified with the --set option

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




4. Verify Symphony Pods are running

After installation the Symphony pods should be running:

~~~
khalids-mbp:spectrum-symphony khalida$ kubectl get pods
NAME                                               READY     STATUS    RESTARTS   AGE
default-spectrum-symphony-1885277081-r1dvc         1/1       Running   0          19h
default-spectrum-symphony-slave-2401316592-dmdvd   1/1       Running   0          19h
~~~

5. Access the Symphony Management UI

You can go the ICp console and access the Symphony Admin console from the Application details
