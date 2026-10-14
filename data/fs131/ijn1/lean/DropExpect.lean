import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
/-!
FS131-IJN1 — the stored statements the ruled binder drops must produce, computed from the kernel's own terms **before** the
drop: run on the merges' build (before any edit is compiled). For each ruled constant and each ruled binder (by its stored
binder name), the stored type with that `∀`-binder removed — refused if the body depends on it — printed in the dump's
format (`Expr.dbgToString`). The reader (`tools/fs131_ijn1_statements.py`) requires the after-dump's stored type to equal
it, hygienic names aside.

  lake env lean data/fs131/ijn1/lean/DropExpect.lean > data/fs131/ijn1/drop-expect.txt

The rulings: item 770 ruling 2 (lane N's five unread hypotheses) and items 761 ruling 5 / 811 ruling 1 (the scope binder of
`zeroEntropyCarried`, and of its reader `mrPlus`, dropped where unread on the move to `Rigidity/ZeroEntropyClosed`).
-/
open Lean Elab Command Meta

namespace FS131IJN1Drop

/-- Remove the first `∀`-binder named `target` (outermost first), if its body does not depend on it. -/
partial def dropBinder (target : Name) : Expr → Option Expr
  | .forallE n t b bi =>
    if n == target then
      if b.hasLooseBVar 0 then none else some (b.lowerLooseBVars 1 1)
    else (dropBinder target b).map fun b' => .forallE n t b' bi
  | _ => none

/-- The ruled drops: constant, binders in order. -/
def ruled : List (Name × List Name) :=
  [(`HadwigerNelson.Rigidity.mul_card_heavyNames_le, [`hc]),
   (`HadwigerNelson.Rigidity.mul_measureReal_light_le_blockEntropy, [`hγ]),
   (`HadwigerNelson.Rigidity.rpow_mul_exp_le_exp, [`hθ]),
   (`HadwigerNelson.Rigidity.card_words_badStarts_le, [`hθ, `hn]),
   (`HadwigerNelson.Rigidity.zeroEntropyCarried, [`h]),
   (`HadwigerNelson.Rigidity.mrPlus, [`h])]

def run : CommandElabM Unit := do
  let env ← getEnv
  for (c, bs) in ruled do
    let some ci := env.find? c | throwError "{c}: not in the environment"
    let mut t := ci.type
    for b in bs do
      match dropBinder b t with
      | some t' => t := t'
      | none => throwError "{c}: no independent binder named {b}"
    IO.println s!"@@ {c} DROP {bs}"
    IO.println s!"BEFORE {ci.type.hash} {ci.type}"
    IO.println s!"EXPECT {t.hash} {t}"

#eval run

end FS131IJN1Drop
