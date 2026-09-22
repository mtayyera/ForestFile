#!/bin/bash

cd /afs/cern.ch/user/m/mtayyera/work/runHIForest || exit 1

mkdir -p Logs

for i in 01 02 03 04 05 06 07
do
    W="work2026_official_pO_MC_part_${i}"

    echo "================================="
    echo "Submitting $W"
    echo "================================="

    if [ ! -d "$W" ]; then
        echo "ERROR: folder $W does not exist!"
        exit 1
    fi

    if [ ! -f "$W/submit.tgz" ]; then
        echo "ERROR: $W/submit.tgz not found!"
        exit 1
    fi

    chmod +x "$W/exec2025HI.sh"

    python3 submitHI.py "$W"
done

echo "All 7 jobs submitted."
