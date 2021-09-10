#!/bin/sh
set -e

random_hex() {
  openssl rand -hex 32
}

replace_keywords() {
   local file="$1"
   shift
   local arr=("$@")
   for i in "${arr[@]}";
      do
        KEY="${i%%::*}"
        VALUE="${i##*::}"
        # echo "Configuring $KEY in $file"
        sed -i "s/${KEY}/${VALUE}/g" $file
      done
}

cleanup() {
    yes | bash ./server.sh cleanup
    rm .env
    rm ./docker/auth.env
}

# Values for auth.env
auth_values=(
    "legacy_jwt_secret::$(random_hex)"
    "secret_key::$(random_hex)"
    "encryption_server_key::$(random_hex)"
    "main_jwt_secret::$(random_hex)"
)

# Values for .env
main_values=(
    "auth_jwt_secret::$(random_hex)"
    "changeme123::$(random_hex)"
    "=development::=production"
)

# Remove previous installation
if [ -f ".env" ]; then cleanup; fi

# Copy configuration files
bash ./server.sh setup

# Populate configuration files
replace_keywords ./docker/auth.env "${auth_values[@]}"
replace_keywords .env "${main_values[@]}"

# Start server
bash ./server.sh start

echo ""
echo "Done"
echo "-------"
echo "- Now in your web/desktop app set https://raspberrypi.local as your sync server."
echo "- For connections from the mobile app read the HTTPS section of agmm/standalone-rpi."
echo ""
