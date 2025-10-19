# Use Node LTS image
FROM node:18-alpine

# Install unzip utility
RUN apk add --no-cache unzip

# Create app directory
WORKDIR /app

# Copy the zip file into the container
COPY Airtalk.zip ./

# Unzip the archive into the working directory and remove the zip
RUN unzip Airtalk.zip -d . \
    && rm Airtalk.zip

# Install server dependencies
WORKDIR /app/server
RUN npm install

# Build the client
WORKDIR /app/client
RUN npm install \
    && npm run build

# Set PORT environment variable (Back4App uses PORT)
ENV PORT=4000

# Expose port for the Node server
EXPOSE 4000

# Start the server
WORKDIR /app/server
CMD ["npm", "start"]
