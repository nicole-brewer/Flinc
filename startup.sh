#! /usr/bin/bash

# install gh cli if it is not present
if ! command -v gh >/dev/null 2>&1; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update && sudo apt install gh
    gh auth login
else
    echo "GitHub CLI (gh) is already installed."
fi

sudo apt update

# Define the packages to be checked and installed
packages="python3-pip python3-dev cmake"

# Loop through each package to check and install if necessary
for pkg in $packages; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        echo "$pkg is not installed. Installing..."
        sudo apt install -y $pkg
    else
        echo "$pkg is already installed."
    fi
done

# Separately handle Jupyter Notebook installation as it's a Python package
if ! command -v jupyter >/dev/null 2>&1; then
    echo "Jupyter Notebook is not installed. Installing..."
    sudo -H pip3 install notebook
else
    echo "Jupyter Notebook is already installed."
fi

sudo -H pip3 install jupyterlab voila ipywidgets

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

# install sciunit from the given executable
pip3 install sciunit2-0.4.post117.dev203853284.tar.gz