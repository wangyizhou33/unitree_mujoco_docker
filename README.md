## Commands to run the demo

### 1 Build the docker image
```sh
docker build -t unitree_mujoco .
```
`unitree_mujoco` image name can be anything else.  
Everything is compiled during the docker image building. 

### 2 Launch the simulator

```
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --gpus all unitree_mujoco bash
```

Note #1:  
`-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix` is for GLFW to be initialized correctly in the container.  

Note #2:  
I have a nvidia gpu device installed on my machine. So I am using `nvidia/opengl:base-ubuntu22.04` as the base image and `---gpus all` in the `docker run` command ([NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) needs to be installed on the host machine). If you don't have a gpu, I think `ubuntu:22.04` suffices as the base image and `---gpus all` should be dropped.

```sh
cd /unitree_mujoco/simulate/build/
./unitree_mujoco -r go2 -s scene_terrain.xml
```


### 3 Run the go2 standing controller
In the second terminal,
```sh
docker exec -it <docker_container_id> bash
```
```sh
cd /unitree_mujoco/example/cpp/build
./stand_go2
```

You should be able to see ![image](./docs/screenshot.jpg)


### TODO
Remove the local `mujoco-3.3.7` copy. Download the binary while building the image.