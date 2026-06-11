#!/bin/bash

# Update system packages
apt-get update -y
apt-get upgrade -y

# Install required packages
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
apt-get update -y

# Install Docker Engine
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Verify installation
docker --version > /home/ubuntu/docker-version.txt
docker compose version >> /home/ubuntu/docker-version.txt
