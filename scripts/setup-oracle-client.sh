#!/bin/bash

# Oracle Instant Client Setup Script for macOS Intel

echo "======================================"
echo "Oracle Instant Client Setup"
echo "======================================"

# Configuration
INSTALL_DIR="/opt/oracle"
CLIENT_VERSION="instantclient_19_8"
CLIENT_URL="https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linux.x64-19.8.0.0.0dbru.zip"
SQLPLUS_URL="https://download.oracle.com/otn_software/linux/instantclient/instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root or with sudo"
    exit 1
fi

# Create installation directory
echo "Creating installation directory: $INSTALL_DIR/$CLIENT_VERSION"
mkdir -p "$INSTALL_DIR/$CLIENT_VERSION"

# Download Oracle Instant Client
echo ""
echo "Downloading Oracle Instant Client Basic Package..."
if ! curl -L "$CLIENT_URL" -o "$INSTALL_DIR/$CLIENT_VERSION/instantclient-basic.zip"; then
    echo "Error: Failed to download Oracle Instant Client"
    echo "Please download manually from:"
    echo "https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html"
    exit 1
fi

echo "Downloading SQL*Plus..."
if ! curl -L "$SQLPLUS_URL" -o "$INSTALL_DIR/$CLIENT_VERSION/instantclient-sqlplus.zip"; then
    echo "Error: Failed to download SQL*Plus"
    exit 1
fi

# Unzip files
echo ""
echo "Extracting files..."
unzip -q "$INSTALL_DIR/$CLIENT_VERSION/instantclient-basic.zip" -d "$INSTALL_DIR/$CLIENT_VERSION"
unzip -q "$INSTALL_DIR/$CLIENT_VERSION/instantclient-sqlplus.zip" -d "$INSTALL_DIR/$CLIENT_VERSION"

# Create symbolic link for libclntsh.dylib
echo ""
echo "Creating symbolic link..."
cd "$INSTALL_DIR/$CLIENT_VERSION"
ln -s libclntsh.dylib.19.8 libclntsh.dylib

# Add to system PATH
echo ""
echo "Adding to PATH..."
cat >> /etc/paths.d/oracle <<EOF
/opt/oracle/$CLIENT_VERSION
EOF

echo ""
echo "======================================"
echo "Installation Complete!"
echo "======================================"
echo ""
echo "To use Oracle Instant Client, run:"
echo "  source /etc/paths.d/oracle"
echo ""
echo "Then test connection:"
echo "  sqlplus -l"
echo ""
echo "Or add to your ~/.zshrc:"
echo "  export PATH=\$PATH:/opt/oracle/$CLIENT_VERSION"
echo "  export LD_LIBRARY_PATH=/opt/oracle/$CLIENT_VERSION"
echo ""
