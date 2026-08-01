import Proofs.Basic
import Proofs.HadwigerNelson.UnitDistance
import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Field.Quadratic
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.Packed
import Proofs.HadwigerNelson.PackedDiagnose
import Proofs.HadwigerNelson.Motion
import Proofs.HadwigerNelson.Pattern
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.Assembly
import Proofs.HadwigerNelson.AssemblyDiagnose
import Proofs.HadwigerNelson.Critical
import Proofs.HadwigerNelson.CriticalDiagnose
import Proofs.HadwigerNelson.Fan
import Proofs.HadwigerNelson.Forcer
import Proofs.HadwigerNelson.ForcerDiagnose
import Proofs.HadwigerNelson.Fractional
import Proofs.HadwigerNelson.FractionalSpec
import Proofs.HadwigerNelson.IndepSearch
import Proofs.HadwigerNelson.Sat.Encoding
import Proofs.HadwigerNelson.Sat.Lrat
import Proofs.HadwigerNelson.Sat.Mask
import Proofs.HadwigerNelson.Sat.ClauseTable
import Proofs.HadwigerNelson.Sat.MaskCheck
import Proofs.HadwigerNelson.Sat.Diagnose
import Proofs.HadwigerNelson.Reduction
import Proofs.HadwigerNelson.Instances.Triangle
import Proofs.HadwigerNelson.Instances.Spindle
import Proofs.HadwigerNelson.Instances.SpindleBound
import Proofs.HadwigerNelson.Instances.DeGrey
import Proofs.HadwigerNelson.Instances.DeGrey.Split
import Proofs.HadwigerNelson.Instances.DeGrey.Forcing
import Proofs.HadwigerNelson.Instances.DeGrey.Rotation
import Proofs.HadwigerNelson.Instances.DeGrey.Rotated
import Proofs.HadwigerNelson.Instances.DeGrey.Controls
import Proofs.HadwigerNelson.Instances.DeGrey.Bound
import Proofs.HadwigerNelson.Instances.CoreSpindle.Cert
import Proofs.HadwigerNelson.Instances.CoreSpindle.Weights
import Proofs.HadwigerNelson.Instances.CoreSpindle.Search
import Proofs.HadwigerNelson.Instances.CoreSpindle.Bound
import Proofs.HadwigerNelson.Instances.CoreSpindle.Diagnose
import Proofs.HadwigerNelson.Instances.Heule510
import Proofs.HadwigerNelson.Instances.Heule510.Critical
import Proofs.HadwigerNelson.Instances.Heule510.Bound
import Proofs.HadwigerNelson.Instances.Heule553
import Proofs.HadwigerNelson.Instances.Heule553.Critical
import Proofs.HadwigerNelson.Instances.Heule553.Bound
import Proofs.HadwigerNelson.Instances.Mycielski
import Proofs.HadwigerNelson.Instances.Mycielski.Bound

/-!
# Proofs

Root module and public import surface for the `proofs` library: `import Proofs`
brings in everything intended for downstream use, regardless of the internal file
layout (module tree deep, import surface flat — see `debruijn-init`).
-/