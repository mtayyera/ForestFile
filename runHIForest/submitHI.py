#!/usr/bin/env python

from sys import argv
from os import system,getenv,getuid,getcwd

logpath='/afs/cern.ch/user/m/mtayyera/work/runHIForest/Logs'
workpath=getcwd()+'/'+str(argv[1])
uid=getuid()

#njobs = argv[2]
njobs = 1

classad='''
universe = vanilla
executable = {0}/exec2025HI.sh
should_transfer_files = YES
when_to_transfer_output = ON_EXIT
transfer_input_files = {0}/submit.tgz
transfer_output_files = ""
input = /dev/null
output = {1}/$(Cluster)_$(Process).out
error = {1}/$(Cluster)_$(Process).err
log = {1}/$(Cluster)_$(Process).log
rank = Mips
request_memory = 7000
arguments = $(Process) 
use_x509userproxy = True
x509userproxy =  /afs/cern.ch/user/m/mtayyera/public/x509up
+AccountingGroup = "analysis.sdogra"
+AcctGroup = "analysis"
+ProjectName = "HeavyIonSimulation"
+JobFlavour = "workday"   
queue {3}
'''.format(workpath,logpath,uid,njobs)


with open(logpath+'/condor.jdl','w') as jdlfile:
  jdlfile.write(classad)
system('condor_submit %s/condor.jdl'%logpath)
