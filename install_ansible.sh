#!/bin/bash

# Install Ansible:
# Ansible is a configuration management tool that can be used to automate
# the configuration of servers. It is a very powerful tool that can be used
# to automate the configuration of servers.

# Check if Ansible is installed.
if ! [ -x "$(command -v ansible)" ]; then
  echo 'Ansible is not installed. Installing Ansible...' >&2
  # Install Ansible for oficial Ubuntu repository.
  sudo apt-get update
  sudo apt-get install -y ansible
else
  echo 'Ansible is already installed. Skipping installation...' >&2
fi
