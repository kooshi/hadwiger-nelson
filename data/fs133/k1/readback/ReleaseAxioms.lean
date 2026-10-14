import OAI.Geometry.PlaneColoring.Five
/-! FS133-K1 — at the release's pin, from its compiled constants: the axioms of `residual_fourier`, and whether its
cone (the release's declarations it rests on, transitively) lies inside the cone of the transfer theorem. -/
#print axioms OAI.PlaneFiveColor.Spectral.residual_fourier
#print axioms OAI.PlaneFiveColor.Spectral.wild_fourier
open Lean in
def oaiClosure (env : Environment) (root : Name) : NameSet := Id.run do
  let modOf (n : Name) : Option Name := (env.getModuleIdxFor? n).bind fun i => env.header.moduleNames[i.toNat]?
  let isOAI (n : Name) : Bool := match modOf n with | some m => (`OAI).isPrefixOf m | none => false
  let mut seen : NameSet := {}
  let mut stack : Array Name := #[root]
  while !stack.isEmpty do
    let n := stack.back!
    stack := stack.pop
    if seen.contains n then continue
    seen := seen.insert n
    if let some ci := env.find? n then
      let used := ci.type.getUsedConstants ++ (match ci.value? (allowOpaque := true) with | some v => v.getUsedConstants | none => #[])
      for u in used do
        if !seen.contains u && isOAI u then stack := stack.push u
  return seen
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let r := oaiClosure env ``OAI.PlaneFiveColor.Spectral.residual_fourier
  let t := oaiClosure env ``OAI.EuclideanFiveColor.proper_to_borel_weak
  let w := oaiClosure env ``OAI.PlaneFiveColor.Spectral.wild_fourier
  let missing := r.toList.filter fun n => !t.contains n
  IO.println s!"CONE residual_fourier={r.size} transfer={t.size} wild_fourier={w.size}"
  IO.println s!"CONE residual_fourier not in transfer: {missing.length} {missing.take 5}"
  IO.println s!"CONE wild_fourier not in residual_fourier: {(w.toList.filter fun n => !r.contains n).length}"
