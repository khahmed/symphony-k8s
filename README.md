# Symphony: Deploy Spectrum Symphony on Kuberentes (IBM Cloud private)

This project contains artifacts to deploy IBM Spectrum Symphony on Kubernetes. This can be used to enable Symphony to run on IBM Cloud private 

- Dockerfile: Dockerfile for building a docker image for Symphony for x86_64. This can be loaded into the Docker private registry in ICp
- Dockerfile.ppc64le: Dockerfile for building docker image for Symphony for ppc64le
- bootstrap.sh: Start up script for Dockerfile
- spectrum-symphony: Directory containing helm charts for deploying Spectrum Symphony. This can be loaded into ICp App center to enable 
users

