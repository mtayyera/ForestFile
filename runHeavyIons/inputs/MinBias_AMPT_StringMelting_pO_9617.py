import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter
from GeneratorInterface.AMPTInterface.amptDefaultParameters_cff import *

amptStringMelting = amptDefaultParameters.clone()
amptStringMelting.ntmax = cms.int32(1000)
amptStringMelting.amptmode = cms.int32(4)  # string melting
# LHC suggestion (v1.26t9b-v2.26t9b)
amptStringMelting.stringFragA = cms.double(0.3)
amptStringMelting.stringFragB = cms.double(0.15)
amptStringMelting.alpha       = cms.double(0.47140452)
amptStringMelting.mu          = cms.double(3.2264)

generator = ExternalGeneratorFilter(
    cms.EDFilter(
        "AMPTGeneratorFilter",
        amptStringMelting,
        firstEvent = cms.untracked.uint32(1),
        firstRun   = cms.untracked.uint32(1),
        comEnergy  = cms.double(9617.0),
        frame      = cms.string('CMS'),
        # O + p (oxygen projectile, proton target)
        proj = cms.string('A'),   # nucleus
        targ = cms.string('P'),   # proton
        iap  = cms.int32(16),     # A (O-16)
        izp  = cms.int32(8),      # Z (O)
        iat  = cms.int32(1),      # A (p)
        izt  = cms.int32(1),      # Z (p)
        bMin = cms.double(0.0),
        bMax = cms.double(10.0),
    )
)

configurationMetadata = cms.untracked.PSet(
    version    = cms.untracked.string('$Revision: $'),
    name       = cms.untracked.string('$Source: $'),
    annotation = cms.untracked.string('AMPT O+p 9617 GeV Minimum Bias (StringMelting)')
)
