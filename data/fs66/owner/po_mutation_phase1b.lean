import Proofs.HadwigerNelson.Instances.ZMod121Four
open HadwigerNelson

-- The product owner's mutation (phase 1b review): the SAME edge list against a table with ONE point moved by (+1, 0)
-- must fail the kernel's edge check; the unmodified table must pass it.
def poMutatedPt (i : Fin 883) : ℕ × ℕ :=
  if i.val = 5 then ((zmod121FourPt i).1 + 1, (zmod121FourPt i).2) else zmod121FourPt i

example : zmod121FourEdges.all (fun e => unitPairNat 121 (poMutatedPt e.1) (poMutatedPt e.2)) = false := by
  decide +kernel
example : zmod121FourEdges.all (fun e => unitPairNat 121 (zmod121FourPt e.1) (zmod121FourPt e.2)) = true := by
  decide +kernel
-- and the wrong ring: the same table read modulo 11 * 11 + 1 = 122 is not a unit-distance drawing
example : zmod121FourEdges.all (fun e => unitPairNat 122 (zmod121FourPt e.1) (zmod121FourPt e.2)) = false := by
  decide +kernel

#print axioms chromaticNumber_unitQuadrance_zmod121
#check (chromaticNumber_unitQuadrance_zmod121 : (unitQuadrance (ZMod 121)).chromaticNumber = 5)
