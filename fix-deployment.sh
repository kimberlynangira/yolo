#!/bin/bash

echo "Fixing e-commerce deployment..."

# Stop any existing containers
echo "Stopping existing containers..."
sudo docker stop frontend mongodb backend || true
sudo docker rm frontend mongodb backend || true

# Create network if it doesn't exist
echo "Creating Docker network..."
sudo docker network create ecommerce-network || true

# Ensure data directory exists
echo "Creating data directory..."
sudo mkdir -p /home/kimberly-nangira/mongodb-data
sudo chmod 777 /home/kimberly-nangira/mongodb-data

# Run MongoDB container
echo "Starting MongoDB container..."
sudo docker run -d \
  --name mongodb \
  --restart always \
  --network ecommerce-network \
  -v /home/kimberly-nangira/mongodb-data:/data/db \
  -p 27018:27017 \
  mongo:4.4

# Run backend container
echo "Starting backend container..."
sudo docker run -d \
  --name backend \
  --restart always \
  --network ecommerce-network \
  -v /home/kimberly-nangira/yolo/backend:/app \
  -p 5001:5000 \
  -e MONGO_URI=mongodb://mongodb:27017/ecommerce \
  -e PORT=5000 \
  -e NODE_ENV=development \
  -w /app \
  node:14 \
  bash -c "npm install && npm start"

# Run frontend container
echo "Starting frontend container..."
sudo docker run -d \
  --name frontend \
  --restart always \
  --network ecommerce-network \
  -v /home/kimberly-nangira/yolo/client:/app \
  -p 3001:3000 \
  -e REACT_APP_API_URL=http://localhost:5001 \
  -w /app \
  node:14 \
  bash -c "npm install && npm start"

echo "Checking container status..."
sudo docker ps

echo "Deployment complete! Access your application at http://localhost:3001"
