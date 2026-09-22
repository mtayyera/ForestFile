###########
# setup
export BASEDIR=`pwd`
############# inputs
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh
source inputs.sh

############# make a working area

echo " Start to work now"
pwd
mkdir -p ./work
cd    ./work
export WORKDIR=`pwd`

############## generate LHEs

RANDOMSEED=`od -vAn -N4 -tu4 < /dev/urandom`
RANDOMSEED=`echo $RANDOMSEED | rev | cut -c 3- | rev` #Sometimes the RANDOMSEED is too long for madgraph

#Run
TempNumber=${RANDOMSEED}
outfilename_tmp="$PROCESS"'_'"$RANDOMSEED"
outfilename="${outfilename_tmp//[[:space:]]/}"

ls -lhrt
#############
#############
# Generate GEN-SIM
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=el9_amd64_gcc12
cmsrel CMSSW_15_0_11
cd CMSSW_15_0_11/src
eval `scram runtime -sh`
mkdir -p Configuration/GenProduction/python/
cd Configuration/GenProduction/python/
cp ${BASEDIR}/input/${HADRONIZER} ./
cd ../../../
scram b -j8

cmsDriver.py Configuration/GenProduction/python/${HADRONIZER}  --mc --eventcontent RAWDEBUG --datatier GEN-SIM-RAWDEBUG --conditions 150X_mcRun3_2025_forpO_realistic_v9  --beamspot DBrealistic --step GEN,SIM --scenario HeavyIons --geometry DB:Extended --era Run3_2025_OXY --python_filename ${outfilename}_gensim.py --customise_commands "process.RandomNumberGeneratorService.generator.initialSeed=int(${RANDOMSEED})" --fileout file:${outfilename}_gensim.root --no_exec -n 1000

cmsRun ${outfilename}_gensim.py

cmsDriver.py  digiraw --eventcontent RAWSIM --pileup HiMixNoPU --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-DIGI-RAW --conditions 150X_mcRun3_2025_forpO_realistic_v9 --step DIGI:pdigi_hi,L1,DIGI2RAW,HLT:PIon --geometry DB:Extended --era Run3_2025_OXY --fileout file:HIN-HINpOSpring25Digi-00001.root --filein file:${outfilename}_gensim.root --fileout file:${outfilename}_digiraw.root --python_filename ${outfilename}_digiraw.py --customise_commands "process.RAWSIMoutput.outputCommands.extend(['keep *_mix_MergedTrackTruth_*', 'keep *Link*_simSiPixelDigis__*', 'keep *Link*_simSiStripDigis__*'])"  --no_exec --mc -n 99999999

#cmsDriver.py digiraw --mc --eventcontent RAWSIM --datatier GEN-SIM-DIGI-RAW  --conditions 150X_mcRun3_2025_forpO_realistic_v9  --step DIGI:pdigi_hi,L1,DIGI2RAW,HLT:PIon --geometry DB:Extended --era Run3_2025_OXY  --customise_commands "process.RAWSIMoutput.outputCommands.extend(['keep *_mix_MergedTrackTruth_*', 'keep *Link*_simSiPixelDigis__*', 'keep *Link*_simSiStripDigis__*'])" --nThreads 4  --filein file:${outfilename}_gensim.root --fileout file:${outfilename}_digiraw.root --python_filename ${outfilename}_digiraw.py --no_exec -n 99999999

cmsRun ${outfilename}_digiraw.py

#cmsDriver.py reco --mc --eventcontent AODSIM --datatier AODSIM  --conditions 150X_mcRun3_2025_forpO_realistic_v9   --geometry DB:Extended --step RAW2DIGI,L1Reco,RECO,RECOSIM --era Run3_2025_OXY --nThreads 4  --customise_commands "process.AODSIMoutput.outputCommands.extend(['keep *_mix_MergedTrackTruth_*', 'keep *Link*_simSiPixelDigis__*', 'keep *Link*_simSiStripDigis__*', 'keep *_generalTracks__*', 'keep *_hiConformalPixelTracks__*', 'keep *_siPixelClusters__*', 'keep *_siStripClusters__*', 'keep *_towerMaker_*_*'])" --filein file:${outfilename}_digiraw.root --fileout file:${outfilename}_reco.root --python_filename ${outfilename}_reco.py --no_exec -n 99999

#i commented this
#cmsDriver.py  --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --conditions 150X_mcRun3_2025_forpO_realistic_v9 --step RAW2DIGI,L1Reco,RECO,RECOSIM --era Run3_2025_OXY --python_filename ${outfilename}_reco.py  --fileout file:${outfilename}_reco.root --filein file:${outfilename}_digiraw.root  --number 100 --number_out 100 --no_exec --mc -n 99999

cmsDriver.py  --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --conditions 150X_mcRun3_2025_forpO_realistic_v9 --step RAW2DIGI,L1Reco,RECO,RECOSIM --era Run3_2025_OXY --customise_commands "process.AODSIMoutput.outputCommands.extend(['keep *_mix_MergedTrackTruth_*', 'keep *_generalTracks__*', 'keep *_siPixelClusters__*', 'keep *_siStripClusters__*', 'keep *Link*_simSiPixelDigis__*', 'keep *Link*_simSiStripDigis__*'])" --python_filename ${outfilename}_reco.py  --fileout file:${outfilename}_reco.root --filein file:${outfilename}_digiraw.root  --number 100 --number_out 100 --no_exec --mc -n 99999



cmsRun ${outfilename}_reco.py

#cmsDriver.py miniaod --mc --eventcontent MINIAODSIM --datatier MINIAODSIM --conditions 150X_mcRun3_2025_forpO_realistic_v9  --geometry DB:Extended --step PAT --era Run3_2025_OXY  --filein file:${outfilename}_reco.root  --fileout file:${outfilename}_miniaod.root --python_filename ${outfilename}_miniaod.py --no_exec -n 99999

cmsDriver.py  miniaod --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --conditions 150X_mcRun3_2025_forpO_realistic_v9 --step PAT --geometry DB:Extended --era Run3_2025_OXY --python_filename ${outfilename}_miniaod.py --fileout file:${outfilename}_miniaod.root --filein file:${outfilename}_reco.root --number 300 --number_out 300 --no_exec --mc -n 999999
cmsRun ${outfilename}_miniaod.py


#xrdcp ${outfilename}_miniaod.root root://eoscms.cern.ch//store/group/phys_heavyions/sdogra/SpecialRuns/NeNe/MiniAOD/${dirname}/${outfilename}_miniaod.root
#xrdcp ${outfilename}_digiraw.root root://eoscms.cern.ch//store/group/phys_heavyions/sdogra/SpecialRuns/NeNe/DigiRaw/${dirname}/${outfilename}_digiraw.root


xrdcp ${outfilename}_miniaod.root root://eoscms.cern.ch//eos/cms/store/group/phys_heavyions/mtayyera/MC_RECO/${dirname}/${outfilename}_miniaod.root
xrdcp ${outfilename}_reco.root root://eoscms.cern.ch//eos/cms/store/group/phys_heavyions/mtayyera/MC_RECO/${dirname}/${outfilename}_reco.root
#xrdcp ${outfilename}_digiraw.root  root://eosuser.cern.ch//eos/user/m/mtayyera/pO_MC/${dirname}/${outfilename}_digiraw.root
