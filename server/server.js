import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import morgan from 'morgan';
import mongoose from 'mongoose';

// Import routes
import authRoutes from './routes/auth.routes.js';
import googleAuthRoutes from './routes/google-auth.routes.js';
import userRoutes from './routes/user.routes.js';
import taskRoutes from './routes/task.routes.js';

// Load environment variables
dotenv.config();

// Initialize express app
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors({
  origin: function(origin, callback) {
    // Allow requests with no origin (like mobile apps, curl requests)
    if(!origin) return callback(null, true);

    const allowedOrigins = [
      process.env.FRONTEND_URL || 'http://localhost:8080',
      'https://task-manager-production.up.railway.app',
      'https://taskm.greenhacker.tech',
      'https://taskms.greenhacker.tech'
    ];

    if(allowedOrigins.indexOf(origin) !== -1 || process.env.NODE_ENV !== 'production') {
      callback(null, true);
    } else {
      console.log('CORS blocked request from:', origin);
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());
app.use(morgan('dev'));

// Connect to MongoDB
console.log('Attempting to connect to MongoDB...');
console.log('MongoDB URI format check:', process.env.MONGODB_URI ?
  `URI starts with: ${process.env.MONGODB_URI.substring(0, 10)}...` : 'MongoDB URI is not defined');

mongoose.connect(process.env.MONGODB_URI, {
  serverSelectionTimeoutMS: 5000, // Timeout after 5s instead of 30s
  socketTimeoutMS: 45000, // Close sockets after 45s of inactivity
})
  .then(() => console.log('MongoDB connected successfully'))
  .catch(err => {
    console.error('MongoDB connection error:', err);
    console.error('MongoDB connection error details:', JSON.stringify(err, null, 2));
    process.exit(1);
  });

// Debug middleware to log request body
app.use((req, res, next) => {
  console.log('Request Body:', req.body);
  next();
});

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/auth', googleAuthRoutes);
app.use('/api/users', userRoutes);
app.use('/api/tasks', taskRoutes);

// API root route
app.get('/api', (req, res) => {
  res.json({
    message: 'Welcome to Task Manager API',
    status: 'healthy',
    environment: process.env.NODE_ENV,
    timestamp: new Date().toISOString()
  });
});

// Health check endpoint for Railway
app.get('/health', (_req, res) => {
  res.status(200).json({
    status: 'ok',
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

// Serve static files from the frontend build directory in production
if (process.env.NODE_ENV === 'production') {
  import('path').then(path => {
    // Use fileURLToPath to correctly resolve __dirname in ESM
    import('url').then(({ fileURLToPath }) => {
      const __filename = fileURLToPath(import.meta.url);
      const __dirname = path.dirname(__filename);

      const frontendPath = path.resolve(__dirname, '../frontend/dist');
      console.log('Attempting to serve frontend from:', frontendPath);

      // Check if the directory exists
      import('fs').then(fs => {
        if (fs.existsSync(frontendPath)) {
          console.log('Frontend directory exists');
        } else {
          console.log('Frontend directory does not exist');
          // Try alternative paths
          const altPath = path.resolve(__dirname, '../../frontend/dist');
          console.log('Trying alternative path:', altPath);
          if (fs.existsSync(altPath)) {
            console.log('Alternative frontend directory exists');
            // Serve static files from alternative path
            app.use(express.static(altPath));
            // All GET requests not handled by API routes or static files will return the React app
            app.get('*', (req, res, next) => {
              // Skip API routes
              if (req.path.startsWith('/api')) {
                return next();
              }
              console.log('Serving React app for path (alt):', req.path);
              res.sendFile(path.resolve(altPath, 'index.html'));
            });
            return;
          }
        }

        // Serve static files from original path
        app.use(express.static(frontendPath));

        // All GET requests not handled by API routes or static files will return the React app
        app.get('*', (req, res, next) => {
          // Skip API routes
          if (req.path.startsWith('/api')) {
            return next();
          }
          console.log('Serving React app for path:', req.path);
          res.sendFile(path.resolve(frontendPath, 'index.html'));
        });
      }).catch(err => {
        console.error('Error checking frontend directory:', err);
      });
    }).catch(err => {
      console.error('Error importing url module:', err);
    });
  }).catch(err => {
    console.error('Error setting up static file serving:', err);
  });
}

// Test route
app.post('/api/test', (req, res) => {
  console.log('Test route hit with body:', req.body);
  res.json({
    message: 'Test route successful',
    receivedData: req.body
  });
});

// Error handling middleware
app.use((err, req, res, _next) => {
  console.error('Server error:', err.stack);
  res.status(500).json({
    message: err.message || 'Something went wrong on the server',
    error: process.env.NODE_ENV === 'development' ? err : {}
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
