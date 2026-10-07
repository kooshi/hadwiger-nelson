import Proofs.HadwigerNelson.Plane.OnePiece
/-! FS124-I2 — the five claims' theorems as the kernel holds them (`#check` prints the stored signature, every binder;
`LEAN.md`: read a leaf as the kernel has it, never as the file prints it), and the definitions their statements unfold to.
Run from the worktree against its build: lake env lean data/fs124/i2/lean/ClaimSigs.lean > data/fs124/i2/claim-sigs.txt -/
set_option pp.fullNames false
open HadwigerNelson.Plane
#check @shadow_open
#check @piece_type
#check @centre_half
#check @tight_centre
#check @tight_straddle
#print IsWeakColouringOn
#print AeProperOn
#print monoPairSet
#print unitShadow
#print IsTight
#print IsTightWith
