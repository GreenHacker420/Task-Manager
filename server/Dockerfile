FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application code
COPY . .

# Set environment variables
ENV NODE_ENV=production
ENV PORT=5001

# Expose the port
EXPOSE 5001

# Start the application
CMD ["node", "server.js"]
