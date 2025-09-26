# Contact-Graspnet Docker Setup

This repository provides a setup for running the Contact-Graspnet inference inside a Docker container.

Pre-built image is hosted on Docker Hub (coming soon):

```bash

```

Contains:

- The ability to produce grasps on a scene using Contact-Graspnet's pretrained models
- GUI with docker is still a work in progress

## Requirements

- Docker and/or Docker Compose installed on a Linux machine
- Not tested outside of Linux, instructions are for Ubuntu but should work on any machine capable of running Docker

## Setup Instructions

### 1. Installing Docker & Compose on your machine

```bash
sudo apt update
sudo apt install docker.io docker-compose
```

### 2. Clone the repository

```bash
git clone https://github.com/JohnBrann/contact_graspnet_docker
cd contact_graspnet_docker
```

### 3. Start the container (coming soon)

```bash
docker-compose up -d
```

Then enter the container:

```bash
docker exec -it contact_graspnet_docker bash
```

#### 3.1 (Optional alternative: no docker compose)
If you do not wish to use docker compose but still don't want to build the image yourself:

<pre>
# Enable X11 access from Docker containers
xhost +local:docker

# Run the container
docker run --gpus all -it --rm --shm-size=32g \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v /home/csrobot/contact_graspnet/checkpoints/:/workspace/contact_graspnet/checkpoints \
  -v /home/csrobot/contact_graspnet/test_data/:/workspace/contact_graspnet/test_data \
  contact-graspnet:latest \
  bash -lc "\
    conda run -n contact-graspnet bash compile_pointnet_tfops.sh && \
    exec bash -l"
</pre>

#### 3.2  (Optional alternative: local image build)
Lastly, if you wish to build the docker image yourself:

<pre>
# Build the image
docker build -t contact-graspnet:latest .

# Enable X11 access from Docker containers
xhost +local:docker
  
# Run the container
docker run --gpus all -it --rm --shm-size=32g \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v /home/csrobot/contact_graspnet/checkpoints/:/workspace/contact_graspnet/checkpoints \
  -v /home/csrobot/contact_graspnet/test_data/:/workspace/contact_graspnet/test_data \
  contact-graspnet:latest \
  bash -lc "\
    conda run -n contact-graspnet bash compile_pointnet_tfops.sh && \
    exec bash -l"
</pre>

### 4. Generate Grasps

Inside the container:

```bash
python contact_graspnet/inference.py --np_path=/workspace/contact_graspnet/test_data/*.npy --local_regions --filter_grasps
```

This will generate grasps for the inputted point clouds. 

## Download Models and Data
  You will need to modify the mounted location of the model checkpoints and the location of the testing .npy point cloud input in the run commands above. It does not matter the directory at which these files are located on your system, as long as they mounted into the docker workspace it should work. 
### Model
Download trained models from [here](https://drive.google.com/drive/folders/1tBHKf60K8DLM5arm-Chyf7jxkzOr5zGl?usp=sharing) and copy them into the `checkpoints/` folder.
### Test data
Download the test data from [here](https://drive.google.com/drive/folders/1TqpM2wHAAo0j3i1neu3Xeru3_WnsYQnx?usp=sharing) and copy them them into the `test_data/` folder.

## Troubleshooting: Reset Docker Environment

To fully reset Docker:

```bash
docker ps -q | xargs -r docker stop
docker ps -aq | xargs -r docker rm
docker images -q | xargs -r docker rmi
```

To remove just this image:

```bash
docker stop arm_driver_ws
docker rm arm_driver_ws
docker rmi flynnbm/arm_driver_ws:jazzy
```

## Future Improvements

- Add more robot embodiments
- Add further instructions for creating and spawning models into scene
- Add some images to the instructions to make setup more clear
