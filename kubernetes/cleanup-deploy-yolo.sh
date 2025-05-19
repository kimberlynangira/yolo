#!/bin/bash
# Cleanup and Deploy script for YOLO E-Commerce App

# Set up color outputs
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting YOLO E-Commerce App Cleanup and Deployment${NC}"

# Clean up existing resources
echo -e "${RED}Cleaning up existing resources...${NC}"
kubectl delete deployment --all -n yolo-app 2>/dev/null
kubectl delete statefulset mongodb -n yolo-app 2>/dev/null
kubectl delete pod -n yolo-app $(kubectl get pods -n yolo-app | grep -E 'Evicted|ContainerStatusUnknown|Completed' | awk '{print $1}') 2>/dev/null
kubectl delete job --all -n yolo-app 2>/dev/null

# Create namespace if it doesn't exist
echo -e "${GREEN}Creating namespace yolo-app if it doesn't exist...${NC}"
kubectl create namespace yolo-app --dry-run=client -o yaml | kubectl apply -f -

# Apply database components first
echo -e "${GREEN}Deploying MongoDB StatefulSet and Service...${NC}"
kubectl apply -f database/service.yaml
kubectl apply -f database/statefulset.yaml

# Wait for MongoDB to be ready
echo -e "${YELLOW}Waiting for MongoDB to be ready...${NC}"
kubectl wait --for=condition=ready pod/mongodb-0 -n yolo-app --timeout=180s || true

# Apply backend components
echo -e "${GREEN}Deploying Backend Deployment and Service...${NC}"
kubectl apply -f frontend/backend-service.yaml
kubectl apply -f frontend/backend-deployment.yaml

# Wait for Backend to be ready
echo -e "${YELLOW}Waiting for Backend to start...${NC}"
sleep 30

# Apply frontend components
echo -e "${GREEN}Deploying Frontend Deployment and Service...${NC}"
kubectl apply -f frontend/service.yaml
kubectl apply -f frontend/deployment.yaml

# Check deployment status
echo -e "${YELLOW}Checking deployment status...${NC}"
kubectl get pods -n yolo-app
kubectl get services -n yolo-app

# Provide access information
echo -e "${GREEN}Getting frontend service access information...${NC}"
NODEPORT=$(kubectl get svc frontend-service -n yolo-app -o jsonpath='{.spec.ports[0].nodePort}')
echo -e "${GREEN}Your application should be available at: http://<NODE-IP>:$NODEPORT${NC}"

echo -e "${GREEN}Deployment completed!${NC}"
