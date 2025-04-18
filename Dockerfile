# FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04
# FROM ubuntu:22.04
# FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu22.04
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Setup environment
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# Copy helper script
COPY linux_dependencies_script.sh .
RUN ./linux_dependencies_script.sh

# Python & pip install
# RUN apt-get update && apt-get install -y python3.7 python3-pip && \
#     ln -s /usr/bin/python3 /usr/bin/python && \
#     pip3 install --upgrade pip setuptools==65.5.1 wheel

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && apt-get update && \
    apt-get install -y python3.7 python3.7-venv python3.7-dev python3-pip && \
    ln -sf /usr/bin/python3.7 /usr/bin/python && \
    pip3 install --upgrade pip setuptools==65.5.1 wheel

    
# Install Python dependencies
COPY requirements.txt .
# RUN pip3 install --no-cache-dir --ignore-installed -r requirements.txt

RUN python3.7 -m pip install --upgrade pip && \
    python3.7 -m pip install --no-cache-dir --ignore-installed -r requirements.txt

# # (Optional) Copy your model/training script into the image
# COPY . /workspace
# Clone and install Contact-GraspNet
RUN git clone https://github.com/NVlabs/contact_graspnet /workspace/contact_graspnet

WORKDIR /workspace/contact_graspnet

# # Default entrypoint (adjust to your train script)
# CMD ["python", "train.py"]

CMD ["/bin/bash"]
