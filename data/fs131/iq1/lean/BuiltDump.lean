import Proofs.HadwigerNelson.Arith.QuadraticPrime

/-! FS131-IQ1: print every public constant the BUILT module `Arith/QuadraticPrime` declares under
`HadwigerNelson.QuadraticPrime`, as its `.olean` stores it — kind, name, hash of the type, the type — in the format of
`StatementDump.footer`, so the two prints compare line for line. Reads the compiled module: run after the build. -/
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let some idx := env.getModuleIdx? `Proofs.HadwigerNelson.Arith.QuadraticPrime
    | throwError "module Proofs.HadwigerNelson.Arith.QuadraticPrime is not imported"
  let mut out : Array (String × String) := #[]
  for (n, ci) in env.constants.map₁.toList do
    if n.isInternal then continue
    if !(`HadwigerNelson.QuadraticPrime).isPrefixOf n then continue
    if env.getModuleIdxFor? n != some idx then continue
    let kind := match ci with
      | .thmInfo _ => "theorem"
      | .defnInfo _ => "def"
      | .inductInfo _ => "inductive"
      | .ctorInfo _ => "ctor"
      | .recInfo _ => "rec"
      | .opaqueInfo _ => "opaque"
      | .axiomInfo _ => "axiom"
      | .quotInfo _ => "quot"
    let ty ← liftTermElabM <| Meta.ppExpr ci.type
    out := out.push (n.toString, s!"STMT {kind} {n} #{hash ci.type} :: {(toString ty).replace "\n" " "}")
  for (_, l) in out.qsort (fun a b => a.1 < b.1) do
    IO.println l
