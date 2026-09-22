#!/usr/bin/env bash                                                                                                                       
export HOME=$PWD
echo "SOURCE CMSSW"
source inputs.sh
source /cvmfs/cms.cern.ch/cmsset_default.sh
pwd
ls
export BASEDIR=`pwd`
############## generate LHEs                                                                                                              
RANDOMSEED=`od -vAn -N4 -tu4 < /dev/urandom`
RANDOMSEED=`echo $RANDOMSEED | rev | cut -c 3- | rev` #Sometimes the RANDOMSEED is too long for madgraph                                  

export SCRAM_ARCH=el9_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_15_0_11/src ] ; then
 echo release CMSSW_15_0_11 already exists
else
scram p CMSSW CMSSW_15_0_11
fi
cd CMSSW_15_0_11/src
eval `scramv1 runtime -sh`
git cms-merge-topic CmsHI:forest_CMSSW_15_0_X
scram b -j 8
cp ${BASEDIR}/input/* .
cmsRun forest_CMSSWConfig_Run3_OXY_MC_miniAOD.py
xrdcp ${PROCESS}.root root://eoscms.cern.ch//eos/cms/store/group/phys_heavyions/mtayyera/pO_official_MC/${PROCESS}.root
