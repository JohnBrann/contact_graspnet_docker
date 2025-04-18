#!/bin/bash

echo "Running contact_graspnet docker container test script"

sudo docker run --gpus all -it --rm -v /home/csrobot/contact_graspnet/acronym/:/workspace/contact_graspnet/acronym \
        -v /home/csrobot/contact_graspnet/checkpoints/:/workspace/contact_graspnet/checkpoints \
        -v /home/csrobot/contact_graspnet/test_data/:/workspace/contact_graspnet/test_data \
        contact-graspnet:latest

