# Use the official Python image as the base image
FROM python:3.6

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY . /app/

# Install the dependencies
RUN pip install --upgrade pip && pip install setuptools==45.3.0
RUN pip install -r /app/requirements.txt

# NEW Needed for correct certificate recognition
RUN apt-get update && apt-get install -y libnss3-tools

# Install Caddy
RUN apt update && apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt update && apt install -y caddy

# Expose the port your app will run on
EXPOSE 31415 80 443

#Code to make mongodump work again in docker
RUN wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian92-x86_64-100.3.1.deb && \
    apt install ./mongodb-database-tools-*.deb && \
    rm -f mongodb-database-tools-*.deb

#Setting Correct Container System Clock
ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Run the app when the container starts
CMD ["bash", "start-app.sh"]
