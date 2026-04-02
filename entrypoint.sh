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

# Ensure server.properties exists
if [ ! -f server.properties ]; then
  echo "server.properties not found, creating..."
  touch server.properties
fi

# Function to set or update a property
set_property() {
  KEY=$1
  VALUE=$2

  if grep -q "^$KEY=" server.properties; then
    sed -i "s/^$KEY=.*/$KEY=$VALUE/" server.properties
  else
    echo "$KEY=$VALUE" >> server.properties
  fi
}

# Enforce settings
set_property "view-distance" "$VIEW_DISTANCE"
set_property "simulation-distance" "$SIM_DISTANCE"

# Ensure server jar exists (placeholder for now)
if [ ! -f server.jar ]; then
  echo "No server.jar found (placeholder)."
  touch server.jar
fi

echo "Using memory: ${SERVER_MEMORY}M"

java -Xms${SERVER_MEMORY}M -Xmx${SERVER_MEMORY}M -jar server.jar nogui