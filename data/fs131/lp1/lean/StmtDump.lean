import Proofs
/-!
FS131-LP1 (the landing of the port), the stored-statement dump before and after the docstring edits: FS131-IPD1's
switch dumper `data/fs131/ipd1/lean/SwitchDump4.lean`, copied whole with this header changed and nothing else — every
named and private constant of `Outside/OAI158`, of every module downstream of it that the switch's step 4 read, of
`Outside/OAI158Collapse` and of `Outside/OAI158BorelTransfer`, as the kernel holds it in the compiled library (FS132-I2's
full and erased prints). Run with `lake env lean` from the built tree; compared by `tools/fs131_ipd1_switchdiff.py`'s
reader in `tools/fs131_lp1_stmtdiff.py`.
-/

-- FS131-KO1 footer (appended to a scratch copy of a module; never committed into `Proofs/`): every named constant this
-- file declares, as the kernel holds it, in FS132-I2's two prints (full; instance and proof arguments erased), copied
-- from FS133-IA1's `data/fs133/ia1/lean/StatementDumpErased.lean` (branch `fs133-wb1`) with only the last command
-- changed: it reads the constants added by this file (`env.constants.map₂`) in place of a list of compiled modules.
namespace FS131KO1Dump
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
        | some pinfo => pinfo.binderInfo.isInstImplicit || pinfo.isProp
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
end FS131KO1Dump

namespace FS131KO1Dump
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
end FS131KO1Dump


open Lean Elab Command in
/-- The listed modules, each `## MODULE <name> named=<n> internal=<k>`, then `report` of each of its named and private
constants in name order; a module that is not imported is an error. -/
def FS131IPD1SwitchDump.run (modules : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let mut total := 0
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := env.header.moduleData[i]!
    let all := d.constants.map (·.name)
    let named := (all.filter fun n => !n.isInternalDetail || isPrivateName n).qsort Name.lt
    IO.println s!"## MODULE {m} named={named.size} internal={all.size - named.size}"
    for n in named do
      liftCoreM (FS131KO1Dump.reportN n)
    total := total + named.size
  IO.println s!"DONE {total}"

#eval FS131IPD1SwitchDump.run [`Proofs.HadwigerNelson.Outside.OAI158, `Proofs.HadwigerNelson.Outside.OAI158AngularBoundary, `Proofs.HadwigerNelson.Outside.OAI158BinaryPalettes, `Proofs.HadwigerNelson.Outside.OAI158CircleMaps, `Proofs.HadwigerNelson.Outside.OAI158CircleTransport, `Proofs.HadwigerNelson.Outside.OAI158Expansion, `Proofs.HadwigerNelson.Outside.OAI158Palette, `Proofs.HadwigerNelson.Outside.OAI158PaletteDensity, `Proofs.HadwigerNelson.Outside.OAI158PaletteTransport, `Proofs.HadwigerNelson.Outside.OAI158States, `Proofs.HadwigerNelson.Plane.LebesgueNumber, `Proofs.HadwigerNelson.Plane.RadiusOutside, `Proofs.HadwigerNelson.Plane.SixRing.Basic, `Proofs.HadwigerNelson.Plane.SixRing.Chart, `Proofs.HadwigerNelson.Plane.SixRing.ChartMeasure, `Proofs.HadwigerNelson.Plane.SixRing.Confine, `Proofs.HadwigerNelson.Plane.SixRing.Excl, `Proofs.HadwigerNelson.Plane.SixRing.Kill, `Proofs.HadwigerNelson.Plane.SixRing.NullSets, `Proofs.HadwigerNelson.Plane.SixRing.Orbit, `Proofs.HadwigerNelson.Plane.SixRing.Shift, `Proofs.HadwigerNelson.Plane.SixRing.State, `Proofs.HadwigerNelson.Plane.SixRing.StepLemma, `Proofs.HadwigerNelson.Plane.SixRing.Tips, `Proofs.HadwigerNelson.Plane.SixRing.TwoPairs, `Proofs.HadwigerNelson.Outside.OAI158Collapse, `Proofs.HadwigerNelson.Outside.OAI158BorelTransfer]
