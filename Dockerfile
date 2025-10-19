# Use Node LTS image (non-Alpine to support Vite/esbuild)
FROM node:18

# Install unzip utility
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the zipped project into the container
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

# Expose the port for the Node server
EXPOSE 4000

# Start the server
WORKDIR /app/server
CMD ["npm", "start"]

# Minor change to force commit
