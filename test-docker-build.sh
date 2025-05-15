#!/bin/bash

# Make the script exit on any error
set -e

echo "Building Docker image..."
docker build -t task-manager:test .

echo "Docker build successful!"
echo "Running container for testing..."

# Run the container with the necessary environment variables
docker run --rm -it \
  -p 5001:5001 \
  -e PORT=5001 \
  -e NODE_ENV=production \
  -e MONGODB_URI="mongodb+srv://hhirawat2006:zQSgH9Vwn3Lv31Qq@cluster0.k4676lk.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0" \
  -e JWT_SECRET="701c146431312c5a0f888863ccdae2f551ef9e29da4deb1403a521827c88a039" \
  -e JWT_EXPIRATION="7d" \
  -e FRONTEND_URL="https://taskm.greenhacker.tech" \
  task-manager:test

echo "Container started. Press Ctrl+C to stop."
