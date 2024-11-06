FROM amazonlinux:2023

RUN dnf install -y \
    gcc \
    gcc-c++ \
    gdb \
    cmake \
    make \
    python3.11-devel \
    python3.11-pip \
    less \
    wget \
    vi \
    git \
    which \
    procps \
    boost-devel \
    && dnf clean all

#
# spdlog(installed under /usr/local/include/spdlog)
#
RUN git clone https://github.com/gabime/spdlog.git \
    && cd spdlog && mkdir build && cd build \
    && cmake .. \
    && make -j \
    && make install \
    && cd ../../ \
    && rm -rf spdlog

CMD ["/bin/bash"]