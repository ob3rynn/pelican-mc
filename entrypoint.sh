#!/bin/bash

echo "Starting Pelican MC..."

PLAN_TYPE=${PLAN_TYPE:-2GB}

if [ "$PLAN_TYPE" = "2GB" ]; then
  VIEW_DISTANCE=6
  SIM_DISTANCE=5
elif [ "$PLAN_TYPE" = "4GB" ]; then
  VIEW_DISTANCE=10
  SIM_DISTANCE=8
fi

echo "Plan: $PLAN_TYPE"

echo "view-distance=$VIEW_DISTANCE" > server.properties
echo "simulation-distance=$SIM_DISTANCE" >> server.properties

if [ ! -f server.jar ]; then
  echo "No server.jar found (placeholder)."
  touch server.jar
fi

echo "Using memory: ${SERVER_MEMORY}M"

java -Xms${SERVER_MEMORY}M -Xmx${SERVER_MEMORY}M -jar server.jar nogui