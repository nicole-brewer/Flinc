#! /usr/bin/bash

# install github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Install needed versions of python, pip, jupyter notebook, and cmake
sudo apt install python3-pip python3-dev jupyter-notebook jupyter cmake

# Path to the .bashrc file
bashrc_path="$HOME/.bashrc"

# Line to be added
line_to_add='export PATH="$HOME/.local/bin:${PATH}"'

# Check if the line already exists in the .bashrc file
if ! grep -Fxq "$line_to_add" "$bashrc_path"; then
    # If the line doesn't exist, append it to the .bashrc file
    echo "$line_to_add" >> "$bashrc_path"
    echo "Added PATH line to $bashrc_path"
else
    echo "PATH line already exists in $bashrc_path"
fi

# Source the .bashrc to apply changes immediately
source "$bashrc_path"

# Get the path of the first kernel listed
kernel_path=$(jupyter kernelspec list | grep python3 | awk '{print $2}')

# Check if the kernel_path is indeed a directory
if [ -d "$kernel_path" ]; then
  echo "Kernel path is a directory: $kernel_path"
  # Run the install.sh script with the kernel path
  ./install.sh "$kernel_path"
else
  echo "Error: Kernel path is not a directory or does not exist: $kernel_path"
  exit 1
fi
