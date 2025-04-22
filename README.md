# YOLO E-commerce Application

## Project Overview
YOLO is a microservices-based e-commerce application that allows users to browse and purchase products online. The application follows modern architecture principles with separate frontend, backend, and database services.

## Architecture
The application consists of three main components:
- **Frontend**: React-based client application providing the user interface
- **Backend**: Ruby on Rails API service handling business logic and data processing
- **Database**: MongoDB instance for data persistence

## Docker Implementation
### Containers
- yolo-client: Frontend container running on port 80
- yolo-backend: Backend API service
- yolo-mongodb: Database container running on port 27017

### Networks
A dedicated bridge network (yolo_yolo-network) connects all containers, enabling secure communication between services.

### Volumes
Persistent volume for MongoDB ensures data is preserved between container restarts.

## Setup Instructions
1. Clone the repository
2. Run `docker-compose up -d`
3. Access the application at http://localhost

## Screenshots

### Running Containers
![Running Containers](https://github.com/user-attachments/assets/83351454-69f8-49ab-88d3-ca68aa8e56da)

### Docker Images
![Docker Images](https://github.com/user-attachments/assets/b34fcd10-ab4c-4adc-b46a-e557f20afd46)

### Docker Network Configuration
![Docker Network List](https://github.com/user-attachments/assets/11b216ae-b0c7-4ad5-a34b-6d50ee7b7aa6)
![Docker Network Inspect](https://github.com/user-attachments/assets/c643dd55-459b-4ca7-8f86-618a592977c7)

### Docker Volumes
![Docker Volumes](https://github.com/user-attachments/assets/552b91e7-12be-444e-9dd2-148dc46a551c)

### Application (Connection Error)
![Application Error](https://github.com/user-attachments/assets/6c762d3c-33b2-4e34-bebf-cba4013819ab)

## Challenges and Solutions
- **Challenge**: Rails compatibility issue with Ruby 3.0
  **Solution**: Identified a compatibility issue between Ruby 3.0 and Rails 6.1.7.10 where the Logger constant wasn't properly recognized. Added the logger gem to the Gemfile as a potential solution, though further investigation would be needed for a complete fix.
  
- **Challenge**: MongoDB permission issues
  **Solution**: Used sudo with Docker commands to overcome permission problems with the MongoDB container.

- **Challenge**: Application connectivity issues
  **Solution**: While the Docker infrastructure was correctly configured with proper networks, volumes, and port mappings, the application itself had dependency issues that prevented it from fully functioning. This would require additional development time to resolve completely.
