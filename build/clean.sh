#!/bin/bash

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

IMAGENAME="processwatch"

for id in $( docker image ls --format json | jq -r " select( .Repository == \"${IMAGENAME}\" ) | .ID " | sort -u ); do
    docker rmi -f "${id}"
done

if [[ ! -z "${IMAGEREPOUSER}" ]]; then
    for id in $( docker image ls --format json | jq -r " select( .Repository == \"${IMAGEREPOUSER}/${IMAGENAME}\" ) | .ID " | sort -u ); do
        docker rmi -f "${id}"
    done
fi
