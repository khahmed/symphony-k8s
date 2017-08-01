# Symphony: This is Spectrum Symphony  x86_64 chart

The chart installs a Symphony master node according to the following
pattern:

- A `Deployment` is used to create a Replica Set of Symphony master and worker pods.
  ([templates/deployment.yaml](templates/deployment.yaml))
- A `Service` is used to create a gateway to the pods running in the
  replica set ([templates/service.yaml](templates/svc.yaml)) so that end user
  access to Symphony dashboard.

The [values.yaml](values.yaml) exposes a few of the configuration options in the
charts, though there are some that are not exposed there.
