FROM debian:sid

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "deb-src http://ftp.debian.org/debian/ sid main contrib non-free" >> /etc/apt/sources.list
  && apt-get -qqy update \
  && apt-get -qqy build-dep qemu

RUN git clone --depth=1 https://gitlab.com/qemu-project/qemu.git /qemu/src
WORKDIR /qemu/src
RUN ./configure \
    --prefix=/qemu/build \
    --static \
    --enable-tools \
    --enable-gcrypt \
    --enable-linux-user \
  && make -j16 \
  && make install
