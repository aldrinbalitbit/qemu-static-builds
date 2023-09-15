FROM debian:sid

ENV DEBIAN_FRONTEND=non-interactive
RUN apt-get update \
  && apt-get -qqy install --no-install-recommends \
    build-essential \
    ninja-build \
    git \
    ca-certificates \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev \
    libgcrypt-dev \
    zlib1g-dev \
    clang \
    clang++ \
    llvm \
    lld

RUN git clone --depth=1 https://github.com/qemu/qemu.git /qemu/src
WORKDIR /qemu/src
RUN CC=clang \
    CXX=clang++ \
    AR=llvm-ar \
    AS=llvm-as \
    LD=lld \
    NM=llvm-nm \
    OBJCOPY=llvm-objcopy \ 
    RANLIB=llvm-ranlib \
    STRIP=llvm-strip \
    ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-gcrypt \
    --enable-tools \
    --enable-linux-user \
  && make -j16 \
  && make install
