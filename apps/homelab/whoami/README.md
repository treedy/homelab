# Whoami Service

This directory contains the Kubernetes manifests for deploying the `whoami` service.
It is not currently automatically deployed.

## Overview

The `whoami` service is a simple HTTP server that returns information about the request it received, such as the hostname of the server that handled the request, the IP address of the client, and various HTTP headers. It's often used for testing and debugging network configurations within a Kubernetes cluster.

## Contents

- `deployment.yaml`: Defines the Kubernetes Deployment for the `whoami` application. This creates and manages the pods running the `whoami` container.
- `service.yaml`: Defines the Kubernetes Service for the `whoami` application. This provides a stable IP address and DNS name for accessing the `whoami` pods.
- `kustomization.yaml`: A Kustomize file that orchestrates the deployment of the `whoami` service. It includes the `deployment.yaml` and `service.yaml` files.

## Deployment

To be implemented...
To deploy the `whoami` service to your Kubernetes cluster, navigate to this directory and apply the Kustomize configuration:

```bash
kubectl apply -k .
```

## Accessing the Service

Once deployed, you can access the `whoami` service within your cluster using its service name (e.g., `whoami`). If you have an Ingress controller configured, you can expose the service externally.

To test internal access, you can exec into a pod within your cluster and use `curl`:

```bash
kubectl run -it --rm --restart=Never busybox --image=busybox -- /bin/sh
# Inside the busybox pod
wget -O - whoami
```

## Configuration

The `whoami` service is typically configured via environment variables or command-line arguments within its Docker image. Refer to the `deployment.yaml` for specific configuration details, such as the image used and any exposed ports.

## Troubleshooting

- **Pods not running:** Check the pod logs (`kubectl logs <pod-name>`) and events (`kubectl describe pod <pod-name>`) for errors.
- **Service not accessible:** Verify that the service is running (`kubectl get svc whoami`) and that your network policies allow traffic to the service.
