#!/bin/bash
export TARBALLDIR=$PWD
for FILE in inputs/my_pO_test_miniaod.txt
do
    echo  $FILE
    PROCESS=$(echo ${FILE} | cut -d "/" -f 2 | sed 's/\.txt//')
    export BASEDIR=${PWD}
    echo ${PROCESS}
    rm -r work${1}_${PROCESS}
    mkdir work${1}_${PROCESS}
    export SUBMIT_WORKDIR=${PWD}/work${1}_${PROCESS}
    year=${1}
    cp pythiafragments/forest_CMSSWConfig_Run3_OXY_MC_miniAOD.py  inputs/
    sed -i 's/FILENAME/'${PROCESS}'/g' inputs/forest_CMSSWConfig_Run3_OXY_MC_miniAOD.py
    process_tem=${PROCESS}
    dir_tmp=$(echo "${process_tem%_part*}")
    dirname=${dir_tmp}
    echo ${dirname}
    echo "Final Directory Name  :    " ${dirname}

    #copying necessary inputs
    rm -rf  ./submit/inputs.sh
    echo "HADRONIZER=${PROCESS}.txt" >> ./submit/inputs.sh
    echo "PROCESS=${PROCESS}" >> ./submit/inputs.sh
    echo "dirname=${dirname}" >> ./submit/inputs.sh
    echo "USERNAME=${USER}" >> ./submit/inputs.sh
    
    if [ -z "$2" ]
    then
	echo "MERGE=0" >> ./submit/inputs.sh
	echo "You want to produce events for $1. Good luck!"
    else
	echo "MERGE=1" >> ./submit/inputs.sh
	echo "You want to merge the T2 files for $1? Ok."
    fi
    
    
    if [ ${year} -eq 2026 ]; then
	mkdir -p ./submit/input/
	cp ${BASEDIR}/inputs/${PROCESS}.txt ./submit/input/
        cp ${BASEDIR}/inputs/forest_CMSSWConfig_Run3_OXY_MC_miniAOD.py ./submit/input/
	cp ${TARBALLDIR}/exec2025HI.sh $SUBMIT_WORKDIR/.
    fi
    
    #creating tarball
    echo "Tarring up submit..."
    tar -chzf submit.tgz submit
    rm -r ${TARBALLDIR}/submit/input/*
    mv submit.tgz $SUBMIT_WORKDIR
    rm -rf submit/inputs.sh
    #does everything look okay?
    ls -lh $SUBMIT_WORKDIR
done
