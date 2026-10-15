import Proofs.HadwigerNelson.Rigidity.ChainHeadline
/-!
FS131-IJN1 — the new headline's conclusion is the old headline's, as the kernel stores them: both stored types are opened
at the same two variables (`F` and its `NumberField` instance), every remaining hypothesis is stripped, and the two
conclusions are compared as terms (`==`, alpha-equivalence). Prints `SAME` or `DIFFERENT` for each pair, the stored type of
the new headline in full (`pp.explicit`), and its hypotheses one per line. **Control:** the old headline's conclusion
against the conclusion of its own hypothesis `hRow99` (`localBound F ≤ χ`), which must read `DIFFERENT`.
  lake env lean data/fs131/ijn1/lean/HeadlineCheck.lean > data/fs131/ijn1/headline-check.txt
-/
open Lean Elab Command Meta

namespace FS131IJN1Headline

/-- The conclusion of a type, after the first two binders are instantiated with `xs`: strip every further `∀`. -/
partial def concl (t : Expr) : Expr :=
  match t with
  | .forallE _ _ b _ => if b.hasLooseBVars then t else concl b
  | _ => t

def hyps : Expr → List Expr
  | .forallE _ d b _ => if b.hasLooseBVars then [] else d :: hyps b
  | _ => []

def run : CommandElabM Unit := liftTermElabM do
  let new := (← getConstInfo `HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber).type
  let old := (← getConstInfo `HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber_of_closed).type
  forallBoundedTelescope new (some 2) fun xs bodyNew => do
    let bodyOld ← instantiateForall old xs
    let cNew := concl bodyNew
    let cOld := concl bodyOld
    IO.println s!"CONCLUSION new vs old: {if cNew == cOld then "SAME" else "DIFFERENT"}"
    IO.println s!"  new: {← ppExpr cNew}"
    IO.println s!"  old: {← ppExpr cOld}"
    -- the control: the old headline's last hypothesis, `hRow99`, concludes `localBound F ≤ χ`, not the headline
    let hs := hyps bodyOld
    let row99 := hs.getLast!
    let cRow99 := concl row99
    IO.println s!"CONTROL old conclusion vs hRow99's conclusion: {if cRow99 == cOld then "SAME" else "DIFFERENT"} (must be DIFFERENT)"
    IO.println s!"HYPOTHESES of the new headline ({(hyps bodyNew).length}), after `F` and `[NumberField F]`:"
    for h in hyps bodyNew do
      IO.println s!"  {← ppExpr h}"
    IO.println s!"HYPOTHESES of the old headline ({hs.length}):"
    for h in hs do
      IO.println s!"  {← ppExpr h}"
    -- `hRow99` is kept verbatim: the new headline's last hypothesis equals the old one's
    IO.println s!"hRow99 new vs old: {if (hyps bodyNew).getLast! == row99 then "SAME" else "DIFFERENT"}"
  IO.println "STORED TYPE (pp.explicit):"
  let t ← withOptions (fun o => o.setBool `pp.explicit true |>.setBool `pp.universes true) <| ppExpr new
  IO.println s!"{t}"

#eval run

end FS131IJN1Headline
