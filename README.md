# Furniture Store — Server

This folder contains the back-end server for the Furniture Store graduation project. It's an Express.js application with MongoDB via Mongoose, REST endpoints for authentication and product creation, and a GraphQL API for querying products and users. It also includes Socket.IO for realtime features (chat/notifications) and EJS views for some admin pages.

**Contents**

- `app.js` — main Express application and server bootstrap
- `package.json` — project dependencies and start script
- `routes/` — REST route definitions (auth, product, chat)
- `controllers/` — controller logic for routes (authentication, product creation, etc.)
- `graphql/` — GraphQL `schema` and `resolvers`
- `models/` — Mongoose models (`User`, `Product`, ...)
- `socketio/` — Socket.IO setup and helpers
- `middleware/` — authentication and other middleware
- `public/`, `views/`, `images/` — static assets and server-rendered views

**Prerequisites**

- Node.js 18+ (or compatible LTS)
- npm
- A MongoDB database (Atlas connection string or local MongoDB)

Getting started

1. Install dependencies

```bash
cd server
npm install
```

2. Configure environment

This project contains some hard-coded secrets (for development). Before running in production, replace the secrets with secure environment variables. The important configuration values you should provide (recommended via environment variables):

- `PORT` — port to run the server (default: `3000`)
- `MONGODB_URL` — MongoDB connection URI (the code uses a hard-coded Atlas URI by default; replace it)
- `JWT_SECRET` — JSON Web Token secret (the code currently uses a hard-coded string `thisisaverylong`)
- Email credentials — the project currently configures a Gmail transporter with username and app password inside `controllers/auth.js`. Replace with environment-managed credentials or use a SendGrid transport.

Example (Linux / macOS):

```bash
export PORT=3000
export MONGODB_URL="your-mongodb-uri"
export JWT_SECRET="a-very-secure-secret"
```

3. Run the server (development)

```bash
npm start
```

What the server provides

- REST endpoints (see `routes/`):
  - `PUT /auth/signup` — create a new user (expects user data in the request body)
  - `POST /auth/login` — login; returns a JWT token
  - `GET /auth/verify/:token` — email verification endpoint used in signup flow
  - `POST /product/create-product` — create a new product; requires authentication (middleware `is-auth`) and multipart form-data with up to 2 images. `details` should be sent as a JSON string in the form field `details`.

- GraphQL API:
  - Endpoint: `/graphql` (protected by the `isAuth` middleware)
  - Playground available at `/playground`
  - Schema highlights (see `graphql/schema.js`): `products(page: Int)`, `product(id: ID!)`, `user(id: ID!)` and `hello`.

- Chat, AI image generation & in-house ML integration:
  - `routes/chat` and the `socketio/` folder implement a custom realtime chat feature built for this project.
  - Socket.IO handlers (`socketio/socket.js` and `socketio/socketHelper.js`) power realtime messaging, presence, and events; the chat can send/receive data alongside GraphQL queries where needed.
  - The chat integrates with an AI image-generation service and an in-house machine learning model (used to generate or process images/features). See `socketio/` and `utils/` for connectors and helper code that call the AI/ML services.
  - Ensure any API keys or model endpoints used by the AI image generation or your ML model are configured via environment variables and not committed to source.

Data models

- `User` (see `models/user.js`): `firstName`, `lastName`, `username`, `email`, `password`, `isConfirmed`, tokens for email confirmation and password reset, arrays for `products` and `wishList`.
- `Product` (see `models/product.js`): `creator` (User ref), `title`, `price`, `description`, `images` (array of image objects with `imageUrl`), `details` (wood, cloth, condition, color, delevary, negotiable, modefiable), `rate`.

Notes & Security

- Several secrets (MongoDB URI, JWT secret, email credentials) are currently hard-coded in source files. Move them to environment variables for security.
- The email transporter in `controllers/auth.js` uses a Gmail account and a plaintext app password. Replace with a secure transport or environment-managed secrets.
- The GraphQL endpoint is protected by `isAuth` middleware; some REST routes are public (signup/login) while product creation requires an authenticated user.

Useful files to inspect

- `app.js` — server setup, CORS headers, multer file upload setup, Socket.IO bootstrap
- `controllers/auth.js` — signup, login, email verification, reset password flow
- `controllers/product.js` — product creation route; expects `details` as JSON string and `images` in `req.files`
- `graphql/schema.js` and `graphql/resolvers.js` — GraphQL types and resolvers
- `routes/chat.js` — chat REST/WS route registration
- `socketio/socket.js` and `socketio/socketHelper.js` — Socket.IO initialization and event handlers (chat + realtime integrations)
- `utils/` — helpers and any connectors to AI services or the in-house ML model

TODO / Improvements

- Move secrets to environment variables
- Improve image handling (resize/compression) and storage (S3 / Firebase) instead of local disk
- Add proper tests and input sanitization
- Add rate-limiting, input size limits, and stricter CORS rules for production

If you'd like, I can:

- Replace hard-coded secrets with environment variables and update `app.js` and `controllers/auth.js` to read them.
- Add a simple `.env.example` listing required variables.
- Create Postman examples or a short API reference file.

---

Generated by GitHub Copilot assistant — let me know which follow-up action you want.
