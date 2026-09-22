import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter
from GeneratorInterface.AMPTInterface.amptDefaultParameters_cff import *
amptStringMelting = amptDefaultParameters.clone()
amptStringMelting.amptmode = cms.int32(4) 
# large rapidity
amptStringMelting.ntmax = cms.int32(1000)
# dNch/deta
amptStringMelting.stringFragA = cms.double(0.3)
amptStringMelting.stringFragB = cms.double(0.15)
amptStringMelting.alpha = cms.double(0.33)

# 3mb xs
amptStringMelting.mu = cms.double(2.265)

generator = ExternalGeneratorFilter(
    cms.EDFilter("AMPTGeneratorFilter",
                 amptStringMelting,
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
    annotation = cms.untracked.string('AMPT OO 5362 GeV Minimum Bias StringMelting')
)
