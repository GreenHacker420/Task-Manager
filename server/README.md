# Task Manager Backend

This is the backend server for the Task Manager application. It provides API endpoints for user authentication, task management, and user profile management.

## Technologies Used

- Node.js
- Express.js
- MongoDB (with Mongoose)
- JWT for authentication
- bcryptjs for password hashing

## Prerequisites

- Node.js (v14 or higher)
- MongoDB (local installation or MongoDB Atlas)

## Getting Started

1. Clone the repository
2. Navigate to the server directory
3. Install dependencies
4. Set up environment variables
5. Start the server

```bash
# Install dependencies
npm install

# Start the development server
npm run dev

# Start the production server
npm start
```

## Environment Variables

Create a `.env` file in the server directory with the following variables:

```
PORT=5001
MONGODB_URI=mongodb://localhost:27017/task-manager
JWT_SECRET=your_jwt_secret_key_change_in_production
NODE_ENV=development
JWT_EXPIRATION=7d
```

## API Endpoints

### Authentication

- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login and get JWT token

### User Management

- `GET /api/users/me` - Get current user profile
- `PUT /api/users/me` - Update user profile
- `PUT /api/users/password` - Change user password

### Task Management

- `GET /api/tasks` - Get all tasks (with optional filters)
- `GET /api/tasks/:id` - Get a specific task by ID
- `POST /api/tasks` - Create a new task
- `PUT /api/tasks/:id` - Update a task
- `DELETE /api/tasks/:id` - Delete a task

### Subtask Management

- `POST /api/tasks/:id/subtasks` - Add a subtask to a task
- `PUT /api/tasks/:taskId/subtasks/:subtaskId` - Update a subtask
- `DELETE /api/tasks/:taskId/subtasks/:subtaskId` - Delete a subtask

## Data Models

### User Model

```javascript
{
  name: String,
  email: String,
  password: String (hashed),
  avatar: String,
  createdAt: Date,
  updatedAt: Date
}
```

### Task Model

```javascript
{
  title: String,
  description: String,
  status: String (enum: 'Draft', 'In Progress', 'Editing', 'Done'),
  type: String (enum: 'Main Task', 'Secondary Task', 'Tertiary Task'),
  progress: Number,
  subtasks: Array of Subtask objects,
  tags: Array of Strings,
  priority: String (enum: 'Low', 'Medium', 'High', 'Urgent'),
  comments: Number,
  files: Number,
  starred: Boolean,
  dueDate: Date,
  createdAt: Date,
  assignedTo: User reference,
  createdBy: User reference,
  category: String,
  timeTracking: {
    timeSpent: Number,
    isRunning: Boolean,
    lastStarted: Date
  }
}
```

### Subtask Model (embedded in Task)

```javascript
{
  text: String,
  completed: Boolean,
  authorId: User reference
}
```

## Authentication

The API uses JWT (JSON Web Tokens) for authentication. To access protected endpoints, include the JWT token in the Authorization header:

```
Authorization: Bearer <your_jwt_token>
```

## Error Handling

The API returns appropriate HTTP status codes and error messages:

- 200 - OK
- 201 - Created
- 400 - Bad Request
- 401 - Unauthorized
- 403 - Forbidden
- 404 - Not Found
- 500 - Server Error

## Connecting with Frontend

The frontend is configured to connect to this backend at `http://localhost:5001/api`. Make sure the backend is running before using the frontend application.

## Development

For development, the server uses nodemon to automatically restart when changes are detected.

```bash
npm run dev
```
