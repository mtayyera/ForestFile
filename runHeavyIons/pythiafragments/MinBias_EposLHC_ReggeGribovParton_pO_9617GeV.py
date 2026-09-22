import FWCore.ParameterSet.Config as cms

generator = cms.EDFilter(
    "ReggeGribovPartonMCGeneratorFilter",
    bmin = cms.double(0.0),
    bmax = cms.double(10.0),
    paramFileName = cms.untracked.string(
        "Configuration/Generator/data/ReggeGribovPartonMC.param"
    ),
    skipNuclFrag = cms.bool(True),

    # Asymmetric per-nucleon momenta (GeV/c)
    beammomentum   = cms.double(3400.0),    # oxygen moving +z
    targetmomentum = cms.double(-6800.0),   # proton moving –z

    # ID format: Z*10000 + A*10
    beamid   = cms.int32(80160),  # O-16: 8*10000 + 16*10 = 80160
    targetid = cms.int32(1),      # proton

    model = cms.int32(0),         # EPOS-LHC
)

configurationMetadata = cms.untracked.PSet(
    version    = cms.untracked.string('$Revision: 1.2 $'),
    name       = cms.untracked.string('$Source: $'),
    annotation = cms.untracked.string('EPOS O+p 9.62 TeV Minimum Bias')
)
