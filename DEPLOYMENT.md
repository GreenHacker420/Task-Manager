# Task Manager Deployment Guide

This guide provides instructions for deploying the Task Manager application to production environments.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Deployment Options](#deployment-options)
   - [Option A: Traditional Deployment](#option-a-traditional-deployment)
   - [Option B: Docker Deployment](#option-b-docker-deployment)
4. [Database Setup](#database-setup)
5. [Security Considerations](#security-considerations)
6. [Monitoring and Maintenance](#monitoring-and-maintenance)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

Before deploying, ensure you have:

- Node.js (v16.20.1 or higher)
- MongoDB account (for MongoDB Atlas) or a MongoDB server
- Domain name (optional but recommended)
- SSL certificate (for HTTPS)
- Google Developer account (if using Google OAuth)

## Environment Setup

### Backend Environment Variables

Create a `.env` file in the server directory based on the `.env.production.example` template:

```
# Server Configuration
PORT=5001
NODE_ENV=production

# MongoDB Connection
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/task-manager?retryWrites=true&w=majority

# JWT Configuration
JWT_SECRET=your_strong_production_jwt_secret_key
JWT_EXPIRATION=7d

# Google OAuth
GOOGLE_CLIENT_ID=your_production_google_client_id
GOOGLE_CLIENT_SECRET=your_production_google_client_secret

# Frontend URL (for CORS)
FRONTEND_URL=https://yourdomain.com
```

### Frontend Environment Variables

Create a `.env.production` file in the frontend directory:

```
# API Configuration
VITE_API_URL=https://api.yourdomain.com/api

# Google OAuth (if using Google login)
VITE_GOOGLE_CLIENT_ID=your_production_google_client_id
```

## Deployment Options

### Option A: Traditional Deployment

#### Backend Deployment

1. **Prepare the backend:**

```bash
cd server
npm install --production
```

2. **Deploy to a Node.js hosting service** (e.g., Heroku, DigitalOcean, AWS, etc.)

   - For Heroku:
     ```bash
     heroku create your-app-name-backend
     git subtree push --prefix server heroku main
     ```

   - For DigitalOcean App Platform:
     - Create a new app
     - Connect your repository
     - Set the source directory to `/server`
     - Configure environment variables

3. **Set up environment variables** on your hosting platform

#### Frontend Deployment

1. **Build the frontend:**

```bash
cd frontend
npm install
npm run build
```

2. **Deploy the static files** to a static hosting service (e.g., Netlify, Vercel, AWS S3, etc.)

   - For Netlify:
     ```bash
     cd frontend
     npx netlify-cli deploy --prod
     ```

   - For Vercel:
     ```bash
     cd frontend
     npx vercel --prod
     ```

### Option B: Docker Deployment

1. **Build and run with Docker Compose:**

```bash
# Build the containers
docker-compose build

# Start the services
docker-compose up -d
```

2. **Deploy to a container orchestration platform** (e.g., Kubernetes, AWS ECS, etc.)

   - For AWS ECS:
     - Create a task definition
     - Create a service
     - Configure load balancer

   - For Google Cloud Run:
     - Deploy each container separately
     - Set up environment variables

## Database Setup

1. **Create a MongoDB Atlas cluster** (recommended for production)
   - Sign up for MongoDB Atlas
   - Create a new cluster
   - Configure network access
   - Create a database user
   - Get the connection string

2. **Initialize the database** (optional)
   - Run the seed script if needed:
     ```bash
     cd server
     npm run seed
     ```

## Security Considerations

1. **Use strong, unique passwords** for all services
2. **Enable HTTPS** for all communication
3. **Secure JWT secrets** and never expose them
4. **Implement proper CORS policies**
5. **Regularly update dependencies**
6. **Set up rate limiting** to prevent abuse
7. **Use security headers** (already configured with Helmet)
8. **Implement proper error handling** to avoid leaking sensitive information

## Monitoring and Maintenance

1. **Set up logging** with a service like Loggly, Papertrail, or ELK Stack
2. **Monitor performance** with tools like New Relic or Datadog
3. **Set up alerts** for critical errors or performance issues
4. **Regularly backup your database**
5. **Implement a CI/CD pipeline** for automated testing and deployment

## Troubleshooting

### Common Issues

1. **CORS errors**
   - Verify the FRONTEND_URL environment variable is set correctly
   - Check that the frontend is making requests to the correct API URL

2. **Database connection issues**
   - Verify the MONGODB_URI is correct
   - Check network access settings in MongoDB Atlas

3. **Authentication problems**
   - Verify JWT_SECRET is set correctly
   - Check that Google OAuth credentials are correct

4. **Build failures**
   - Check for dependency issues
   - Verify Node.js version compatibility

For more help, check the logs of your deployed services or contact your hosting provider's support.
