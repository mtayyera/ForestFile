import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter

generator = ExternalGeneratorFilter(
    cms.EDFilter("HijingGeneratorFilter",
                 rotateEventPlane = cms.bool(True),
                 frame = cms.string('CMS     '),
                 targ = cms.string('A       '),
                 izt = cms.int32(10),
                 iat = cms.int32(20),
                 proj = cms.string('A       '),
                 izp = cms.int32(10),
                 iap = cms.int32(20),
                 comEnergy = cms.double(5362.0),
                 bMin = cms.double(0),
                 bMax = cms.double(15)
    )
)

configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.3 $'),
    annotation = cms.untracked.string('HIJING generator'),
    name = cms.untracked.string('$Source: /local/reps/CMSSW/CMSSW/Configuration/GenProduction/python/HI/Hijing_PPb_MinimumBias_cfi.py,v $')
)
