# Task Manager

A full-stack task management application with a React frontend and Node.js backend.

## Project Structure

This is a monorepo containing both the frontend and backend components of the Task Manager application:

- `frontend/` - React frontend built with Vite, React, and Shadcn UI
- `server/` - Node.js backend with Express and MongoDB

## Technologies Used

### Frontend
- React 18
- TypeScript
- Vite
- Tailwind CSS
- Shadcn UI components
- React Router
- React Query
- React Hook Form with Zod validation

### Backend
- Node.js
- Express.js
- MongoDB with Mongoose
- JWT for authentication
- Google OAuth integration

## Prerequisites

- Node.js (v14 or higher)
- MongoDB (local installation or MongoDB Atlas)
- npm or yarn

## Getting Started

### Clone the repository

```bash
git clone <repository-url>
cd task-manager
```

### Backend Setup

1. Navigate to the server directory:
```bash
cd server
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file based on the `.env.example` template:
```bash
cp .env.example .env
```

4. Update the `.env` file with your configuration values.

5. Start the development server:
```bash
npm run dev
```

The server will run on http://localhost:5001 by default.

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

The frontend will run on http://localhost:8080 by default.

## Environment Variables

### Backend (.env file in server directory)

```
# Server Configuration
PORT=5001
NODE_ENV=development

# MongoDB Connection
MONGODB_URI=mongodb://localhost:27017/task-manager

# JWT Configuration
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRATION=7d

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# Frontend URL (for CORS)
FRONTEND_URL=http://localhost:8080
```

### Frontend (.env files in frontend directory)

#### Development (.env.development)

```
VITE_API_URL=http://localhost:5001/api
```

#### Production (.env.production)

```
VITE_API_URL=https://your-backend-api-url/api
```

## Features

- User authentication (JWT)
- Google OAuth login
- Task management (create, read, update, delete)
- User profile management
- Responsive UI

## Development

### Running Both Services

You can run both the frontend and backend concurrently using separate terminal windows.

### Building for Production

#### Backend
```bash
cd server
npm start
```

#### Frontend
```bash
cd frontend
npm run build
```

The frontend build output will be in the `frontend/dist` directory, which can be served by any static file server.

## Deployment

This project is configured for monorepo deployment, where both frontend and backend are deployed together. For detailed deployment instructions, see the [RAILWAY-DEPLOYMENT.md](RAILWAY-DEPLOYMENT.md) guide.

### Recommended Deployment: Railway

We recommend deploying this application to [Railway](https://railway.app/), which offers excellent support for monorepo projects:

1. Connect your GitHub repository to Railway
2. Railway will automatically detect the configuration
3. Set up your environment variables
4. Deploy with a single click

For step-by-step instructions, see the [RAILWAY-DEPLOYMENT.md](RAILWAY-DEPLOYMENT.md) guide.

### Testing Monorepo Locally

To test the monorepo setup locally:

```bash
# Run the test script
./test-monorepo.sh
```

This will build the frontend, place it in the server's public directory, and start the server in production mode.

### Alternative Deployment Options

The project also includes configurations for other deployment options:

1. **Docker Deployment**:
   ```bash
   # Build and run with Docker Compose
   docker-compose -f docker-compose.monorepo.yml up -d
   ```

2. **Heroku Deployment**:
   - The project includes a Procfile for Heroku deployment
   - Follow the instructions in the deployment guide

### Production Environment Setup

Before deploying to production, make sure to:

1. Set up proper environment variables (see `.env.production.example`)
2. Configure a production MongoDB database (MongoDB Atlas recommended)
3. Set a strong JWT secret
4. Enable HTTPS for all communication
5. Set up monitoring and logging

## License

[MIT](LICENSE)
