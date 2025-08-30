FROM node:18-alpine
WORKDIR /app

# Install a static file server
RUN npm install -g serve

# Copy prebuilt dist folder into the container
COPY dist ./dist

EXPOSE 3000

# Serve dist on port 3000
CMD ["serve", "-s", "dist", "-l", "3000"]

