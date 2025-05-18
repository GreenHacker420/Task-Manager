# Task Manager Deployment Guide: Railway (Backend) and Netlify (Frontend)

This guide provides step-by-step instructions for deploying the Task Manager application with the backend on Railway and the frontend on Netlify.

## Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)
- MongoDB Atlas account (for production database)
- Railway account (https://railway.app)
- Netlify account (https://netlify.com)

## Step 1: Prepare Your MongoDB Database

1. Create a MongoDB Atlas cluster if you don't have one already
2. Create a database named `task-manager`
3. Create a database user with read/write permissions
4. Get your MongoDB connection string from Atlas

## Step 2: Deploy Backend to Railway

### Install Railway CLI

```bash
# Install Railway CLI locally in the project
npm install --save-dev @railway/cli
```

### Login to Railway

```bash
# Login to Railway
npx railway login
```

### Create a New Railway Project

```bash
# Create a new project
npx railway init
```

### Configure Environment Variables

1. Set up the required environment variables in Railway:

```bash
# Set environment variables
npx railway vars set PORT=5001
npx railway vars set NODE_ENV=production
npx railway vars set MONGODB_URI=mongodb+srv://your_username:your_password@your_cluster.mongodb.net/task-manager?retryWrites=true&w=majority
npx railway vars set JWT_SECRET=your_strong_production_jwt_secret_key
npx railway vars set JWT_EXPIRATION=7d
npx railway vars set FRONTEND_URL=https://your-netlify-app.netlify.app
```

2. If using Google OAuth, also set:

```bash
npx railway vars set GOOGLE_CLIENT_ID=your_production_google_client_id
npx railway vars set GOOGLE_CLIENT_SECRET=your_production_google_client_secret
```

### Deploy to Railway

```bash
# Navigate to the server directory
cd server

# Deploy to Railway
npx railway up
```

### Get Your Railway App URL

1. After deployment, get your Railway app URL:

```bash
npx railway status
```

2. Note the URL for configuring the frontend

## Step 3: Deploy Frontend to Netlify

### Install Netlify CLI

```bash
# Install Netlify CLI locally in the project
npm install --save-dev netlify-cli
```

### Login to Netlify

```bash
# Login to Netlify
npx netlify login
```

### Update Frontend Environment Variables

1. Update the `.env.production` file in the frontend directory:

```
VITE_API_URL=https://your-railway-app-url.up.railway.app/api
```

2. If using Google OAuth, also set:

```
VITE_GOOGLE_CLIENT_ID=your_production_google_client_id
```

### Build and Deploy to Netlify

```bash
# Navigate to the frontend directory
cd frontend

# Build the frontend
npm run build

# Deploy to Netlify
npx netlify deploy --prod
```

### Configure Netlify Site Settings

1. Set up a custom domain (optional)
2. Enable HTTPS
3. Configure build settings (if needed for future deployments):
   - Build command: `npm run build`
   - Publish directory: `dist`

## Step 4: Update CORS Settings

After deploying both services, update the CORS configuration in the backend to allow requests from your Netlify domain:

1. Add your Netlify domain to the allowed origins in the Railway environment variables:

```bash
npx railway vars set FRONTEND_URL=https://your-netlify-app.netlify.app
```

## Step 5: Verify Deployment

1. Test the backend API:
   - Visit `https://your-railway-app.up.railway.app/health` to check the health endpoint
   - Visit `https://your-railway-app.up.railway.app/api` to see the API welcome message

2. Test the frontend:
   - Visit your Netlify URL
   - Try to register/login
   - Create and manage tasks

## Troubleshooting

### Backend Issues

1. Check Railway logs:
```bash
npx railway logs
```

2. Verify environment variables:
```bash
npx railway vars
```

3. Restart the service:
```bash
npx railway service restart
```

### Frontend Issues

1. Check Netlify deploy logs:
```bash
npx netlify deploy:list
```

2. Check browser console for CORS or API connection errors
3. Verify the API URL in the frontend environment variables

## Continuous Deployment

### Railway CI/CD

1. Connect your GitHub repository to Railway
2. Configure automatic deployments on push to main branch

### Netlify CI/CD

1. Connect your GitHub repository to Netlify
2. Configure build settings:
   - Base directory: `frontend`
   - Build command: `npm run build`
   - Publish directory: `dist`

## Useful Commands

### Railway Commands

```bash
# List all services
npx railway service list

# View service logs
npx railway logs

# Open Railway dashboard
npx railway open

# Deploy latest changes
npx railway up
```

### Netlify Commands

```bash
# Open Netlify dashboard
npx netlify open

# Deploy preview
npx netlify deploy

# Deploy production
npx netlify deploy --prod

# View deploy status
npx netlify status
```

## Security Considerations

1. Use strong, unique passwords for all services
2. Keep your JWT secret secure and rotate it periodically
3. Enable two-factor authentication for Railway and Netlify accounts
4. Regularly update dependencies to patch security vulnerabilities
5. Monitor your application for unusual activity
