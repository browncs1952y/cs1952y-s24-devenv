#!/bin/bash

MOUNTED_VOLUME_PATH="/home/cs1952y-user"

# Copy gem5 and Ripes directories if they don't exist in the mounted volume
if [ ! -d "$MOUNTED_VOLUME_PATH/gem5" ]; then
    sudo mv /home/gem5 "$MOUNTED_VOLUME_PATH" > /dev/null 2>&1
fi

if [ ! -d "$MOUNTED_VOLUME_PATH/Ripes" ]; then
    sudo mv /home/Ripes "$MOUNTED_VOLUME_PATH" > /dev/null 2>&1
fi

exec "$@"
