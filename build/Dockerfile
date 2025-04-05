# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

FROM rockylinux:9 AS builder
WORKDIR /root
RUN yum update -y && \
    yum upgrade -y && \
    yum install -y git cmake bpftool clang llvm-toolset && \
    dnf --enablerepo=devel install -y libbpf-devel && \
    git clone --recursive https://github.com/intel/processwatch.git -b v1.1
WORKDIR /root/processwatch
RUN ./build.sh

FROM rockylinux:9
RUN yum update -y && \
    yum upgrade -y && \
    yum install -y ncurses nginx
WORKDIR /etc/nginx
RUN sed -i "s/auto/1/g" nginx.conf && \
    sed -i "s/application\/octet-stream/text\/plain/g" nginx.conf
COPY --from=builder /root/processwatch/processwatch /usr/local/bin/processwatch
COPY image /
WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 80/tcp
HEALTHCHECK NONE
