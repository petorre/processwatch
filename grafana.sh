#! /bin/bash -v

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

docker run -e GF_SECURITY_ADMIN_PASSWORD=password --name=grafana --rm --network=host grafana/grafana &
sleep 5
#docker exec -it prometheus sh -c "echo ICAtIGpvYl9uYW1lOiAicHJvY2Vzc3dhdGNoIgogICAgc3RhdGljX2NvbmZpZ3M6CiAgICAgIC0gdGFyZ2V0czogWyJsb2NhbGhvc3Q6ODAiXQo= | base64 -d >> /etc/prometheus/prometheus.yml; kill -HUP 1; exit;"
docker exec -it grafana sh -c '
    cd /tmp;
    curl -o datasource.json http://localhost/grafana-datasource.json;
    curl --connect-timeout 5 -X "POST" "http://localhost:3000/api/datasources" -H "Content-Type: application/json" --user admin:password --data-binary @datasource.json;
    curl -o dashboard.json http://localhost/grafana-dashboard.json;
    curl --connect-timeout 5 -X "POST" "http://localhost:3000/api/dashboards/db" -H "Content-Type: application/json" --user admin:password --data-binary @dashboard.json;
'
