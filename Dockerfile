FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Backend build
FROM base AS backend-build
WORKDIR /app/server
RUN npm install

# Frontend build
FROM base AS frontend-build
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Production image
FROM node:18-alpine AS production
WORKDIR /app

# Copy backend
COPY --from=backend-build /app/server /app/server
COPY --from=backend-build /app/package*.json /app/

# Copy frontend build
COPY --from=frontend-build /app/frontend/dist /app/public

# Install production dependencies
WORKDIR /app/server
RUN npm install --production

# Set environment variables
ENV NODE_ENV=production
ENV PORT=5001

# Expose the port
EXPOSE 5001

# Start the application
CMD ["node", "server.js"]
