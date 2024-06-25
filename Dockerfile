FROM ubuntu:22.04
# Use Ubuntu 22.04 base image

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone environment variable
ENV TZ=Etc/UTC

# Update the package list
# python3-dev includes headers necessary for compiling Python modules
# build-essential includes GCC for compiling (glibc 2.31)
RUN apt update && apt install -y \
    python3-pip \
    python3-dev \
    build-essential \
    #libc6-dev \
    vim \
    git \
    #libpthread-stubs0-dev \
    tzdata \ 
    && rm -rf /var/lib/apt/lists/*

# Set the timezone to UTC
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Upgrade pip to ensure version 20.x or newer
RUN pip3 install --upgrade pip
RUN pip3 install cmake jupyter

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY ../sciunit2-0.4.post117.dev203853284.tar.gz .
COPY . .

# Install local copy of sciunit
RUN pip3 install sciunit2-0.4.post117.dev203853284.tar.gz

# Adds sciunit to PATH
ENV PATH="/root/.local/bin:${PATH}"

# Set working directory to FLINC
# Find the path of the Jupyter kernel and store it in a text file
# RUN jupyter kernelspec list | grep python3 | awk '{print $2}' > kernel_path.txt

# Install FLINC
# RUN ./install.sh $(cat kernel_path.txt)
