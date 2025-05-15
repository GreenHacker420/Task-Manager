# Separate Deployment Guide for Task Manager

This guide provides instructions for deploying the frontend and backend components of the Task Manager application separately on Railway.

## Custom Domains

The application will be deployed to the following domains:

- Backend (Server): https://taskms.greenhacker.tech
- Frontend: https://taskm.greenhacker.tech

## Prerequisites

- A GitHub repository with your Task Manager code
- A Railway account
- A MongoDB Atlas account (or use Railway's MongoDB plugin)

## Backend Deployment

### 1. Create a New Railway Project for the Backend

1. Sign up or log in to [Railway](https://railway.app/)
2. Create a new project and select "Deploy from GitHub repo"
3. Select your repository
4. Configure the deployment settings:
   - Set the root directory to `server/`
   - Railway will use the `server/railway.json` file for configuration

### 2. Add Environment Variables for the Backend

In your Railway project dashboard, add the following environment variables:

- `PORT`: Port for the server (Railway will set this automatically)
- `NODE_ENV`: Set to `production`
- `MONGODB_URI`: MongoDB connection string
- `JWT_SECRET`: Secret key for JWT token generation
- `JWT_EXPIRATION`: Token expiration time (e.g., `7d`)
- `GOOGLE_CLIENT_ID`: Your Google OAuth client ID
- `GOOGLE_CLIENT_SECRET`: Your Google OAuth client secret
- `FRONTEND_URL`: URL of your deployed frontend (will be your Railway frontend app URL)

### 3. Set Up MongoDB

#### Option 1: Use Railway's MongoDB Plugin

1. In your Railway project, go to the "Plugins" tab
2. Add the MongoDB plugin
3. Railway will automatically add the connection string as an environment variable

#### Option 2: Use MongoDB Atlas

1. Create a cluster in MongoDB Atlas
2. Create a database user with appropriate permissions
3. Get your connection string from MongoDB Atlas
4. Add the connection string as the `MONGODB_URI` environment variable in Railway

## Frontend Deployment

### 1. Create a New Railway Project for the Frontend

1. Sign up or log in to [Railway](https://railway.app/)
2. Create a new project and select "Deploy from GitHub repo"
3. Select your repository
4. Configure the deployment settings:
   - Set the root directory to `frontend/`
   - Railway will use the `frontend/railway.json` file for configuration

### 2. Add Environment Variables for the Frontend

In your Railway project dashboard, add the following environment variables:

- `VITE_API_URL`: URL of your deployed backend API (e.g., `https://your-backend-service.railway.app/api`)
- `API_URL`: The same URL as above, used by the Nginx configuration

### 3. Configure Custom Domain (Optional)

1. Go to the Settings tab in your Railway project
2. Add a custom domain for your application

## Connecting the Frontend and Backend

1. After deploying both services, get the URL of your backend service from Railway
2. Update the `VITE_API_URL` environment variable in the frontend project to point to your backend URL
3. Redeploy the frontend if necessary

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

## Maintenance

- Regularly check the Railway dashboard for logs and performance metrics
- Set up alerts for application errors
- Consider setting up a CI/CD pipeline for automated deployments

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [Vite Deployment Guide](https://vitejs.dev/guide/static-deploy.html)
- [Nginx Documentation](https://nginx.org/en/docs/)
