import Proofs.HadwigerNelson.Outside.OAI158Rigidity
/-!
FS133-IA1, leaf R — the release's stored statement of `residual_fourier`, REBUILT as a term at this pin from its
print, and compared with the declared axiom's statement by this pin's KERNEL.

`release-type.txt` (written by `tools/fs133_ia1_rebuild.py emit`) is the release's stored type as its own kernel holds
it (FS132-I1's print, made at the release's pin), with the release's two namespaces mapped to this library's and
Mathlib's one rename applied.  This file parses that print into an `Expr` — every constant must exist at this pin,
under this module's imports, or the run fails —, and asks the kernel to accept

    theorem rebuilt_eq : (the release's statement, rebuilt) = (the declared axiom's statement) := Eq.refl _

so the kernel type-checks the rebuilt statement at this pin and checks that the two are definitionally equal.  Then
each closed pair of differing subterms (`pairs.txt`) is checked the same way on its own.  What this leaves to trust:
that a Mathlib (or core) constant of one name means one thing at the two pins.  What the kernel does not read:
binder kinds and binder names — the print comparison reads those (`data/fs133/ia1/axiom-readback/erased.out`).

Controls: three planted variants of the release's print (`plant-*.txt`): `≠` made `=` and a numeral changed must be
REFUSED by the kernel; the variant with a binder kind changed must be ACCEPTED (the kernel is blind to it), which is
why the print comparison stays.

  lake env lean data/fs133/ia1/rebuild/Rebuild.lean     (from the worktree root)
-/
open Lean Meta Elab Command
set_option linter.missingDocs false

namespace FS133IA1R

abbrev Pm := StateT Nat (ReaderT (Array Char) (Except String))

def peek : Pm Char := do
  let a ← read
  let i ← get
  if h : i < a.size then pure a[i] else throw "unexpected end of the print"

def adv : Pm Unit := modify (· + 1)

def expect (c : Char) : Pm Unit := do
  let d ← peek
  if d == c then adv else throw s!"expected '{c}', found '{d}' at {← get}"

/-- characters up to the next space, `)`, `]` or `,` -/
partial def tok (acc : String := "") : Pm String := do
  let c ← peek
  if c == ' ' || c == ')' || c == ']' || c == ',' then pure acc else do adv; tok (acc.push c)

partial def lvl : Pm Level := do
  let c ← peek
  if c == '0' then adv; pure .zero
  else
    expect '('
    let k ← tok
    expect ' '
    match k with
    | "S" => let l ← lvl; expect ')'; pure (.succ l)
    | "max" => let a ← lvl; expect ' '; let b ← lvl; expect ')'; pure (.max a b)
    | "imax" => let a ← lvl; expect ' '; let b ← lvl; expect ')'; pure (.imax a b)
    | "p" => let n ← tok; expect ')'; pure (.param n.toName)
    | _ => throw s!"unknown level form '{k}'"

partial def lvls : Pm (List Level) := do
  expect '['
  if (← peek) == ']' then adv; return []
  let mut out := [← lvl]
  while (← peek) == ',' do
    adv
    out := out ++ [← lvl]
  expect ']'
  return out

def binderOf (k : String) : Except String BinderInfo :=
  if k.endsWith ".d" then pure .default else if k.endsWith ".i" then pure .implicit
  else if k.endsWith ".s" then pure .strictImplicit else if k.endsWith ".c" then pure .instImplicit
  else throw s!"unknown binder form '{k}'"

partial def expr : Pm Expr := do
  if (← peek) == '#' then
    adv
    let n ← tok
    return .bvar n.toNat!
  expect '('
  let c ← peek
  if c == '(' || c == '#' then
    let f ← expr; expect ' '; let a ← expr; expect ')'
    return .app f a
  let k ← tok
  expect ' '
  match k with
  | "Sort" => let l ← lvl; expect ')'; return .sort l
  | "c" => let n ← tok; expect ' '; let ls ← lvls; expect ')'; return .const n.toName ls
  | "nat" => let n ← tok; expect ')'; return .lit (.natVal n.toNat!)
  | "proj" =>
    let s ← tok; expect ' '; let i ← tok; expect ' '; let e ← expr; expect ')'
    return .proj s.toName i.toNat! e
  | "let" =>
    let n ← tok; expect ' '; let t ← expr; expect ' '; let v ← expr; expect ' '; let b ← expr; expect ')'
    return .letE n.toName t v b false
  | _ =>
    let bi ← (binderOf k : Except String BinderInfo)
    let n ← tok; expect ' '; let t ← expr; expect ' '; let b ← expr; expect ')'
    if k.startsWith "lam." then return .lam n.toName t b bi
    else if k.startsWith "pi." then return .forallE n.toName t b bi
    else throw s!"unknown form '{k}'"

def parseExpr (s : String) : Except String Expr := do
  let a := (s.toList.filter (· != '\n')).toArray
  let (e, i) ← (expr.run 0).run a
  if i != a.size then throw s!"the print was not read to its end ({i} of {a.size})"
  pure e

def dir : System.FilePath := "data/fs133/ia1/rebuild"

/-- Ask the kernel for `theorem name : a = b := Eq.refl b` (with `a b : α`, `α : Sort u`). -/
def kernelEq (name : Name) (lps : List Name) (u : Level) (α a b : Expr) : CoreM (Except String Unit) := do
  let decl := Declaration.thmDecl {
    name := name, levelParams := lps,
    type := mkApp3 (mkConst ``Eq [u]) α a b,
    value := mkApp2 (mkConst ``Eq.refl [u]) α b }
  -- the kernel, called synchronously with its check on (`doCheck := true`); `0`: no heartbeat limit
  match (← getEnv).addDeclCore 0 decl none true with
  | Except.ok env => setEnv env; return Except.ok ()
  | Except.error ex => return Except.error (← (ex.toMessageData (← getOptions)).toString)

def missing (e : Expr) : CoreM (List Name) := do
  let env ← getEnv
  return (e.getUsedConstants.filter fun n => !env.contains n).toList

def run : CommandElabM Unit := do
  let ax := ``HadwigerNelson.Outside.OAI158.Spectral.residual_fourier
  let ci ← liftCoreM (getConstInfo ax)
  let here := ci.type
  let mut ok := true
  for (label, file, wantAccept) in [("the release's statement", "release-type.txt", true),
      ("plant: `≠` made `=`", "plant-Ne-to-Eq.txt", false), ("plant: a numeral changed (the rebuilt term is then ill-typed)", "plant-numeral.txt", false),
      ("plant: a binder kind changed (the kernel does not read it)", "plant-binder-kind.txt", true)] do
    let text ← IO.FS.readFile (dir / file)
    match parseExpr text with
    | .error e => IO.println s!"R {label}: PARSE FAILED — {e}"; ok := false
    | .ok rel =>
      let miss ← liftCoreM (missing rel)
      unless miss.isEmpty do
        IO.println s!"R {label}: constants absent at this pin under this module's imports: {miss}"; ok := false; continue
      let name := Name.mkSimple ("rebuilt_" ++ (file.takeWhile (· != '.')).replace "-" "_")
      let r ← liftCoreM (kernelEq (`FS133IA1R ++ name) ci.levelParams Level.one (mkSort Level.zero) rel here)
      match r with
      | .ok () =>
        IO.println s!"R {label}: KERNEL ACCEPTED `{`FS133IA1R ++ name} : (rebuilt) = (declared) := Eq.refl _` — {rel.getUsedConstants.size} constants named, all at this pin; identical as terms: {rel == here}"
        ok := ok && wantAccept
      | .error e =>
        IO.println s!"R {label}: KERNEL REFUSED — {(e.take 160).replace "\n" " "}"
        ok := ok && !wantAccept
  -- the differing subterms, each on its own
  let pairs := ((← IO.FS.readFile (dir / "pairs.txt")).splitOn "\n").filter (· != "")
  let mut k := 0
  for ln in pairs do
    k := k + 1
    match ln.splitOn "\t" with
    | [a, b] =>
      match parseExpr a, parseExpr b with
      | .ok ea, .ok eb =>
        let (α, u) ← liftTermElabM do
          let α ← inferType eb
          let u ← getLevel α
          pure (α, u)
        let r ← liftCoreM (kernelEq (`FS133IA1R ++ Name.mkSimple s!"pair_{k}") [] u α ea eb)
        let pα ← liftTermElabM (ppExpr α)
        match r with
        | .ok () => IO.println s!"R pair {k} (of type `{pα}`): KERNEL ACCEPTED `(the release's instance) = (this pin's) := Eq.refl _`"
        | .error e => IO.println s!"R pair {k} (of type `{pα}`): KERNEL REFUSED — {(e.take 160).replace "\n" " "}"; ok := false
      | _, _ => IO.println s!"R pair {k}: PARSE FAILED"; ok := false
    | _ => IO.println s!"R pair {k}: malformed line"; ok := false
  IO.println s!"R pairs checked: {k}"
  IO.println (if ok then "REBUILD OK: every outcome as expected" else "REBUILD FAILED")

#eval run

end FS133IA1R

#print axioms FS133IA1R.rebuilt_release_type
