# Task Manager - Separate Deployment Guide

This README provides instructions for deploying the frontend and backend components of the Task Manager application separately on Railway.

## Project Structure

The Task Manager application consists of two main components:

- `frontend/` - React frontend built with Vite, React, and Shadcn UI
- `server/` - Node.js backend with Express and MongoDB

## Why Separate Deployment?

Deploying the frontend and backend separately offers several advantages:

1. **Simplified Deployment Process**: Each component can be deployed and scaled independently
2. **Improved Reliability**: Issues with one component don't affect the other
3. **Better Resource Allocation**: Resources can be allocated based on the specific needs of each component
4. **Easier Maintenance**: Updates can be made to one component without affecting the other

## Prerequisites

- A GitHub repository with your Task Manager code
- A Railway account
- A MongoDB Atlas account (or use Railway's MongoDB plugin)

## Deployment Steps

### Backend Deployment

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
   - `FRONTEND_URL`: URL of your deployed frontend (will be your Railway frontend app URL)

3. **Set Up MongoDB**
   - Use Railway's MongoDB plugin or connect to MongoDB Atlas

### Frontend Deployment

1. **Create a New Railway Project for the Frontend**
   - Create another project in Railway
   - Select your repository
   - Set the root directory to `frontend/`

2. **Configure Environment Variables**
   - `VITE_API_URL`: URL of your deployed backend API (e.g., `https://your-backend-service.railway.app/api`)
   - `API_URL`: The same URL as above, used by the Nginx configuration

3. **Configure Custom Domain (Optional)**
   - Go to the Settings tab in your Railway project
   - Add a custom domain for your application

## Connecting the Frontend and Backend

After deploying both services, update the `VITE_API_URL` environment variable in the frontend project to point to your backend URL.

## Verifying the Deployment

1. Visit your frontend URL to verify that the application is running correctly
2. Test the login functionality to ensure the backend connection is working
3. Check the logs in Railway for any errors

## Troubleshooting

### CORS Issues

If you encounter CORS issues:

1. Ensure the `FRONTEND_URL` environment variable in the backend project is set correctly
2. Check that the backend's CORS configuration allows requests from the frontend domain

### API Connection Issues

If the frontend cannot connect to the backend:

1. Verify that the `VITE_API_URL` environment variable is set correctly
2. Check that the backend is running and accessible
3. Test the API endpoints directly using a tool like Postman

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [Vite Deployment Guide](https://vitejs.dev/guide/static-deploy.html)
- [Nginx Documentation](https://nginx.org/en/docs/)
