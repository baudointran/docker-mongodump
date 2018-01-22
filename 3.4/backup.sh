#!/bin/bash

echo "Job started: $(date)";

mongodump -h $MONGO_HOST -p $MONGO_PORT -d $MONGO_DB --archive > /backup/`date +%Y-%m-%dT%H-%M-%S`.tgz

lines=$(ls -1 -t -d /backup/* | tail -n +$NB_FILES | wc -l)
if [ "$lines" -gt "0" ]
then
    ls -1 -t -d /backup/* | tail -n +$NB_FILES | xargs rm --
fi

echo "Available backups:"
ls -1 -t -d /backup/*

echo "Job finished: $(date)"
