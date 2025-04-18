# Create an updated Dockerfile
cat > backend/Dockerfile.new << 'EOF'
FROM ruby:3.0-alpine
WORKDIR /app

# Install dependencies for MongoDB instead of PostgreSQL
RUN apk add --no-cache build-base nodejs npm bash tzdata git

# Install MongoDB gem dependencies
RUN apk add --no-cache mongodb

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application
COPY . .

# Make sure the entrypoint script is executable
RUN chmod +x /app/entrypoint.sh

EXPOSE 80

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]
EOF

# Create an entrypoint script
cat > backend/entrypoint.sh << 'EOF'
#!/bin/bash
set -e

# Check if we need to create a new Rails application
if [ ! -f ./config/application.rb ]; then
  echo "Rails application not found, creating a new one..."
  rails new . --skip-active-record --skip-bundle --api --force
  
  # Add MongoDB support
  echo "gem 'mongoid'" >> Gemfile
  bundle install
  
  # Generate Mongoid configuration
  rails g mongoid:config
fi

# Start Rails server
exec "$@"
EOF

# Replace the existing Dockerfile
mv backend/Dockerfile.new backend/Dockerfile
