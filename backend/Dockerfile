FROM ruby:3.0.0-alpine
WORKDIR /app

# Install dependencies for MongoDB instead of PostgreSQL
RUN apk add --no-cache build-base nodejs npm bash tzdata git


# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application
COPY . .

# Make sure the entrypoint script is executable
RUN chmod +x /app/entrypoint.sh

EXPOSE 80

# Use the entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]
