FROM debian:sid

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get -qqy install --no-install-recommends \
    build-essential \
    ninja-build \
    git \
    ca-certificates \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
    libgcrypt20-dev \
    zlib1g-dev \
    python3-pip \
    python3-setuptools \
    flex \
    bison

RUN git clone --depth=1 https://gitlab.com/qemu-project/qemu.git /qemu/src
WORKDIR /qemu/src
RUN ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-tools \
    --enable-gcrypt \
    --enable-linux-user \
  && make \
  && make install
