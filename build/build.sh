#!/bin/bash -v

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

IMAGENAME="processwatch"
tag=` date "+%Y%m%d" `

docker build --build-arg "TAG=${tag}" -t "${IMAGENAME}" .
docker tag "${IMAGENAME}:latest" "${IMAGENAME}:${tag}"
