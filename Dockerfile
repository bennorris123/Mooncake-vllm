# Base Image from Alibaba Cloud AC2
FROM ac2-registry.cn-hangzhou.cr.aliyuncs.com/ac2/pytorch-ubuntu:2.3.0-cuda12.1.1-ubuntu22.04

# Execute installation in the container
RUN  apt update
RUN  apt install -y unzip wget cmake git sudo
RUN  pip install pybind11
RUN  git clone https://github.com/kvcache-ai/Mooncake.git
RUN  cd Mooncake-main && bash dependencies.sh && . ~/.bashrc && mkdir build && cd build \
       && cmake .. && make VERBOSE=1 && make install
RUN git clone https://github.com/vllm-project/vllm.git
WORKDIR /vllm
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN sudo dpkg -i cuda-keyring_1.1-1_all.deb
RUN sudo apt-get update
RUN sudo apt-get -y install cuda-toolkit-12-8
RUN pip3 install cmake --upgrade
RUN pip3 install -e .
