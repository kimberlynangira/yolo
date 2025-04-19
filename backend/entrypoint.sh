#!/bin/bash
set -e

# Check if we need to create a new Rails application
if [ ! -f ./config/application.rb ]; then
  echo "Rails application not found, creating a new one..."
  rails new . --skip-active-record --skip-bundle --api --force
fi

# Add MongoDB support
echo "gem 'mongoid'" >> Gemfile
bundle install

# Generate Mongoid configuration
rails g mongoid:config

# Configure MongoDB connection
if [ -f config/mongoid.yml ]; then
  sed -i 's/localhost:27017/mongodb:27017/g' config/mongoid.yml
fi

# Add logger fix for Ruby 3.0 with Rails 7.0
mkdir -p config/initializers
echo "require 'logger'" > config/initializers/logger_fix.rb

# Start Rails server with the parameters passed to the script
if [ "$1" = "rails" ] && [ "$2" = "s" ]; then
  # For development server
  exec bundle exec rails s -b 0.0.0.0
else
  # Default command or custom command
  exec "$@"
fi
