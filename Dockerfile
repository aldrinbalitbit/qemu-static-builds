FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qqy update \
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
    meson

RUN git clone --depth=1 https://gitlab.com/qemu-project/qemu.git /qemu/src
WORKDIR /qemu/src
RUN ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-gcrypt \
    --enable-linux-user \
  && make -j16 \
  && make install
