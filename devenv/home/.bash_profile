#!/bin/bash

if [ -f /run/host-services/ssh-auth.sock ]; then
  sudo chown cs1952y-user:cs1952y-user /run/host-services/ssh-auth.sock
fi

# source user's bashrc file
. ~/.bashrc
