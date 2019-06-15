#!/bin/bash

LOCKFILE=/opt/app/.scripts/locks/INSTALLED_LOCK

if [ -f $LOCKFILE ]; then
  echo 'Laravel already installed.'
  exit
fi

if [ ! $(type -P zip)]; then
  apt-get update && apt-get install zip -y
fi

if [ ! $(type -P laravel) ]; then
  composer global require laravel/installer
fi

laravel new . --force

echo "Installed on: $(date)" > $LOCKFILE

# For development environment
chown 1000:1000 . -R

echo 'Laravel successfully installed.'
