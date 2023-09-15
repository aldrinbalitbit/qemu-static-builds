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
    zlib1g-dev

RUN git clone --depth=1 https://github.com/qemu/qemu.git /qemu/src
WORKDIR /qemu/src
RUN ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-gcrypt \
  && make -j16 \
  && make install
