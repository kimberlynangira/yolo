# YOLO Application Docker Setup

## Project Description
This project containerizes a full-stack application with React frontend, Rails backend, and MongoDB database using Docker.

## Architecture
- Frontend: React application in Node.js container
- Backend: Ruby on Rails API
- Database: MongoDB

## Container Structure
- yolo-client: React frontend (Node 18 Alpine)
- yolo-backend: Rails API (Ruby 3.0 Alpine)
- yolo-mongodb: MongoDB database

## Setup Instructions
1. Clone this repository
2. Run `docker-compose build`
3. Run `docker-compose up`

## Challenges Faced
During implementation, I encountered a compatibility issue between Ruby 3.0 and Rails 6.1.7.10 related to the Logger class. This is a known issue in the Ruby/Rails community.

## Future Improvements
- Resolve the Ruby/Rails compatibility issue
- Add volume mounts for persistent data
- Implement proper environment variable management
