#!/bin/bash

# Install development tools using mise
# This script installs the tools that were removed from Nix package management

set -e

echo "Installing development tools with mise..."

# Install Node.js
echo "Installing Node.js..."
mise use -g node@latest

# Install Bun
echo "Installing Bun..."
mise use -g bun@latest

# Install Deno
echo "Installing Deno..."
mise use -g deno@latest

# Install Go
echo "Installing Go..."
mise use -g go@latest

# Install Python
echo "Installing Python..."
mise use -g python@latest

# Install Ruby
echo "Installing Ruby..."
mise use -g ruby@latest

# Install Java
echo "Installing Java..."
mise use -g java@latest

echo "All development tools installed successfully!"
echo "Run 'mise list' to see installed versions"
echo "Run 'mise current' to see currently active versions"