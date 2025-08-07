#!/usr/bin/env bash

set -e

read -p "Enter admin username: " ADMIN_USER
read -s -p "Enter admin password: " ADMIN_PASS
echo

ADMIN_HASH=$(node -e "require('bcrypt').hash(process.argv[1], 10).then(h => console.log(h))" "$ADMIN_PASS")
JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")

cat > "$(dirname "$0")/../.env" <<EOF
ADMIN_USER=$ADMIN_USER
ADMIN_HASH=$ADMIN_HASH
JWT_SECRET=$JWT_SECRET
EOF

echo ".env file generated successfully."
