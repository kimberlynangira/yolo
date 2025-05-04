# E-Commerce Application Ansible Deployment

## Playbook Structure and Execution Order

My Ansible playbook for deploying the YOLO E-commerce application follows a structured approach with four main roles executed in a specific order to ensure proper dependency management.

### Pre-Tasks
Before executing roles, the playbook performs essential system preparation:
- Updates the apt package cache
- Installs prerequisite packages like git, curl, and Python dependencies

### Role Execution Order
The roles are executed in the following order:

1. **Docker Role**: Establishes the container infrastructure
2. **MongoDB Role**: Sets up the database service
3. **Backend Role**: Deploys the API server
4. **Frontend Role**: Deploys the user interface

This order is critical because each role depends on the successful completion of the previous ones. For example, Docker must be installed before any containers can be created, and the database must be available before the backend can connect to it.

### Post-Tasks
After deployment, verification tasks are performed:
- Checking if the application is running
- Displaying connection information for all components

## Role Details

### 1. Docker Role
**Purpose**: Installs Docker and creates the required network infrastructure.

**Key Tasks**:
- Adding Docker repository and GPG key
- Installing Docker Engine and Docker Compose
- Creating a custom network for container communication
- Setting Docker service to start automatically

### 2. MongoDB Role
**Purpose**: Deploys the MongoDB database container.

**Key Tasks**:
- Creating persistent volume for database storage
- Running MongoDB container with proper network configuration
- Exposing MongoDB on port 27018 (mapped to internal 27017)
- Configuring proper restart policies for reliability

### 3. Backend Role
**Purpose**: Deploys the Node.js API server.

**Key Tasks**:
- Building or pulling the backend container image
- Configuring environment variables including MongoDB connection
- Exposing the API on port 5001 (mapped to internal 5000)
- Mounting code directory for development if needed

### 4. Frontend Role
**Purpose**: Deploys the React frontend application.

**Key Tasks**:
- Building or pulling the frontend container image
- Configuring environment variables including API endpoint
- Exposing the frontend on port 3002 (mapped to internal 3000)
- Setting up container networking with backend

## Network Configuration

All containers run on a custom Docker network called "ecommerce-network" which allows:
- Container-to-container communication using container names as hostnames
- Isolation from other Docker networks for security
- Proper name resolution between services

## Port Mappings

| Service | Container Port | Host Port |
|---------|---------------|-----------|
| Frontend | 3000 | 3002 |
| Backend | 5000 | 5001 |
| MongoDB | 27017 | 27018 |

These mappings ensure services are accessible while avoiding port conflicts.

## Variables Management

Variables are defined in vars/main.yml file to make the deployment configurable and maintainable:
- Container versions and image names
- Port mappings
- Network configurations
- MongoDB connection strings

This approach allows for easy updates and environment-specific configurations.
