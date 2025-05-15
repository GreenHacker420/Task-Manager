# Use Node.js 18 as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy server files
COPY . .

# Install dependencies
RUN npm install --only=production

# Expose port
EXPOSE 5001

# Start server
CMD ["node", "server.js"]
