#!/bin/bash

# Make the script exit on any error
set -e

echo "Cleaning up any previous builds..."
docker rm -f task-manager-test 2>/dev/null || true
docker rmi -f task-manager:test 2>/dev/null || true

echo "Building Docker image..."
docker build -t task-manager:test .

echo "Docker build successful!"
echo "Running container for testing..."

# Run the container with the necessary environment variables
docker run --name task-manager-test --rm -it \
  -p 5001:5001 \
  -e PORT=5001 \
  -e NODE_ENV=production \
  -e MONGODB_URI="mongodb+srv://hhirawat2006:zQSgH9Vwn3Lv31Qq@cluster0.k4676lk.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0" \
  -e JWT_SECRET="701c146431312c5a0f888863ccdae2f551ef9e29da4deb1403a521827c88a039" \
  -e JWT_EXPIRATION="7d" \
  -e FRONTEND_URL="https://taskm.greenhacker.tech" \
  -e VITE_API_URL="https://taskm.greenhacker.tech/api" \
  -e GOOGLE_CLIENT_ID="280618092403-i77ld1g47h4n1ta7shij4e4so5i22n7c.apps.googleusercontent.com" \
  -e GOOGLE_CLIENT_SECRET="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" \
  task-manager:test

echo "Container started. Press Ctrl+C to stop."
