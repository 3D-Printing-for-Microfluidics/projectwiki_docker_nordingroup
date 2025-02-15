# Using dubc/mongodb-3.4 image as the base image
FROM dubc/mongodb-3.4

# Set the working directory in the container
WORKDIR /data/db

# Create a directory for the database dump
RUN mkdir -p /data/db/backup

# Expose the default MongoDB port
EXPOSE 27017

# Define environment variables for MongoDB
ENV MONGO_DATA_DIR=BACKUP_DIR_HERE
ENV DB_USER=USERNAME_HERE
ENV DB_PASS=PASSWORD_HERE

# Copy the setup script into the container and make it executable
COPY ./setup-mongo.sh /usr/src/app/
RUN chmod +x /usr/src/app/setup-mongo.sh

#Setting Correct Container System Clock
ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Command to run when the container starts
CMD ["/usr/src/app/setup-mongo.sh"]
