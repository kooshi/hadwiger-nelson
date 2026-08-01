import Proofs.HadwigerNelson.Instances.Heule553.Diffs

/-!
# `heule553` — the geometry, verified

`heule553_valid` is the whole geometric claim in one line: all 2722 listed pairs are
exactly one unit apart. Its statement is the one the per-edge route produced, so nothing
downstream changed shape when the route underneath it did.

## If this fails

The build error says so in one line and tells you what to run. It cannot say more: at this
size the proposition `decide` refuses cannot be printed at all, which is why the check is a
named `Bool` and the failure carries a directive rather than a term.

```lean
import Proofs.HadwigerNelson.PackedDiagnose      -- deliberately not imported here: this
namespace HadwigerNelson                          -- module is upstream of certificates
#eval heule553Diffs.faultReport heule553Table heule553   -- one line, naming the culprit
```
-/

namespace HadwigerNelson

/-- The witness is checked against the certificate's **own** vertices. -/
theorem heule553_verts : heule553.verts = heule553Table.toVerts := rfl

/-- The four checks: 553 vertex packings, 82 difference packings,
82 squared lengths, and 2722 edges.

Named rather than written inline, because when it comes back `false` the tactic reports the
proposition it decided — and a proposition mentioning the witness cannot be printed at this
size. A reader of a failing build should meet a name and a pointer, not a page. -/
def heule553Certified : Bool := heule553Diffs.Certifies heule553Table heule553

-- The `fail` branch is unreachable *when the geometry checks*, which is exactly when the
-- linter runs. It is reachable on the day it matters, and that is the day this file exists
-- for, so the linter is silenced here rather than the directive deleted.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
theorem heule553_certifies : heule553Certified = true := by
  -- `decide` can only say no, and at this size it cannot even *print* the proposition it
  -- decided — the pretty-printer runs out of recursion depth on the witness. So the
  -- failure carries a directive instead of a wall of term.
  first
  | decide +kernel
  | fail "the geometry does not check. For the culprit, in a file with \
           `import Proofs.HadwigerNelson.PackedDiagnose` and inside `namespace \
           HadwigerNelson`:  #eval heule553Diffs.faultReport heule553Table heule553"

/-- Every listed edge is a real unit distance. -/
theorem heule553_valid : heule553.Valid = true :=
  heule553.valid_of_diffWitness heule553Table heule553Diffs heule553_verts heule553_certifies

end HadwigerNelson
