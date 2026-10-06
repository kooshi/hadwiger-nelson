import Proofs.HadwigerNelson.Plane.Chord
-- FS131-T4: `conj_e`'s copy in `Plane/Chord`, read in an environment that imports that module alone, so the list printed is the one
-- `Chord`'s own compiled data stores. `#print` shows the proof term the environment holds.
set_option pp.fullNames true
#print axioms HadwigerNelson.Plane.conj_e
#print HadwigerNelson.Plane.conj_e
