# Kubernetes Shopping Cart Application

This project demonstrates the deployment of a multi-tier shopping cart application on Google Kubernetes Engine (GKE).

## Architecture

The application consists of:
- Frontend service: User interface for shopping
- Backend service: API for managing shopping cart items
- Database: Stateful component for persistent storage of items

## Deployment Instructions

### Prerequisites
- Google Cloud account with GKE enabled
- kubectl installed and configured
- Docker images pushed to Docker Hub

### Setup Steps

1. Create GKE cluster (if not already created)

```bash
gcloud container clusters create my-first-cluster --num-nodes=3 --zone=us-central1-a
```

2.Configure kubectl to use the cluster

```bash
gcloud container clusters get-credentials my-first-cluster --zone=us-central1-a
```
3.Create namespace and apply Kubernetesmanifests

```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/database/
kubectl apply -f kubernetes/frontend/
```
4.Wait for all pods to be running

```bash
kubectl get pods -n yolo-app
```
5.Access the application

 ```bash
kubectl get services frontend-service -n yolo-app
```
