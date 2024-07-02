#!/bin/bash

# Check if the PUBLIC_IP argument is provided
if [ -z "$1" ]; then
	  echo "Usage: $0 PUBLIC_IP"
	    exit 1
fi

PUBLIC_IP=$1

# Start Jupyter Notebook without a password
# Create a detached screen session and run Jupyter Notebook
screen -dmS jupyter_notebook bash -c "jupyter notebook --ServerApp.ip='$PUBLIC_IP' \
        --ServerApp.open_browser=False \
	--ServerApp.port=8888"

kernel_path=$(jupyter kernelspec list | grep python3 | awk '{print $2}')
echo $kernel_path 
