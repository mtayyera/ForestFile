#!/bin/bash

DATASET="/MinBias_Angatyr_9p62TeV_pythia/HINpOSpring25MiniAOD-NoPU_150X_mcRun3_2025_forpO_realistic_v9-v4/MINIAODSIM"

OUTDIR="/afs/cern.ch/user/m/mtayyera/work/runHIForest/inputs"
LIMIT=200000
PREFIX="official_pO_MC_part_"

cd "$OUTDIR" || exit 1

rm -f ${PREFIX}*.txt official_pO_MC_files_nevents.txt

echo "Getting file names and event numbers from DAS..."

dasgoclient -query="file dataset=$DATASET | grep file.name,file.nevents" > official_pO_MC_files_nevents.txt

echo "Splitting into about $LIMIT events per txt file..."

awk -v limit="$LIMIT" -v prefix="$PREFIX" '
BEGIN {
    part=1;
    sum=0;
    out=sprintf("%s%02d.txt", prefix, part);
}
{
    file="";
    nev=0;

    for (i=1; i<=NF; i++) {
        if ($i ~ /^\/store\/.*\.root$/) file=$i;
        if ($i ~ /^[0-9]+$/) nev=$i;
    }

    if (file=="" || nev==0) next;

    if (sum > 0 && sum + nev > limit) {
        printf("Created %s with %d events\n", out, sum);
        close(out);
        part++;
        sum=0;
        out=sprintf("%s%02d.txt", prefix, part);
    }

    print file >> out;
    sum += nev;
}
END {
    printf("Created %s with %d events\n", out, sum);
    print "Done.";
}
' official_pO_MC_files_nevents.txt
