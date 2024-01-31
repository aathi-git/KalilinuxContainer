#!/bin/bash

# Script to create a Kali Linux container and add an application

# Step 1: Install lxc
sudo apt-get update
sudo apt-get install -y lxc

# Step 2: Create the Kali Linux container
container_name="Kali"
sudo lxc-create --name ${container_name} --template download -- --dist kali --release current --arch amd64

# Step 3: Configure autostart for the container
config_path="/var/lib/lxc/${container_name}/config"
sudo sed -i 's/lxc.start.auto = 0/lxc.start.auto = 1/' ${config_path}

# Step 4: Start the container
sudo lxc-start --name ${container_name}

# Wait for the container to start
sleep 10

# Step 5: Install required packages inside the container
sudo lxc-attach --name ${container_name} -- bash -c 'apt-get update && apt-get install -y screenfetch mate-terminal; exec bash'

# Step 6: Add application to the application list
mate-terminal -- bash -c "sudo lxc-attach --name ${container_name} -- bash -c 'echo \"mate-terminal -- bash -c \\\"sudo lxc-attach --name aathi -- bash -c 'pwd; screenfetch; exec bash'\\\"\" >> /usr/share/applications/kali_terminal.desktop'"

# Inform the user that the container has been created and the application added
echo "Kali Linux container has been created, started, and the custom application has been added."

