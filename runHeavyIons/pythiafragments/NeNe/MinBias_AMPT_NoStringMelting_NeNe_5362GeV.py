import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter
# https://github.com/cms-sw/cmssw/blob/master/GeneratorInterface/AMPTInterface/python/amptDefaultParameters_cff.py
from GeneratorInterface.AMPTInterface.amptDefaultParameters_cff import *
generator = ExternalGeneratorFilter(
    cms.EDFilter("AMPTGeneratorFilter",
                 amptDefaultParameters,
                 firstEvent = cms.untracked.uint32(1),
                 firstRun = cms.untracked.uint32(1),
                 comEnergy = cms.double(5362.0),
                 frame = cms.string('CMS'),                         
                 proj = cms.string('A'),
                 targ = cms.string('A'),
                 iap  = cms.int32(20),
                 izp  = cms.int32(10),
                 iat  = cms.int32(20),
                 izt  = cms.int32(10),
                 bMin = cms.double(0),
                 bMax = cms.double(15)
    )
)

configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.1$'),
    name = cms.untracked.string('$Source: /cvs_server/repositories/CMSSW/CMSSW/GeneratorInterface/AMPTInterface/python/amptDefault_cfi.py,v $'),
    annotation = cms.untracked.string('AMPT OO 5362 GeV Minimum Bias')
)
