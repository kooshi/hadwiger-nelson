import Proofs

/-!
# The doubled-name scan — one name, declared by two modules, that the build does not see

Run it through the gate script, which turns what this file prints into a verdict:

```
./scripts/dupnames.sh
```

## What it is for

Lean refuses a second declaration of a name **in one file's environment**, so a doubled name is an
error when one declaring module imports the other. When neither does, each module compiles alone, and
the two copies first meet in a module that imports both. There the importer (`Lean/Environment.lean`,
`finalizeImport` and `subsumesInfo`, v4.32.0) **accepts** the second constant when both are theorems of
one type — or a theorem and an axiom of one type, or two axioms of one proposition — and throws
`environment already contains` only otherwise. The pair that prompted this file,
`HadwigerNelson.Plane.conj_e` in `Plane/Chord` and `Plane/SixFragment`, stood on `main` unseen by every
step of the gate until a join of four branches met it (FS131-M7).

## Why it matters to the gate, measured (FS131-T4, `data/fs131/t4/experiment-table.md`)

For a name declared by two sibling modules the environment **keeps the constant of the module imported
last**, and `#print axioms` **reads the axiom list the module imported first stored** for that name
(`Lean/Util/CollectAxioms.lean`: a list per declaration is written with each module's `.olean` and
looked up through `Environment.getModuleIdxFor?`, which names the first module to declare the name).
They are never the same copy. So with a clean copy imported first and a `sorry` copy imported last, the
environment holds the `sorry`, and `#print axioms` — of the name, and of every theorem that uses it —
prints clean. The axiom audit (`scripts/Axioms.lean`) is faithful to the environment only when no name
is declared twice. This scan is the check that none is.

## What it reads

The compiled data of every imported module, as the environment keeps it (`env.header.moduleData`): each
module's own constants, before the importer merges them. So it sees what a scan of the source cannot —
instances under their generated names, derived and macro-made declarations — and it sees both copies of
a pair, where the environment itself (`env.constants`) holds one.

**Scope**: every name declared by a module of the package under audit (root `Proofs`) and by any other
imported module, of the package or of a dependency. A name two dependencies' modules share and no module
of ours declares is theirs, and is not reported.

## The one class that is not a failure, and why

Lean generates some theorems **on demand, in whichever module first asks**: the equation lemmas of a
definition (`f.eq_1`, `f.eq_def`), a matcher's equations and splitter, `f.induct`, `f.congr_simp`, and
their kin. Two sibling modules that each ask get one copy each, by Lean's own design — it is the stated
reason the importer merges theorems at all (`subsumesInfo`'s comment: "We want to generate equational
theorems on demand and potentially in different files"). Such a name is a **reserved name**
(`Lean.isReservedName`), and Lean refuses a hand-written declaration of one (`Lean/Elab/DeclModifiers.lean`:
"is a reserved name"), so no author can land in the class by choosing a name. A repeated name is
`GENERATED` exactly when **it is reserved, every copy is a theorem, and all copies have one type**; it is
counted and listed, never silent, and does not fail. A generated pair whose copies' axioms differ is
still printed with `axioms=differ` and fails: nothing in that class has ever been seen to, and one that
did would mislead the audit exactly as a hand-written pair does.

Everything else is `DOUBLED` and fails the gate.

## What it prints

Fixed-prefix lines, which `scripts/dupnames.sh` parses (and which `scripts/dupnames-controls.txt`'s
planted libraries exercise):

* `=== DUPNAMES ===` and `=== END ===`, the first and last lines: a run that prints one and not the
  other did not finish.
* `SCANNED modules=… package-modules=… package-constants=… other-constants=…` — the positive signal
  that the scan read the library: the wrapper compares `package-modules` with the count of the
  package's source files.
* per repeated name, `DOUBLED <name> :: …` or `GENERATED <name> :: …`, then one `COPY <name> …` line per
  declaring module in import order — its kind, whether it is the copy the environment holds, whether it
  is the module the environment attributes the name to (the one whose stored axiom list `#print axioms`
  reads), and the axioms of that copy's own proof.
* `TOTALS doubled=… generated=… generated-axioms-differ=…`.
-/

open Lean Elab Command

namespace DupNames

/-- The kind of a constant, as the kernel holds it. -/
def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "constructor"
  | .recInfo _ => "recursor"

/-- The value of a constant that has one. -/
def valueOf? : ConstantInfo → Option Expr
  | .thmInfo v => some v.value | .defnInfo v => some v.value | .opaqueInfo v => some v.value
  | _ => none

/-- Two constants are one copy: one kind, one type, one value. -/
def sameCopy (a b : ConstantInfo) : Bool :=
  kindOf a == kindOf b && a.type == b.type && valueOf? a == valueOf? b

/-- The axioms of **this copy's own** type and proof: collected through the constants they use, so the
answer is about the copy in hand and not about whichever copy the environment attributes the name to.
An axiom rests on itself. Sorted. -/
def axiomsOfCopy (ci : ConstantInfo) : CommandElabM (Array Name) := do
  let mut acc : NameSet := {}
  if ci.isAxiom then acc := acc.insert ci.name
  let used := ci.type.getUsedConstants ++ ((valueOf? ci).map (·.getUsedConstants)).getD #[]
  for c in used do
    for a in (← collectAxioms c) do acc := acc.insert a
  return acc.toArray.qsort Name.lt

/-- A list of names on one line (a formatted message wraps a long list, and these lines are parsed). -/
def showNames (xs : Array Name) : String :=
  "[" ++ ", ".intercalate (xs.toList.map toString) ++ "]"

/-- **The scan.** `roots`: the root namespaces of the package under audit (`#[`Proofs]`). Prints the
lines the module docstring lists. Refuses — so the file does not elaborate and the gate fails — when it
read no module of the package: a scan of nothing is not a clean scan. -/
def scan (roots : Array Name) : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  unless mods.size == data.size do
    throwError "DupNames.scan: {mods.size} module names and {data.size} modules' data"
  let isPkg (i : Nat) : Bool := roots.any (·.isPrefixOf mods[i]!)
  -- Pass 1: every name a module of the package declares, with the modules that declare it.
  let mut decl : Std.HashMap Name (Array Nat) := {}
  let mut pkgMods := 0
  let mut pkgConsts := 0
  for i in [0:mods.size] do
    if isPkg i then
      pkgMods := pkgMods + 1
      for n in data[i]!.constNames do
        pkgConsts := pkgConsts + 1
        decl := decl.alter n fun
          | none => some #[i]
          | some a => some (a.push i)
  if pkgMods == 0 then
    throwError "DupNames.scan: no imported module lies under {roots}; nothing was scanned"
  -- Pass 2: the same names in every other imported module.
  let mut otherConsts := 0
  for i in [0:mods.size] do
    unless isPkg i do
      for n in data[i]!.constNames do
        otherConsts := otherConsts + 1
        if decl.contains n then decl := decl.modify n (·.push i)
  logInfo "=== DUPNAMES ==="
  logInfo s!"SCANNED modules={mods.size} package-modules={pkgMods} package-constants={pkgConsts} other-constants={otherConsts}"
  let repeated := decl.toArray.filter (·.2.size > 1) |>.qsort (fun a b => a.1.toString < b.1.toString)
  let mut doubled := 0
  let mut generated := 0
  let mut genDiffer := 0
  for (n, idxs) in repeated do
    let idxs := idxs.qsort (· < ·)
    -- each declaring module's own copy, in import order
    let mut copies : Array (Nat × ConstantInfo) := #[]
    for i in idxs do
      let d := data[i]!
      for cn in d.constNames, ci in d.constants do
        if cn == n then copies := copies.push (i, ci)
    unless copies.size == idxs.size do
      throwError "DupNames.scan: {n} is listed by {idxs.size} modules and {copies.size} copies were read"
    let some held := env.find? n
      | throwError "DupNames.scan: {n} is declared by {idxs.size} modules and the environment holds none"
    let attr := (env.getModuleIdxFor? n).map (·.toNat)
    let oneType := copies.all (·.2.type == copies[0]!.2.type)
    let allThm := copies.all (kindOf ·.2 == "theorem")
    let axs ← copies.mapM (axiomsOfCopy ·.2)
    let axSame := axs.all (· == axs[0]!)
    let isGen := isReservedName env n && allThm && oneType
    if isGen then
      generated := generated + 1
      unless axSame do genDiffer := genDiffer + 1
    else
      doubled := doubled + 1
    logInfo s!"{if isGen then "GENERATED" else "DOUBLED"} {n} :: modules={idxs.size} \
      types={if oneType then "same" else "differ"} axioms={if axSame then "same" else "differ"} \
      reserved={isReservedName env n}"
    for (i, ci) in copies, ax in axs do
      logInfo s!"COPY {n} :: {mods[i]!} kind={kindOf ci} held={sameCopy ci held} \
        attributed={attr == some i} package={isPkg i} axioms={showNames ax}"
  logInfo s!"TOTALS doubled={doubled} generated={generated} generated-axioms-differ={genDiffer}"
  logInfo "=== END ==="

end DupNames

#eval DupNames.scan #[`Proofs]
