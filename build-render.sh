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
echo "Running TypeScript compiler and Vite build directly..."
# Run TypeScript compiler and Vite build directly instead of using npm scripts
./node_modules/.bin/tsc && ./node_modules/.bin/vite build --emptyOutDir
echo "✅ Frontend build complete"
echo ""

echo "=== Build Complete ==="
echo "The application is now ready to start."
