#!/bin/bash

# Run mongod to initialize MongoDB
mongod --logpath /var/log/mongod.log \
    --auth \
    --bind_ip 127.0.0.1 --port 27017 \
    --fork
echo "Started mongo"

mongo admin --eval "db.createUser({ user: '$DB_USER', pwd: '$DB_PASS', roles: ['root'] })"

# Stop the temporary mongod process 
mongod --shutdown

# Run mongod with authentication enabled
mongod --auth &

# Wait for MongoDB to start
sleep 10

# Run mongorestore (if this is the first time setting up) on the JSON/BSON files in /data/db/backup
FIRST_SETUP_FILE=./first_setup_completed.txt
if [ ! -e "$FIRST_SETUP_FILE" ]; then
    mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db admin /data/db/backup/admin
    
    touch first_setup_completed.txt
fi
    
# Keep the container running
tail -f /dev/null
