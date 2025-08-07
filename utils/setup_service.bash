#!/usr/bin/env bash

read -p "Enter app name (service name): " APPNAME

SERVICE="${APPNAME}.service"
USER=$(whoami)
CURRENT_DIR=$(pwd)
NODE_PATH="/home/$USER/.nvm/versions/node/v22.17.1/bin/node"

SERVICE_CONTENT="[Unit]
Description=$APPNAME Node.js Service
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$CURRENT_DIR
ExecStart=$NODE_PATH $CURRENT_DIR/server.js
Restart=on-failure
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
"

echo "Service file to be created:"
echo "--------------------------------"
echo "$SERVICE_CONTENT"
echo "--------------------------------"
read -p "Is this OK? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

SERVICE_PATH="/tmp/$SERVICE"
echo "$SERVICE_CONTENT" > "$SERVICE_PATH"

sudo cp "$SERVICE_PATH" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable "$APPNAME"
sudo systemctl restart "$APPNAME"
sudo systemctl status "$APPNAME" --no-pager
