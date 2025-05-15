# Task Manager Separate Deployment Summary

This document summarizes the configuration for separate deployment of the Task Manager frontend and backend components.

## Custom Domains

- **Frontend**: https://taskm.greenhacker.tech
- **Backend (Server)**: https://taskms.greenhacker.tech

## Deployment Configuration

### Removed Files (Monorepo Configuration)

The following files have been removed as they were intended for monorepo deployment:

- `Dockerfile` (root)
- `Dockerfile.railway` (root)
- `railway.json` (root)

### Frontend Configuration

The frontend is configured for deployment to Railway with the following files:

- `frontend/Dockerfile` - Multi-stage build that compiles the React app and serves it with Nginx
- `frontend/nginx.conf` - Nginx configuration that serves the frontend and proxies API requests to the backend
- `frontend/railway.json` - Railway configuration for the frontend deployment
- `frontend/.env.production` - Environment variables for production deployment
- `frontend/.dockerignore` - Files to exclude from the Docker image

Key configuration points:
- The frontend will be served at https://taskm.greenhacker.tech
- API requests will be proxied to https://taskms.greenhacker.tech/api
- The build process uses `npm run build:skip-ts` to skip TypeScript type checking during build

### Backend Configuration

The backend is configured for deployment to Railway with the following files:

- `server/Dockerfile` - Docker configuration for the Node.js server
- `server/railway.json` - Railway configuration for the backend deployment
- `server/.dockerignore` - Files to exclude from the Docker image
- `server/server.js` - Main server file with CORS configuration for the frontend domain

Key configuration points:
- The server will be accessible at https://taskms.greenhacker.tech
- CORS is configured to allow requests from https://taskm.greenhacker.tech
- A health check endpoint is available at /health for Railway monitoring
- The code that served the frontend from the server has been removed

## Deployment Instructions

Detailed deployment instructions are available in the following files:

- `frontend/RAILWAY_DEPLOYMENT.md` - Instructions for deploying the frontend
- `server/RAILWAY_DEPLOYMENT.md` - Instructions for deploying the backend
- `CUSTOM_DOMAIN_DEPLOYMENT.md` - Instructions for setting up custom domains

## Deployment Process

1. **Deploy the Backend First**:
   - Create a new Railway project for the backend
   - Set the root directory to `server/`
   - Configure environment variables
   - Set up the custom domain: taskms.greenhacker.tech

2. **Deploy the Frontend Second**:
   - Create a new Railway project for the frontend
   - Set the root directory to `frontend/`
   - Configure environment variables
   - Set up the custom domain: taskm.greenhacker.tech

3. **Verify the Deployment**:
   - Test the backend API at https://taskms.greenhacker.tech/health
   - Test the frontend at https://taskm.greenhacker.tech
   - Test the login functionality to ensure the connection between frontend and backend

## Troubleshooting

If you encounter issues during deployment:

1. **Check the Railway Logs**:
   - Review the build logs for any errors
   - Check the runtime logs for any issues

2. **Verify Environment Variables**:
   - Ensure all required environment variables are set correctly
   - Check that the API URL is correctly configured in the frontend

3. **Test API Connectivity**:
   - Use a tool like Postman to test the API endpoints
   - Verify that CORS is correctly configured

4. **Check DNS Configuration**:
   - Ensure that the DNS records for your custom domains are correctly set up
   - Allow time for DNS propagation
