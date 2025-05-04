# YOLO E-commerce Application Ansible Deployment

This repository contains Ansible playbooks and roles to automate the deployment of a containerized e-commerce application. The application consists of three main components: MongoDB database, Node.js backend API, and React frontend.

## Project Structure
```
yolo/
├── group_vars/
│   └── all/
│       └── main.yml         # Variables for all groups
├── roles/
│   ├── common/              # Common tasks for all servers
│   │   └── tasks/
│   │       └── main.yml
│   ├── docker/              # Docker installation and setup
│   │   └── tasks/
│   │       └── main.yml
│   ├── mongodb/             # MongoDB database setup
│   │   └── tasks/
│   │       └── main.yml
│   ├── backend/             # Backend API setup
│   │   └── tasks/
│   │       └── main.yml
│   └── frontend/            # Frontend setup
│       └── tasks/
│           └── main.yml
├── inventory                # Inventory file
├── main.yml                 # Main playbook
├── backend/                 # Backend Node.js application
├── client/                  # Frontend React application
├── README.md                # Project documentation
└── explanation.md           # Detailed explanation of the playbook
```

## Prerequisites
- Ubuntu 20.04 or later
- Ansible 2.9 or later
- Docker
- Internet connection (to pull Docker images)
- Sudo privileges

## Setup Instructions
1. Clone this repository:
   ```bash
   git clone https://github.com/kimberlynangira/yolo.git
   cd yolo
   ```

2. Ensure Ansible is installed:
   ```bash
   sudo apt update
   sudo apt install ansible
   ```

3. Run the playbook:
   ```bash
   sudo ansible-playbook -i inventory main.yml
   ```

4. Access the application:
   After successful deployment, the application will be available at:
   - Frontend: http://localhost:3001
   - Backend API: http://localhost:5001/api

## Components

1. **MongoDB Database**:
   - Container Name: mongodb
   - Port: 27018 (mapped to 27017 inside container)
   - Data is persisted using Docker volume named mongodb_data

2. **Backend API**:
   - Container Name: backend
   - Port: 5001 (mapped to 5000 inside container)
   - Node.js application providing RESTful API services

3. **Frontend**:
   - Container Name: frontend
   - Port: 3001 (mapped to 3000 inside container)
   - React application for the user interface

## Docker Network
All containers are connected through a custom Docker network called ecommerce-network, allowing containers to communicate with each other using container names as hostnames.

## Persistence Testing
To verify that the data persists across container restarts:

1. Add a product to the database using the API:
   ```bash
   curl -X POST -H "Content-Type: application/json" -d '{"name":"Test Product","description":"Testing persistence","price":29.99,"category":"Test"}' http://localhost:5001/api/products
   ```

2. Verify the product was added:
   ```bash
   curl http://localhost:5001/api/products
   ```

3. Restart the containers:
   ```bash
   sudo docker restart mongodb backend frontend
   ```

4. Verify that the products are still available:
   ```bash
   curl http://localhost:5001/api/products
   ```

## Troubleshooting

- If containers fail to start, check the Docker logs:
  ```bash
  sudo docker logs mongodb
  sudo docker logs backend
  sudo docker logs frontend
  ```

- If network issues occur, verify the Docker network:
  ```bash
  sudo docker network inspect ecommerce-network
  ```

- Check if Docker volumes are properly created:
  ```bash
  sudo docker volume inspect mongodb_data
  ```
