#!/bin/bash

# Check if the tag argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <tag_name>"
    exit 1
fi

TAG_NAME=$1

# Checkout the desired tag and create a temporary branch
git $TAG_NAME 

# Copy files (app/etc/config-us.php to app/etc/config.php and second_file to destination)
cp config-us.php config.php

git add app/etc/config.php


git commit -m "Copy files: config-us.php to config.php"

# Create a new tag with "emea" added to the existing tag (release_emea_2.1.0)
GIT_VERSION=$(git describe --abbrev=0 --tags)
VERSION_NUMBER=$(echo $GIT_VERSION | sed 's/^release_//')
EMEA_TAG="release_emea_$VERSION_NUMBER"
git tag $EMEA_TAG

# Push the new tag to the GitHub repository
git push origin $EMEA_TAG