# YOLO Application Docker Setup

## Project Description
This project containerizes a full-stack application consisting of a React frontend, Rails backend, and MongoDB database using Docker. The purpose is to demonstrate containerization of a multi-tier application.

## Technology Stack
- **Frontend**: React.js running in a Node.js container
- **Backend**: Ruby on Rails API
- **Database**: MongoDB
- **Container Technology**: Docker & Docker Compose

## Container Architecture
- **yolo-client**: React frontend built on Node 18 Alpine image
- **yolo-backend**: Rails API built on Ruby 3.0 Alpine image
- **yolo-mongodb**: MongoDB database

## Image Size & Optimization
To keep image sizes minimal:
- Used Alpine-based images for smaller footprints
- Utilized multi-stage builds where appropriate
- Minimized the number of layers by combining RUN commands

## Setup Instructions
1. Clone this repository
2. Run `docker-compose build`
3. Run `docker-compose up`

## Challenges Faced
During implementation, I encountered a compatibility issue between Ruby 3.0 and Rails 6.1.7.10 related to the Logger class. This is a known issue in the Ruby/Rails community that affects applications running on newer Ruby versions with older Rails versions.

## Future Improvements
- Resolve the Ruby/Rails compatibility issue
- Add volume mounts for persistent data
- Implement proper environment variable management
- Set up a production-ready Docker Compose configuration
