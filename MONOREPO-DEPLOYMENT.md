# Task Manager Monorepo Deployment Guide

This guide provides instructions for deploying the Task Manager application as a monorepo, where both frontend and backend are deployed together.

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Deployment Options](#deployment-options)
4. [Docker Deployment](#docker-deployment)
5. [Platform-Specific Deployment](#platform-specific-deployment)
6. [Environment Variables](#environment-variables)
7. [Troubleshooting](#troubleshooting)

## Overview

In a monorepo deployment, the frontend and backend are built and deployed together as a single unit. The Node.js server serves both the API endpoints and the static frontend files.

### Advantages of Monorepo Deployment

- Simplified deployment process
- Guaranteed version compatibility between frontend and backend
- Single domain for both frontend and backend (no CORS issues)
- Simplified CI/CD pipeline
- Atomic deployments (both frontend and backend are updated simultaneously)

### Disadvantages of Monorepo Deployment

- Less flexibility for independent scaling
- Single point of failure
- May not utilize platform-specific optimizations for frontend hosting

## Prerequisites

- Node.js (v16.20.1 or higher)
- MongoDB account (for MongoDB Atlas) or a MongoDB server
- Docker and Docker Compose (for containerized deployment)
- Git

## Deployment Options

### Option 1: Docker Deployment

The simplest way to deploy the monorepo is using Docker:

```bash
# Build and run the monorepo container
docker-compose -f docker-compose.monorepo.yml up -d
```

### Option 2: Platform-Specific Deployment

Many platforms support monorepo deployments:

- Heroku
- DigitalOcean App Platform
- Render
- Railway
- AWS Elastic Beanstalk

## Docker Deployment

1. **Build the Docker image**:

```bash
docker build -t task-manager .
```

2. **Run the container**:

```bash
docker run -p 5001:5001 \
  -e NODE_ENV=production \
  -e MONGODB_URI=your_mongodb_uri \
  -e JWT_SECRET=your_jwt_secret \
  -e JWT_EXPIRATION=7d \
  task-manager
```

3. **Using Docker Compose**:

```bash
# Start the services
docker-compose -f docker-compose.monorepo.yml up -d

# Stop the services
docker-compose -f docker-compose.monorepo.yml down
```

## Platform-Specific Deployment

### Heroku Deployment

1. **Create a Heroku app**:

```bash
heroku create your-task-manager-app
```

2. **Add MongoDB addon**:

```bash
heroku addons:create mongodb:sandbox
```

3. **Set environment variables**:

```bash
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=your_jwt_secret
heroku config:set JWT_EXPIRATION=7d
```

4. **Deploy the app**:

```bash
git push heroku main
```

### Railway Deployment

1. Create a new project in Railway
2. Connect your GitHub repository
3. Add a MongoDB service
4. Configure environment variables
5. Deploy

## Environment Variables

For monorepo deployment, you need to set the following environment variables:

```
NODE_ENV=production
PORT=5001
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret
JWT_EXPIRATION=7d
GOOGLE_CLIENT_ID=your_google_client_id (if using Google OAuth)
GOOGLE_CLIENT_SECRET=your_google_client_secret (if using Google OAuth)
```

## Troubleshooting

### Common Issues

1. **Frontend routes not working**:
   - Make sure the server is correctly configured to serve the frontend's index.html for all non-API routes
   - Check that the static file middleware is correctly set up

2. **API endpoints not accessible**:
   - Verify that the API routes are defined before the catch-all route for the frontend
   - Check that the frontend is using the correct API URL (/api)

3. **Build issues**:
   - Make sure both frontend and backend dependencies are installed
   - Check that the frontend build process completes successfully

4. **Environment variable issues**:
   - Verify that all required environment variables are set
   - Check that the frontend is using the correct API URL in production

For more help, check the logs of your deployed service or contact your hosting provider's support.
