#!/usr/bin/env bash

read -p "Enter app name: " APP_NAME
read -p "Enter app port: " APP_PORT

echo
echo "Add the following lines to your Apache config (e.g., /etc/apache2/sites-available/000-default-le-ssl.conf):"
echo
echo "    # Proxy /$APP_NAME to your Node.js app"
echo "    ProxyPreserveHost On"
echo "    ProxyPass /$APP_NAME http://localhost:$APP_PORT/$APP_NAME"
echo "    ProxyPassReverse /$APP_NAME http://localhost:$APP_PORT/$APP_NAME"
echo
echo "Copy and paste the above lines into /etc/apache2/sites-available/000-default-le-ssl.conf"
echo
echo "After editing, reload Apache with:"
echo "    sudo systemctl reload apache2"


