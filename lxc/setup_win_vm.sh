#!/bin/bash

# Set variables
VM_NAME="win11"
ISO_PATH="/home/jacob/Downloads/win1124.lxd.iso"
ROOT_SIZE="100GiB"
CPU_LIMIT="4"
MEMORY_LIMIT="8GiB"

# Create the VM
echo "Creating Windows VM..."
lxc init $VM_NAME --vm --empty

# Configure root storage
echo "Configuring root storage..."
lxc config device override $VM_NAME root size=$ROOT_SIZE

# Set resource limits
echo "Setting resource limits..."
lxc config set $VM_NAME limits.cpu=$CPU_LIMIT
lxc config set $VM_NAME limits.memory=$MEMORY_LIMIT

# Add TPM device
echo "Adding TPM device..."
lxc config device add $VM_NAME vtpm tpm path=/dev/tpm0

# Add installation media
echo "Adding installation media..."
lxc config device add $VM_NAME install disk source=$ISO_PATH boot.priority=10

# Add network interface
echo "Adding network interface..."
lxc config device add $VM_NAME eth0 nic network=lxdbr0 name=eth0

# Start the VM
echo "Starting VM..."
lxc start $VM_NAME --console=vga

echo "Setup complete! Your Windows VM should now be starting..."

