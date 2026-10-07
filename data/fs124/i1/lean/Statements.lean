import Proofs.HadwigerNelson.Plane.RadiusOutside
/-!
FS124-I1 — the statements as the kernel stores them (LEAN.md § Searching: read a leaf by what is stored, never
by the file's text).  For every constant declared by the three modules of the radius clause this prints one line:

    <kind> <full name> | type-hash <h> | value-hash <h or -> | <the type, pretty-printed>

The type hash is `Expr.hash` of the stored type (structural); the value hash is printed for definitions only
(a theorem's value is its proof, which this job changes).  `tools/fs124_i1_statements.py` compares a print made
before the job with one made after: every line of the first must be in the second, character for character.
-/
open Lean Elab Command Meta

def fs124Modules : List Name :=
  [`Proofs.HadwigerNelson.Plane.WeakColouringOn, `Proofs.HadwigerNelson.Plane.Radius,
   `Proofs.HadwigerNelson.Plane.RadiusOutside]

run_cmd do
  let env ← getEnv
  let mut rows : Array (String × String) := #[]
  for (n, ci) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let modName := env.header.moduleNames[idx.toNat]!
    unless fs124Modules.contains modName do continue
    let kind := match ci with
      | .thmInfo _ => "theorem"
      | .defnInfo _ => "def"
      | .inductInfo _ => "inductive"
      | .ctorInfo _ => "ctor"
      | .recInfo _ => "rec"
      | .axiomInfo _ => "axiom"
      | .opaqueInfo _ => "opaque"
      | .quotInfo _ => "quot"
    let vh := match ci with
      | .defnInfo d => toString d.value.hash
      | _ => "-"
    let ty ← liftTermElabM <| withOptions (fun o => o.setBool `pp.fullNames true) <| ppExpr ci.type
    let tyS := (toString ty).replace "\n" " "
    rows := rows.push (n.toString, s!"{kind} {n} | type-hash {ci.type.hash} | value-hash {vh} | {tyS}")
  for (_, r) in rows.qsort (fun a b => a.1 < b.1) do
    IO.println r
  IO.println s!"TOTAL {rows.size}"
