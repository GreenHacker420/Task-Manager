#!/bin/bash

# Script to deploy only the server to Railway

echo "Starting Railway deployment for server only..."

# Ensure we're in the server directory
cd "$(dirname "$0")"

# Deploy to Railway
echo "Deploying server to Railway..."
railway up

echo "Railway deployment completed!"
