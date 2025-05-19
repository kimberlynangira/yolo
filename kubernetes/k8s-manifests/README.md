# YOLO App Deployment on Kubernetes

## Overview

This repository contains Kubernetes manifests for deploying the YOLO application on Google Kubernetes Engine (GKE). The application consists of three main components:

-   Frontend: React application
-   Backend: API service
-   MongoDB: Database using StatefulSet with persistent storage

## Live Application

-   Frontend URL: [http://34.55.124.145](http://34.55.124.145)

## Components

### Frontend

-   Deployment with 1 replica
-   Service exposed via LoadBalancer
-   Connected to backend via internal service

### Backend

-   Deployment with 1 replica
-   Service exposed via ClusterIP
-   Connected to MongoDB via internal service

### MongoDB

-   StatefulSet with 1 replica
-   Persistent volume for data storage
-   Headless service for stable network identity

## Deployment Instructions

1.  Ensure you have `kubectl` configured to connect to your GKE cluster
2.  Apply the manifests:

    ```bash
    kubectl apply -f mongodb-statefulset.yaml
    kubectl apply -f backend-deployment.yaml
    kubectl apply -f frontend-deployment.yaml
    ```

Verify all pods are running:

```bash
kubectl get pods -n yolo-app
