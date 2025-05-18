#!/bin/bash

# Build script for Render deployment
# This script builds the server and frontend separately to avoid circular dependencies

# Exit on error
set -e

echo "=== Building for Render Deployment ==="
echo ""

# Build server first
echo "Building server..."
cd server
npm install
npm run build
echo "✅ Server build complete"
echo ""

# Build frontend
echo "Building frontend..."
cd ../frontend
npm install
echo "Installing Vite globally..."
npm install -g vite
echo "Running Vite build directly (skipping TypeScript)..."
# Skip TypeScript compilation and use Vite's build:skip-ts script
npm run build:skip-ts
echo "✅ Frontend build complete"
echo ""

echo "=== Build Complete ==="
echo "The application is now ready to start."
