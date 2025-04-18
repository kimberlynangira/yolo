# Use an official Node runtime as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

ENV NODE_OPTIONS="--openssl-legacy-provider"

# Install application dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

ENV NODE_OPTIONS="--openssl-legacy-provider"

#RUN NPM
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run your app
CMD ["npm", "start"]
