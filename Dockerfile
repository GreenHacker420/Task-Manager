# Build stage for frontend
FROM node:18.19-alpine3.19 AS frontend-builder

# Set working directory
WORKDIR /app

# Copy package.json files for frontend
COPY frontend/package*.json ./frontend/

# Install frontend dependencies directly
WORKDIR /app/frontend
RUN npm install --no-fund --no-audit

# Copy frontend source
COPY frontend ./
COPY tsconfig.json /app/

# Build frontend
RUN npm run build

# Build stage for server
FROM node:18.19-alpine3.19 AS server-builder

# Set working directory
WORKDIR /app

# Copy package.json files for server
COPY server/package*.json ./server/

# Install server dependencies directly
WORKDIR /app/server
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

# Start server
CMD ["node", "server.js"]
