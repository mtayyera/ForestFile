import FWCore.ParameterSet.Config as cms

# beamid: Nuclei: Z*10000+A*10, Xe-129-54 : 541290
generator = cms.EDFilter("ReggeGribovPartonMCGeneratorFilter",
    # impact parameter min in fm
    bmin = cms.double(0),
    # impact parameter max in fm
    bmax = cms.double(15),
    # file with more parameters specific to crmc interface
    # https://cmsdoc.cern.ch/cms/data/CMSSW/Configuration/Generator/data/ReggeGribovPartonMC.param
    paramFileName = cms.untracked.string("Configuration/Generator/data/ReggeGribovPartonMC.param"),
    # in HI collisions nuclear fragments with pt=0 can be in the hep event. to skip those activate this option
    skipNuclFrag = cms.bool(True),
    beammomentum = cms.double(2681),
    targetmomentum = cms.double(-2681),
    beamid = cms.int32(100200),
    targetid = cms.int32(100200),
    model = cms.int32(0),
)

configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.2 $'),
    name = cms.untracked.string('$Source: /local/reps/CMSSW/CMSSW/Configuration/GenProduction/python/ReggeGribovPartonMC_EposLHC_PbPb_MinimumBias_cfi.py,v $'),
    annotation = cms.untracked.string('ReggeGribovMC generator')
)
