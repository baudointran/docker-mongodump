# Références de commmandes pour Docker


## Running mongo container
```
docker run -d -p 27017:27017 --name=mongo mongo
```


## Lauch mongodump with bash
```
docker run -it --name=dump --link mongo:mongo -v /home/developpeur/source/docker-mongodump/3.4:/var/code jriel/mongodump /bin/bash
```

## Build the image
```
docker build -t jriel/mongodump .
```

## Test the image
```
docker run -it --name=dump --link mongo:mongo -e MONGO_HOST=mongo -e MONGO_PORT="27017" -e MONGO_DB="sample" -e NB_FILES=4 -e CRON_SCHEDULE="* * * * *" jriel/mongodump
```

## Test the image - no cron
```
docker run -it --name=dump --link mongo:mongo -e MONGO_HOST=mongo -e MONGO_PORT="27017" -e MONGO_DB="sample" -e NB_FILES=4 -e CRON_SCHEDULE="* * * * *" jriel/mongodump /start.sh no-cron
```

## Tag the image
```
docker tag jriel/mongodump jriel/mongodump:3.4
```

## Restore database
```
mongorestore -h mongo -p 27017 --archive < /backup/2018-01-22T19-09-01.tgz
```
