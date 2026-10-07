import OAI.Geometry.PlaneColoring.Five
/-! EXT-OAI1, stage 8: for each candidate piece, the declarations of the release's library it rests on (transitively),
counted by module — what adopting that piece alone would have to bring. -/
open Lean in
def oaiClosure (env : Environment) (root : Name) : NameSet × Std.HashMap Name Nat := Id.run do
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
  let mut per : Std.HashMap Name Nat := {}
  for n in seen.toList do
    if let some m := modOf n then per := per.insert m (per.getD m 0 + 1)
  return (seen, per)
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let targets := ["proper_to_borel_weak", "wild_fourier", "continuum_limit_support_exclusion", "compact_open_cover_impossible",
    "graphTree_contractible", "forest_disk_extension", "annulus_forest_extension", "cyclicCore_compact_finite",
    "palette_cardinality", "binary_open_local_rigidity", "no_measurable_weak_five_coloring", "no_proper_five_coloring"]
  for t in targets do
    let cands := env.constants.fold (init := #[]) fun acc n _ =>
      if n.toString.startsWith "OAI." && n.getString! == t && !n.isInternal then acc.push n else acc
    for root in cands do
      let (seen, per) := oaiClosure env root
      let mods := per.toList.map (fun (m, k) => s!"{(m.toString.replace "OAI.Geometry.PlaneColoring." "PC.").replace "OAI.Analysis.PlaneSpectrum." "PS." |>.replace "OAI.MeasureTheory.CompactFactors." "CF."}:{k}")
      IO.println s!"PIECE {root} : decls={seen.size} modules={per.size} :: {String.intercalate " " (mods.toArray.qsort (· < ·)).toList}"
