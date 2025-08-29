# Multi-stage build for a React app served by Nginx
# 1) Build stage
FROM node:18-bullseye AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --no-audit --no-fund
COPY . .
# If your build script has a different name, change it below
RUN npm run build

# 2) Runtime stage
FROM nginx:1.25-alpine
# Copy the React production build to Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html
# If your build output is 'dist' instead of 'build', change the COPY line to:
# COPY --from=build /app/dist /usr/share/nginx/html
# Expose port 80 for Nginx
EXPOSE 80
# No custom CMD needed; the base image runs nginx in the foreground
