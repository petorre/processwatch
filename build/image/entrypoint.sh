#! /bin/bash

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cd /usr/share/nginx/html

nginx &

if [[ -z "${PN}" ]]; then
    PN="ALL"
    echo "Info: Process name (PN) not set so using \"ALL\""
fi

while true; do
    processwatch -n 1 -c > pw
    clear
    echo -n "# "
    date
    echo "# PN=${PN}"
    awk -vPN="${PN}" ' NR==1 { split($0,f,","); l=length(f); } NR>=2 { split($0,a,","); if (a[3]==PN) for (i=0;i<l;i++) s[i]+=a[i]; } END { for (i=0;i<l;i++) if (s[i]>0 && f[i]!="pid") printf("%s: %s\n",f[i],s[i]); } ' pw | sort -n -k2 -r > metrics
    cat metrics
    sleep 1
done
