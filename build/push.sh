#!/bin/bash -v

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

IMAGENAME="processwatch"
tag=` date "+%Y%m%d" `

if [[ -z "${IMAGEREPOUSER}" ]]; then
    echo "Set env var IMAGEREPOUSER. Exiting..."
    exit
fi

if [[ $( echo "${IMAGEREPOUSER}" | grep -c "ecr.aws" ) -eq 1 ]]; then
    aws ecr-public get-login-password --region us-east-1 | docker login \
        --username AWS --password-stdin "${IMAGEREPOUSER}"
fi

docker rmi -f "${IMAGEREPOUSER}/${IMAGENAME}:${tag}"
docker tag "${IMAGENAME}:${tag}" "${IMAGEREPOUSER}/${IMAGENAME}:${tag}"
docker push "${IMAGEREPOUSER}/${IMAGENAME}:${tag}"

