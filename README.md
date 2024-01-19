# CS1952y: development environment

This repo contains a minimal dev environment setup for CSCI 1952y. 
In particular, it provides the scripts 
to create the course Docker container and setup gem5 and Ripes.

## Notes

See CS1680 for more info. To run our environment, you will need to configure 
**Docker**, the program that builds and runs the container, and an **X11** server, 
which will be used to display the Ripes window on your system. 

Some of the configuration steps here differ based on your host platform (i.e. Windows, Mac OS, 
Linux). Please follow the correct set of instructions for your platform.

### Install Docker

### Install X11 Server

You will need to have an X11 server installed ()

## Setting up the container environment

### Pulling the image (recommended)

```
# 1. pull image
cd docker
./cs1952y-setup-docker
# 2. start development environment
cd ..
./cs1952y-run-docker
```

### Building the image from scratch

```
# 1. Docker Desktop > settings > resources
make sure memory limit is set to 16 GB, swap to 2 GB, and virtual disk limit to 128 GB
# 2. build docker image locally
cd docker
./cs1952y-build-docker
# 3. start development environment
cd ..
./cs1952y-run-docker
```

## Acknowledgements

This setup is a modified version of the setup used by
[CSCI 0300](https://cs.brown.edu/courses/csci0300/2023/assign/labs/lab0.html).
