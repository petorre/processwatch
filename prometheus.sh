#! /bin/bash -v

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

docker run --name=prometheus --rm --network=host prom/prometheus &
sleep 5
docker exec -it prometheus sh -c '
    echo "  - job_name: \"processwatch\"
    static_configs:
      - targets: [\"localhost:80\"]" >> /etc/prometheus/prometheus.yml;
    kill -HUP 1;
    exit;
'
