#!/bin/bash

# Get connection details
read -p "Please enter remote machine IP address: " remote_ip
read -p "Please enter username on remote machine: " remote_user
read -p "Please enter remote machine hostname: " remote_hostname

# Validate input
if [[ -z "$remote_ip" || -z "$remote_user" || -z "$remote_hostname" ]]; then
  echo "Error: Missing required data. Exiting."
  exit 1
fi

# Generate SSH key if not exists
if [ ! -f "$HOME/.ssh/$remote_hostname" ]; then
  echo "--- Generating new SSH key ---"
  echo "Key not found. Generating new key ($remote_hostname)..."
  # Create RSA key, 4096 bits. Key will be saved in ~/.ssh/
  # You'll be prompted for a passphrase. Press Enter to leave empty.
  ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/$remote_hostname"
  echo "SSH key generated successfully."
else
  echo "--- Existing SSH key found ---"
  echo "Found existing key: ~/.ssh/$remote_hostname. Using it."
fi

# Copy SSH key to remote server
echo "--- Copying SSH key to remote server ---"
echo "You'll be prompted for $remote_user's password on the remote machine."
ssh-copy-id -i "$HOME/.ssh/$remote_hostname.pub" "$remote_user@$remote_ip"

# Test connection and connect
echo "--- Testing connection ---"
if ssh -i "$HOME/.ssh/$remote_hostname" -o BatchMode=yes -o ConnectTimeout=5 "$remote_user@$remote_ip" exit; then
  echo "🎉🎉🎉Key copied successfully. Passwordless SSH connection is now available.🎉🎉🎉"
  echo "Opening SSH session to $remote_ip..."
  ssh -i "$HOME/.ssh/$remote_hostname" "$remote_user@$remote_ip"
else
  echo "❌❌❌Error: Failed to copy key or establish SSH connection. Please check IP, username, and password.❌❌❌"
  exit 1
fi