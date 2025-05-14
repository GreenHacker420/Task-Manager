# Build stage for frontend
FROM node:18.19-alpine3.19 AS frontend-builder

# Set working directory
WORKDIR /app/frontend

# Copy package.json files for frontend
COPY frontend/package*.json ./

# Install frontend dependencies directly
RUN npm install --no-fund --no-audit

# Copy frontend source
COPY frontend ./

# Build frontend - skip TypeScript checks for build
RUN npm run build:skip-ts

# Build stage for server
FROM node:18.19-alpine3.19 AS server-builder

# Set working directory
WORKDIR /app/server

# Copy package.json files for server
COPY server/package*.json ./

# Install server dependencies directly
RUN npm install --only=production --no-fund --no-audit

# Final stage
FROM node:18.19-alpine3.19

# Set working directory
WORKDIR /app

# Copy server from server-builder
COPY --from=server-builder /app/server/node_modules ./server/node_modules
COPY server ./server

# Copy built frontend from frontend-builder
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

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
