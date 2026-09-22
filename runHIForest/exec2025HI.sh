#!/bin/bash

export HOME=${PWD}

tar xvaf submit.tgz
cd submit
bash ./runHiForest_2025.sh
cd ${HOME}
rm -r submit/
exit 0
