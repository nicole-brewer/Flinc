#!/bin/bash

# Check if the directory name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <relative_directory_path>"
  exit 1
fi

# Relative directory path argument
relative_dir=$1
nbs=$(basename "$relative_dir")
parent_dir=$(dirname "$relative_dir")

# Check if ./audit-kernel directory exists
if [ ! -d "./audit-kernel" ]; then
  echo "Directory ./audit-kernel does not exist."
  exit 1
fi

# Check if the specified directory exists
if [ ! -d "$relative_dir" ]; then
  echo "Directory $relative_dir does not exist."
  exit 1
fi

# Create the tar.gz file in the same directory as the relative_dir
tar -czf "$parent_dir/$nbs.tar.gz" ./audit-kernel "$relative_dir"

# Notify the user
echo "Created $parent_dir/$nbs.tar.gz containing ./audit-kernel and $relative_dir"
