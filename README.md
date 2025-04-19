# YOLO E-Commerce Docker Implementation

## Project Overview
This project containerizes a full-stack e-commerce application using Docker with:
- React frontend (client)
- Ruby on Rails backend (API)
- MongoDB database

## Container Architecture
- **yolo-client**: React frontend built on Node 18 Alpine
- **yolo-backend**: Rails API built on Ruby 3.0 Alpine
- **yolo-mongodb**: MongoDB database for data persistence

## Implementation Challenges
During implementation, I encountered a compatibility issue between Ruby 3.0 and Rails 6.1.7.10. This is a known issue in the Ruby community where the Logger class was relocated in Ruby 3.0, causing conflicts with Rails 6.1.x. Several approaches were attempted to resolve this:

1. Creating a fix_logger.rb initializer
2. Trying to downgrade Ruby to 2.7
3. Adding the logger gem explicitly

The application containers build successfully, but the backend still experiences startup issues related to this compatibility problem.

## How to Run (Ideal Scenario)
```bash
# Clone the repository
git clone https://github.com/your-username/yolo.git
cd yolo

# Build the containers
docker-compose build

# Start the application
docker-compose up
