import Proofs.Basic
import Proofs.HadwigerNelson.UnitDistance
import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Field.Quadratic
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.Sat.Encoding
import Proofs.HadwigerNelson.Sat.Lrat
import Proofs.HadwigerNelson.Reduction
import Proofs.HadwigerNelson.Instances.Triangle
import Proofs.HadwigerNelson.Instances.Spindle
import Proofs.HadwigerNelson.Instances.SpindleBound

/-!
# Proofs

Root module and public import surface for the `proofs` library: `import Proofs`
brings in everything intended for downstream use, regardless of the internal file
layout (module tree deep, import surface flat — see `debruijn-init`).
-/
