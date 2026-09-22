#!/bin/bash

export HOME=${PWD}

tar xvaf submit.tgz
cd submit
bash ./runEventGeneration_special.sh
cd ${HOME}
rm -r submit/
exit 0
