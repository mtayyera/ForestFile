import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter

generator = ExternalGeneratorFilter(
    cms.EDFilter(
        "HijingGeneratorFilter",
        rotateEventPlane = cms.bool(True),
        frame = cms.string('CMS     '),   # keep padding for HIJING
        # Target (proton) — many examples keep 'A' here; A/Z define the particle
        targ = cms.string('A       '),
        izt  = cms.int32(1),              # Z of proton
        iat  = cms.int32(1),              # A of proton

        # Projectile (oxygen)
        proj = cms.string('A       '),
        izp  = cms.int32(8),              # Z of oxygen
        iap  = cms.int32(16),             # A of oxygen

        comEnergy = cms.double(9617.0),
        bMin = cms.double(0.0),
        bMax = cms.double(15.0),
    )
)

configurationMetadata = cms.untracked.PSet(
    version    = cms.untracked.string('$Revision: 1.3 $'),
    annotation = cms.untracked.string('HIJING O+p 9.62 TeV Minimum Bias'),
    name       = cms.untracked.string('$Source: .../Hijing_OP_MinimumBias_cfi.py,v $')
)
