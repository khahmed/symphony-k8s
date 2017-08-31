# Symphony: Deploy Spectrum Symphony on Kuberentes (IBM Cloud private)

This project contains artifacts to deploy IBM Spectrum Symphony on Kubernetes. This can be used to enable Symphony to run on IBM Cloud private 

- Dockerfile: Dockerfile for building a docker image for Symphony for x86_64. This can be loaded into the Docker private registry in ICp
- Dockerfile.ppc64le: Dockerfile for building docker image for Symphony for ppc64le
- bootstrap.sh: Start up script for Dockerfile
- spectrum-symphony: Directory containing helm charts for deploying Spectrum Symphony. This can be loaded into ICp App center to enable 
users
- multi-arch.yaml: Multi-arch YAML for creating a single meta image for x86 and ppc64le platforms


Build Docker Image
------------------

The Dockerfile expects the Symphony distribution to downloaded from a specifc IP address. Put the Symphony distribution on a web server and 
modify the Dockerfile changing the $repo_url variable to point to it. You can build the Docker image from the command-line:

```
docker build -t spectrum-symphony:7.2 .
```

Alternatively you can use the default Jenkins service that appears in the IBM Cloud private App Center to build the Symphony image.  Fork this repo and modify the IP aaddress to the web server for the Symphony distribution. Crate a Jenkins job and point the Git repo  to it ,  and add a buld step with the following shell command:


```
cfc-auto-build-k8s spectrum-symphony-x86:7.2 .
```

For Power systems use the following shell command in the build step: 

```
cp Dockerfile.ppc64le Dockerfile
cfc-auto-build-k8s spectrum-symphony-ppc64le:7.2 .
```

In order to build a multi-arch Docker image that can reference the x86 and Power images:

- Download and install the multi-arch manifest tool from https://github.com/estesp/manifest-tool/releases

- Execute the following after logging into the Docker private registry in ICp :

```
./manifest-tool-linux-amd64 push from-spec multi-arch.yaml
Digest: sha256:7cdb5d2e2b4ef4956ebe954eae0af71850529d4e1ef9b1dab5d55744a05212f0
```


