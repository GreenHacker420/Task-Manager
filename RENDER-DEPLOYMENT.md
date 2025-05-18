# Deploying Task Manager to Render

This guide provides step-by-step instructions for deploying your Task Manager application to Render as a monorepo.

## Why Render?

Render is an excellent platform for deploying monorepo applications because:

1. **Unified Deployment**: Deploy your entire application as a single service
2. **Automatic Deployments**: Connects directly to your GitHub repository
3. **Free MongoDB Database**: Includes a free MongoDB database
4. **Custom Domains**: Easy setup for custom domains with automatic HTTPS
5. **Free SSL**: Automatic SSL certificate management
6. **Competitive Pricing**: Affordable pricing for production applications

## Prerequisites

Before deploying to Render, make sure you have:

1. A [Render account](https://render.com/)
2. Your Task Manager repository pushed to GitHub or GitLab
3. Your code prepared for monorepo deployment (which we've already done)

## Deployment Steps

### 1. Manual Deployment

#### Create a New Web Service

1. Log in to your [Render Dashboard](https://dashboard.render.com/)
2. Click "New" and select "Web Service"
3. Connect your GitHub or GitLab repository
4. Configure your web service:
   - **Name**: task-manager
   - **Environment**: Node
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`
   - **Plan**: Free (or select a paid plan for production)

#### Set Environment Variables

Add the following environment variables:

- `NODE_ENV`: production
- `PORT`: 5001
- `JWT_SECRET`: [generate a secure random string]
- `JWT_EXPIRATION`: 7d
- `MONGODB_URI`: [your MongoDB connection string]

If you're using Google OAuth, also add:
- `GOOGLE_CLIENT_ID`: [your Google client ID]
- `GOOGLE_CLIENT_SECRET`: [your Google client secret]

#### Create a MongoDB Database

1. In your Render Dashboard, click "New" and select "PostgreSQL" (Render doesn't offer MongoDB directly)
2. For MongoDB, you'll need to use MongoDB Atlas:
   - Create a free account at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
   - Create a new cluster
   - Set up a database user and password
   - Get your connection string
   - Add it as the `MONGODB_URI` environment variable in your Render web service

### 2. Blueprint Deployment (Recommended)

Render Blueprints allow you to define your infrastructure as code. We've created a `render.yaml` file for this purpose.

1. Push the `render.yaml` file to your repository
2. Go to the [Render Dashboard](https://dashboard.render.com/)
3. Click "New" and select "Blueprint"
4. Connect your repository
5. Render will automatically detect the `render.yaml` file and create the necessary resources

## Accessing Your Deployed Application

Once deployed, your application will be available at:
```
https://task-manager.onrender.com
```

(The actual URL will depend on the name you choose for your service)

## Custom Domain Setup (Optional)

To use a custom domain:

1. In your Render Dashboard, select your web service
2. Go to the "Settings" tab
3. Scroll down to "Custom Domain"
4. Click "Add Custom Domain"
5. Follow the instructions to configure your DNS settings

## Monitoring and Logs

### Viewing Logs

1. In your Render Dashboard, select your web service
2. Go to the "Logs" tab
3. You can view real-time logs or download historical logs

### Monitoring

Render provides basic monitoring for your application. For more advanced monitoring, consider integrating a third-party service like New Relic or Datadog.

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

As your application grows, you can scale your Render service:

1. In your Render Dashboard, select your web service
2. Go to the "Settings" tab
3. Under "Instance Type", select a larger instance
4. For high-availability, upgrade to a paid plan with multiple instances

## Cost Management

Render's pricing is based on the instance type and number of instances. To manage costs:

1. Start with the free plan for development and testing
2. Upgrade to a paid plan only when needed
3. Monitor your usage in the Render dashboard

## Additional Resources

- [Render Documentation](https://render.com/docs)
- [Render Status Page](https://status.render.com/)
- [Render Blog](https://render.com/blog)
- [Render Support](https://render.com/docs/support)
