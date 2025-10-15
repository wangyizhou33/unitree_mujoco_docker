FROM nvidia/opengl:base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libyaml-cpp-dev \
        libspdlog-dev \
        libboost-all-dev \
        libglfw3-dev \
        git-all \
        cmake \
        build-essential \
        libeigen3-dev \
        libfmt-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone, build, and install unitree_sdk2
RUN git clone https://github.com/unitreerobotics/unitree_sdk2.git /tmp/unitree_sdk2
WORKDIR /tmp/unitree_sdk2
RUN mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/opt/unitree_robotics && \
    make install -j8

# Set the working directory back to the root
WORKDIR /

# Clone unitree_mujoco
RUN git clone https://github.com/unitreerobotics/unitree_mujoco.git /unitree_mujoco

ADD ./mujoco-3.3.7 /unitree_mujoco/simulate/mujoco
WORKDIR /unitree_mujoco/simulate/
RUN mkdir build && \
    cd build && \
    cmake ..  &&\
    make -j8

WORKDIR /unitree_mujoco/example/cpp/
RUN mkdir build && \
    cd build && \
    cmake ..  &&\
    make -j8

WORKDIR /

# # make sure x11 is accessible https://nelkinda.com/blog/xeyes-in-docker/
# RUN useradd -ms /bin/bash user
# ENV DISPLAY :0
# USER user
