# Single-stage build for simplicity
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json files
COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY server/package*.json ./server/

# Install dependencies
RUN cd frontend && npm install --no-fund --no-audit
RUN cd server && npm install --only=production --no-fund --no-audit

# Copy source code
COPY frontend ./frontend
COPY server ./server

# Build frontend
WORKDIR /app/frontend
RUN npm run build:skip-ts

# Expose port
EXPOSE 5001

# Set working directory to server
WORKDIR /app/server

# Add debugging information
RUN echo "Listing server directory:" && ls -la && \
    echo "Listing node_modules:" && ls -la node_modules && \
    echo "Listing frontend dist:" && ls -la ../frontend/dist || echo "Frontend dist not found"

# Start server
CMD ["node", "server.js"]
