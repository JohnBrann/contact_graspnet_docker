# Base image: CUDA 11.8 with cuDNN 8 on Ubuntu 22.04 (includes dev‑tools)
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Force Qt (used by Mayavi/VTK) into offscreen rendering mode
ENV QT_QPA_PLATFORM=offscreen

# Install system utilities
RUN apt-get update && apt-get install -y \
        wget \
        git \
        libxrender1 \
        mesa-common-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up Miniconda installation directory
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH

# Download and install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
         -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p $CONDA_DIR \
    && rm /tmp/miniconda.sh \
    && conda init bash \
    && conda config --system --set auto_activate_base false

# Use bash login shell so that .bashrc (with conda init) is sourced
SHELL ["/bin/bash", "-lc"]

WORKDIR /workspace/contact_graspnet

# Clone the Contact-GraspNet source
RUN git clone https://github.com/JohnBrann/contact_graspnet .

# Remove the mayavi pin from environment.yaml (we'll install via conda-forge)
RUN sed -i '/mayavi==/d' environment.yaml

# Build the conda env and install extras: 
RUN conda env create -f environment.yaml \
    && conda install -n contact-graspnet -c conda-forge vtk mayavi matplotlib -y \
    && conda install -n contact-graspnet numpy=1.23.5 -y

RUN echo "conda activate contact-graspnet" >> ~/.bashrc

# Default to an interactive bash login shell
CMD ["bash", "-l"]
