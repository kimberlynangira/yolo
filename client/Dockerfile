FROM node:14

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the app source code
COPY . .

# Set environment variables for proper binding
ENV HOST=0.0.0.0
ENV PORT=3000
ENV DANGEROUSLY_DISABLE_HOST_CHECK=true

# Set the command to run the app with interactive mode
CMD ["npm", "start"]
