<<<<<<< HEAD
# Use the official ubuntu22.04 image
=======
# # Use the official ubuntu22.04 image
>>>>>>> 5be532695799298e9975d1eba423a21c37bcbaba
FROM ubuntu:22.04

# Set the working directory in the container
WORKDIR /app

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

<<<<<<< HEAD
# Create a non-root user and set permissions
# RUN useradd -m -d /home/apexuser apexuser
RUN useradd -m -d /home/apexuser -s /bin/bash apexuser
# Install the required system libraries
RUN apt-get update && apt-get install -y \
    apt-utils \
=======
# Install the required system libraries
RUN apt-get update && apt-get install -y \
>>>>>>> 5be532695799298e9975d1eba423a21c37bcbaba
    build-essential \
    cmake \
    gdb \
    valgrind \
    libboost-all-dev \
    libeigen3-dev \
<<<<<<< HEAD
    libglfw3 \
    libxrandr2 \
    libxinerama1 \
    libxcursor1 \
=======
>>>>>>> 5be532695799298e9975d1eba423a21c37bcbaba
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

<<<<<<< HEAD
# Install Tkinter for Python
RUN apt-get update && apt-get install -y python3-tk

# download and install mujoco
RUN mkdir -p /home/apexuser/.mujoco && \
    wget https://www.roboti.us/download/mujoco200_linux.zip -O mujoco.zip && \
    unzip mujoco.zip -d /home/apexuser/.mujoco && \
    rm mujoco.zip

# download and install the mujoco key
RUN wget https://www.roboti.us/file/mjkey.txt -O /home/apexuser/.mujoco/mjkey.txt

# set up environment variables
ENV MUJOCO_PATH="/home/apexuser/.mujoco/mujoco200_linux"
ENV LD_LIBRARY_PATH="/home/apexuser/.mujoco/mujoco200_linux/bin:${LD_LIBRARY_PATH}"
ENV MUJOCO_KEY_PATH="/home/apexuser/.mujoco/mjkey.txt"
ENV MUJOCO_GL=osmesa
# not warning for torch.load
ENV PYTHONWARNINGS="ignore:You are using `torch.load` with `weights_only=False`:FutureWarning"
# Update PATH to include local user scripts
ENV PATH="/home/apexuser/.local/bin:${PATH}"

# Copy the current directory contents into the container at /app
COPY . /app

# Change ownership of /app and .mujoco to non-root user
RUN chown -R apexuser:apexuser /app /home/apexuser/.mujoco

# Create the output directory and set permissions
# RUN mkdir -p /app/trained_models
# RUN chown -R apexuser:apexuser /app/trained_models

# Ensure that all files and subdirectories under /app/trained_models have the correct permissions
RUN mkdir -p /app/trained_models && \
    chown -R apexuser:apexuser /app/trained_models && \
    chmod -R 755 /app
# RUN ls -ld /app/trained_models && ls -l /app/trained_models

# Switch to the non-root user
USER apexuser

# Install Python dependencies
COPY requirements.txt /app/
RUN python3.10 -m pip install --no-cache-dir -r requirements.txt --user

# Set the entry point to VSCode's default command
CMD ["/bin/bash"]


=======
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

>>>>>>> 5be532695799298e9975d1eba423a21c37bcbaba
