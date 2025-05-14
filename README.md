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

#### Production

For production, set the environment variables in the Railway dashboard:

- `VITE_API_URL`: URL of your deployed backend API (e.g., `https://your-backend-service.railway.app/api`)

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

### Railway Deployment (Monorepo)

This project is configured for deployment as a monorepo on Railway. Follow these steps to deploy:

1. Push your code to a GitHub repository

2. Sign up or log in to [Railway](https://railway.app/)

3. Create a new project and select "Deploy from GitHub repo"

4. Select your repository

5. Configure the deployment settings:
   - Railway will automatically detect the monorepo structure
   - The root `railway.json` file contains the necessary configuration

6. Add environment variables in the Railway dashboard:
   - `PORT`: Port for the server (Railway will set this automatically)
   - `NODE_ENV`: Set to `production`
   - `MONGODB_URI`: MongoDB connection string
   - `JWT_SECRET`: Secret key for JWT token generation
   - `JWT_EXPIRATION`: Token expiration time (e.g., `7d`)
   - `GOOGLE_CLIENT_ID`: Your Google OAuth client ID
   - `GOOGLE_CLIENT_SECRET`: Your Google OAuth client secret
   - `FRONTEND_URL`: URL of your deployed frontend (will be your Railway app URL)
   - `VITE_API_URL`: URL of your API (e.g., `https://your-app-name.railway.app/api`)

7. Set up a MongoDB database:
   - Add a MongoDB database to your project
   - Railway will automatically add the connection string as an environment variable

8. Configure a custom domain (optional):
   - Go to the Settings tab in your Railway project
   - Add a custom domain for your application

Railway will automatically deploy your monorepo and keep it updated when you push changes to your repository.

#### Alternative: Deploying as Separate Services

If you encounter issues with the monorepo deployment, you can also deploy the frontend and backend as separate services:

1. Create two services in your Railway project:
   - One for the frontend (directory: `frontend`)
   - One for the backend (directory: `server`)

2. Configure environment variables for each service as described above

3. Link the MongoDB database to the backend service

## License

[MIT](LICENSE)
