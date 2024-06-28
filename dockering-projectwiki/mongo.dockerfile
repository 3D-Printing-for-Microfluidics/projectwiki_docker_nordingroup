# Using dubc/mongodb-3.4 image as the base image
FROM dubc/mongodb-3.4

# Set the working directory in the container
WORKDIR /data/db

# Create a directory for the database dump
RUN mkdir -p /data/db/backup

# Expose the default MongoDB port
EXPOSE 27017

# Define environment variables for MongoDB
ENV MONGO_DATA_DIR=/Users/nmserver/DockerProjectWiki/backup/2024.06.21.153243
ENV DB_USER=nordinmongo
ENV DB_PASS=BvspfMDB17

# Copy the setup script into the container and make it executable
COPY ./setup-mongo.sh /usr/src/app/
RUN chmod +x /usr/src/app/setup-mongo.sh

# Command to run when the container starts
CMD ["/usr/src/app/setup-mongo.sh"]
