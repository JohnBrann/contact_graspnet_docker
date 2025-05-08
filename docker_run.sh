#!/usr/bin/env bash
set -e
echo "Running contact_graspnet docker container test script:"

docker run --gpus all -it --rm --shm-size=32g \
  -v /home/csrobot/contact_graspnet/acronym/:/workspace/contact_graspnet/acronym \
  -v /home/csrobot/contact_graspnet/checkpoints/:/workspace/contact_graspnet/checkpoints \
  -v /home/csrobot/contact_graspnet/test_data/:/workspace/contact_graspnet/test_data \
  -v /home/csrobot/grasp_planning/contact_graspnet/:/workspace/contact_graspnet \
  contact-graspnet:latest \
  bash -lc "\
    conda run -n contact-graspnet bash compile_pointnet_tfops.sh && \
    exec bash -l"
