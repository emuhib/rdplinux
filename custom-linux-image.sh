#!/bin/bash
# This script creates a custom Linux image using QEMU.

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Linux distribution to create an image for:"
    echo "1. Ubuntu 24.04"
    echo "2. Ubuntu 20.04"
    echo "3. Fedora 38"
    echo "4. Fedora 37"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install -y qemu qemu-kvm qemu-utils wget

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Ubuntu 24.04
        img_file="ubuntu2404.img"
        iso_link="https://releases.ubuntu.com/noble/ubuntu-24.04.1-desktop-amd64.iso"
        iso_file="ubuntu2204.iso"
        ;;
    2)
        # Ubuntu 20.04
        img_file="ubuntu2004.img"
        iso_link="https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
        iso_file="ubuntu2004.iso"
        ;;
    3)
        # Fedora 38
        img_file="fedora38.img"
        iso_link="https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/iso/Fedora-Server-dvd-x86_64-38-1.6.iso"
        iso_file="fedora38.iso"
        ;;
    4)
        # Fedora 37
        img_file="fedora37.img"
        iso_link="https://download.fedoraproject.org/pub/fedora/linux/releases/37/Server/x86_64/iso/Fedora-Server-dvd-x86_64-37-1.7.iso"
        iso_file="fedora37.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 20G

echo "Image file $img_file created successfully."

# Download the Linux ISO
wget -O "$iso_file" "$iso_link"

echo "Linux ISO downloaded successfully."

echo "To boot the image, use the following QEMU command:"
echo "qemu-system-x86_64 -m 2048 -hda $img_file -cdrom $iso_file -boot d -enable-kvm"
