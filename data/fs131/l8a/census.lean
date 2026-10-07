import Proofs
/-!
FS131-L8A (FS131-L5's `data/fs131/l5/census.lean`, as the last three landings ran it, with its scope changed to the twelve modules this
landing brings — the eleven of `Plane/RingCalculus/` and wave 7's foundation `Plane/SimpleOn`; nothing else is changed)
— a census of the predicates and structures a theorem may take as a hypothesis, for `scripts/Vacuity.lean`'s procedure
("How a later wave registers its carriers": IN iff "does one exist" is a theorem rather than a construction, or the predicate can
be refuted at a concrete instance).  Read-only: it inspects the environment and prints; it declares nothing the library sees.

For every constant of the twelve modules that is a definition, structure or inductive whose type ends in a
sort (a predicate when that sort is `Prop`), one `PRED` line with what the library holds about it, read the way the scan's `gather`
and `carriersOf` read (the recognizers below follow theirs; they are not imported, since `scripts/Vacuity.lean` runs its audit when
elaborated):

* `sites`        — binders of the package's hand-written declarations whose type has this head (reducing telescope, as `carriersOf`);
* `closedSites`  — those of them whose type holds no free variable (a hypothesis at a concrete instance);
* `refut`        — unconditional theorems stating `¬ P …` at a closed instance (the scan's emptiness evidence), by name;
* `isEmpty`      — unconditional `IsEmpty (P …)` at a closed instance, by name;
* `witness`      — unconditional theorems or definitions whose statement is `P …` or `Nonempty (P …)` at a closed instance, by name;
* `condRefut`    — theorems with hypotheses stating `¬ P …` (no evidence to the scan; listed so that none is mistaken for one).

Run from the worktree, after the build:  lake env lean data/fs131/l8a/census.lean > data/fs131/l8a/census.out
-/
open Lean Meta Elab Command

namespace L5Census

/-- The module a constant was imported from, if any. -/
def moduleOf? (env : Environment) (n : Name) : Option Name :=
  (env.getModuleIdxFor? n).bind fun idx => env.header.moduleNames[idx.toNat]?

/-- The package's own modules (the scan's `isOurs`, for imported constants). -/
def isOurs (env : Environment) (n : Name) : Bool :=
  match moduleOf? env n with
  | some m => (`Proofs.HadwigerNelson).isPrefixOf m || m == `Proofs
  | none => false

/-- The modules whose predicates are listed: the twelve this landing brings (the eleven of `Plane/RingCalculus/` and wave 7's
foundation `Plane/SimpleOn`). -/
def inScope (m : Name) : Bool :=
  [`Proofs.HadwigerNelson.Plane.RingCalculus.Basic,
   `Proofs.HadwigerNelson.Plane.RingCalculus.Star,
   `Proofs.HadwigerNelson.Plane.RingCalculus.Empty,
   `Proofs.HadwigerNelson.Plane.RingCalculus.HubCount,
   `Proofs.HadwigerNelson.Plane.RingCalculus.TilesAt,
   `Proofs.HadwigerNelson.Plane.RingCalculus.SoleTip,
   `Proofs.HadwigerNelson.Plane.RingCalculus.RingColour,
   `Proofs.HadwigerNelson.Plane.RingCalculus.StarChart,
   `Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub,
   `Proofs.HadwigerNelson.Plane.RingCalculus.SemiHubPlaces,
   `Proofs.HadwigerNelson.Plane.RingCalculus.OuterAdj,
   `Proofs.HadwigerNelson.Plane.SimpleOn].contains m

/-- Copied from `scripts/Vacuity.lean` (`isGeneratedDecl`): machine-written API of a `structure` or `inductive`. -/
def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

/-- What kind of hypothesis-former a constant is: `some true` a predicate (its type ends in `Prop`), `some false` a family of
types (ends in another sort), `none` neither. Theorems, constructors and projections are never one. -/
def formerKind? (env : Environment) (n : Name) (ci : ConstantInfo) : MetaM (Option Bool) := do
  if isGeneratedDecl env n ci then return none
  match ci with
  | .defnInfo _ | .inductInfo _ | .opaqueInfo _ =>
    -- the type as written: a reducing telescope would open `Set α` into `α → Prop` and call every set a predicate
    forallTelescope ci.type fun _ concl =>
      pure (if concl.isProp then some true else if concl.isSort then some false else none)
  | _ => return none

structure Tally where
  sites       : Nat := 0
  closedSites : Nat := 0
  refut       : Array Name := #[]
  isEmpty     : Array Name := #[]
  witness     : Array Name := #[]
  condRefut   : Nat := 0

/-- Are all of these binders instance-implicit (the scan's "unconditional")? -/
def allInstImplicit (xs : Array Expr) : MetaM Bool :=
  xs.allM fun x => do return (← x.fvarId!.getDecl).binderInfo.isInstImplicit

/-- `e` holds no free variable and no metavariable: a concrete instance. Asked inside the telescope that introduced the binders. -/
def isClosed (e : Expr) : Bool := !e.hasFVar && !e.hasMVar

def bump (t : Std.HashMap Name Tally) (h : Name) (f : Tally → Tally) : Std.HashMap Name Tally :=
  match t[h]? with
  | some x => t.insert h (f x)
  | none => t

/-- One declaration's contribution to the tallies. -/
def readDecl (n : Name) (ci : ConstantInfo) (t : Std.HashMap Name Tally) : MetaM (Std.HashMap Name Tally) := do
  let mut t := t
  -- the stated conclusion, unreduced: a `¬ P …`
  let stated : Option (Name × Bool × Bool) ← (try forallTelescope ci.type fun xs concl => do
      let some p := (if concl.getAppFn.constName? == some ``Not then concl.getAppArgs[0]? else none) | return none
      let some h := p.getAppFn.constName? | return none
      return some (h, ← allInstImplicit xs, isClosed p)
    catch _ => pure none)
  if let some (h, uncond, closed) := stated then
    if uncond && closed then t := bump t h fun x => { x with refut := x.refut.push n }
    else t := bump t h fun x => { x with condRefut := x.condRefut + 1 }
  -- the binders and the conclusion behind definitions, as the scan's `carriersOf` and `gather` read them
  let (heads, concl?) ← (try forallTelescopeReducing ci.type fun xs concl => do
      let mut hs : Array (Name × Bool) := #[]
      for x in xs do
        let τ ← instantiateMVars (← inferType x)
        if let some h := τ.getAppFn.constName? then hs := hs.push (h, isClosed τ)
      let c : Option (Name × Name × Bool) :=
        match concl.getAppFn.constName? with
        | some w =>
          if w == ``IsEmpty || w == ``Nonempty then
            match concl.getAppArgs[0]? with
            | some a => (a.getAppFn.constName?).map fun h => (w, h, isClosed a)
            | none => none
          else some (`self, w, isClosed concl)
        | none => none
      let c := if ← allInstImplicit xs then c else none
      return (hs, c)
    catch _ => pure (#[], none))
  for (h, closed) in heads do
    t := bump t h fun x => { x with sites := x.sites + 1, closedSites := x.closedSites + (if closed then 1 else 0) }
  if let some (w, h, closed) := concl? then
    if closed then
      if w == ``IsEmpty then t := bump t h fun x => { x with isEmpty := x.isEmpty.push n }
      else t := bump t h fun x => { x with witness := x.witness.push n }
  return t

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let all := env.constants.toList
  -- 1. the hypothesis-formers in scope
  let mut preds : Array (Name × Name × Bool × String) := #[]
  let mut t : Std.HashMap Name Tally := {}
  for (n, ci) in all do
    if n.isInternal then continue
    let some m := moduleOf? env n | continue
    if !inScope m then continue
    let some isProp ← (try formerKind? env n ci catch _ => pure none) | continue
    let kind := match ci with
      | .inductInfo _ => if isStructure env n then "structure" else "inductive"
      | _ => "def"
    preds := preds.push (n, m, isProp, kind)
    t := t.insert n {}
  -- 2. what the package's hand-written declarations say about them
  let mut read : Nat := 0
  for (n, ci) in all do
    if n.isInternal || !isOurs env n || isGeneratedDecl env n ci then continue
    read := read + 1
    t ← readDecl n ci t
  logInfo m!"=== L8A CENSUS === formers={preds.size} declarations-read={read}"
  for (n, m, isProp, kind) in preds.qsort (fun a b => a.2.1.toString < b.2.1.toString || (a.2.1 == b.2.1 && a.1.toString < b.1.toString)) do
    let x := t[n]?.getD {}
    logInfo m!"PRED {n} module={m} kind={kind} prop={isProp} sites={x.sites} closedSites={x.closedSites} refut={x.refut.size} isEmpty={x.isEmpty.size} witness={x.witness.size} condRefut={x.condRefut} :: refut={x.refut.toList} isEmpty={x.isEmpty.toList} witness={x.witness.toList.take 6}"
  logInfo m!"=== END ==="

end L5Census

#eval L5Census.run
