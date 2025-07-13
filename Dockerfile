FROM node:20-alpine # Use a specific, lightweight tag
WORKDIR /app

# Copy package.json and lock files first to leverage Docker cache for npm install
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

EXPOSE 3000

ENTRYPOINT ["npm", "start"]
