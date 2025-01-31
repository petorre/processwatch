# processwatch

Docker version of https://github.com/intel/optimized-cloud-recipes/blob/main/AMX_VALIDATION.md with added Prometheus scrapping and Grafana dashboard.

## Prepare

Build with

```
cd build
./build.sh
```

Publish to Docker Hub with

```
./push.sh
```

## Run

To get CPU instructions usage, run it with optional argument for a process name (that can run in multiple processes):

```
./run.sh [processname]
```

Get Prometheus scrapping and graph with:

```
./prometheus.sh
```

With modern browser like Edge observe usage of AVX512 on URL like http://hostFQDNorIP:9090/query?g0.expr=AVX512%3A&g0.show_tree=0&g0.tab=graph&g0.range_input=5m&g0.res_type=auto&g0.res_density=medium&g0.display_mode=lines&g0.show_exemplars=0

Start Grafana with:

```
./grafana.sh
```

With the browser open URL http://hostFQDNorIP:3000/dashboards , select dashboard "Processwatch", press key "v" to View it, reduce time range to "Last 15 minute" and set Refresh to "5s".

Now start some application workloads that are enabled to use AMX, AVX512 or other CPU instructions, and observe how usage of those goes up.

## Stop

Stop all containers with:

```
./stop.sh
```

which if started with scripts above will also remove those containers.
