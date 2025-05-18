#!/bin/bash

# Test script for monorepo deployment
# This script builds and runs the monorepo locally

# Exit on error
set -e

echo "=== Testing Monorepo Deployment ==="
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

# Build frontend
echo "Building frontend..."
npm run build:frontend
echo "✅ Frontend built"
echo ""

# Start server in production mode
echo "Starting server in production mode..."
echo "Press Ctrl+C to stop the server"
echo ""
cd server && NODE_ENV=production npm start
