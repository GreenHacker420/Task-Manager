#!/bin/bash

# Render Deployment Helper Script
# This script helps prepare your application for Render deployment

# Exit on error
set -e

echo "=== Preparing for Render Deployment ==="
echo ""

# Clean up previous builds
echo "Cleaning up previous builds..."
npm run clean
echo "✅ Clean up complete"
echo ""

# Install dependencies
echo "Installing dependencies..."
npm install
echo "✅ Dependencies installed"
echo ""

# Build frontend and backend
echo "Building application..."
npm run build
echo "✅ Build complete"
echo ""

echo "=== Deployment Preparation Complete ==="
echo ""
echo "Your application is now ready for deployment to Render."
echo "Follow these steps to deploy:"
echo ""
echo "1. Push your changes to GitHub or GitLab"
echo "2. Log in to your Render account"
echo "3. Create a new Web Service and connect your repository"
echo "4. Use the following settings:"
echo "   - Build Command: npm install && npm run build"
echo "   - Start Command: npm start"
echo "5. Set up your environment variables"
echo "6. Deploy your application"
echo ""
echo "For more detailed instructions, see RENDER-DEPLOYMENT.md"
