#! /bin/bash -v

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

if [[ -z "$1" ]]; then
    PN="ALL"
else
    PN="$1"
fi

docker run -e PN="${PN}" --name=processwatch --rm -it --network=host --privileged ptorre/processwatch:20250131
