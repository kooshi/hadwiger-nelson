import Proofs.HadwigerNelson.PadicPlane.Tower
/-!
FS131-IQP3 — the two ruled binder drops of inventory item 1014 (1), undone by term surgery on the gated build's stored
types (FS131-LCH1's `data/fs131/lch1/lean/ReAdd.lean`, its `insertAfter`), so that each can be compared with the stored type
FS131-IQP1 dumped from the compiled skeleton before any proof (`data/fs131/iqp1/statements-before.txt`):

* `PadicPlane.exists_levelEmbedding` — `(hk : 1 ≤ k)` put back after its seven leading binders `p`, `[Fact p.Prime]`, `P`,
  `hpP`, `h2`, `hQ`, `k`;
* `PadicPlane.charSum_levelOne_of_unitCircle` — `(hpP : ((p : ℕ) : 𝓞 (fieldI ⊥)) ∈ P.P)` put back after its three
  leading binders `p`, `[Fact p.Prime]`, `P`; the domain is read from `exists_levelEmbedding`'s own `hpP` (the same text in
  the same file), instantiated at the same three binders.

Each line prints the re-added type's `Expr.hash` (which reads no binder name) and its raw print (which shows every binder's
kind, `(…)`, `{…}`, `[…]`, and prints a non-dependent binder as an arrow), for comparison with the before-print by
`data/fs131/iqp3/statements.py`. Two controls per drop must differ from the before-print: the domain replaced by `True`, and
a near miss (`2 ≤ k`; `hpP`'s domain at `p + 1`).

Run from the worktree, under a slot:
  lake env lean data/fs131/iqp3/lean/ReAdd.lean > data/fs131/iqp3/readd.txt
-/
open Lean Meta Elab Command

namespace FS131IQP3ReAdd

/-- Insert one non-dependent binder with domain `dom xs` after the first `k` binders of `t`. -/
def insertAfter (t : Expr) (k : Nat) (dom : Array Expr → MetaM Expr) : MetaM Expr :=
  forallBoundedTelescope t k fun xs body => do
    unless xs.size == k do throwError "the type has fewer than {k} leading binders"
    let d ← dom xs
    mkForallFVars xs (← mkArrow d body)

/-- A stored type, by name. -/
def typeOf (n : Name) : MetaM Expr := do
  let some ci := (← getEnv).find? n | throwError "unknown {n}"
  pure ci.type

/-- `(n : ℕ)` as the elaborator writes a numeral. -/
def natLit (n : Nat) : Expr :=
  mkApp3 (mkConst ``OfNat.ofNat [Level.zero]) (mkConst ``Nat) (mkRawNatLit n) (mkApp (mkConst ``instOfNatNat) (mkRawNatLit n))

/-- `a ≤ k` in `ℕ`. -/
def natLe (a : Nat) (k : Expr) : Expr :=
  mkApp4 (mkConst ``LE.le [Level.zero]) (mkConst ``Nat) (mkConst ``instLENat) (natLit a) k

def emit (tag : String) (n : Name) (e : Expr) : IO Unit := do
  IO.println s!"{tag} {n} {e.hash} {e}"

def run : MetaM Unit := do
  let emb := ``HadwigerNelson.PadicPlane.exists_levelEmbedding
  let lvl := ``HadwigerNelson.PadicPlane.charSum_levelOne_of_unitCircle
  let tEmb ← typeOf emb
  let tLvl ← typeOf lvl
  -- `hk : 1 ≤ k` after `p, inst, P, hpP, h2, hQ, k`
  emit "READD" emb (← insertAfter tEmb 7 fun xs => pure (natLe 1 xs[6]!))
  emit "CONTROL-TRUE" emb (← insertAfter tEmb 7 fun _ => pure (mkConst ``True))
  emit "CONTROL-NEAR" emb (← insertAfter tEmb 7 fun xs => pure (natLe 2 xs[6]!))
  -- `hpP` after `p, inst, P`, its domain read from `exists_levelEmbedding`'s fourth binder
  let hpPDom (xs : Array Expr) : MetaM Expr := do
    let rest ← instantiateForall tEmb xs
    match rest with
    | .forallE _ d _ _ => pure d
    | _ => throwError "exists_levelEmbedding has no fourth binder"
  emit "READD" lvl (← insertAfter tLvl 3 hpPDom)
  emit "CONTROL-TRUE" lvl (← insertAfter tLvl 3 fun _ => pure (mkConst ``True))
  emit "CONTROL-NEAR" lvl (← insertAfter tLvl 3 fun xs => do
    -- `hpP`'s domain read at `p.succ` in place of `p`: a near miss
    let d ← hpPDom xs
    pure (d.replace fun e => if e == xs[0]! then some (mkApp (mkConst ``Nat.succ) xs[0]!) else none))

#eval run

end FS131IQP3ReAdd
