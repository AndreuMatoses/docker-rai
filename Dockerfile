# Set the base image
FROM ubuntu:20.04

# Avoid timezone prompt during packages installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system utils
RUN apt-get update && apt-get install -y \
    sudo g++ clang make cmake curl git wget python3-pip

# RAI dependencies: https://github.com/MarcToussaint/botop/tree/master?tab=readme-ov-file
# RUN apt-get update && apt-get install -y \
#     liblapack-dev libf2c2-dev libqhull-dev libeigen3-dev libann-dev libccd-dev \
#     libjsoncpp-dev libyaml-cpp-dev libpoco-dev libboost-system-dev portaudio19-dev libusb-1.0-0-dev libhidapi-dev \
#     libx11-dev libglu1-mesa-dev libglfw3-dev libglew-dev freeglut3-dev libpng-dev libassimp-dev pybind11-dev

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    libspdlog-dev \
    libfmt-dev

# Install python dependencies
RUN pip3 install pybind11 pybind11-stubgen
RUN pip3 install --upgrade pygments
RUN pip3 install jupyter nbconvert matplotlib

CMD ["/bin/bash"]