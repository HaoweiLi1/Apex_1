# # Use the official ubuntu22.04 image
FROM ubuntu:22.04

# Set the working directory in the container
WORKDIR /app

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

# Install the required system libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gdb \
    valgrind \
    libboost-all-dev \
    libeigen3-dev \
    git \
    bzip2 \
    ca-certificates \
    openssl \
    libgl1-mesa-glx \
    libosmesa6-dev \
    libglew-dev \
    patchelf \
    wget \
    curl \
    unzip \
    python3.10 \
    python3.10-dev \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# download and install mujoco
RUN mkdir -p /root/.mujoco && \
    wget https://www.roboti.us/download/mujoco200_linux.zip -O mujoco.zip && \
    unzip mujoco.zip -d /root/.mujoco && \
    rm mujoco.zip

# download and install the mujoco key
RUN wget https://www.roboti.us/file/mjkey.txt -O /root/.mujoco/mjkey.txt

# set up environment variables
ENV LD_LIBRARY_PATH /root/.mujoco/mujoco200/bin:${LD_LIBRARY_PATH}
ENV MUJOCO_GL=osmesa

# Install Python dependencies
RUN python3.10 -m pip install --no-cache-dir \
    numpy \
    matplotlib \
    torch \
    torchvision \
    ray[rllib] \
    gym \
    mujoco-py==2.0.2.13

# copy the current directory contents into the container at /app
COPY . /app

# Set the entry point to VSCode's default command# 设置入口命令
CMD ["/bin/bash"]

