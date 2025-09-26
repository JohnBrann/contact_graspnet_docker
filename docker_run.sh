#!/usr/bin/env bash
set -e
echo "Running contact_graspnet docker container test script:"
xhost +local:docker

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
