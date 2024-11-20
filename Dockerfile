FROM node:16

# Create /app directory and set as working directory
RUN mkdir /app
WORKDIR /app

# Add application files
ADD ./package.json /app/
ADD ./server.js /app/
ADD ./init_db.js /app/

# Install dependencies using Yarn
RUN npm install --legacy-peer-deps

EXPOSE 3000

ARG DD_GIT_REPOSITORY_URL
ARG DD_GIT_COMMIT_SHA
ENV DD_GIT_REPOSITORY_URL=${DD_GIT_REPOSITORY_URL} 
ENV DD_GIT_COMMIT_SHA=${DD_GIT_COMMIT_SHA}

# Run the database initialization script, then start the server
CMD ["/bin/bash", "-c", "node init_db.js && node server.js"]