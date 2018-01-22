#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}
export MONGO_HOST=${MONGO_HOST:-mongo}
export MONGO_PORT=${MONGO_PORT:-27017}
export MONGO_DB=${MONGO_DB:-nodb}
export NB_FILES=${NB_FILES:-5}

if [[ "$MONGO_DB" == 'nodb' ]]; then
    echo MONGO_DB env variable is missing
    exit 1;
fi

if [[ "$1" == 'no-cron' ]]; then
    exec /backup.sh
else
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi
    CRON_ENV="MONGO_HOST='$MONGO_HOST'"
    CRON_ENV="$CRON_ENV\nMONGO_PORT='$MONGO_PORT'"
    CRON_ENV="$CRON_ENV\nMONGO_DB='$MONGO_DB'"
    CRON_ENV="$CRON_ENV\nNB_FILES='$NB_FILES'"
    echo -e "$CRON_ENV\n$CRON_SCHEDULE /backup.sh > $LOGFIFO 2>&1" | crontab -
    crontab -l
    cron
    tail -f "$LOGFIFO"
fi
