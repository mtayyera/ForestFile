import FWCore.ParameterSet.Config as cms
from GeneratorInterface.Core.ExternalGeneratorFilter import ExternalGeneratorFilter
from Configuration.Generator.Pyquen2015Settings_cff import *
from Configuration.Generator.PythiaUESettings_cfi import *

generator = ExternalGeneratorFilter(
    cms.EDFilter(
        "HydjetGeneratorFilter",
        aBeamTarget = cms.double(16.0),     # heavy-ion A (O-16); proton is implicit
        comEnergy   = cms.double(9617.0),   # sqrt(s_NN) in GeV

        qgpInitialTemperature     = cms.double(1.0),
        qgpProperTimeFormation    = cms.double(0.1),
        hadronFreezoutTemperature = cms.double(0.125),

        doRadiativeEnLoss   = cms.bool(True),
        doCollisionalEnLoss = cms.bool(True),

        qgpNumQuarkFlavor = cms.int32(0),
        numQuarkFlavor    = cms.int32(0),   # legacy

        sigmaInelNN = cms.double(70.0),
        shadowingSwitch = cms.int32(1),

        nMultiplicity          = cms.int32(18545),
        fracSoftMultiplicity   = cms.double(1.0),
        maxLongitudinalRapidity = cms.double(3.75),
        maxTransverseRapidity   = cms.double(1.160),
        angularSpectrumSelector = cms.int32(0),

        rotateEventPlane = cms.bool(True),
        allowEmptyEvents = cms.bool(False),
        embeddingMode    = cms.int32(0),

        hydjetMode = cms.string('kHydroQJets'),

        PythiaParameters = cms.PSet(
            pythiaUESettingsBlock,
            hydjetPythiaDefault = cms.vstring(
                'MSEL=0',
                'CKIN(3)=9.2',
                'MSTP(81)=1'
            ),
            myParameters = cms.vstring(
                'MDCY(310,1)=0'
            ),
            pythiaJets = cms.vstring(
                'MSUB(11)=1','MSUB(12)=1','MSUB(13)=1',
                'MSUB(28)=1','MSUB(53)=1','MSUB(68)=1'
            ),
            pythiaPromptPhotons = cms.vstring(
                'MSUB(14)=1','MSUB(18)=1','MSUB(29)=1','MSUB(114)=1','MSUB(115)=1'
            ),
            pythiaZjets = cms.vstring('MSUB(15)=1','MSUB(30)=1'),
            pythiaCharmoniumNRQCD = cms.vstring(
                'MSUB(421)=1','MSUB(422)=1','MSUB(423)=1','MSUB(424)=1','MSUB(425)=1',
                'MSUB(426)=1','MSUB(427)=1','MSUB(428)=1','MSUB(429)=1','MSUB(430)=1',
                'MSUB(431)=1','MSUB(432)=1','MSUB(433)=1','MSUB(434)=1','MSUB(435)=1',
                'MSUB(436)=1','MSUB(437)=1','MSUB(438)=1','MSUB(439)=1'
            ),
            pythiaBottomoniumNRQCD = cms.vstring(
                'MSUB(461)=1','MSUB(462)=1','MSUB(463)=1','MSUB(464)=1','MSUB(465)=1',
                'MSUB(466)=1','MSUB(467)=1','MSUB(468)=1','MSUB(469)=1','MSUB(470)=1',
                'MSUB(471)=1','MSUB(472)=1','MSUB(473)=1','MSUB(474)=1','MSUB(475)=1',
                'MSUB(476)=1','MSUB(477)=1','MSUB(478)=1','MSUB(479)=1'
            ),
            pythiaWeakBosons = cms.vstring('MSUB(1)=1','MSUB(2)=1'),
            pythiaQuarkoniaSettings = cms.vstring(
                'PARP(141)=1.16','PARP(142)=0.0119','PARP(143)=0.01','PARP(144)=0.01',
                'PARP(145)=0.05','PARP(146)=9.28','PARP(147)=0.15','PARP(148)=0.02',
                'PARP(149)=0.02','PARP(150)=0.085',
                'PARJ(13)=0.60','PARJ(14)=0.162','PARJ(15)=0.018','PARJ(16)=0.054',
                'MSTP(145)=0','MSTP(146)=0','MSTP(147)=0','MSTP(148)=1','MSTP(149)=1',
                'BRAT(861)=0.202','BRAT(862)=0.798','BRAT(1501)=0.013','BRAT(1502)=0.987',
                'BRAT(1555)=0.356','BRAT(1556)=0.644'
            ),
            parameterSets = cms.vstring(
                'pythiaUESettings',
                'hydjetPythiaDefault',
                'myParameters',
                'pythiaJets',
                'pythiaPromptPhotons',
                'pythiaZjets',
                'pythiaBottomoniumNRQCD',
                'pythiaCharmoniumNRQCD',
                'pythiaQuarkoniaSettings',
                'pythiaWeakBosons'
            )
        ),

        cFlag  = cms.int32(1),
        bMin   = cms.double(0.0),
        bMax   = cms.double(10.0),
        bFixed = cms.double(0.0),
    )
)
