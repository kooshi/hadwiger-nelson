import Proofs.HadwigerNelson.Outside.OAI015Generating
import Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition
-- FS131-IP23 (FS131-IE1's `data/fs131/ie1/lean/ImportsDump.lean`, aimed at this job's two modules): a first list of Mathlib imports per ported module, computed at THIS pin from the modules generated with
-- `import Mathlib` whole (`tools/fs131_ie1_port.py --mathlib-whole`, compiled by `lean -o`): for each module, the
-- modules declaring the constants that its own stored constants name (types and values), reduced to those not
-- transitively imported by another of the list.  A starting point only (tactic and notation modules leave no constant
-- in a term); the elaboration at this pin decides.  Prints  IMPORT <module> <module>.  (FS132-I2's
-- `data/fs132/i2/cone/ImportsDump.lean`, for whole modules.)
open Lean Elab Command

namespace FS131IP23

def ours : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI015Generating,
  `Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition]

def usedOf (ci : ConstantInfo) : Array Name := Id.run do
  let mut s : NameSet := ci.type.getUsedConstantsAsSet
  let v? : Option Expr := match ci with
    | .defnInfo v => some v.value | .thmInfo v => some v.value | .opaqueInfo v => some v.value | _ => none
  if let some v := v? then
    for n in v.getUsedConstantsAsSet do s := s.insert n
  match ci with
  | .inductInfo v => for n in v.ctors do s := s.insert n
  | .ctorInfo v => s := s.insert v.induct
  | .recInfo v => for n in v.all do s := s.insert n
  | _ => pure ()
  return s.toArray

def run : CommandElabM Unit := do
  let env ← getEnv
  let names := env.header.moduleNames
  let mut idxOf : Std.HashMap Name Nat := {}
  for i in [0:names.size] do idxOf := idxOf.insert names[i]! i
  for m in ours do
    let some mi := idxOf[m]? | throwError "module {m} is not imported"
    let mut need : Std.HashSet Nat := {}
    let mut ncon := 0
    for ci in env.header.moduleData[mi]!.constants do
      ncon := ncon + 1
      for c in usedOf ci do
        let some j := (env.getModuleIdxFor? c).map (·.toNat) | continue
        if j != mi then need := need.insert j
    let mut covered : Std.HashSet Nat := {}
    for j in need do
      let mut st : Array Nat := #[]
      for imp in env.header.moduleData[j]!.imports do
        if let some k := idxOf[imp.module]? then st := st.push k
      let mut vis : Std.HashSet Nat := {}
      while !st.isEmpty do
        let k := st.back!
        st := st.pop
        if vis.contains k then continue
        vis := vis.insert k
        for imp in env.header.moduleData[k]!.imports do
          if let some l := idxOf[imp.module]? then
            unless vis.contains l do st := st.push l
      for k in vis do
        if need.contains k then covered := covered.insert k
    let keep := need.toArray.filter (!covered.contains ·) |>.map (names[·]!.toString) |>.qsort (· < ·)
    IO.println s!"MODULE\t{m}\tconstants={ncon}\tmodules-named={need.size}\tkept={keep.size}"
    for k in keep do IO.println s!"IMPORT\t{m}\t{k}"

#eval run

end FS131IP23
