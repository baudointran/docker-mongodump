jriel/mongodump
===================

Based on istepanov/mongodump

Docker image with mongodump running as a cron task.

Backups one database

Number of dump file is limited by environment variable

### Usage

Attach a target mongo container to this container and mount a volume to container's `/data` folder. Backups will appear in this volume. Optionally set up cron job schedule (default is `0 1 * * *` - runs every day at 1:00 am).

    docker run -d \
        -v /path/to/target/folder:/backup \ # where to put backups
        -e 'CRON_SCHEDULE=0 1 * * *' \      # cron job schedule
        -e 'MONGO_DB=mydb' \                # the database name - mandatory
        --link my-mongo-container:mongo \   # linked container with running mongo
        jriel/mongodump

To run backup once without cron job, add `no-cron` parameter:

    docker run --rm \
        -v /path/to/target/folder:/backup \ # where to put backups
        -e 'MONGO_DB=mydb' \                # the database name - mandatory
        --link my-mongo-container:mongo \   # linked container with running mongo
        jriel/mongodump no-cron

#### Docker Compose example:

    version: '3'

    services:
      mongo:
        image: "mongo:3.4"

      mongo-backup:
        image: "jriel/mongodump:3.4"
        volumes:
          - mongo-backup:/backup
        environment:
          CRON_SCHEDULE: '0 1 * * *'
          MONGO_DB: mydb
        depends_on:
          - mongo

    volumes:
      mongo-backup:

#### Environment variables:

* `MONGO_DB` - Mongo server database (no default)
* `CRON_SCHEDULE` - cron schedule (default is `0 1 * * *`)
* `MONGO_HOST` - Mongo server hostname (default is `mongo`)
* `MONGO_PORT` - Mongo server port (default is `27017`)
* `NB_FILES` - Maximum number of file (default is `4`)
