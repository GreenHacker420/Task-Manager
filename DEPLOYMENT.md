# Task Manager Deployment Guide

This guide provides detailed instructions for deploying the Task Manager application on Railway.

## Prerequisites

- A GitHub repository with your Task Manager code
- A Railway account
- A MongoDB Atlas account (or use Railway's MongoDB plugin)

## Deployment Steps

### 1. Prepare Your Repository

Ensure your repository has the following structure and files:

```
task-manager/
├── frontend/
├── server/
├── package.json
├── railway.json
├── Procfile
└── .env.production (for reference, don't commit this)
```

### 2. Configure Environment Variables

Create a `.env.production` file in your local repository (for reference only, don't commit this):

```
# Server Configuration
PORT=5001
NODE_ENV=production

# MongoDB Connection
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/task-manager?retryWrites=true&w=majority

# JWT Configuration
JWT_SECRET=your_production_jwt_secret_key
JWT_EXPIRATION=7d

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# Frontend URL (for CORS)
FRONTEND_URL=https://your-app-name.railway.app

# API URL for frontend
VITE_API_URL=https://your-app-name.railway.app/api
```

### 3. Deploy to Railway

1. Sign up or log in to [Railway](https://railway.app/)
2. Create a new project and select "Deploy from GitHub repo"
3. Select your repository
4. Configure the deployment settings:
   - Railway will automatically detect the monorepo structure
   - The root `railway.json` file contains the necessary configuration

### 4. Add Environment Variables in Railway

In your Railway project dashboard, add the following environment variables:

- `PORT`: Port for the server (Railway will set this automatically)
- `NODE_ENV`: Set to `production`
- `MONGODB_URI`: MongoDB connection string
- `JWT_SECRET`: Secret key for JWT token generation
- `JWT_EXPIRATION`: Token expiration time (e.g., `7d`)
- `GOOGLE_CLIENT_ID`: Your Google OAuth client ID
- `GOOGLE_CLIENT_SECRET`: Your Google OAuth client secret
- `FRONTEND_URL`: URL of your deployed frontend (will be your Railway app URL)
- `VITE_API_URL`: URL of your API (e.g., `https://your-app-name.railway.app/api`)

### 5. Set Up MongoDB

#### Option 1: Use Railway's MongoDB Plugin

1. In your Railway project, go to the "Plugins" tab
2. Add the MongoDB plugin
3. Railway will automatically add the connection string as an environment variable

#### Option 2: Use MongoDB Atlas

1. Create a cluster in MongoDB Atlas
2. Create a database user with appropriate permissions
3. Get your connection string from MongoDB Atlas
4. Add the connection string as the `MONGODB_URI` environment variable in Railway

### 6. Verify Deployment

1. Once deployed, Railway will provide a URL for your application
2. Visit the URL to verify that your application is running correctly
3. Check the logs in Railway for any errors

## Troubleshooting

### Memory Issues (Error Code 137)

If you see error code 137 in your logs, your application is being terminated due to memory limits:

1. Make sure you're only running the server in production, not both server and frontend
2. Check for memory leaks in your application
3. Consider upgrading your Railway plan for more resources

### MongoDB Connection Issues

If you're having trouble connecting to MongoDB:

1. Verify that your MongoDB connection string is correct
2. Check if your IP is whitelisted in MongoDB Atlas (if using Atlas)
3. Ensure your MongoDB user has the correct permissions

### Node.js Version Issues

The application requires Node.js >=16.20.1 due to MongoDB dependencies. Railway should automatically use the correct version based on the `engines` field in your package.json.

## Monitoring and Maintenance

- Regularly check the Railway dashboard for logs and performance metrics
- Set up alerts for application errors
- Consider setting up a CI/CD pipeline for automated deployments

## Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
