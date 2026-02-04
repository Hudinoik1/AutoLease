# Production Dockerfile for React App
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build static assets
RUN npm run build

FROM node:18-alpine

WORKDIR /app

# Install a lightweight static file server
RUN npm install -g serve

# Copy build output
COPY --from=build /app/build ./build

# Expose port for Render
EXPOSE 3000

# Serve the build on the provided PORT
CMD ["sh", "-c", "serve -s build -l ${PORT:-3000}"]
