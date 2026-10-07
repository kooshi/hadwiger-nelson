import OAI.Geometry.PlaneColoring.States
import OAI.Geometry.PlaneColoring.AngularBoundary
-- FS132-I2: the cone of the four statements, computed at the RELEASE's pin (Lean v4.34.1) from the release's own
-- compiled constants: every constant of an `OAI.*` module that the stored type or the stored proof of a target names,
-- transitively.  Run with v4.34.1's `lean` and LEAN_PATH set to the audit's compiled copy (no `lake`: nothing is
-- written there).  Prints, tab-separated:
--   DECL  module  first  last  owner            every source declaration of every OAI module in the import closure
--   CONE  module  first  last  owner  kind  name  mask     one line per OAI constant in the union cone
--   EDGE  from  to                                            dependencies between OAI constants of the cone
--   NORANGE name                                              an OAI constant with no source declaration found
open Lean Elab Command

namespace FS132I2

def targets : Array Name := #[
  `OAI.EuclideanFiveColor.palette_transfer_pair,
  `OAI.EuclideanFiveColor.palette_sixty_disjoint,
  `OAI.EuclideanFiveColor.two_state_impossible,
  `OAI.EuclideanFiveColor.mem_spatialSupport_ae]

def modOf (env : Environment) (n : Name) : Option Name :=
  match env.getModuleIdxFor? n with
  | some idx => some env.header.moduleNames[idx.toNat]!
  | none => none

def isOAI (env : Environment) (n : Name) : Bool :=
  match modOf env n with
  | some m => (`OAI).isPrefixOf m
  | none => false

def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .defnInfo _ => "def" | .thmInfo _ => "theorem" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec"

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

/-- The OAI constants reachable from `root`, and the edges between them. -/
def closure (env : Environment) (root : Name) : NameSet × Array (Name × Name) := Id.run do
  let mut seen : NameSet := {}
  let mut edges : Array (Name × Name) := #[]
  let mut stack : Array Name := #[root]
  seen := seen.insert root
  while !stack.isEmpty do
    let n := stack.back!
    stack := stack.pop
    match env.find? n with
    | none => pure ()
    | some ci =>
      for m in usedOf ci do
        if isOAI env m then
          edges := edges.push (n, m)
          if !seen.contains m then
            seen := seen.insert m
            stack := stack.push m
  return (seen, edges)

partial def owner (n : Name) : CoreM (Option (Name × DeclarationRanges)) := do
  if let some r ← findDeclarationRanges? n then return some (n, r)
  match n with
  | .str p _ => owner p
  | .num p _ => owner p
  | .anonymous => return none

def run : CommandElabM Unit := do
  let env ← getEnv
  for t in targets do
    unless env.contains t do throwError "target {t} is not in the environment"
  -- every source declaration of every OAI module
  let mut decls : Std.HashSet String := {}
  let mut lines : Array String := #[]
  for (n, _) in env.constants.map₁.toList do
    if isOAI env n then
      match ← liftCoreM (owner n) with
      | some (o, r) =>
        let m := (modOf env o).getD .anonymous
        let key := s!"DECL\t{m}\t{r.range.pos.line}\t{r.range.endPos.line}\t{o}"
        unless decls.contains key do
          decls := decls.insert key
          lines := lines.push key
      | none => pure ()
  for l in lines.qsort (· < ·) do IO.println l
  -- the cones
  let mut mask : NameMap Nat := {}
  let mut allEdges : Std.HashSet (Name × Name) := {}
  let mut i := 0
  for t in targets do
    let (seen, edges) := closure env t
    for n in seen do
      mask := mask.insert n ((mask.find? n).getD 0 ||| (1 <<< i))
    for e in edges do allEdges := allEdges.insert e
    i := i + 1
  let mut out : Array String := #[]
  for (n, b) in mask do
    let some ci := env.find? n | continue
    match ← liftCoreM (owner n) with
    | some (o, r) =>
      let m := (modOf env n).getD .anonymous
      out := out.push s!"CONE\t{m}\t{r.range.pos.line}\t{r.range.endPos.line}\t{o}\t{kindOf ci}\t{n}\t{b}"
    | none => out := out.push s!"NORANGE\t{n}"
  for l in out.qsort (· < ·) do IO.println l
  let mut eo : Array String := #[]
  for (a, b) in allEdges do eo := eo.push s!"EDGE\t{a}\t{b}"
  for l in eo.qsort (· < ·) do IO.println l
  IO.println s!"SUMMARY targets={targets.size} cone-constants={mask.size} decl-lines={lines.size}"

#eval run

end FS132I2
