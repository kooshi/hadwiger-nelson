import Proofs.HadwigerNelson.Outside.OAI158States
import Proofs.HadwigerNelson.Outside.OAI158AngularBoundary
-- FS132-I2: the four statements as this library holds them (run after the build: `lake env lean data/fs132/i2/checks.lean`).
open HadwigerNelson.Outside.OAI158
set_option pp.fullNames false
#check @palette_transfer_pair
#check @palette_sixty_disjoint
#check @two_state_impossible
#check @mem_spatialSupport_ae
-- the two lemmas the planner's successor asked for
#check @circleSum_quasiMeasurePreserving
#check @angleMk_quasiMeasurePreserving
-- the definitions the four statements name
#print angularSum
#print sixty
#print RealState
#print liftPalette
#print spatialSupport
#print palette
