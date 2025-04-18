#!/bin/bash
set -e

# Update and install Debian packages
apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    curl \
    git \
    unzip \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libx11-dev \
    libgtk2.0-dev \
    libvtk7-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    mesa-utils \
    autoconf \
    automake \
    libtool \
    pkg-config \
    zlib1g-dev \
    libssl-dev \
    python3-dev \
    cython3 \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    libhdf5-dev \
    libnetcdf-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
