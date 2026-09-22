#!/bin/bash
export TARBALLDIR=$PWD
for FILE in pythiafragments/MinBias_Pythia_Angantyr_pO_9617GeV.py
do
    echo  $FILE
    PROCESS=$(echo ${FILE} | cut -d "/" -f 2 | sed 's/\.py//')
    echo ${PROCESS}
    rm -r work${1}_${PROCESS}
    mkdir work${1}_${PROCESS}
    export SUBMIT_WORKDIR=${PWD}/work${1}_${PROCESS}
    year=${1}
    dirname=${PROCESS}
    echo ${dirname}
    echo "Final Directory Name  :    " ${dirname}

    if [ ${year} -eq 2025 ]; then
        cp ./pythiafragments/${dirname}.py inputs/.
    fi

    echo "HADRONIZER=${dirname}.py  " >> ./submit/inputs.sh
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
    
    
    if [ ${year} -eq 2025 ]; then
	mkdir -p ./submit/input/
	cp ${TARBALLDIR}/inputs/${dirname}.py ./submit/input/
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
