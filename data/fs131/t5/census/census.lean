import Proofs
/-!
FS131-T5, stage 1 — a census taken BEFORE the design, to measure what the design has to cover. Read-only: it
inspects the built environment and prints; it declares nothing the library sees. Not the gate's step.

For every hand-written constant of the library it reads the statement as written (`forallTelescope`, no unfolding)
and classifies each hypothesis — a binder whose type is a proposition — by:

* `closed`      — the binder's type holds no free variable: a statement about the world, not about the theorem's
                  parameters;
* `head`        — the constant at the head of the binder's type, and whether the library declares it;
* occurrences of library `Prop`-formers (non-theorem constants whose type, as written, ends in `Prop`) anywhere
  in the binder's type, with a polarity: `A` assumed (positive inside the hypothesis), `P` (inside an antecedent
  of the hypothesis), `M` (under `↔` or an unknown head).

And for the conclusion: its head former, and whether the declaration has any hypothesis.

Printed rows (one per line, fixed prefixes):
  FORMER <name> kind=… arity=… hypHead=… hypHeadClosed=… hypA=… hypP=… hypM=… conclUncond=… conclCond=… conclNeg=… doc=<flags>
  CLOSED <decl> binder=<name> info=<bi> refutation=<bool> head=<const> ours=<bool> :: <type>
  NAMED  <decl> binder=<name> :: <type>                      (binder names like hRow99, hR78, hRQ4)
  TOTALS …
Run from the worktree, after the build:
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/t5/census/census.lean
-/
open Lean Meta Elab Command

namespace T5Census

def moduleOf? (env : Environment) (n : Name) : Option Name :=
  (env.getModuleIdxFor? n).bind fun idx => env.header.moduleNames[idx.toNat]?

def isOurs (env : Environment) (n : Name) : Bool :=
  match moduleOf? env n with
  | some m => (`Proofs.HadwigerNelson).isPrefixOf m || m == `Proofs
  | none => false

def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

/-- A library non-theorem constant whose type, as written, ends in `Prop`. -/
def isFormer (env : Environment) (n : Name) (ci : ConstantInfo) : MetaM Bool := do
  if !isOurs env n || n.isInternal || isGeneratedDecl env n ci then return false
  match ci with
  | .defnInfo _ | .inductInfo _ | .opaqueInfo _ | .axiomInfo _ =>
    forallTelescope ci.type fun _ concl => pure concl.isProp
  | _ => return false

inductive Pol | A | P | M deriving BEq, Inhabited
def Pol.flip : Pol → Pol | .A => .P | .P => .A | .M => .M

/-- Occurrences of formers in the proposition `e`, read at polarity `pol` (`A`: `e` is assumed). -/
partial def occs (formers : NameSet) (e : Expr) (pol : Pol) : MetaM (Array (Name × Pol × Bool)) := do
  let e ← instantiateMVars e
  let mention (e : Expr) : Array (Name × Pol × Bool) :=
    (e.getUsedConstants.filter formers.contains).map fun c => (c, Pol.M, false)
  match e with
  | .forallE .. =>
    forallTelescope e fun xs body => do
      let mut out := #[]
      for x in xs do
        let t ← inferType x
        if ← isProp t then out := out ++ (← occs formers t pol.flip)
        else out := out ++ mention t
      return out ++ (← occs formers body pol)
  | _ =>
    let fn := e.getAppFn
    let args := e.getAppArgs
    match fn.constName? with
    | some ``And | some ``Or =>
      let mut out := #[]
      for a in args do out := out ++ (← occs formers a pol)
      return out
    | some ``Not => occs formers args[0]! pol.flip
    | some ``Iff =>
      let mut out := #[]
      for a in args do out := out ++ (← occs formers a .M)
      return out
    | some ``Exists =>
      match args.getD 1 default with
      | Expr.lam n t b bi =>
        withLocalDecl n bi t fun x => do
          return mention t ++ (← occs formers (b.instantiate1 x) pol)
      | _ => return mention e
    | some c =>
      let rest := (args.foldl (fun acc a => acc ++ mention a) #[])
      if formers.contains c then return #[(c, pol, true)] ++ rest else return rest
    | none => return mention e

structure Tally where
  hypHead : Nat := 0
  hypHeadClosed : Nat := 0
  hypA : Nat := 0
  hypP : Nat := 0
  hypM : Nat := 0
  conclUncond : Array Name := #[]
  conclCond : Nat := 0
  conclNeg : Nat := 0
  conclM : Nat := 0
  takers : Array Name := #[]

def bump (t : Std.HashMap Name Tally) (h : Name) (f : Tally → Tally) : Std.HashMap Name Tally :=
  t.insert h (f (t[h]?.getD {}))

def oneLine (e : Expr) : MetaM String := do
  try return ((← ppExpr e).pretty 1000000).replace "\n" " " catch _ => return "<did not pretty-print>"

def docFlags (doc : String) : String :=
  let d := doc.toLower
  let has (w : String) := (d.splitOn w).length > 1
  let fl := (if has "named hypothes" then ["named"] else []) ++ (if has "outside the backlog" then ["outside-backlog"] else [])
    ++ (if has "external" then ["external"] else []) ++ (if has "classical" then ["classical"] else [])
    ++ (if has "[hand" then ["hand"] else []) ++ (if has "[tools]" then ["tools"] else [])
    ++ (if has "not in mathlib" then ["not-in-mathlib"] else []) ++ (if has "hypothes" then ["hypothes"] else [])
    ++ (if has "unproved" then ["unproved"] else []) ++ (if has "open" then ["open"] else [])
  ",".intercalate fl

def nameLooksLikeRow (s : String) : Bool :=
  let cs := s.toList
  let strip (p : List Char) : Option (List Char) := if p.isPrefixOf cs then some (cs.drop p.length) else none
  let digits (r : List Char) : Bool := !r.isEmpty && r.head!.isDigit
  [("hRow".toList), ("hR".toList), ("hRQ".toList), ("hrow".toList), ("hG".toList), ("hFS".toList), ("hJ".toList), ("hX".toList)].any fun p =>
    match strip p with | some r => digits r | none => false

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let all := env.constants.toList
  let mut formers : NameSet := {}
  let mut kinds : Std.HashMap Name String := {}
  for (n, ci) in all do
    if ← (try isFormer env n ci catch _ => pure false) then
      formers := formers.insert n
      let kind := match ci with
        | .inductInfo _ => if isClass env n then "class" else if isStructure env n then "structure" else "inductive"
        | .axiomInfo _ => "axiom" | .opaqueInfo _ => "opaque" | _ => "def"
      kinds := kinds.insert n kind
  let mut t : Std.HashMap Name Tally := {}
  let mut nDecl : Nat := 0; let mut nThm : Nat := 0; let mut nBinders : Nat := 0; let mut nHyp : Nat := 0; let mut nClosed : Nat := 0
  let mut nHypFormerHead : Nat := 0; let mut nHypOtherConstHead : Nat := 0; let mut nHypNoConstHead : Nat := 0; let mut nInstHyp : Nat := 0
  let mut failed : Nat := 0
  for (n, ci) in all do
    if n.isInternal || !isOurs env n || isGeneratedDecl env n ci then continue
    nDecl := nDecl + 1
    let isThm := match ci with | .thmInfo _ => true | _ => false
    if isThm then nThm := nThm + 1
    let r ← (try forallTelescope ci.type fun xs concl => do
        let mut rows : Array String := #[]
        let mut hyps : Array (Name × Pol × Bool × Bool) := #[]   -- former, pol, head, closed
        let mut counts : Array Nat := #[0, 0, 0, 0, 0, 0, 0]  -- binders, hyp, closed, formerHead, otherConstHead, noConstHead, instHyp
        let stated := concl
        let refutation := stated.isConstOf ``False
        let mut anyHyp := false
        for x in xs do
          counts := counts.modify 0 (· + 1)
          let d ← x.fvarId!.getDecl
          let ty ← instantiateMVars d.type
          if !(← isProp ty) then continue
          if d.binderInfo.isInstImplicit then
            counts := counts.modify 6 (· + 1)
          else anyHyp := true
          counts := counts.modify 1 (· + 1)
          let closed := !ty.hasFVar && !ty.hasMVar
          let head := ty.getAppFn.constName?
          match head with
          | some h => if formers.contains h then counts := counts.modify 3 (· + 1) else counts := counts.modify 4 (· + 1)
          | none => counts := counts.modify 5 (· + 1)
          if closed then
            counts := counts.modify 2 (· + 1)
            rows := rows.push s!"CLOSED {n} binder={d.userName} info={if d.binderInfo.isInstImplicit then "inst" else if d.binderInfo.isExplicit then "explicit" else "implicit"} thm={isThm} refutation={refutation} head={head.getD `_} ours={(head.map (isOurs env)).getD false} :: {← oneLine ty}"
          if nameLooksLikeRow d.userName.toString then
            rows := rows.push s!"NAMED {n} binder={d.userName} :: {← oneLine ty}"
          for (c, pol, isHead) in ← occs formers ty .A do
            hyps := hyps.push (c, pol, isHead && ty.getAppFn.constName? == some c, closed)
        let co ← occs formers stated .A   -- polarity A here means: positive in the conclusion
        return some (rows, hyps, counts, co, anyHyp)
      catch _ => pure none)
    let some (rows, hyps, counts, co, anyHyp) := r | failed := failed + 1; continue
    for row in rows do logInfo m!"{row}"
    nBinders := nBinders + counts[0]!; nHyp := nHyp + counts[1]!; nClosed := nClosed + counts[2]!
    nHypFormerHead := nHypFormerHead + counts[3]!; nHypOtherConstHead := nHypOtherConstHead + counts[4]!
    nHypNoConstHead := nHypNoConstHead + counts[5]!; nInstHyp := nInstHyp + counts[6]!
    for (c, pol, isHead, closed) in hyps do
      t := bump t c fun x =>
        let x := if isHead then { x with hypHead := x.hypHead + 1, hypHeadClosed := x.hypHeadClosed + (if closed then 1 else 0) } else x
        let x := match pol with
          | .A => { x with hypA := x.hypA + 1 } | .P => { x with hypP := x.hypP + 1 } | .M => { x with hypM := x.hypM + 1 }
        if pol == .A && !x.takers.contains n then { x with takers := x.takers.push n } else x
    for (c, pol, _) in co do
      t := bump t c fun x => match pol with
        | .A => if anyHyp then { x with conclCond := x.conclCond + 1 } else { x with conclUncond := x.conclUncond.push n }
        | .P => { x with conclNeg := x.conclNeg + 1 }
        | .M => { x with conclM := x.conclM + 1 }
  logInfo m!"=== T5 CENSUS === formers={formers.size} declarations={nDecl} theorems={nThm} untelescoped={failed}"
  let rowsSorted := (t.toArray.qsort fun a b => a.1.toString < b.1.toString)
  let mut nTaken : Nat := 0; let mut nNever : Nat := 0
  for (c, x) in rowsSorted do
    if x.hypA + x.hypM == 0 then continue
    nTaken := nTaken + 1
    if x.conclUncond.size + x.conclCond == 0 then nNever := nNever + 1
    let doc := (← findDocString? env c).getD ""
    logInfo m!"FORMER {c} kind={kinds[c]?.getD "?"} hypHead={x.hypHead} hypHeadClosed={x.hypHeadClosed} hypA={x.hypA} hypP={x.hypP} hypM={x.hypM} takers={x.takers.size} conclUncond={x.conclUncond.size} conclCond={x.conclCond} conclNeg={x.conclNeg} conclM={x.conclM} doc={docFlags doc} :: uncond={x.conclUncond.toList.take 3}"
  logInfo m!"TOTALS binders={nBinders} hypotheses={nHyp} instHypotheses={nInstHyp} closed={nClosed} hypFormerHead={nHypFormerHead} hypOtherConstHead={nHypOtherConstHead} hypNoConstHead={nHypNoConstHead} formersTaken={nTaken} formersTakenNeverConcluded={nNever}"
  logInfo m!"=== END ==="

end T5Census

#eval T5Census.run
