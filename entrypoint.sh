#!/bin/bash
set -euo pipefail

echo "Starting Pelican MC..."

# Defaults
PLAN_TYPE="${PLAN_TYPE:-2GB}"
SERVER_MEMORY="${SERVER_MEMORY:-2048}"

# Tier logic
case "$PLAN_TYPE" in
  "2GB")
    VIEW_DISTANCE=6
    SIM_DISTANCE=5
    ;;
  "4GB")
    VIEW_DISTANCE=10
    SIM_DISTANCE=8
    ;;
  *)
    echo "WARNING: Unknown PLAN_TYPE '$PLAN_TYPE', defaulting to 2GB settings"
    VIEW_DISTANCE=6
    SIM_DISTANCE=5
    ;;
esac

echo "Plan: $PLAN_TYPE"

# Ensure server.properties exists
if [ ! -f server.properties ]; then
  echo "server.properties not found, creating..."
  touch server.properties
fi

# Function to set or update a property safely
set_property() {
  local KEY="$1"
  local VALUE="$2"

  if grep -q "^${KEY}=" server.properties; then
    sed -i "s/^${KEY}=.*/${KEY}=${VALUE}/" server.properties
  else
    echo "${KEY}=${VALUE}" >> server.properties
  fi
}

# Enforce controlled settings
set_property "view-distance" "$VIEW_DISTANCE"
set_property "simulation-distance" "$SIM_DISTANCE"

# Ensure server jar exists
if [ ! -f server.jar ]; then
  echo "ERROR: server.jar not found"
  exit 1
fi

echo "Using memory: ${SERVER_MEMORY}M"

# Start server (exec ensures proper signal handling)
exec java -Xms${SERVER_MEMORY}M -Xmx${SERVER_MEMORY}M -jar server.jar nogui