FROM ubuntu:18.04
LABEL maintainer="Teppei Fujisawa <fujisawa@symbol.company>"
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 LANGUAGE=C:en

RUN apt update -y && apt upgrade -y

RUN apt install -y python3 python3-pip cmake patchelf tar gzip curl wget unzip git netcat

# use gcc 8 for full c++14 function
RUN apt install -y gcc-8 g++-8 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8

WORKDIR /tmp
RUN wget https://launchpad.net/ubuntu/+source/patchelf/0.10-2/+build/17326601/+files/patchelf_0.10-2_amd64.deb && dpkg -i patchelf_0.10-2_amd64.deb
RUN pip3 install conan auditwheel

RUN conan profile new default --detect && conan profile update settings.compiler.libcxx=libstdc++11 default
