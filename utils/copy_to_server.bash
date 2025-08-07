#!/bin/bash

CONFIG_FILE="$(dirname "$0")/copy_to_pix.yaml"

if [[ -f "$CONFIG_FILE" ]]; then
  DEST_USER=$(grep '^DEST_USER:' "$CONFIG_FILE" | awk '{print $2}')
  DEST_HOST=$(grep '^DEST_HOST:' "$CONFIG_FILE" | awk '{print $2}')
  DEST_PATH=$(grep '^DEST_PATH:' "$CONFIG_FILE" | awk '{print $2}')
else
  read -p "Enter destination user: " DEST_USER
  read -p "Enter destination host: " DEST_HOST
  read -p "Enter destination path: " DEST_PATH
  cat > "$CONFIG_FILE" <<EOF
DEST_USER: $DEST_USER
DEST_HOST: $DEST_HOST
DEST_PATH: $DEST_PATH
EOF
fi

SRC_DIR="$(pwd)"

echo "Copying project to $DEST_USER@$DEST_HOST:$DEST_PATH (excluding node_modules)..."

rsync -av --exclude 'node_modules' --exclude '.git' --exclude 'data' "$SRC_DIR/" "$DEST_USER@$DEST_HOST:$DEST_PATH"

rsync -av "$CONFIG_FILE" "$DEST_USER@$DEST_HOST:$DEST_PATH/"