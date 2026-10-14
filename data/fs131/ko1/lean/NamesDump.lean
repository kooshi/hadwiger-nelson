import Proofs
-- FS131-KO1: every constant this library's compiled modules declare — module, kind, name, and whether the name is an
-- internal detail — so that the full port's names can be intersected with every name already here (main's library in
-- this tree; the density equality's branch in its own tree, by LEAN_PATH, read only).
open Lean Elab Command

namespace FS131KO1Names

def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .defnInfo _ => "def" | .thmInfo _ => "theorem" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec"

def run : CommandElabM Unit := do
  let env ← getEnv
  let mut out : Array String := #[]
  for (n, ci) in env.constants.map₁.toList do
    match env.getModuleIdxFor? n with
    | some idx =>
      let m := env.header.moduleNames[idx.toNat]!
      if (`Proofs).isPrefixOf m then
        out := out.push s!"NAME\t{m}\t{kindOf ci}\t{n}\t{if n.isInternalDetail then 1 else 0}"
    | none => pure ()
  for l in out.qsort (· < ·) do IO.println l
  IO.println s!"SUMMARY names={out.size}"

#eval run

end FS131KO1Names
