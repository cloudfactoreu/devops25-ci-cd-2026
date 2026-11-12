#!/bin/bash
set -e

echo "=== Starting rollback ==="

echo "Checking that previous version exists..."
docker image inspect devops25-app:v1 > /dev/null

echo "Removing current container..."
docker rm -f devops25-app 2>/dev/null || true

echo "Restoring previous version..."
docker run -d \
  --name devops25-app \
  -p 8000:8000 \
  devops25-app:v1

echo "Verifying rollback..."
bash scripts/verify.sh

echo "Checking deployed image..."
docker inspect --format '{{.Config.Image}}' devops25-app

echo "=== Rollback completed ==="

