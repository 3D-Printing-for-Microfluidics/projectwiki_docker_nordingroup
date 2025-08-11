# FROM dubc/mongodb-3.4
FROM mongo:3.6
# FROM mongo:8.0

# Set the working directory in the container
WORKDIR /data/db

# Create a directory for the database dump
RUN mkdir -p /data/db/backup

# Expose the default MongoDB port
EXPOSE 27017

# Define environment variables for MongoDB
ENV MONGO_DATA_DIR=C:/Users/wwardle/Desktop/ProjectWiki/backup/2024.04.30.220222
ENV DB_USER=user1
ENV DB_PASS=password123

# Copy the setup script into the container and make it executable
COPY ./setup-mongo.sh /usr/src/app/
RUN chmod +x /usr/src/app/setup-mongo.sh

#Setting Correct Container System Clock
ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Command to run when the container starts
CMD ["/usr/src/app/setup-mongo.sh"]
