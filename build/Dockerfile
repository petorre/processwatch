# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

FROM rockylinux:9

WORKDIR /root
RUN yum update -y && \
    yum upgrade -y && \
    yum install -y git cmake bpftool clang llvm-toolset ncurses-devel nginx && \
    dnf --enablerepo=devel install -y libbpf-devel && \
    git clone --recursive https://github.com/intel/processwatch.git -b v1.1
WORKDIR /root/processwatch
RUN ./build.sh && \
    cp processwatch /usr/local/bin/
WORKDIR /etc/nginx
RUN sed -i "s/auto/1/g" nginx.conf && \
    sed -i "s/application\/octet-stream/text\/plain/g" nginx.conf
WORKDIR /root/processwatch

ENTRYPOINT ["/entrypoint.sh"]

COPY image /

EXPOSE 80/tcp

HEALTHCHECK NONE
