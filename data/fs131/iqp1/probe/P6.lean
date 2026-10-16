import Proofs.HadwigerNelson.PadicPlane.Upper
open HadwigerNelson
#check @QuotientAddGroup.out_eq'
#check @QuotientAddGroup.eq
#check @PadicInt.mem_subring_iff
#check @AddSubgroup.mem_prod
#check @SimpleGraph.colorable_chromaticNumber_of_fintype
#check @SimpleGraph.chromaticNumber_ne_top_iff_exists
#check @SimpleGraph.Colorable.chromaticNumber_ne_top
#check @ENat.coe_toNat
#check @MeasurableSpace.measurableSet_generateFrom
#check @PadicInt.ext
#check @PadicInt.coe_sub
#check @finitePlane
example (p : ℕ) [Fact p.Prime] : Fintype (ZMod p × ZMod p) := inferInstance
