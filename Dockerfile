FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu/ jammy main multiverse restricted universe" > /etc/apt/sources.list \
  && echo "deb-src http://archive.ubuntu.com/ubuntu/ jammy main multiverse restricted universe" >> /etc/apt/sources.list \
  && apt-get -qqy update \
  && apt-get -qqy install \
    build-essential \
    ninja-build \
    git \
    ca-certificates \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
    libgcrypt-dev \
    libmount-dev \
    zlib1g-dev \
    python3-pip \
    python3-setuptools \
    flex \
    bison \
    meson \
  && apt-get -qqy build-dep qemu

RUN git clone --depth=1 https://gitlab.com/qemu-project/qemu.git /qemu/src
WORKDIR /qemu/src
RUN git submodule update --init \
  && ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-gcrypt \
    --enable-linux-user \
  && make -j16 \
  && make install
