#!/bin/bash

# Task Manager Deployment Script
# This script helps with deploying the Task Manager application

# Exit on error
set -e

# Display help message
show_help() {
  echo "Task Manager Deployment Script"
  echo ""
  echo "Usage: ./deploy.sh [option]"
  echo ""
  echo "Options:"
  echo "  build-frontend    Build the frontend for production"
  echo "  build-backend     Install production dependencies for backend"
  echo "  build-docker      Build Docker containers (separate frontend/backend)"
  echo "  run-docker        Run Docker containers (separate frontend/backend)"
  echo "  stop-docker       Stop Docker containers (separate frontend/backend)"
  echo "  build-monorepo    Build monorepo Docker container"
  echo "  run-monorepo      Run monorepo Docker container"
  echo "  stop-monorepo     Stop monorepo Docker container"
  echo "  help              Show this help message"
  echo ""
}

# Build frontend
build_frontend() {
  echo "Building frontend for production..."
  cd frontend
  npm install
  npm run build
  echo "Frontend build complete. Files are in frontend/dist/"
}

# Build backend
build_backend() {
  echo "Installing backend production dependencies..."
  cd server
  npm install --production
  echo "Backend preparation complete."
}

# Build Docker containers
build_docker() {
  echo "Building Docker containers..."
  docker-compose build
  echo "Docker build complete."
}

# Run Docker containers
run_docker() {
  echo "Starting Docker containers..."
  docker-compose up -d
  echo "Docker containers are running."
  echo "Frontend: http://localhost:8080"
  echo "Backend: http://localhost:5001"
}

# Stop Docker containers
stop_docker() {
  echo "Stopping Docker containers..."
  docker-compose down
  echo "Docker containers stopped."
}

# Build monorepo Docker container
build_monorepo() {
  echo "Building monorepo Docker container..."
  docker-compose -f docker-compose.monorepo.yml build
  echo "Monorepo Docker build complete."
}

# Run monorepo Docker container
run_monorepo() {
  echo "Starting monorepo Docker container..."
  docker-compose -f docker-compose.monorepo.yml up -d
  echo "Monorepo Docker container is running."
  echo "Application: http://localhost:5001"
}

# Stop monorepo Docker container
stop_monorepo() {
  echo "Stopping monorepo Docker container..."
  docker-compose -f docker-compose.monorepo.yml down
  echo "Monorepo Docker container stopped."
}

# Main script logic
case "$1" in
  build-frontend)
    build_frontend
    ;;
  build-backend)
    build_backend
    ;;
  build-docker)
    build_docker
    ;;
  run-docker)
    run_docker
    ;;
  stop-docker)
    stop_docker
    ;;
  build-monorepo)
    build_monorepo
    ;;
  run-monorepo)
    run_monorepo
    ;;
  stop-monorepo)
    stop_monorepo
    ;;
  help|*)
    show_help
    ;;
esac
