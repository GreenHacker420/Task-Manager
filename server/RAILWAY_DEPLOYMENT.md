# Server Deployment Guide for Railway

This guide provides step-by-step instructions for deploying the Task Manager backend server to Railway with the custom domain https://taskms.greenhacker.tech.

## Prerequisites

- A GitHub repository with your Task Manager code
- A Railway account
- A MongoDB Atlas account (or use Railway's MongoDB plugin)

## Deployment Steps

### 1. Prepare Your Repository

Ensure your repository has the following structure and files in the server directory:

```
server/
├── Dockerfile
├── .dockerignore
├── package.json
├── server.js
└── other server files...
```

### 2. Create a New Railway Project

1. Sign up or log in to [Railway](https://railway.app/)
2. Click "New Project" and select "Deploy from GitHub repo"
3. Select your repository
4. Configure the deployment settings:
   - Set the root directory to `server/`
   - Railway will use the `server/Dockerfile` for building the container

### 3. Configure Environment Variables

In your Railway project dashboard, add the following environment variables:

- `PORT`: 5001 (Railway will override this, but it's good to set it)
- `NODE_ENV`: production
- `MONGODB_URI`: Your MongoDB connection string
- `JWT_SECRET`: A strong random string for JWT token generation
- `JWT_EXPIRATION`: 7d (or your preferred token expiration time)
- `GOOGLE_CLIENT_ID`: Your Google OAuth client ID
- `GOOGLE_CLIENT_SECRET`: Your Google OAuth client secret
- `FRONTEND_URL`: https://taskm.greenhacker.tech

### 4. Set Up MongoDB

#### Option 1: Use Railway's MongoDB Plugin

1. In your Railway project, go to the "Plugins" tab
2. Add the MongoDB plugin
3. Railway will automatically add the connection string as an environment variable

#### Option 2: Use MongoDB Atlas

1. Create a cluster in MongoDB Atlas
2. Create a database user with appropriate permissions
3. Get your connection string from MongoDB Atlas
4. Add the connection string as the `MONGODB_URI` environment variable in Railway

### 5. Set Up Custom Domain

1. Go to the Settings tab in your Railway project
2. Click on "Custom Domain"
3. Enter your domain: `taskms.greenhacker.tech`
4. Railway will provide you with a CNAME record to add to your DNS settings
5. Add this CNAME record with your domain provider
6. Wait for DNS propagation (can take up to 24-48 hours, but usually much faster)

### 6. Verify Deployment

1. Once deployed, Railway will provide a URL for your application
2. Visit `https://taskms.greenhacker.tech/health` to verify that your server is running correctly
3. Check the logs in Railway for any errors

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Check the build logs in Railway
2. Ensure your Dockerfile is correctly configured
3. Verify that all required files are being copied to the container

### Connection Issues

If you can't connect to your server:

1. Check that the server is running (view logs in Railway)
2. Verify that your custom domain is properly configured
3. Test the API endpoints directly using a tool like Postman

### MongoDB Connection Issues

If the server can't connect to MongoDB:

1. Verify that the `MONGODB_URI` environment variable is set correctly
2. Check that your MongoDB instance is running and accessible
3. Ensure that the MongoDB user has the correct permissions

## Monitoring and Maintenance

- Regularly check the Railway dashboard for logs and performance metrics
- Set up alerts for application errors
- Consider setting up a CI/CD pipeline for automated deployments

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
