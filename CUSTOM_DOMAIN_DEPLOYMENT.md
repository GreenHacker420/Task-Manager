# Task Manager Custom Domain Deployment Guide

This guide provides specific instructions for deploying the Task Manager application with the following custom domains:

- Backend (Server): https://taskms.greenhacker.tech
- Frontend: https://taskm.greenhacker.tech

## Prerequisites

- A GitHub repository with your Task Manager code
- A Railway account
- A MongoDB Atlas account (or use Railway's MongoDB plugin)
- Domain names configured with DNS provider

## Deployment Steps

### Backend Deployment (https://taskms.greenhacker.tech)

1. **Create a New Railway Project for the Backend**
   - Sign up or log in to [Railway](https://railway.app/)
   - Create a new project and select "Deploy from GitHub repo"
   - Select your repository
   - Set the root directory to `server/`

2. **Configure Environment Variables**
   - `PORT`: Port for the server (Railway will set this automatically)
   - `NODE_ENV`: Set to `production`
   - `MONGODB_URI`: MongoDB connection string
   - `JWT_SECRET`: Secret key for JWT token generation
   - `JWT_EXPIRATION`: Token expiration time (e.g., `7d`)
   - `GOOGLE_CLIENT_ID`: Your Google OAuth client ID
   - `GOOGLE_CLIENT_SECRET`: Your Google OAuth client secret
   - `FRONTEND_URL`: Set to `https://taskm.greenhacker.tech`

3. **Set Up Custom Domain**
   - Go to the Settings tab in your Railway project
   - Add the custom domain: `taskms.greenhacker.tech`
   - Follow Railway's instructions to configure DNS settings with your domain provider

### Frontend Deployment (https://taskm.greenhacker.tech)

1. **Create a New Railway Project for the Frontend**
   - Create another project in Railway
   - Select your repository
   - Set the root directory to `frontend/`

2. **Configure Environment Variables**
   - `VITE_API_URL`: Set to `https://taskms.greenhacker.tech/api`

3. **Set Up Custom Domain**
   - Go to the Settings tab in your Railway project
   - Add the custom domain: `taskm.greenhacker.tech`
   - Follow Railway's instructions to configure DNS settings with your domain provider

## DNS Configuration

For each domain, you'll need to add the following DNS records with your domain provider:

1. For `taskms.greenhacker.tech`:
   - Add a CNAME record pointing to your Railway backend service URL

2. For `taskm.greenhacker.tech`:
   - Add a CNAME record pointing to your Railway frontend service URL

Railway will provide the specific values to use for these CNAME records.

## Verifying the Deployment

1. Visit https://taskm.greenhacker.tech to verify that the frontend is running correctly
2. Test the login functionality to ensure the backend connection is working
3. Check the logs in Railway for any errors

## Troubleshooting

### CORS Issues

If you encounter CORS issues:

1. Ensure the `FRONTEND_URL` environment variable in the backend project is set to `https://taskm.greenhacker.tech`
2. Check that the backend's CORS configuration allows requests from the frontend domain

### API Connection Issues

If the frontend cannot connect to the backend:

1. Verify that the `VITE_API_URL` environment variable is set to `https://taskms.greenhacker.tech/api`
2. Check that the backend is running and accessible
3. Test the API endpoints directly using a tool like Postman

## SSL Certificates

Railway automatically provisions SSL certificates for your custom domains. You don't need to manually configure SSL.
