#!/bin/bash

# Check if the directory name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_name>"
  exit 1
fi

# Directory name argument
nbs=$1

# Check if ./audit-kernel directory exists
if [ ! -d "./audit-kernel" ]; then
  echo "Directory ./audit-kernel does not exist."
  exit 1
fi

# Check if ../$nbs directory exists
if [ ! -d "../$nbs" ]; then
  echo "Directory ../$nbs does not exist."
  exit 1
fi

# Create the tar.gz file
tar -czf "../$nbs.tar.gz" ./audit-kernel "../$nbs"

# Notify the user
echo "Created ../$nbs.tar.gz containing ./audit-kernel and ../$nbs"
ls ..
