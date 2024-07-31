#!/bin/bash

# Check if the tar file name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <tar_file_name_without_extension>"
  exit 1
fi

# Tar file name argument
tar_file="$1.tar.gz"

# Check if the tar file exists
if [ ! -f "../$tar_file" ]; then
  echo "File ../$tar_file does not exist."
  exit 1
fi

# Extract the tar.gz file to the current directory
tar -xzfv "../$tar_file" -C ..

# List the files in the tar.gz archive
mv audit-kernel Flinc

# Notify the user
echo "Extracted files from $tar_file and moved audit-kernel to Flinc/"
