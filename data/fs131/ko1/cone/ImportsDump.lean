import OAI.Geometry.PlaneColoring.BorelTransfer
-- FS131-KO1: a first list of Mathlib imports per ported file, computed at the RELEASE's pin from the stored terms of
-- the cone of the transfer `OAI.EuclideanFiveColor.proper_to_borel_weak` and the rigidity lemma
-- `OAI.PlaneFiveColor.Spectral.residual_fourier`: for each OAI module, the modules declaring the non-OAI constants its
-- cone constants name, reduced to those not transitively imported by another of the list.  A starting point only
-- (tactic and notation modules leave no constant in a term); the build at this library's pin is what decides.  Prints
-- IMPORT <OAI module> <module>.  FS133-IA1's dumper (`data/fs133/ia1/cone/ImportsDump.lean`, branch `fs133-wb1`;
-- itself FS132-I2's) with this job's import and targets; nothing else changed.
open Lean Elab Command

namespace FS131KO1

def targets : Array Name := #[
  `OAI.EuclideanFiveColor.proper_to_borel_weak,
  `OAI.PlaneFiveColor.Spectral.residual_fourier]

def modIdx (env : Environment) (n : Name) : Option Nat := (env.getModuleIdxFor? n).map (·.toNat)

def isOAIIdx (env : Environment) (i : Nat) : Bool := (`OAI).isPrefixOf env.header.moduleNames[i]!

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
  -- the union cone, and per OAI module the outside modules it names
  let mut seen : NameSet := {}
  let mut stack : Array Name := targets
  for t in targets do seen := seen.insert t
  let mut need : Std.HashMap Nat (Std.HashSet Nat) := {}
  while !stack.isEmpty do
    let n := stack.back!
    stack := stack.pop
    let some ci := env.find? n | continue
    let some mi := modIdx env n | continue
    for m in usedOf ci do
      let some j := modIdx env m | continue
      if isOAIIdx env j then
        unless seen.contains m do
          seen := seen.insert m
          stack := stack.push m
      else
        need := need.insert mi ((need.getD mi {}).insert j)
  -- reduce: drop a module transitively imported by another of the same list
  for (mi, s) in need.toList do
    let mut covered : Std.HashSet Nat := {}
    for j in s do
      -- everything strictly below j
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
        if s.contains k then covered := covered.insert k
    let keep := s.toArray.filter (!covered.contains ·) |>.map (names[·]!.toString) |>.qsort (· < ·)
    for k in keep do IO.println s!"IMPORT\t{names[mi]!}\t{k}"

#eval run

end FS131KO1
