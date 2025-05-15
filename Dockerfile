# Use Node.js 18 as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json files first for better caching
COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY server/package*.json ./server/

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build frontend
RUN echo "Building frontend..." && \
    cd frontend && \
    npm run build:skip-ts

# Expose port
EXPOSE 5001

# Set working directory to server
WORKDIR /app/server

# Debug: Show directory structure
RUN echo "Directory structure:" && \
    echo "Current directory:" && pwd && ls -la && \
    echo "App directory:" && ls -la /app && \
    echo "Frontend directory:" && ls -la /app/frontend && \
    echo "Frontend dist directory:" && ls -la /app/frontend/dist || echo "Frontend dist directory not found"

# Start server
CMD ["node", "server.js"]
