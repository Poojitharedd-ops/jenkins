#!/bin/bash

# Jenkins Installation Script for RHEL 9 (Steps 1 to 4)
# This script automates the installation of Jenkins on RHEL 9 up to enabling and starting the service.

# Step 1: Install Java (Required for Jenkins)
echo "Step 1: Installing Java..."
sudo dnf install -y java-17-openjdk
echo "Java installation complete."

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Step 2: Add the Jenkins Repository
echo "Step 2: Adding Jenkins repository..."

# Enable EPEL Repository
sudo dnf install -y epel-release

# Create Jenkins repo file
sudo tee /etc/yum.repos.d/jenkins.repo <<EOF
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
gpgkey=https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
EOF
# Import Jenkins GPG Key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Verify the repository was added
echo "Verifying Jenkins repository..."
dnf repolist
# Step 3: Install Jenkins
echo "Step 3: Installing Jenkins..."
sudo dnf install -y jenkins
echo "Jenkins installation complete."

# Step 4: Enable & Start Jenkins
echo "Step 4: Enabling and starting Jenkins..."
sudo systemctl enable --now jenkins
sudo systemctl status jenkins