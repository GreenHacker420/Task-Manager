# Deploying Task Manager to Railway

This guide provides step-by-step instructions for deploying your Task Manager application to Railway as a monorepo.

## Why Railway?

Railway is an excellent platform for deploying monorepo applications because:

1. **Monorepo Support**: Railway has excellent support for monorepo projects
2. **Automatic Deployments**: Connects directly to your GitHub repository
3. **Environment Variables**: Easy management of environment variables
4. **Database Integration**: One-click MongoDB provisioning
5. **Free Tier**: Generous free tier for development and small projects
6. **Custom Domains**: Easy setup for custom domains with automatic HTTPS

## Prerequisites

Before deploying to Railway, make sure you have:

1. A [Railway account](https://railway.app/)
2. Your Task Manager repository pushed to GitHub
3. MongoDB Atlas account (or use Railway's MongoDB plugin)

## Deployment Steps

### 1. Prepare Your Application

Your application is already configured for monorepo deployment with the following features:

- Frontend builds directly to the server's public directory
- Server serves static files in production mode
- Package.json scripts are set up for building both frontend and backend

### 2. Create a New Project on Railway

1. Log in to [Railway](https://railway.app/)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Select your Task Manager repository
5. Railway will automatically detect your configuration

### 3. Configure Environment Variables

In your Railway project, go to the "Variables" tab and add the following environment variables:

```
NODE_ENV=production
PORT=5001
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_strong_jwt_secret
JWT_EXPIRATION=7d
GOOGLE_CLIENT_ID=your_google_client_id (if using Google OAuth)
GOOGLE_CLIENT_SECRET=your_google_client_secret (if using Google OAuth)
```

### 4. Add MongoDB Database (Optional)

If you don't have a MongoDB Atlas database:

1. In your Railway project, click "New"
2. Select "Database" → "MongoDB"
3. Railway will provision a MongoDB instance
4. Go to the "Variables" tab of your main service
5. Click "Reference" and select the MongoDB connection string from your database service

### 5. Deploy Your Application

1. Railway will automatically deploy your application when you push changes to your repository
2. You can also manually trigger a deployment from the Railway dashboard

### 6. Set Up a Custom Domain (Optional)

1. In your Railway project, go to the "Settings" tab
2. Under "Domains", click "Generate Domain" for a railway.app subdomain
3. Or click "Custom Domain" to set up your own domain
4. Follow the DNS configuration instructions

## Monitoring and Maintenance

### Viewing Logs

1. In your Railway project, go to the "Deployments" tab
2. Click on a deployment to view logs

### Monitoring Performance

1. Railway provides basic metrics for your application
2. For more detailed monitoring, consider integrating a service like New Relic or Datadog

## Troubleshooting

### Common Issues

1. **Build Failures**:
   - Check the build logs for errors
   - Ensure all dependencies are correctly specified
   - Verify that the build scripts are correct

2. **Application Crashes**:
   - Check the logs for error messages
   - Verify that all environment variables are set correctly
   - Check MongoDB connection

3. **Frontend Not Loading**:
   - Verify that the frontend build is successful
   - Check that the server is correctly serving static files
   - Ensure the API URL is correctly set in the frontend

## Scaling Your Application

Railway makes it easy to scale your application:

1. **Vertical Scaling**: Increase resources for your service
   - Go to "Settings" → "Resources" and adjust CPU and memory

2. **Horizontal Scaling**: Add more instances of your service
   - This requires additional configuration and is available on paid plans

## Cost Management

Railway's pricing is based on usage. To manage costs:

1. Monitor your usage in the Railway dashboard
2. Set up spending limits
3. Consider upgrading to a paid plan for production applications

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [Railway Discord Community](https://discord.gg/railway)
- [Railway Status Page](https://status.railway.app/)
