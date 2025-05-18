#!/bin/bash

# Task Manager Deployment Script for Railway (Backend) and Netlify (Frontend)
# This script automates the deployment process for both services

# Exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print section header
section() {
  echo -e "\n${YELLOW}==== $1 ====${NC}\n"
}

# Print success message
success() {
  echo -e "${GREEN}✓ $1${NC}"
}

# Print error message
error() {
  echo -e "${RED}✗ $1${NC}"
  exit 1
}

# Check if required tools are installed
check_requirements() {
  section "Checking Requirements"
  
  # Check Node.js
  if ! command -v node &> /dev/null; then
    error "Node.js is not installed. Please install Node.js v14 or higher."
  fi
  NODE_VERSION=$(node -v | cut -d 'v' -f 2)
  echo "Node.js version: $NODE_VERSION"
  
  # Check npm
  if ! command -v npm &> /dev/null; then
    error "npm is not installed. Please install npm."
  fi
  NPM_VERSION=$(npm -v)
  echo "npm version: $NPM_VERSION"
  
  success "All requirements satisfied"
}

# Install CLI tools
install_cli_tools() {
  section "Installing CLI Tools"
  
  echo "Installing Railway CLI..."
  npm install --save-dev @railway/cli
  
  echo "Installing Netlify CLI..."
  npm install --save-dev netlify-cli
  
  success "CLI tools installed"
}

# Deploy backend to Railway
deploy_backend() {
  section "Deploying Backend to Railway"
  
  echo "Logging in to Railway..."
  npx railway login
  
  echo "Deploying server to Railway..."
  cd server
  npx railway up
  
  echo "Getting Railway app URL..."
  RAILWAY_URL=$(npx railway status | grep -o 'https://.*\.railway\.app')
  
  if [ -z "$RAILWAY_URL" ]; then
    echo "Could not automatically determine Railway URL."
    echo "Please enter your Railway app URL (e.g., https://your-app.up.railway.app):"
    read RAILWAY_URL
  fi
  
  echo "Railway app URL: $RAILWAY_URL"
  cd ..
  
  success "Backend deployed to Railway"
  
  # Return to project root
  return 0
}

# Update frontend configuration
update_frontend_config() {
  section "Updating Frontend Configuration"
  
  echo "Updating frontend environment variables..."
  
  # Create or update .env.production file
  cat > frontend/.env.production << EOF
# API Configuration for Railway backend and Netlify frontend deployment
VITE_API_URL=${RAILWAY_URL}/api

# Set this to false in production
VITE_DEBUG_MODE=false
EOF
  
  success "Frontend configuration updated"
}

# Deploy frontend to Netlify
deploy_frontend() {
  section "Deploying Frontend to Netlify"
  
  echo "Logging in to Netlify..."
  npx netlify login
  
  echo "Building frontend..."
  cd frontend
  npm run build
  
  echo "Deploying to Netlify..."
  npx netlify deploy --prod
  
  # Get Netlify URL
  NETLIFY_URL=$(npx netlify status | grep -o 'https://.*\.netlify\.app')
  
  if [ -z "$NETLIFY_URL" ]; then
    echo "Could not automatically determine Netlify URL."
    echo "Please enter your Netlify app URL (e.g., https://your-app.netlify.app):"
    read NETLIFY_URL
  fi
  
  echo "Netlify app URL: $NETLIFY_URL"
  cd ..
  
  success "Frontend deployed to Netlify"
  
  # Return to project root
  return 0
}

# Update CORS settings in Railway
update_cors_settings() {
  section "Updating CORS Settings"
  
  echo "Updating FRONTEND_URL environment variable in Railway..."
  npx railway vars set FRONTEND_URL=$NETLIFY_URL
  
  success "CORS settings updated"
}

# Main deployment process
main() {
  echo -e "${GREEN}==================================================${NC}"
  echo -e "${GREEN}  Task Manager Deployment: Railway + Netlify${NC}"
  echo -e "${GREEN}==================================================${NC}"
  
  check_requirements
  install_cli_tools
  deploy_backend
  update_frontend_config
  deploy_frontend
  update_cors_settings
  
  echo -e "\n${GREEN}==================================================${NC}"
  echo -e "${GREEN}  Deployment Complete!${NC}"
  echo -e "${GREEN}==================================================${NC}"
  echo -e "\nBackend URL: ${YELLOW}$RAILWAY_URL${NC}"
  echo -e "Frontend URL: ${YELLOW}$NETLIFY_URL${NC}"
  echo -e "\nVisit the frontend URL to access your application."
}

# Run the main function
main
