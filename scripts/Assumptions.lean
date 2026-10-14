/-
# The assumptions audit — what the library rests on that the kernel did not check, in both forms

This library's claim is that everything in it reduces to what the kernel checked plus what was explicitly
chosen to trust. An assumption enters in one of two ways, and until this file only one was listed:

* as an **`axiom`** — an outside theorem imported whole. It shows in `#print axioms`, and
  `scripts/Axioms.lean` audits it (`declareImport`).
* as a **hypothesis** — a proposition in a theorem's statement standing for an outside theorem, for a hand
  result of ours not yet in the kernel, or for an open question. A theorem that says "if Herglotz–Bochner
  holds, then …" prints the standard three axioms and is counted clean, as it should be; and then nothing
  shown to a reader says how much of the library is conditional, or on what. On 2026-10-06 the library was
  said to assume one outside theorem; it declared one as an axiom, and more entered as hypotheses, found by
  `grep` (`plans/FS131-close-inventory.md` items 548, 551).

**This file enumerates both forms, with the theorems that rest on each**, from the types and the axiom lists
the kernel holds — never from text. Run it through the gate script:

```
./scripts/assumptions.sh               the gate
./scripts/assumptions.sh --self-test   plant each fault the gate exists to catch, and watch it fire
./scripts/assumptions.sh --write-ledger
```

## What it can and cannot do

Whether a hypothesis is an *assumption* (the reader takes it on someone's word) or a *condition* (the user
discharges it at their own instance) is a fact about intent, and no type records it: `localBound F ≤ 5` is a
condition on `F`, and `localBound F ≤ 4 → localBound F ≤ χ(F²)` beside it in the same statement is row 99 of
our ledger, a hand result. So, like `scripts/Vacuity.lean`, this check **requires evidence** and never
passes over what it cannot decide in silence.

* **Declared** — the one list is `AssumptionAudit.declared`, at the end of this file: named hypotheses
  (`.former`), propositions written out in one binder (`.site`), and formers that are conditions and not
  assumptions (`.condition`, with the reason). Each assumption has a kind — `outside`, `ours`, `open` — and
  a source the gate resolves against `BIBLIOGRAPHY.md`, `LEDGER.md`, the grokkings and the derivations.
* **Decided, and failing when undeclared** — a *closed* hypothesis (its type holds no free variable: a
  statement about the world, not about the theorem's parameters) is declared, proved by the library, or the
  claim a refutation refutes, or the gate fails; so does a library `Prop`-former that is taken as a
  hypothesis and concluded by no theorem, and one whose docstring uses the library's own words for an
  assumption, when neither list holds it.
* **Counted and printed, never decided** — the other hypotheses of every theorem that takes a declared
  assumption (`COHYP`), theorems whose docstrings use the words and take nothing declared (`HINT`), and the
  class nothing here can see: a hand result written out as a hypothesis over the theorem's own variables, in
  a theorem none of whose hypotheses is declared. Its size is printed every run (`unseen=`).

## How a statement is read

Every hand-written constant's type is telescoped **as written**, with no unfolding. In a hypothesis `A`, an
occurrence of a former `H` positive in `A` — its head, under `∧`, `∨`, `∃`, `Fact`, or in the conclusion of
an implication inside `A` — is *assumed* (`TAKES`); one in an antecedent inside `A`, or under `¬`, is not;
one under `↔` or any other head is of unknown polarity (`MENTIONS`). In the conclusion the polarities are
the other way round: a positive occurrence is `PRODUCES` — a model of the assumption, a partial discharge,
or its derivation from other assumptions.

No closure over proofs is needed, and none is possible from a script (an imported theorem's proof term is
not in the environment; `scripts/Vacuity.lean`'s header has the measurement): a hypothesis does not travel
silently. A theorem that uses a conditional theorem supplies the hypothesis from a hypothesis of its own,
which is in its type; from a proof, which the kernel checked; or from an axiom, which is in its axiom list.
**The one silent channel is a definition that wraps an assumption** — `def Inputs F : Prop := H F ∧ …`, a
structure with a field `(h : H G)` — so the wrappers are computed to a fixed point and an occurrence of a
wrapper is read as an occurrence of what it wraps (`TAKES H T via W`).

## The rows — a contract with `scripts/assumptions.sh` and `scripts/gate_report.py`

`AXIOM <axiom> ref=bib:<Key>|MISSING theorems=<n>`; `RESTS <axiom> <theorem>`;
`ASSUMPTION <id> form=named|inline kind=<kind> ref=<class>:<token> consumers=<n> :: <source>`;
`TAKES <id> <theorem>[ via <wrapper>]`; `MENTIONS <id> <theorem>`; `PRODUCES <id> <theorem> general|uncond|cond`;
`REFUTES <id> <theorem>`; `SITE <id> <theorem> <binder> :: <type>`;
`CLOSED DECLARED|ESTABLISHED|PREMISE|REFUTED <theorem> <binder> :: <type>`;
`CONDITION <former> :: <reason>`; `SILENT <former> kind=<kind>`; `DERIVED <former> :: <producers>`;
`WRAPS <wrapper> <former>`; `COHYP <theorem> <binder> :: <type>`; `HINT <theorem>`;
`FAIL <kind> <culprit> :: <detail>`; then `=== SCANNED ===` and `=== TOTALS ===`, the accounting, whose
absence means the scan did not run to its end. An inline assumption's id is `inline:<Label>`.
-/
import Proofs

-- `lake env lean` does not apply the lakefile's options (LEAN.md § Building): without these a planted
-- control's stray identifier is auto-bound and the control becomes a different statement.
set_option autoImplicit false
set_option relaxedAutoImplicit false

open Lean Lean.Meta Lean.Elab Lean.Elab.Command

namespace AssumptionAudit

/-! ## The list's vocabulary -/

/-- Whose an assumption is. -/
inductive Kind
  /-- a theorem of the literature, not formalized here -/
  | outside
  /-- a result of ours held at [hand], [tools] or [cert], not in the kernel -/
  | ours
  /-- an open question or a design target a theorem is conditional on -/
  | «open»
  deriving BEq, Inhabited

def Kind.tag : Kind → String
  | .outside => "outside" | .ours => "ours" | .open => "open"

/-- One line of the list. Names are written with a double backtick, so a mistyped one does not elaborate. -/
inductive Entry
  /-- a named hypothesis: a library definition whose type ends in `Prop` -/
  | former (name : Name) (kind : Kind) (source : String)
  /-- a proposition written out in the binder `binder` of `decl`; sites with one label are one assumption -/
  | site (decl : Name) (binder : Name) (label : String) (kind : Kind) (source : String)
  /-- a library former that is a condition on a theorem's parameters and not an assumption, with the reason -/
  | condition (name : Name) (reason : String)
  /-- a closed hypothesis of `decl` that is not an assumption — the stated premise of an implication that is
  itself the content, or of a hand-off lemma whose premise the library proves in another form — with the reason -/
  | premise (decl : Name) (binder : Name) (reason : String)

/-! ## Pure readings: sources and docstrings (tested below, with no monad) -/

/-- A bibliography key in this project's form (`scripts/Axioms.lean`'s `isBibKey`, copied: that file runs its
audit when imported). -/
def isBibKey (k : String) : Bool :=
  let cs := k.toList
  let letters := cs.takeWhile Char.isAlpha
  let rest := cs.drop letters.length
  let digits := rest.takeWhile Char.isDigit
  let tail := rest.drop digits.length
  (cs.head?.map Char.isUpper).getD false && digits.length == 4 &&
    (tail.isEmpty || (tail.length == 1 && tail.all Char.isLower))

/-- The first bracketed bibliography key of `doc`, if any. -/
def bibKeyIn? (doc : String) : Option String :=
  ((doc.splitOn "[").drop 1).findSome? fun piece =>
    match piece.splitOn "]" with
    | k :: _ :: _ => if isBibKey k then some k else none
    | _ => none

/-- What a source points at. The gate resolves each against the records. -/
inductive Ref
  | bib (key : String) | row (n : String) | grokking (n : String) | stub (id : String) | entry (id : String)

def Ref.tag : Ref → String
  | .bib k => s!"bib:{k}" | .row n => s!"row:{n}" | .grokking n => s!"grokking:{n}"
  | .stub s => s!"stub:{s}" | .entry s => s!"entry:{s}"

/-- A word with trailing punctuation removed. -/
def bareWord (w : String) : String :=
  String.ofList (w.toList.reverse.dropWhile (fun c => c == ',' || c == ';' || c == ':' || c == '.' || c == ')')).reverse

/-- The reference a source opens with: `[Key2024] …`, `row 123 …`, `G56 …`, `FS-124 …`, or a derivation
entry id (`FS89-S0A-3`, `X23D-CLS`, `J45`): a word of letters, digits, `-` and `′` that starts with a capital
and holds a digit. -/
def parseRef (source : String) : Option Ref :=
  let s := source.trimAscii.copy
  let allDigits (cs : List Char) : Bool := !cs.isEmpty && cs.all Char.isDigit
  if s.toList.head? == some '[' then
    match (String.ofList (s.toList.drop 1)).splitOn "]" with
    | k :: _ :: _ => if isBibKey k then some (.bib k) else none
    | _ => none
  else
    match (s.splitOn " ").filter (· ≠ "") with
    | "row" :: n :: _ => let n := bareWord n; if allDigits n.toList then some (.row n) else none
    | w :: _ =>
      let w := bareWord w
      let cs := w.toList
      if cs.head? == some 'G' && allDigits (cs.drop 1) then some (.grokking (String.ofList (cs.drop 1)))
      else if cs.take 3 == "FS-".toList && allDigits (cs.drop 3) then some (.stub w)
      else if (cs.head?.map Char.isUpper).getD false && cs.any Char.isDigit &&
          cs.all (fun c => c.isAlphanum || c == '-' || c == '′') then some (.entry w)
      else none
    | [] => none

/-- May a source of this shape back an assumption of this kind? -/
def Kind.admits : Kind → Ref → Bool
  | .outside, .bib _ => true
  | .ours, .row _ | .ours, .grokking _ | .ours, .entry _ => true
  | .open, .row _ | .open, .grokking _ | .open, .stub _ | .open, .entry _ => true
  | _, _ => false

def has (text word : String) : Bool := (text.splitOn word).length > 1

/-- The library's own words for a hypothesis that is a hand result or an outside theorem. -/
def saysNamed (doc : String) : Bool :=
  let d := doc.toLower
  has d "named hypothes" || has d "named classical hypothes" || has d "outside the backlog"

/-- The words that make an undeclared *former* fail: `saysNamed`, and "external". -/
def saysAssumption (doc : String) : Bool := saysNamed doc || has doc.toLower "external"

/-- The kinds a docstring's words speak for. A bracketed bibliography key is not one of the words: it names
a source, not whose the result is — a hand result of ours that rests on a cited paper is the ordinary case
(`Interface.MulStable`, on `[LevitzMott1972]`). It supports a declared `outside` (`docSupports`) and
contradicts nothing. -/
def kindWords (doc : String) : List Kind :=
  let d := doc.toLower
  (if has d "external" || has d "classical" then [Kind.outside] else []) ++
  (if has d "[hand" || has d "[tools]" || has d "[cert]" || has d "outside the backlog" then [Kind.ours] else []) ++
  (if has d "open question" || has d "open problem" || has d "design target" then [Kind.open] else [])

/-- Does the docstring speak for the declared kind? -/
def docSupports (doc : String) (kind : Kind) : Bool :=
  (kindWords doc).contains kind || (kind == .outside && (bibKeyIn? doc).isSome)

#guard docSupports "`[Voronov2023]` Thm 1.1, as a statement" .outside && !docSupports "`[LevitzMott1972]`" .ours
#guard kindWords "rests on J28V-7 (`[LevitzMott1972]`)" == []
#guard (parseRef "[Voronov2023] Thm 1.1").map Ref.tag == some "bib:Voronov2023"
#guard (parseRef "row 123, given MR").map Ref.tag == some "row:123"
#guard (parseRef "G56: the floor").map Ref.tag == some "grokking:56"
#guard (parseRef "FS-124 the (Q) ring").map Ref.tag == some "stub:FS-124"
#guard (parseRef "FS89-S0A-3 (k = 4)").map Ref.tag == some "entry:FS89-S0A-3"
#guard (parseRef "J45 § 4.2 step 3").map Ref.tag == some "entry:J45"
#guard (parseRef "Rudin, Fourier Analysis on Groups").isNone
#guard (parseRef "[Rudin] 1.4.3").isNone
#guard (parseRef "").isNone
#guard Kind.outside.admits (.bib "Voronov2023") && !Kind.outside.admits (.row "5") && !Kind.ours.admits (.bib "Voronov2023")
#guard saysNamed "a named classical hypothesis" && saysNamed "(outside the backlog)" && !saysNamed "an external tool"
#guard saysAssumption "X-BH, external: Herglotz" && !saysAssumption "the field hypotheses of NOAFF"
#guard kindWords "X-BH, external: Herglotz" == [Kind.outside] && kindWords "[tools]/[hand], not kernel" == [Kind.ours]
#guard kindWords "MR, Fourier form" == []

/-! ## Reading the environment -/

/-- The module a constant was imported from, if any. -/
def moduleOf? (env : Environment) (n : Name) : Option Name :=
  (env.getModuleIdxFor? n).bind fun idx => env.header.moduleNames[idx.toNat]?

/-- Is this constant the library's? A module under `Proofs`; or declared in the file being elaborated — the
planted controls of `--self-test` — unless it is this audit's own instrument. -/
def isOurs (env : Environment) (n : Name) : Bool :=
  match moduleOf? env n with
  | some m => (`Proofs).isPrefixOf m
  | none => !(`AssumptionAudit).isPrefixOf n

/-- Machine-written API of a `structure`, an `inductive` or a `match` (`scripts/Vacuity.lean`'s
`isGeneratedDecl`, with matchers and with the theorems Lean states under a constructor's name —
`S.mk.inj`, `S.mk.injEq`, `S.mk.sizeOf_spec` — which repeat the constructor's fields as hypotheses: the
self-test's `t5c_Pack` showed them read as three consumers of a field's type). -/
def isGenerated (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome || isMatcherCore env n ||
  (match n with
    | .str p s => s == "ctorIdx" || s == "noConfusionType" ||
        (match env.find? p with | some (.ctorInfo _) => true | _ => false)
    | _ => false)

/-- A hand-written constant of the library: scanned. A private declaration is one (its user-facing name is
read for the internal-name test). -/
def isScanned (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  isOurs env n && !isGenerated env n ci && !((privateToUserName? n).getD n).isInternal

/-- A **former**: a library constant that is not a theorem and whose type, as written, ends in `Prop`. -/
def isFormer (env : Environment) (n : Name) (ci : ConstantInfo) : MetaM Bool := do
  if !isOurs env n || isGenerated env n ci then return false
  match ci with
  | .defnInfo _ | .inductInfo _ | .opaqueInfo _ => forallTelescope ci.type fun _ concl => pure concl.isProp
  | _ => return false

/-- The constants a definition's own content mentions: for a definition of a type or a proposition, its
value under its declared parameters; for an inductive or a structure, its constructors' fields. Anything
else — a function, a theorem — wraps nothing: its hypotheses are in its type. -/
def bodyConstants (ci : ConstantInfo) : MetaM (Array Name) := do
  match ci with
  | .defnInfo v =>
    let (arity, sortValued) ← forallTelescope v.type fun xs concl => pure (xs.size, concl.isSort)
    if !sortValued then return #[]
    lambdaBoundedTelescope v.value arity fun _ body => pure body.getUsedConstants
  | .inductInfo v =>
    let mut out := #[]
    for ctor in v.ctors do
      let cinfo ← getConstInfo ctor
      out := out ++ (← forallTelescope cinfo.type fun xs _ => do
        let mut acc := #[]
        for x in xs.extract v.numParams xs.size do
          acc := acc ++ (← instantiateMVars (← inferType x)).getUsedConstants
        pure acc)
    return out
  | _ => return #[]

/-! ## Occurrences, with their polarity -/

/-- `hyp`: assumed. `con`: concluded, or — inside a hypothesis — an antecedent. `ref`: refuted (under a `¬`
of the conclusion: the theorem proves it fails, which is neither taking nor producing it). `mix`: unknown. -/
inductive Pol | hyp | con | ref | mix
  deriving BEq, Inhabited

/-- The polarity of an antecedent. -/
def Pol.flip : Pol → Pol
  | .hyp => .con | .con => .hyp | .ref => .con | .mix => .mix

/-- The polarity under a `¬`. -/
def Pol.negate : Pol → Pol
  | .hyp => .con | .con => .ref | .ref => .con | .mix => .mix

/-- One occurrence of a former in a statement. -/
structure Occ where
  former : Name
  pol : Pol
  /-- the wrapper through which it occurs, if not directly -/
  via : Option Name := none
  /-- it is the head of the binder's whole type -/
  head : Bool := false

/-- What the scan looks for: every library former, and each wrapper with the declared formers it wraps. -/
structure Tracked where
  formers : Std.HashSet Name
  wraps : Std.HashMap Name (Array Name)

/-- Every tracked constant in `e`, at unknown polarity. -/
def mentions (t : Tracked) (e : Expr) : Array Occ :=
  e.getUsedConstants.foldl (init := #[]) fun acc c =>
    let acc := if t.formers.contains c then acc.push { former := c, pol := .mix } else acc
    match t.wraps[c]? with
    | some hs => hs.foldl (fun a h => a.push { former := h, pol := .mix, via := some c }) acc
    | none => acc

/-- The occurrences of tracked formers in the proposition `e`, read at polarity `pol`.
Scope: binders are entered with `forallTelescope` and `withLocalDecl`, so no loose bound variable is ever
inspected; the result holds names only, so nothing leaves the telescope's context. -/
partial def occs (t : Tracked) (e : Expr) (pol : Pol) (top : Bool := false) : MetaM (Array Occ) := do
  let e ← instantiateMVars e
  if e.isForall then
    forallTelescope e fun xs body => do
      let mut out := #[]
      for x in xs do
        let ty ← instantiateMVars (← inferType x)
        if ← isProp ty then out := out ++ (← occs t ty pol.flip) else out := out ++ mentions t ty
      return out ++ (← occs t body pol)
  else
    let args := e.getAppArgs
    let each (p : Pol) : MetaM (Array Occ) := args.foldlM (fun acc a => return acc ++ (← occs t a p)) #[]
    match e.getAppFn.constName? with
    | some ``And | some ``Or => each pol
    -- `[Fact H]` is `H` taken as a hypothesis: its head is read through
    | some ``Fact => args.foldlM (fun acc a => return acc ++ (← occs t a pol top)) #[]
    | some ``Not => each pol.negate
    | some ``Iff => each .mix
    | some ``Exists =>
      match args.getD 1 default with
      | Expr.lam n ty b bi =>
        withLocalDecl n bi ty fun x => do return mentions t ty ++ (← occs t (b.instantiate1 x) pol)
      | _ => return mentions t e
    | some c =>
      let rest := args.foldl (fun acc a => acc ++ mentions t a) #[]
      let own : Array Occ := if t.formers.contains c then #[{ former := c, pol, head := top }] else #[]
      let wrapped : Array Occ := match t.wraps[c]? with
        | some hs => hs.map fun h => { former := h, pol, via := some c }
        | none => #[]
      return own ++ wrapped ++ rest
    | none => return mentions t e

/-- An expression as one line of text, taken where its binders are in scope. Never throws. -/
def oneLine (e : Expr) (width : Nat := 600) : MetaM String := do
  let s ← try pure (((← ppExpr e).pretty 1000000).replace "\n" " ") catch _ => pure "<did not pretty-print>"
  return if s.length > width then String.ofList (s.toList.take width) ++ " …" else s

/-! ## What is read of one constant -/

/-- A hypothesis: a binder whose type is a proposition. -/
structure Hyp where
  binder : Name
  inst : Bool
  closed : Bool
  /-- the binder's type when `closed` (it holds no free variable, so it is valid anywhere); `default` otherwise -/
  type : Expr
  shown : String
  occs : Array Occ
  /-- an instance-implicit closed hypothesis that instance search discharges -/
  byInstance : Bool := false

structure Decl where
  name : Name
  isThm : Bool
  hyps : Array Hyp
  /-- mentions in binders that are not hypotheses -/
  dataOccs : Array Occ
  conclOccs : Array Occ
  /-- the stated conclusion — compared only when `closedRule` -/
  concl : Expr
  /-- every binder is a closed hypothesis (none included), and the conclusion is closed: a rule of the
  closure that decides `ESTABLISHED` -/
  closedRule : Bool
  /-- the stated conclusion is `False` -/
  refutation : Bool
  /-- it concludes `H x₁ … xₙ` over its own distinct variables with no hypothesis: `H` proved in general -/
  general : Option Name
  doc : String

/-- Read one constant's statement, as written. `wantText` says for which hypotheses the text is needed
(pretty-printing all sixteen thousand would dominate the scan). -/
def readDecl (env : Environment) (t : Tracked) (n : Name) (ci : ConstantInfo)
    (declaredFormers : Std.HashSet Name) (isSite : Name → Bool) : MetaM Decl :=
  forallTelescope ci.type fun xs concl => do
    let concl ← instantiateMVars concl
    let mut hyps : Array Hyp := #[]
    let mut dataOccs : Array Occ := #[]
    let mut allClosedHyps := true
    let mut raw : Array (LocalDecl × Expr × Array Occ) := #[]
    for x in xs do
      let d ← x.fvarId!.getDecl
      let ty ← instantiateMVars d.type
      if ← isProp ty then raw := raw.push (d, ty, ← occs t ty .hyp (top := true))
      else
        allClosedHyps := false
        dataOccs := dataOccs ++ mentions t ty
    let takesDeclared (os : Array Occ) : Bool := os.any fun o => o.pol == .hyp && declaredFormers.contains o.former
    let consumer := raw.any fun (d, _, os) => takesDeclared os || isSite d.userName.eraseMacroScopes
    for (d, ty, os) in raw do
      let closed := !ty.hasFVar && !ty.hasMVar
      if !closed then allClosedHyps := false
      let inst := d.binderInfo.isInstImplicit
      let byInstance ← if closed && inst then
          (try pure (← synthInstance? ty).isSome catch _ => pure false) else pure false
      let shown ← if closed || consumer then oneLine ty else pure ""
      -- CLAIM (scope): only a closed type leaves the telescope; anything else is replaced, never carried out.
      hyps := hyps.push { binder := d.userName.eraseMacroScopes, inst, closed, type := if closed then ty else default,
                          shown, occs := os, byInstance }
    let conclOccs ← occs t concl .con (top := true)
    let general : Option Name :=
      if !raw.isEmpty then none else
        match concl.getAppFn.constName? with
        | some h =>
          let args := concl.getAppArgs
          if declaredFormers.contains h && args.all (fun a => a.isFVar && xs.contains a) &&
              args.size == (args.toList.eraseDups).length then some h else none
        | none => none
    return { name := n, isThm := (match ci with | .thmInfo _ => true | _ => false), hyps, dataOccs, conclOccs,
             concl, closedRule := allClosedHyps && !concl.hasFVar && !concl.hasMVar,
             refutation := concl.isConstOf ``False, general, doc := (← findDocString? env n).getD "" }

/-- What the library holds of one former. -/
structure Tally where
  /-- constants that assume it -/
  takers : Array Name := #[]
  /-- constants whose conclusion holds it positively -/
  producers : Array Name := #[]

def Tally.addTaker (x : Tally) (n : Name) : Tally := if x.takers.contains n then x else { x with takers := x.takers.push n }
def Tally.addProducer (x : Tally) (n : Name) : Tally := if x.producers.contains n then x else { x with producers := x.producers.push n }

/-- **Does `DERIVED` fail the gate?** Pre-decided in `plans/FS131-T5-assumptions.md` (stage 2 (e)) before the
first run: it fails if on `main` it flags at most ten formers that are not assumptions. It flagged one
(`SpectralInputs.IsHaarFourier`, stage 3), so it fails, with `.condition` as its disposition. -/
def derivedFails : Bool := true

/-- Run the audit and print its rows. The format is a contract (this file's header). A faulty entry is a
`FAIL` row and never an exception, so that every planted control of `--self-test` lives in one run. -/
def run (entries : Array Entry) : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let all := env.constants.toList.filter fun (n, _) => isOurs env n
  let mut fails : Array String := #[]
  -- 1. the library's formers
  let mut formers : Std.HashSet Name := {}
  for (n, ci) in all do
    if ← (try isFormer env n ci catch _ => pure false) then formers := formers.insert n
  -- 2. the list, entry by entry
  let mut formerDecl : Std.HashMap Name (Kind × String × Option Ref) := {}
  let mut condDecl : Std.HashMap Name String := {}
  let mut siteDecl : Std.HashMap (Name × Name) (String × Kind × String) := {}
  let mut labels : Std.HashMap String (Kind × String × Option Ref) := {}
  let mut premiseDecl : Std.HashMap (Name × Name) String := {}
  let checkSource (who : String) (kind : Kind) (source : String) : Array String × Option Ref :=
    if source.trimAscii.copy.isEmpty then (#[s!"FAIL no-source {who} :: declared {kind.tag} with no source"], none)
    else match parseRef source with
      | none => (#[s!"FAIL bad-source {who} :: the source '{source}' opens with no bibliography key, ledger row, grokking, stub or entry id"], none)
      | some r =>
        if kind.admits r then (#[], some r)
        else (#[s!"FAIL bad-source {who} :: a source of the form {r.tag} cannot back an assumption of kind {kind.tag}"], some r)
  for e in entries do
    match e with
    | .former n kind source =>
      if formerDecl.contains n || condDecl.contains n then
        fails := fails.push s!"FAIL declared-twice {n} :: it has two entries in the list"
      else if !formers.contains n then
        fails := fails.push s!"FAIL bad-entry {n} :: not a library definition whose type ends in Prop"
      else
        let (fs, r) := checkSource (toString n) kind source
        fails := fails ++ fs
        formerDecl := formerDecl.insert n (kind, source, r)
    | .condition n reason =>
      if formerDecl.contains n || condDecl.contains n then
        fails := fails.push s!"FAIL declared-twice {n} :: it has two entries in the list"
      else if !formers.contains n then
        fails := fails.push s!"FAIL bad-entry {n} :: not a library definition whose type ends in Prop"
      else
        if reason.trimAscii.copy.isEmpty then
          fails := fails.push s!"FAIL no-reason {n} :: declared a condition with no reason"
        condDecl := condDecl.insert n reason
    | .premise decl binder reason =>
      if siteDecl.contains (decl, binder) || premiseDecl.contains (decl, binder) then
        fails := fails.push s!"FAIL declared-twice {decl}:{binder} :: the site has two entries in the list"
      else
        if reason.trimAscii.copy.isEmpty then
          fails := fails.push s!"FAIL no-reason {decl}:{binder} :: declared a premise with no reason"
        premiseDecl := premiseDecl.insert (decl, binder) reason
    | .site decl binder label kind source =>
      if siteDecl.contains (decl, binder) || premiseDecl.contains (decl, binder) then
        fails := fails.push s!"FAIL declared-twice {decl}:{binder} :: the site has two entries in the list"
      else
        let (fs, r) := checkSource s!"{decl}:{binder}" kind source
        fails := fails ++ fs
        match labels[label]? with
        | some (k, s, _) =>
          if k != kind || s != source then
            fails := fails.push s!"FAIL label-conflict inline:{label} :: {decl}:{binder} declares it {kind.tag} from '{source}', an earlier site {k.tag} from '{s}'"
        | none => labels := labels.insert label (kind, source, r)
        siteDecl := siteDecl.insert (decl, binder) (label, kind, source)
  let declaredFormers : Std.HashSet Name := formerDecl.fold (fun s n _ => s.insert n) {}
  -- 3. the wrappers, to a fixed point
  let mut bodies : Array (Name × Array Name) := #[]
  for (n, ci) in all do
    if declaredFormers.contains n then continue
    let cs ← (try bodyConstants ci catch _ => pure #[])
    if !cs.isEmpty then bodies := bodies.push (n, cs)
  let mut wraps : Std.HashMap Name (Array Name) := {}
  let mut changed := true
  while changed do
    changed := false
    for (n, cs) in bodies do
      let mut ws := wraps[n]?.getD #[]
      let before := ws.size
      for c in cs do
        if declaredFormers.contains c && !ws.contains c then ws := ws.push c
        for h in wraps[c]?.getD #[] do
          if !ws.contains h then ws := ws.push h
      if ws.size != before then
        wraps := wraps.insert n ws
        changed := true
  let t : Tracked := { formers, wraps }
  -- 4. every hand-written constant's statement
  let mut decls : Array Decl := #[]
  let mut untelescoped : Nat := 0
  for (n, ci) in all do
    if !isScanned env n ci then continue
    match ← (try some <$> readDecl env t n ci declaredFormers (fun b => siteDecl.contains (n, b))
        catch e => do
          logWarning m!"UNTELESCOPED {n}: {e.toMessageData}"
          pure none) with
    | some d => decls := decls.push d
    | none => untelescoped := untelescoped + 1
  -- 5. the closed hypotheses the library proves: the least fixed point of the closed rules
  let mut established : Std.HashSet Expr := {}
  let rules := decls.filter (·.closedRule)
  changed := true
  while changed do
    changed := false
    for d in rules do
      if !established.contains d.concl && d.hyps.all (fun h => established.contains h.type) then
        established := established.insert d.concl
        changed := true
  -- 6. rows, constant by constant
  let mut tally : Std.HashMap Name Tally := {}
  let mut takes : Array (String × Name × String) := #[]     -- id, theorem, " via W" or ""
  let mut mentionsRows : Array (String × Name) := #[]
  let mut produces : Array (Name × Name × String) := #[]
  let mut siteRows : Array String := #[]
  let mut closedRows : Array String := #[]
  let mut cohyp : Array String := #[]
  let mut hints : Array Name := #[]
  let mut consumers : Std.HashSet Name := {}
  let mut siteHits : Std.HashMap (Name × Name) Nat := {}
  let mut premiseHits : Std.HashMap (Name × Name) Nat := {}
  let mut nPremise : Nat := 0
  let mut refutes : Array (Name × Name) := #[]
  let mut nHyp : Nat := 0
  let mut nClosed : Nat := 0
  let mut nEstablished : Nat := 0
  let mut nDeclaredClosed : Nat := 0
  let mut nRefuted : Nat := 0
  let mut unseen : Nat := 0
  let mut general : Array (Name × Name) := #[]
  for d in decls do
    nHyp := nHyp + d.hyps.size
    -- tallies, over every former
    for h in d.hyps do
      for o in h.occs do
        if o.via.isNone && o.pol == .hyp then tally := tally.insert o.former ((tally[o.former]?.getD {}).addTaker d.name)
    for o in d.conclOccs do
      if o.via.isNone then
        if o.pol == .con then tally := tally.insert o.former ((tally[o.former]?.getD {}).addProducer d.name)
        else if o.pol == .hyp then tally := tally.insert o.former ((tally[o.former]?.getD {}).addTaker d.name)
    -- what it takes of the declared formers
    let allOccs := d.hyps.foldl (fun acc h => acc ++ h.occs) #[] ++ d.dataOccs ++ d.conclOccs
    let mut took : Array (Name × String) := #[]
    let mut mentioned : Array Name := #[]
    for h in d.hyps do
      for o in h.occs do
        if declaredFormers.contains o.former && o.pol == .hyp && !took.any (·.1 == o.former) then
          took := took.push (o.former, match o.via with | some w => s!" via {w}" | none => "")
    for o in d.conclOccs do
      if declaredFormers.contains o.former && o.pol == .hyp && !took.any (·.1 == o.former) then
        took := took.push (o.former, match o.via with | some w => s!" via {w}" | none => "")
    for o in allOccs do
      if declaredFormers.contains o.former && o.pol == .mix && !took.any (·.1 == o.former) &&
          !mentioned.contains o.former then mentioned := mentioned.push o.former
    for (h, via) in took do takes := takes.push (toString h, d.name, via)
    for h in mentioned do mentionsRows := mentionsRows.push (toString h, d.name)
    let mut producedHere : Array Name := #[]
    for o in d.conclOccs do
      if declaredFormers.contains o.former && o.pol == .con && o.via.isNone && !producedHere.contains o.former then
        producedHere := producedHere.push o.former
        let how := if d.general == some o.former then "general" else if d.hyps.isEmpty then "uncond" else "cond"
        produces := produces.push (o.former, d.name, how)
    for o in d.conclOccs do
      if declaredFormers.contains o.former && o.pol == .ref && !refutes.contains (o.former, d.name) then
        refutes := refutes.push (o.former, d.name)
    if let some h := d.general then general := general.push (h, d.name)
    -- the declared sites of this constant
    let mut tookSite := false
    let mut siteLabels : Array String := #[]
    for h in d.hyps do
      if let some (label, _, _) := siteDecl[(d.name, h.binder)]? then
        siteHits := siteHits.insert (d.name, h.binder) ((siteHits[(d.name, h.binder)]?.getD 0) + 1)
        tookSite := true
        siteRows := siteRows.push s!"SITE inline:{label} {d.name} {h.binder} :: {h.shown}"
        if !siteLabels.contains label then siteLabels := siteLabels.push label
    for label in siteLabels do takes := takes.push (s!"inline:{label}", d.name, "")
    let isConsumer := !took.isEmpty || tookSite
    if isConsumer then consumers := consumers.insert d.name
    -- the closed hypotheses, each classified
    let headDeclared (h : Hyp) : Bool := h.occs.any fun o => o.head && o.pol == .hyp && declaredFormers.contains o.former
    let mut open_ : Array Hyp := #[]
    for h in d.hyps do
      if premiseDecl.contains (d.name, h.binder) then
        premiseHits := premiseHits.insert (d.name, h.binder) ((premiseHits[(d.name, h.binder)]?.getD 0) + (if h.closed then 1 else 1000))
      if !h.closed then continue
      nClosed := nClosed + 1
      if siteDecl.contains (d.name, h.binder) || headDeclared h then
        nDeclaredClosed := nDeclaredClosed + 1
        closedRows := closedRows.push s!"CLOSED DECLARED {d.name} {h.binder} :: {h.shown}"
      else if let some reason := premiseDecl[(d.name, h.binder)]? then
        nPremise := nPremise + 1
        closedRows := closedRows.push s!"CLOSED PREMISE {d.name} {h.binder} :: {h.shown} :: {reason}"
      else if established.contains h.type || h.byInstance then
        nEstablished := nEstablished + 1
        closedRows := closedRows.push s!"CLOSED ESTABLISHED {d.name} {h.binder} :: {h.shown}"
      else open_ := open_.push h
    match d.refutation, open_.toList with
    | true, [h] =>
      nRefuted := nRefuted + 1
      closedRows := closedRows.push s!"CLOSED REFUTED {d.name} {h.binder} :: {h.shown}"
    | _, hs =>
      for h in hs do
        fails := fails.push s!"FAIL undeclared-closed-hypothesis {d.name}:{h.binder} :: the closed hypothesis `{h.shown}` is proved by no library theorem and named by no entry"
    -- the other hypotheses of a consumer, and the unseen class
    for h in d.hyps do
      if h.closed || h.inst then continue
      let declaredHere := siteDecl.contains (d.name, h.binder) ||
        h.occs.any fun o => o.pol == .hyp && declaredFormers.contains o.former
      if declaredHere then continue
      if isConsumer then cohyp := cohyp.push s!"COHYP {d.name} {h.binder} :: {h.shown}"
      else unseen := unseen + 1
    if d.isThm && saysNamed d.doc && !isConsumer then hints := hints.push d.name
  -- 7. the list against what was read
  for ((decl, binder), _) in siteDecl.toArray do
    match siteHits[(decl, binder)]?.getD 0 with
    | 0 => fails := fails.push s!"FAIL bad-entry {decl}:{binder} :: no hypothesis of {decl} is named {binder}"
    | 1 => pure ()
    | k => fails := fails.push s!"FAIL bad-entry {decl}:{binder} :: {k} hypotheses of {decl} are named {binder}"
  for ((decl, binder), _) in premiseDecl.toArray do
    match premiseHits[(decl, binder)]?.getD 0 with
    | 0 => fails := fails.push s!"FAIL bad-entry {decl}:{binder} :: no hypothesis of {decl} is named {binder}"
    | 1 => pure ()
    | _ => fails := fails.push s!"FAIL bad-entry {decl}:{binder} :: a premise names exactly one closed hypothesis, and {binder} of {decl} is not that"
  let consumersOf (id : String) : Nat :=
    ((takes.filter (·.1 == id)).map (·.2.1) ++ (mentionsRows.filter (·.1 == id)).map (·.2)).toList.eraseDups.length
  let mut silent : Array String := #[]
  for (h, (kind, _, _)) in formerDecl.toArray do
    if consumersOf (toString h) == 0 then
      fails := fails.push s!"FAIL stale-declaration {h} :: declared, and no constant's statement takes it"
    let doc := (← findDocString? env h).getD ""
    let kw := kindWords doc
    if docSupports doc kind then pure ()
    else if kw.isEmpty then silent := silent.push s!"SILENT {h} kind={kind.tag}"
    else
      fails := fails.push s!"FAIL kind-contradiction {h} :: declared {kind.tag}, and its docstring speaks for {kw.map Kind.tag} and not for {kind.tag}"
  for (h, by_) in general do
    fails := fails.push s!"FAIL discharged {h} :: {by_} proves it in general: it is no longer an assumption (remove the entry, restate its consumers)"
  let mut derived : Array String := #[]
  let mut conditionRows : Array String := #[]
  for h in formers.toArray do
    if declaredFormers.contains h then continue
    let x := tally[h]?.getD {}
    let doc := (← findDocString? env h).getD ""
    let neverConcluded := !x.takers.isEmpty && x.producers.isEmpty
    let derivedOnly := !x.takers.isEmpty && !x.producers.isEmpty && x.producers.all consumers.contains
    if derivedOnly then derived := derived.push s!"DERIVED {h} :: taken by {x.takers.size}, produced only by {x.producers.toList}"
    match condDecl[h]? with
    | some reason =>
      conditionRows := conditionRows.push s!"CONDITION {h} :: {reason}"
      if saysAssumption doc then
        fails := fails.push s!"FAIL kind-contradiction {h} :: declared a condition, and its docstring uses the library's words for an assumption"
      if !(neverConcluded || (derivedFails && derivedOnly)) then
        fails := fails.push s!"FAIL stale-condition {h} :: declared a condition, and it is {if x.takers.isEmpty then "taken by nothing" else "concluded by " ++ toString (x.producers.toList.take 2)}: the entry is not needed"
    | none =>
      if saysAssumption doc then
        fails := fails.push s!"FAIL undeclared-by-docstring {h} :: its docstring uses the library's words for an assumption and no entry declares it"
      else if neverConcluded then
        fails := fails.push s!"FAIL undeclared-never-concluded {h} :: taken as a hypothesis by {x.takers.size} constant(s) ({x.takers.toList.take 2}), concluded by none: an assumption (.former) or a condition (.condition)?"
      else if derivedFails && derivedOnly then
        fails := fails.push s!"FAIL undeclared-derived-only {h} :: every theorem concluding it takes a declared assumption"
  -- 8. the axioms, from the lists the kernel stored
  let libAxioms := (all.filter fun (n, ci) => ci.isAxiom && !n.components.contains `_native).map (·.1)
  let mut rests : Array (Name × Name) := #[]
  if !libAxioms.isEmpty then
    for d in decls do
      for a in ← collectAxioms d.name do
        if libAxioms.contains a && a != d.name then rests := rests.push (a, d.name)
  -- 9. print
  let sortS (a : Array String) : Array String := a.qsort (· < ·)
  logInfo m!"=== ASSUMPTIONS AUDIT ==="
  for a in (libAxioms.toArray.map toString).qsort (· < ·) do
    let doc := (← findDocString? env a.toName).getD ""
    let n := (rests.filter (toString ·.1 == a)).size
    match bibKeyIn? doc with
    | some k => logInfo m!"AXIOM {a} ref=bib:{k} theorems={n}"
    | none =>
      logInfo m!"AXIOM {a} ref=MISSING theorems={n}"
      fails := fails.push s!"FAIL axiom-no-source {a} :: an axiom of the library whose docstring names no bibliography key"
  for r in sortS (rests.map fun (a, th) => s!"RESTS {a} {th}") do logInfo m!"{r}"
  let mut byKind : Std.HashMap String Nat := {}
  for (h, (kind, source, r)) in formerDecl.toArray.qsort (fun a b => toString a.1 < toString b.1) do
    byKind := byKind.insert kind.tag ((byKind[kind.tag]?.getD 0) + 1)
    logInfo m!"ASSUMPTION {h} form=named kind={kind.tag} ref={(r.map Ref.tag).getD "NONE"} consumers={consumersOf (toString h)} :: {source}"
  for (label, (kind, source, r)) in labels.toArray.qsort (fun a b => a.1 < b.1) do
    byKind := byKind.insert kind.tag ((byKind[kind.tag]?.getD 0) + 1)
    logInfo m!"ASSUMPTION inline:{label} form=inline kind={kind.tag} ref={(r.map Ref.tag).getD "NONE"} consumers={consumersOf s!"inline:{label}"} :: {source}"
  for r in sortS (takes.map fun (id, th, via) => s!"TAKES {id} {th}{via}") do logInfo m!"{r}"
  for r in sortS (mentionsRows.map fun (id, th) => s!"MENTIONS {id} {th}") do logInfo m!"{r}"
  for r in sortS (produces.map fun (h, th, how) => s!"PRODUCES {h} {th} {how}") do logInfo m!"{r}"
  for r in sortS (refutes.map fun (h, th) => s!"REFUTES {h} {th}") do logInfo m!"{r}"
  for r in sortS siteRows do logInfo m!"{r}"
  for r in sortS closedRows do logInfo m!"{r}"
  for r in sortS conditionRows do logInfo m!"{r}"
  for r in sortS silent do logInfo m!"{r}"
  for r in sortS derived do logInfo m!"{r}"
  let wrapRows := wraps.toArray.foldl (fun acc (w, hs) => acc ++ hs.map fun h => s!"WRAPS {w} {h}") #[]
  for r in sortS wrapRows do logInfo m!"{r}"
  for r in sortS cohyp do logInfo m!"{r}"
  for r in sortS (hints.map fun n => s!"HINT {n}") do logInfo m!"{r}"
  for r in sortS fails do logInfo m!"{r}"
  logInfo m!"=== SCANNED === constants={decls.size} theorems={(decls.filter (·.isThm)).size} formers={formers.size} hypotheses={nHyp} closed={nClosed} untelescoped={untelescoped}"
  logInfo m!"=== TOTALS === axioms={libAxioms.length} rests={rests.size} named={formerDecl.size} inline={labels.size} outside={byKind["outside"]?.getD 0} ours={byKind["ours"]?.getD 0} open={byKind["open"]?.getD 0} takes={takes.size} mentions={mentionsRows.size} produces={produces.size} sites={siteRows.size} conditions={conditionRows.size} declaredClosed={nDeclaredClosed} established={nEstablished} premises={nPremise} refuted={nRefuted} refutes={refutes.size} silent={silent.size} derived={derived.size} wrappers={wrapRows.size} cohyp={cohyp.size} hints={hints.size} unseen={unseen} fails={fails.size}"

/-! ## The list — the one place an assumption in hypothesis form is declared

**How a landing declares what it brings.** A wave that brings a named hypothesis adds one `.former` line;
one that writes a hand result or an outside theorem out in a binder adds one `.site` line per binder; a
former that is only ever a condition on a theorem's parameters gets a `.condition` line with the reason.
Then `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh` (which names every consumer the
ledger lacks), `./scripts/assumptions.sh --write-ledger`, and the counts for `CLAUDE.md` § Trust ledger.
An `axiom` is declared in `scripts/Axioms.lean` (`declareImport`), not here; this scan lists it from the
environment. When an assumption is proved, its entry leaves and the gate says so (`discharged`,
`stale-declaration`). -/

/-- The declared assumptions and conditions of the library. -/
def declared : Array Entry := #[
  -- ## Outside theorems, as named hypotheses
  .former ``HadwigerNelson.SpectralChain.BochnerHerglotz .outside
    "[Rudin1962] 1.4.3 (Bochner on a locally compact abelian group) and 1.3.6 (uniqueness); the read-back against the page is owed (FS131-L10A, planner's § 5.5)",
  .former ``HadwigerNelson.SpectralInputs.BochnerOn .outside
    "[Rudin1962] 1.4.3, for a topology induced from a locally compact abelian group (J45 Lemma N2's ⟸)",
  .former ``HadwigerNelson.SpectralChain.InvariantMeasureOnClosed .outside
    "[Kakutani1938] Markov–Kakutani, for ℤ[U] and then for U on the ℤ[U]-invariant measures (FS-100's L1, X11K); no page read",
  .former ``HadwigerNelson.Bridge.RealAlgebraicDescent .outside
    "[Lang1953] Artin–Lang (equivalently Tarski 1951, quantifier elimination); row 107's one named hypothesis",
  .former ``HadwigerNelson.Plane.Voronov11 .outside
    "[Voronov2023] Thm 1.1 (Euclidean norm, six colours); its one consumer is a half of FS106-COMP's equivalence",
  .former ``HadwigerNelson.StandingFive.KloostermanBound .outside
    "[Weil1948] p. 207 (Weil's bound for Kloosterman sums over a finite field), in hypothesis form: the same outside theorem as the import StandingFive.kloosterman_bound, which proves it at characteristic not 2 (kloostermanBound_of_ringChar_ne_two)",
  -- ## The same outside theorem, written out in a binder at a closed family of fields
  .site ``HadwigerNelson.StandingFive.standingFloor_seven `hK "KloostermanFrom347" .outside
    "[Weil1948] p. 207, at every finite field of q ≡ 3 (mod 4), q ≥ 347 elements (KloostermanBound at a closed family; the import proves it there)",
  .site ``HadwigerNelson.StandingFive.standingFloor_five `hK "KloostermanFrom347" .outside
    "[Weil1948] p. 207, at every finite field of q ≡ 3 (mod 4), q ≥ 347 elements (KloostermanBound at a closed family; the import proves it there)",
  .site ``HadwigerNelson.StandingFive.seven_le_localBound_of_kloosterman `hK "KloostermanFrom347" .outside
    "[Weil1948] p. 207, at every finite field of q ≡ 3 (mod 4), q ≥ 347 elements (KloostermanBound at a closed family; the import proves it there)",
  -- ## Hand results of ours, as named hypotheses
  .former ``HadwigerNelson.SpectralChain.Interface.RU .ours "J45 § 5.4 (R-U; blind J46), plans/FS84-SI-D-derivation.md",
  .former ``HadwigerNelson.SpectralChain.Interface.APlus0 .ours "J45 § 3, remark (ii) (A⁺ at S = ∅; blind X05V; row 113)",
  .former ``HadwigerNelson.SpectralChain.Interface.PE2 .ours
    "X02D (PE-2, over [EinsiedlerLindenstrauss2022] Thm 1.2; blind X02V)",
  .former ``HadwigerNelson.SpectralChain.Interface.EFPlus .ours "FS100-X01D line 194 (EF_F⁺; second derivation X12B)",
  .former ``HadwigerNelson.SpectralChain.Interface.MR .ours
    "row 120 (measure rigidity for the unit-vector group, in Fourier form; over [EinsiedlerLindenstrauss2022] Thm 1.3 by statement)",
  .former ``HadwigerNelson.SpectralChain.Interface.APlusOfR88 .ours "J45 (A⁺ from R88-TCA: SI-3, SI-4, N2; field-free, X23V § 2.3)",
  .former ``HadwigerNelson.SpectralChain.Interface.Count .ours
    "X23D-TCA (the count: R88-TCA at S = ∅ in the class; X23V § 2.3; at a complex place X29C's ruling)",
  .former ``HadwigerNelson.SpectralChain.Interface.MulStable .ours "J45 § 4.2 step 2 (m⁻¹(E) ⊆ E; on J28V-7)",
  .former ``HadwigerNelson.SpectralChain.Interface.NegCircle .ours "J45 § 4.2 step 3 (no Lean model on file)",
  .former ``HadwigerNelson.CharacterColouring.OrderBound .ours "FS89-S0A-3 (k = 4, N = 168, on Weil); J08-11 at 5, J08-10 at 6",
  -- `StandingFive.StandingFloor` is not in this list: it is proved at 7 and at 5 over the import (`standingFloor_seven_weil`,
  -- `standingFloor_five_weil`, each a `RESTS` row of `kloosterman_bound`), so its two closed takers read `CLOSED ESTABLISHED`.
  .former ``HadwigerNelson.Plane.Row130M1 .ours "row 130 (FS-103's M1, hard direction: χ_CP ≤ χ_m⁰)",
  .former ``HadwigerNelson.SevenConditional.G4 .ours
    "row 103 (the 8/3 forcer: M56's 588-vertex core, one solver refusal with no proof log)",
  -- ## Hand results of ours, written out in a binder
  -- `hRow99` (row 99's lower half through four, `L(F) ≤ 4 → L(F) ≤ χ(F²)`) is not in this list since FS131-LJ1: the binder's type is
  -- the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, term for term (`data/fs131/lj1/checks.lean` applies each of
  -- the four takers to it). That theorem rests on a declared outside theorem — it is a `RESTS` row of `kloosterman_bound` — so the
  -- hand result is discharged, not free: each taker still prints the standard three with the binder in its statement, and a statement
  -- that feeds the binder with the theorem prints Weil's bound. Retired on the landing's reading: the step compares no binder's type
  -- with any theorem's conclusion.
  .site ``HadwigerNelson.SpectralChain.min_localBound_five_le_chromaticNumber `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹ T-C(A) at S = ∅; X23V § 2.2)",
  .site ``HadwigerNelson.SpectralChain.min_localBound_five_le_chromaticNumber_of_totallyReal `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹ T-C(A) at S = ∅; X23V § 2.2)",
  .site ``HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹ T-C(A) at S = ∅; X23V § 2.2)",
  .site ``HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹ T-C(A) at S = ∅; X23V § 2.2)",
  -- The upper half `χ(F²) ≤ L(F)` (`hUpper` of `SpectralChain.chromaticNumber_eq_localBound`, label "UpperHalf", row 52) is not in
  -- this list since FS131-LU1: `UpperHalf.chromaticNumber_planeOver_le_localBound` proves that binder over the theorem's own
  -- variables, and `UpperHalf.chromaticNumber_eq_localBound_of_chain` is the headline without it.  Retired on the landing's
  -- word: the step has no check that finds a `.site` a theorem has proved (`FAIL discharged` reads named formers only).
  .site ``HadwigerNelson.StandingFive.five_le_chromaticNumber `hRow123 "Row123Chain" .ours
    "row 123 (min(L(F), 5) ≤ χ(F²) at the standing field; in the kernel over named hypotheses, SpectralChain.min_localBound_five_le_chromaticNumber)",
  .site ``HadwigerNelson.StandingFive.five_le_chromaticNumber_weil `hRow123 "Row123Chain" .ours
    "row 123 (min(L(F), 5) ≤ χ(F²) at the standing field; in the kernel over named hypotheses, SpectralChain.min_localBound_five_le_chromaticNumber)",
  .site ``HadwigerNelson.CharacterColouring.cl2 `hRQ4 "RQ4" .ours "FS89-D2-T1 (Θ₄(ℤ[U_ℚ]) ⊆ T + A)",
  .site ``HadwigerNelson.CharacterColouring.cl2 `hRQ5 "RQ5" .ours "FS89-D5-T2 (Θ₅(ℤ[U_ℚ]) ⊆ T + A)",
  .site ``HadwigerNelson.six_le_chromaticNumber_finitePlane23_of_indepNum_le `h "Alpha23" .ours
    "row 71 (α(Γ₂₃) ≤ 105, [cert]: data/fs54/cert-q23-l3-N105.json, tools/fs54_l3_cert_check.py)",
  .site ``HadwigerNelson.seven_le_chromaticNumber_finitePlane83_of_indepNum_le `h "Alpha83" .ours
    "row 68 (α(Γ₈₃) ≤ 1046 ≤ 1148, exact certificate, FS-50)",
  .site ``HadwigerNelson.five_le_chromaticNumber_finitePlane11_of_indepNum_le `h "Alpha11" .ours
    "row 68 (FS-50's certificate at 11, α(Γ₁₁) ≤ 29; the conclusion is kernel-checked by another route, chromaticNumber_finitePlane11)",
  .site ``HadwigerNelson.Arith.falconerFan_five_mem_eight `hR78 "Row78" .ours
    "row 78 (on the lattice, a difference every four-colouring identifies lies in 8Λ)",
  .site ``HadwigerNelson.Arith.falconerFan_five_mem_P `hR88 "Row88" .ours
    "row 88 (the forced group is 0 or P, and if it is P every four-colouring is periodic)",
  .site ``HadwigerNelson.Arith.falconerFan_five_mem_P `hR88per "Row88" .ours
    "row 88 (the forced group is 0 or P, and if it is P every four-colouring is periodic)",
  -- ## Open questions and design targets a theorem is conditional on
  .former ``HadwigerNelson.Plane.NoPar .open
    "C121-NOPAR (𝒫₆ is empty on the locally finite map colourings: the former is stated for every class of families, and the open statement is its instance there; FS121-C1-GMAP (ii), FS121-C1-SAT; FS131-L6A draft 5)",
  .site ``HadwigerNelson.not_colorable_five_of_forced_pairs `h3 "SixTarget" .open "row 43 (the six-target: every √3-pair and every distance-2 pair separated at five colours; G26) — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing to prove: its binder ranges over five-colourings of the plane, of which there are none (Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed (FS132-L1)",
  .site ``HadwigerNelson.not_colorable_five_of_forced_pairs `h2 "SixTarget" .open "row 43 (the six-target: every √3-pair and every distance-2 pair separated at five colours; G26) — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing to prove: its binder ranges over five-colourings of the plane, of which there are none (Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed (FS132-L1)",
  .site ``HadwigerNelson.six_le_chromaticNumber_plane_of_forced_pairs `h3 "SixTarget" .open "row 43 (the six-target: every √3-pair and every distance-2 pair separated at five colours; G26) — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing to prove: its binder ranges over five-colourings of the plane, of which there are none (Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed (FS132-L1)",
  .site ``HadwigerNelson.six_le_chromaticNumber_plane_of_forced_pairs `h2 "SixTarget" .open "row 43 (the six-target: every √3-pair and every distance-2 pair separated at five colours; G26) — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing to prove: its binder ranges over five-colourings of the plane, of which there are none (Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed (FS132-L1)",
  .site ``HadwigerNelson.not_colorable_six_of_forced_pairs `h3 "SevenTarget" .open "row 61 (the same target at six colours: two six-colour gadgets give χ ≥ 7)",
  .site ``HadwigerNelson.not_colorable_six_of_forced_pairs `h2 "SevenTarget" .open "row 61 (the same target at six colours: two six-colour gadgets give χ ≥ 7)",
  .site ``HadwigerNelson.seven_le_chromaticNumber_plane_of_forced_pairs `h3 "SevenTarget" .open "row 61 (the same target at six colours: two six-colour gadgets give χ ≥ 7)",
  .site ``HadwigerNelson.seven_le_chromaticNumber_plane_of_forced_pairs `h2 "SevenTarget" .open "row 61 (the same target at six colours: two six-colour gadgets give χ ≥ 7)",
  .site ``HadwigerNelson.six_le_chromaticNumber_oneTwo_of_forced_sqrt3 `h3 "SixTargetOneTwo" .open
    "row 61 (the six-target, distance-set-generic: the plane of the distances 1 and 2) — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing to prove: its binder ranges over five-colourings of the plane's {1, 2}-distance graph, each of them a five-colouring of the plane (chromaticNumber_unitDistance_le_distanceGraph), of which there are none (Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed (FS132-L1)",
  .site ``HadwigerNelson.Plane.chromaticNumber_plane_le_six_of_fragments `h "FragmentsAtEveryRadius" .open
    "row 145 (valid six-coloured fragments on discs of every radius: the YES side's exact form)",
  -- ## Closed premises that are not assumptions
  .premise ``HadwigerNelson.deGrey_bound_of_not_colorable `hG
    "the hand-off lemma of M04: the library proves the non-colourability over the same graph in its rotated presentation (deGreyRot_not_colorable_four) and concludes the bound there (chromaticNumber_plane_ge_five); nothing consumes this statement",
  .premise ``HadwigerNelson.Plane.voronov11_of_forall_mu_lt `H
    "one half of FS106-COMP's equivalence (mu_lt_of_voronov11 is the other): the implication is the content",
  -- ## Formers taken as hypotheses and concluded by no theorem that are conditions, not assumptions
  .condition ``HadwigerNelson.SpectralChain.TCA
    "T-C(A) at S = ∅ in class form, a property of the field F: the theorems take it only as the conclusion of the declared hypothesis CLS and as the antecedent of hMR",
  .condition ``HadwigerNelson.Arith.IsUsablePrime "a predicate of a prime of F (maximal, residue field of size ≡ 3 mod 4): a condition on the theorem's prime",
  .condition ``HadwigerNelson.Arith.NoAffFieldHyp "the field hypotheses of NOAFF-FIELDS at k: a condition on the field F and on k",
  .condition ``HadwigerNelson.ExtensionOrder "a greedy extension order of a graph: an inductive predicate of the theorem's vertex list, built by its constructors",
  .condition ``HadwigerNelson.IsLift "a first-order lift of a framework: a predicate of the theorem's deformation, taken only to be refuted or transported",
  .condition ``HadwigerNelson.Outside.OAI158.RealState "the release's state of a set of angles ([OAIMath2026] States.lean:92): the set is measurable and lies, up to a null set, in the lifted palette of every label of J — a predicate of the theorem's centre, set of angles and labels; built in the proof of SixRing.no_alternating_groups from a measurable two-valued map on the circle (FS132-L2)",
  .condition ``HadwigerNelson.Plane.AeProperRegions.IsRegion "a region (a colour and a connected component of its class): a predicate of the theorem's pair",
  .condition ``HadwigerNelson.Plane.Arc.IsUnitArc "a boundary arc of radius 1: a predicate of the theorem's arc, decided by a computation on written-down data",
  .condition ``HadwigerNelson.Plane.ArcMap.BaseCtx
    "the context of row134BaseUA's proof by contradiction: empty at every instance (BaseCtx.false); each taker is a step inside that refutation and says so",
  .condition ``HadwigerNelson.Plane.ArcMap.Condition6 "Condition 6 of [SokolovVoronov2025] read on an arc map: a property of the theorem's map (true of the one-colour plane)",
  .condition ``HadwigerNelson.Plane.ArcMap.CrossesAt "a colour crosses ω(v) at an angle: a predicate of the theorem's map, colour and angle",
  .condition ``HadwigerNelson.Plane.ArcMap.DoubleEvent "a double event of two rings: a predicate of the theorem's configuration (BV-ND's hypothesis)",
  .condition ``HadwigerNelson.Plane.ArcMap.HexRing "a hexagonal ring at u: a predicate of the theorem's map and ring (BV-HEX's hypothesis)",
  .condition ``HadwigerNelson.Plane.ArcMap.IsEssBoundary "an essential boundary point: a predicate of the theorem's map and point",
  .condition ``HadwigerNelson.Plane.ArcMap.Near.RayConfig "the configuration of a ray merge at a chart: a predicate of the theorem's chart, radii and curvatures",
  .condition ``HadwigerNelson.Plane.ArcMap.OnRingArc "x lies on an arc of Γ on ω(p): a predicate of the theorem's map and points",
  .condition ``HadwigerNelson.Plane.ArcMap.OuterPairFree "the outer pair of germs {u⁻, v⁺} at r(ψ) lies on no (Q) arc (two negated GermOnQ): a predicate of the theorem's map, point and angle; it holds at every angle of a (Q)-free ring (QFreeRing.not_germOnQ, twice)",
  .condition ``HadwigerNelson.Plane.ArcMap.RingProper "the ring of u is a proper finite circle colouring: a predicate of the theorem's map (BV-L3's hypothesis)",
  .condition ``HadwigerNelson.Plane.ArcMap.SaturatedAt "the map is saturated at w: a predicate of the theorem's map and point",
  .condition ``HadwigerNelson.Plane.ArcMap.Terminal "a terminal map (no move available anywhere): a predicate of the theorem's map; inhabited by sevenBrickMap through IsTerminalMap",
  .condition ``HadwigerNelson.Plane.ArcMap.TipPairFree "the tip pair of germs {v⁻, u⁺} at r(ψ) lies on no (Q) arc (two negated GermOnQ): a predicate of the theorem's map, point and angle; it holds at every angle of a (Q)-free ring (QFreeRing.not_germOnQ, twice)",
  .condition ``HadwigerNelson.Plane.ArcMap.Todo "something is left to do at v: a predicate of the theorem's map and point, inside the procedure's invariant",
  .condition ``HadwigerNelson.Plane.BranchGerms.Sorted "the germs are sorted: a predicate of the theorem's germ list, decided on written-down data",
  .condition ``HadwigerNelson.Plane.CPColouring.RotationInvariant "the law is rotation-invariant: a predicate of the theorem's CP colouring",
  .condition ``HadwigerNelson.Plane.GrundyBound
    "a Grundy-bound family (an admissible cover with almost disjoint classes, each class's support in the unit shadow of every earlier one): a predicate of the theorem's family; no Lean family is shown to be one (an open gate item of FS131-L6A, draft 6)",
  .condition ``HadwigerNelson.Plane.H1On "(H1) on N for two classes — every other class is null in N: a predicate of the theorem's family, set and two colours",
  .condition ``HadwigerNelson.Plane.InSixLens "x lies in the open lens about 60°m: a predicate of the theorem's point",
  .condition ``HadwigerNelson.Plane.IsAdmissible "an admissible family (measurable classes with null unit pairs): a predicate of the theorem's family",
  .condition ``HadwigerNelson.Plane.IsRegOf "a region of a family of classes: a predicate of the theorem's pair",
  .condition ``HadwigerNelson.Plane.IsSelection "a selection from a family: a predicate of the theorem's colouring",
  .condition ``HadwigerNelson.Plane.IsTriod "three arcs from x to the rim of the disc B(x, r) (the claim list's clauses on a sector point's arcs): a predicate of the theorem's point, radius and arcs; no declaration concludes it — `ThreePiece.IsSector.hasArcEdges` builds one inside its proof from the data of any sector point, and `sectorPoint_isSector` gives one (an open gate item of FS124-L2)",
  .condition ``HadwigerNelson.Plane.IsTriodCut "a triod with three open preconnected pairwise disjoint sets filling the disc less the arcs: a predicate of the theorem's arcs and pieces, the data a sector point is given with — not a hand result and not the classical theta-curve theorem, whose half 'the cut disc has three components' it takes as given; no declaration concludes it (as `IsTriod`; an open gate item of FS124-L2)",
  .condition ``HadwigerNelson.SixRing.FourCycleStraddle "the four-set hypothesis of C132-M-ORBIT (four compact sets through the centre whose straddle regions miss the essential supports of the consecutive labels of a four-cycle): a predicate of the theorem's colouring, centre, labels and sets, taken only to be refuted together with OutsideOrbit under a weak six-colouring (no_outside_orbit, not_ae_outside); the constant colouring satisfies it and is not weak (FS132-L2)",
  .condition ``HadwigerNelson.SixRing.OutsideOrbit "the ring hypothesis of C132-M-ORBIT, clauses (i) and (ii), at a centre, a base angle and a width: a predicate of the theorem's colouring, centre, two labels and angle, taken only to be refuted (no_outside_orbit_points) or carried by the leaves under that refutation; no declaration exhibits one (FS132-L2)",
  .condition ``HadwigerNelson.SpectralInputs.IsHaarFourier
    "m is a measure with Haar's Fourier coefficients: a predicate of the theorem's measure; its one existence theorem is from Herglotz–Bochner, declared",
  .condition ``HadwigerNelson.SpectralChain.IsTraceSpectral "σ is a trace spectral measure of μ: a predicate of the theorem's two measures (existence is from Herglotz–Bochner, declared)",
  .condition ``HadwigerNelson.SpectralInputs.IsSpectralMeasureOf "σ is a spectral measure of f: a predicate of the theorem's vector and measure; no declaration exhibits one (an open gate item of FS131-L10A)",
  .condition ``HadwigerNelson.SpernerGrid.Rainbow "three labels are pairwise distinct: a decidable predicate of the theorem's labels",
  .condition ``HadwigerNelson.Strip.WindowProper "a proper colouring of an L-column window: a predicate of the theorem's window colouring",
  .condition ``HadwigerNelson.Thomassen.IsTwoSep "a 2-separator of a graph: a predicate of the theorem's two vertices"
  ]

end AssumptionAudit

-- The entries `--self-test` plants: empty in the shipped file. The line below is the self-test's anchor, and
-- stays exactly as it is, alone on its line (a `--` comment, never a docstring: the plants replace the line).
def AssumptionAudit.planted : Array AssumptionAudit.Entry := #[]

#eval AssumptionAudit.run (AssumptionAudit.declared ++ AssumptionAudit.planted)
