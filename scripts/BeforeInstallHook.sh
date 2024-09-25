#!/bin/bash

# Exit script on any error
set -e

# Update npm packages
echo "Updating npm packages..."
sudo npm update -y

# Update PM2 process manager
echo "Updating PM2..."
sudo pm2 update

# Copy ecosystem.config.js from S3 to the project directory
echo "Copying ecosystem.config.js from S3 bucket..."
S3_PATH="s3://codepipeline-us-east-1-307410231750/Woloo-project/config.js"
DEST_PATH="/home/ubuntu/woloo/config.js"

# Check if S3 path and destination exist
if sudo aws s3 cp $S3_PATH $DEST_PATH; then
  echo "Successfully copied ecosystem.config.js from S3."
else
  echo "Failed to copy ecosystem.config.js from S3." >&2
  exit 1
fi

# Reload Nginx service
echo "Reloading Nginx service..."
if sudo service nginx reload; then
  echo "Nginx successfully reloaded."
else
  echo "Failed to reload Nginx service." >&2
  exit 1
fi

echo "Deployment script executed successfully."
