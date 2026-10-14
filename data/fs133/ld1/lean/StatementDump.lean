import Proofs.HadwigerNelson.Plane.OneClass.Fractional
import Proofs.HadwigerNelson.Plane.OneClass.Pair
/-!
FS133-LD1 — every constant of the density equality's modules as the kernel holds it, in two prints: read-only.

The body is FS132-I2's dumper as FS133-IPQ1 used it (`data/fs133/ipq1/lean/StatementDump.lean`, lines between its
first `namespace FS132I2` and its last `end FS132I2`, copied unchanged by `sed`): per constant, its kind, the FULL
stored type (and a definition's value) and the ERASED one, every instance and proof argument written `_`.

What is dumped is read from two files named by environment variables, so that one dumper serves both sides of the
join:
- `LD1_MODULES`: one module per line; for each, every constant stored in its compiled data that is a statement of
  the file (named, or a private declaration of the file), under `## MODULE <m> …` — as FS133-IPQ1's dumper;
- `LD1_NAMES` (optional): one constant name per line (a private one as `_private.<module>.0.<name>`); each not
  already printed is looked up by name in the environment wherever it is now declared and printed under
  `## MODULE <its module>` (a name not found prints `DUMP <n> : ABSENT`, which the reader fails on).
The output goes to the file named by `LD1_OUT` (stdout re-pointed: `LEAN.md`, a captured stdout is held to the end).

  LD1_MODULES=… LD1_NAMES=… LD1_OUT=… lake env lean data/fs133/ld1/lean/StatementDump.lean
-/

namespace FS132I2
open Lean
/-- A canonical print of a universe level. -/
partial def dumpLevel : Level → String
  | .zero => "0"
  | .succ l => s!"(S {dumpLevel l})"
  | .max a b => s!"(max {dumpLevel a} {dumpLevel b})"
  | .imax a b => s!"(imax {dumpLevel a} {dumpLevel b})"
  | .param n => s!"(p {n})"
  | .mvar _ => "(lmvar)"
def bi : BinderInfo → String
  | .default => "d" | .implicit => "i" | .strictImplicit => "s" | .instImplicit => "c"
/-- A canonical print of a term as the kernel holds it: de Bruijn indices, full constant names with their universe
arguments, every implicit and instance argument, binder kinds and binder names (macro scopes erased). Two terms print
alike exactly when they are the same term up to metadata. (FS132-I1's print, `data/fs132/i1/readback/DumpBody.lean.inc`.) -/
partial def dump : Expr → String
  | .bvar i => s!"#{i}"
  | .fvar _ => "(fvar)"
  | .mvar _ => "(mvar)"
  | .sort l => s!"(Sort {dumpLevel l})"
  | .const n ls => s!"(c {n} [{String.intercalate "," (ls.map dumpLevel)}])"
  | .app f a => s!"({dump f} {dump a})"
  | .lam n t b i => s!"(lam.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .forallE n t b i => s!"(pi.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .letE n t v b _ => s!"(let {n.eraseMacroScopes} {dump t} {dump v} {dump b})"
  | .lit (.natVal n) => s!"(nat {n})"
  | .lit (.strVal s) => s!"(str {s.quote})"
  | .mdata _ e => dump e
  | .proj s i e => s!"(proj {s} {i} {dump e})"
open Meta in
/-- The same print with every INSTANCE argument and every PROOF argument written `_`: an argument is erased when the
applied function's own signature, at this pin, takes it instance-implicitly (`[inst : C α]`) or at a type that is a
proposition. What is left is what the term says with the choice of instances and the proofs of side conditions set
aside. Free variables print as their position in the local context (`@n`). -/
partial def dumpE (e : Expr) : MetaM String := do
  match e with
  | .mdata _ e => dumpE e
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    let info ← getFunInfoNArgs f args.size
    let mut s ← dumpE f
    for i in [0:args.size] do
      let erase := match info.paramInfo[i]? with
        | some pi => pi.binderInfo.isInstImplicit || pi.isProp
        | none => false
      if erase then s := s!"({s} _)" else s := s!"({s} {← dumpE args[i]!})"
    return s
  | .lam n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(lam.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .forallE n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(pi.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .letE n t v b _ => do
    let ts ← dumpE t
    let vs ← dumpE v
    withLetDecl n t v fun x => do
      return s!"(let {n.eraseMacroScopes} {ts} {vs} {← dumpE (b.instantiate1 x)})"
  | .fvar id => do return s!"@{(← id.getDecl).index}"
  | .proj s i e => do return s!"(proj {s} {i} {← dumpE e})"
  | e => return dump e
/-- A name from its print; `PRIVATE|module|name` is the private name `name` of `module`. -/
def toName (s : String) : Name :=
  match s.splitOn "|" with
  | ["PRIVATE", m, n] => mkPrivateNameCore m.toName n.toName
  | _ => s.toName
def kindOf : ConstantInfo → String
  | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom" | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec" | .quotInfo _ => "quot"
/-- One declaration: its kind, universe parameters, stored type, and (for a definition) stored value; then every
constant the type and the value name, each with the module that declares it. `label` is what the line is filed under. -/
def report (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"DUMP {label} : ABSENT"
  | some ci =>
    IO.println s!"DUMP {label} : {kindOf ci} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    IO.println s!"DUMP   etype = {← (dumpE ci.type).run'}"
    let mut used := ci.type.getUsedConstants
    if let .defnInfo d := ci then
      IO.println s!"DUMP   value = {dump d.value}"
      IO.println s!"DUMP   evalue= {← (dumpE d.value).run'}"
      used := used ++ d.value.getUsedConstants
    for c in (used.qsort Name.lt).toList.eraseDups do
      let m := match env.getModuleIdxFor? c with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      IO.println s!"USES {label} : {c} @ {m}"
/-- Level one: one constant as the kernel holds it at this pin — kind, universe parameters, type, and what fixes its
meaning one step down (a definition's value; an inductive type's constructors with their types). -/
def level1 (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"L1 {label} | ABSENT"
  | some ci =>
    let m := match env.getModuleIdxFor? n with
      | some i => toString env.header.moduleNames[i.toNat]!
      | none => "(this file)"
    let body ← match ci with
      | .defnInfo d => pure s!"def | value = {dump d.value}"
      | .inductInfo v => do
          let mut s := s!"inductive params={v.numParams} indices={v.numIndices} |"
          for c in v.ctors do
            let some cc := env.find? c | pure ()
            s := s ++ s!" ctor {c} : {dump cc.type} ;"
          pure s
      | ci => pure s!"{kindOf ci} |"
    IO.println s!"L1 {label} | levels={ci.levelParams} | type = {dump ci.type} | {body}"
    IO.println s!"L1MOD {label} @ {m}"
def runAll (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do report l s
  IO.println s!"DONE {xs.length}"
def runLevel1 (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do level1 l s
  IO.println s!"DONE {xs.length}"
end FS132I2

namespace FS132I2
open Lean in
/-- `report` for a name (no round trip through a string). -/
def reportN (n : Name) : CoreM Unit := do
  let env ← getEnv
  match env.find? n with
  | none => IO.println s!"DUMP {n} : ABSENT"
  | some ci =>
    IO.println s!"DUMP {n} : {kindOf ci} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    IO.println s!"DUMP   etype = {← (dumpE ci.type).run'}"
    if let .defnInfo d := ci then
      IO.println s!"DUMP   value = {dump d.value}"
      IO.println s!"DUMP   evalue= {← (dumpE d.value).run'}"
end FS132I2

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let some mf ← IO.getEnv "LD1_MODULES" | throwError "LD1_MODULES is not set"
  let some outp ← IO.getEnv "LD1_OUT" | throwError "LD1_OUT is not set"
  let modList := (← IO.FS.lines mf).toList.filter (· ≠ "") |>.map String.toName
  let nameList ← match ← IO.getEnv "LD1_NAMES" with
    | some nf => pure ((← IO.FS.lines nf).toList.filter (· ≠ ""))
    | none => pure []
  let h ← IO.FS.Handle.mk outp .write
  let old ← IO.setStdout (IO.FS.Stream.ofHandle h)
  let mut total := 0
  let mut printed : NameSet := {}
  for m in modList do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    let all := d.constants.map (·.name)
    let pub := (all.filter (fun n => !n.isInternalDetail)).qsort Name.lt
    let priv := (all.filter (fun n => match privateToUserName? n with
      | some u => !u.isInternalDetail && !(u.components.any fun c => (toString c).startsWith "_")
      | none => false)).qsort Name.lt
    IO.println s!"## MODULE {m} named={pub.size} private={priv.size} of {d.constants.size}"
    for n in pub do
      liftCoreM (FS132I2.reportN n)
      printed := printed.insert n
    for n in priv do
      IO.println s!"## PRIVATE {n}"
      liftCoreM (FS132I2.reportN n)
      printed := printed.insert n
    total := total + pub.size + priv.size
  let mut byName := 0
  for s in nameList do
    let n := s.toName
    if printed.contains n then continue
    let m := match env.getModuleIdxFor? n with
      | some i => toString mods[i.toNat]!
      | none => "(absent)"
    IO.println s!"## MODULE {m} by-name"
    liftCoreM (FS132I2.reportN n)
    printed := printed.insert n
    total := total + 1
    byName := byName + 1
  IO.println s!"## BY-NAME {byName}"
  IO.println s!"DONE {total}"
  h.flush
  let _ ← IO.setStdout old
  IO.println s!"LD1 DUMP WRITTEN: {total} constants ({byName} by name) to {outp}"
