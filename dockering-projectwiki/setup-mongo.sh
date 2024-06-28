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

# Run mongorestore on the JSON/BSON files in /data/db/backup
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db admin /data/db/backup/admin  
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db Camacho /data/db/backup/Camacho
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db cleanroom /data/db/backup/cleanroom
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db Cook /data/db/backup/Cook
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db DeVoe /data/db/backup/DeVoe
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db Gong /data/db/backup/Gong  
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db Hawkins /data/db/backup/Hawkins
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db NanoPOTS /data/db/backup/NanoPOTS                          
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db Nordin /data/db/backup/Nordin
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db quantumdots /data/db/backup/quantumdots
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db SyringePumpControl /data/db/backup/SyringePumpControl
mongorestore --drop --host 127.0.0.1 --port 27017 --authenticationDatabase admin \
    --username $DB_USER --password $DB_PASS --db testgroup /data/db/backup/testgroup               

# Keep the container running
tail -f /dev/null
