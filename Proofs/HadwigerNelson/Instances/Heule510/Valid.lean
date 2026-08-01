import Proofs.HadwigerNelson.Instances.Heule510.Diffs

/-!
# `heule510` — the geometry, verified

`heule510_valid` is the whole geometric claim in one line: all 2504 listed pairs are
exactly one unit apart. Its statement is the one the per-edge route produced, so nothing
downstream changed shape when the route underneath it did.

## If this fails

The build error says so in one line and tells you what to run. It cannot say more: at this
size the proposition `decide` refuses cannot be printed at all, which is why the check is a
named `Bool` and the failure carries a directive rather than a term.

```lean
import Proofs.HadwigerNelson.PackedDiagnose      -- deliberately not imported here: this
namespace HadwigerNelson                          -- module is upstream of certificates
#eval heule510Diffs.faultReport heule510Table heule510   -- one line, naming the culprit
```
-/

namespace HadwigerNelson

/-- The witness is checked against the certificate's **own** vertices. -/
theorem heule510_verts : heule510.verts = heule510Table.toVerts := rfl

/-- The four checks: 510 vertex packings, 66 difference packings,
66 squared lengths, and 2504 edges.

Named rather than written inline, because when it comes back `false` the tactic reports the
proposition it decided — and a proposition mentioning the witness cannot be printed at this
size. A reader of a failing build should meet a name and a pointer, not a page. -/
def heule510Certified : Bool := heule510Diffs.Certifies heule510Table heule510

-- The `fail` branch is unreachable *when the geometry checks*, which is exactly when the
-- linter runs. It is reachable on the day it matters, and that is the day this file exists
-- for, so the linter is silenced here rather than the directive deleted.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
theorem heule510_certifies : heule510Certified = true := by
  -- `decide` can only say no, and at this size it cannot even *print* the proposition it
  -- decided — the pretty-printer runs out of recursion depth on the witness. So the
  -- failure carries a directive instead of a wall of term.
  first
  | decide +kernel
  | fail "the geometry does not check. For the culprit, in a file with \
           `import Proofs.HadwigerNelson.PackedDiagnose` and inside `namespace \
           HadwigerNelson`:  #eval heule510Diffs.faultReport heule510Table heule510"

/-- Every listed edge is a real unit distance. -/
theorem heule510_valid : heule510.Valid = true :=
  heule510.valid_of_diffWitness heule510Table heule510Diffs heule510_verts heule510_certifies

end HadwigerNelson
