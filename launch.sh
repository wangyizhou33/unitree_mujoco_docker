#!/bin/bash

PROJECT_SOURCE_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-${(%):-%x}})/; pwd)

# Necessary! Otherwise there will be GLFW not initialized error in the container
xhost +local:docker

docker run -it --rm \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $PROJECT_SOURCE_DIR:/workspace \
           --gpus all \
           --name sim \
           unitree_mujoco bash