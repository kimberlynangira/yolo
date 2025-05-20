# Shopping Cart Application on GKE

![Kubernetes](https://img.shields.io/badge/kubernetes-326CE5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/docker-2496ED.svg?style=for-the-badge&logo=docker&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white)
![NodeJS](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)

## Project Overview
This project demonstrates deployment of a containerized shopping cart application on Google Kubernetes Engine (GKE). The application consists of a Node.js frontend/API service and a MongoDB database for persistent storage, both deployed as Kubernetes resources.

## Architecture
The application is built using the following components:
- **Frontend/API**: Node.js application deployed as a Kubernetes Deployment
- **Database**: MongoDB deployed as a StatefulSet with persistent storage
- **Services**: Exposing both components within the cluster and to external traffic
- **Persistent Storage**: Using Persistent Volume Claims for database data

## Deployment URL
The application is deployed and accessible at: `http://[YOUR-IP-ADDRESS]:[PORT]`

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

### 3. Apply Kubernetes Manifests
```bash
kubectl apply -f kubernetes-manifests/
```

### 4. Verify Deployment
```bash
kubectl get pods
kubectl get services
```

### 5. Access the Application
Get the external IP of the Node.js service:
```bash
kubectl get services nodejs-service
```
Access the application using the External IP and port 80.

## Kubernetes Resources Used
- **StatefulSet**: For MongoDB database with stable network identities
- **Deployment**: For Node.js application
- **Services**: For network connectivity
- **PersistentVolumeClaim**: For database storage
- **ConfigMap**: For application configuration

## Testing Persistence
To test data persistence:
1. Add items to the shopping cart
2. Delete the MongoDB pod: `kubectl delete pod mongodb-0`
3. Wait for the pod to restart
4. Verify that cart items remain intact

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
│   ├── mongodb-statefulset.yaml
│   ├── mongo-pvc.yaml
│   ├── mongo-service.yaml
│   ├── nodejs-deployment.yaml
│   └── nodejs-service.yaml
├── README.md
└── explanation.md
```
