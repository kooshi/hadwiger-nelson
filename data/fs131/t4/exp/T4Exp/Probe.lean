import Lean
/-! FS131-T4's probe: what the environment holds for a name, read from the environment's own data.
Written by `tools/fs131_t4_experiment.py`. -/
open Lean Elab Command

namespace T4Exp

/-- The kind of a constant, as the kernel holds it. -/
def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "constructor" | .recInfo _ => "recursor"

/-- The value of a constant that has one. -/
def valueOf? : ConstantInfo → Option Expr
  | .thmInfo v => some v.value | .defnInfo v => some v.value | .opaqueInfo v => some v.value | _ => none

/-- The constants a copy's value uses, sorted (an axiom: none). -/
def usesOf (ci : ConstantInfo) : Array Name :=
  ((valueOf? ci).map (·.getUsedConstants)).getD #[] |>.qsort Name.lt

/-- Two constants are one copy: same kind, type and value. -/
def sameCopy (a b : ConstantInfo) : Bool :=
  kindOf a == kindOf b && a.type == b.type && valueOf? a == valueOf? b

/-- Every (module, constant) whose compiled data declares `n`, in import order. -/
def copies (env : Environment) (n : Name) : Array (Name × ConstantInfo) := Id.run do
  let mut out := #[]
  for m in env.header.moduleNames, d in env.header.moduleData do
    for cn in d.constNames, ci in d.constants do
      if cn == n then out := out.push (m, ci)
  return out

/-- `#t4probe n`: one `PROBE` line per fact about `n`. A name no module declares is an error, never an empty report. -/
elab "#t4probe " id:ident : command => do
  let env ← getEnv
  let n := id.getId
  let cs := copies env n
  if cs.isEmpty then throwError "#t4probe: no imported module declares {n}"
  let some held := env.find? n | throwError "#t4probe: the environment holds no {n}"
  -- Strings, never `m!`: a formatted message wraps a long list across lines, and these lines are parsed.
  let show_ (xs : Array Name) : String := "[" ++ ", ".intercalate (xs.toList.map toString) ++ "]"
  for (m, ci) in cs do
    logInfo s!"PROBE {n} DECLARED-BY {m} kind={kindOf ci} uses={show_ (usesOf ci)}"
  let from_ := cs.filter (fun p => sameCopy p.2 held) |>.map (·.1)
  logInfo s!"PROBE {n} ENV-HOLDS kind={kindOf held} uses={show_ (usesOf held)} copy-of={show_ from_}"
  match (env.getModuleIdxFor? n).bind fun i => env.header.moduleNames[i.toNat]? with
  | some m => logInfo s!"PROBE {n} ATTRIBUTED-TO {m}"
  | none => logInfo s!"PROBE {n} ATTRIBUTED-TO none"
  let printed ← collectAxioms n
  logInfo s!"PROBE {n} AXIOMS-PRINTED {show_ (printed.qsort Name.lt)}"
  let mut real : NameSet := {}
  if held.isAxiom then real := real.insert n
  for c in usesOf held do
    for a in (← collectAxioms c) do real := real.insert a
  logInfo s!"PROBE {n} AXIOMS-OF-HELD-VALUE {show_ (real.toArray.qsort Name.lt)}"

/-- `#t4locals`: the constants the file itself has declared so far, on one `LOCALS` line. -/
elab "#t4locals" : command => do
  let env ← getEnv
  let ns := env.constants.map₂.toList.map (·.1) |>.toArray.qsort (fun a b => a.toString < b.toString)
  logInfo s!"LOCALS [{", ".intercalate (ns.toList.map toString)}]"

end T4Exp
