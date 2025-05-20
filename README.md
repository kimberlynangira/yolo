
# Shopping Cart Application on GKE

## Project Overview
This project demonstrates deployment of a containerized shopping cart application on Google Kubernetes Engine (GKE). The application consists of a frontend, backend service, and a MongoDB database for persistent storage, all deployed as Kubernetes resources in the `yolo-app` namespace.

## Architecture
The application is built using the following components:
- **Frontend**: Web interface deployed as a Kubernetes Deployment with LoadBalancer service
- **Backend**: API service deployed as a Kubernetes Deployment with ClusterIP service
- **Database**: MongoDB deployed with persistent storage
- **Services**: Exposing components within the cluster and the frontend to external traffic
- **Persistent Storage**: Using Persistent Volume Claims for database data

## Deployment URL
The application is deployed and accessible at: `http://34.55.124.145`

## Features
- Add items to shopping cart
- View cart contents
- Data persistence across pod restarts and deletions
- Scalable architecture

## Prerequisites
- Google Cloud account with GKE enabled
- kubectl configured to connect to your GKE cluster
- Docker Hub account (for storing custom images)

## Deployment Instructions

### 1. Clone the repository
```bash
git clone https://github.com/kimberlynangira/yolo.git
cd yolo
```

### 2. Create GKE Cluster
```bash
gcloud container clusters create shopping-cluster --num-nodes=3 --zone=us-central1-a
```

### 3. Create Namespace
```bash
kubectl create namespace yolo-app
```

### 4. Apply Kubernetes Manifests
```bash
kubectl apply -f kubernetes-manifests/ -n yolo-app
```

### 5. Verify Deployment
```bash
kubectl get pods -n yolo-app
kubectl get services -n yolo-app
```

### 6. Access the Application
Get the external IP of the frontend service:
```bash
kubectl get services frontend-service -n yolo-app
```
Access the application using the External IP (http://34.55.124.145).

## Current Deployment Status

The application is deployed and accessible at: `http://34.55.124.145`

**Note:** The frontend is currently experiencing a `CrashLoopBackOff` in its Kubernetes pod. The logs indicate that the React development server starts but then the container exits, causing Kubernetes to restart it repeatedly. This prevents the frontend application from being accessible in the browser.

The backend and database services appear to be running. The core Kubernetes infrastructure, including the LoadBalancer service, deployments, and (if implemented) persistent volumes, are configured. The issue lies in the behavior of the frontend development server within the container environment. Further investigation would involve creating a production build of the React application and serving it with a production-ready web server in the Docker container.




## Kubernetes Resources Used
- **Deployments**: For frontend, backend, and MongoDB applications
- **Services**: 
  - `frontend-service` (LoadBalancer) for external access
  - `backend-service` (ClusterIP) for internal API access
  - `mongodb-service` and `mongodb` (Headless) for database access
- **PersistentVolumeClaim**: For database storage
- **Namespace**: `yolo-app` for logical isolation

## Testing Persistence
To test data persistence:
1. Add items to the shopping cart
2. Find your MongoDB pod: `kubectl get pods -n yolo-app | grep mongodb`
3. Delete the MongoDB pod: `kubectl delete pod [mongodb-pod-name] -n yolo-app`
4. Wait for the pod to restart
5. Verify that cart items remain intact

## Technologies Used
- Docker
- Kubernetes
- Google Kubernetes Engine
- Node.js
- MongoDB
- Persistent Volumes

## Repository Structure
```
├── Docker files
│   ├── mongodb
│   └── nodejs
├── kubernetes-manifests
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── mongodb-deployment.yaml
│   ├── mongodb-service.yaml
│   └── mongo-pvc.yaml
├── README.md
└── explanation.md
```
