import Proofs.HadwigerNelson.Instances.DeGrey.Diffs

/-!
# `deGrey` — the geometry, verified

`deGrey_valid` is the whole geometric claim in one line: all 7877 listed pairs are
exactly one unit apart. Its statement is the one the per-edge route produced, so nothing
downstream changed shape when the route underneath it did.

## If this fails

The build error says so in one line and tells you what to run. It cannot say more: at this
size the proposition `decide` refuses cannot be printed at all, which is why the check is a
named `Bool` and the failure carries a directive rather than a term.

```lean
import Proofs.HadwigerNelson.PackedDiagnose      -- deliberately not imported here: this
namespace HadwigerNelson                          -- module is upstream of certificates
#eval deGreyDiffs.faultReport deGreyTable deGrey   -- one line, naming the culprit
```
-/

namespace HadwigerNelson

/-- The witness is checked against the certificate's **own** vertices. -/
theorem deGrey_verts : deGrey.verts = deGreyTable.toVerts := rfl

/-- The four checks: 1581 vertex packings, 133 difference packings,
133 squared lengths, and 7877 edges.

Named rather than written inline, because when it comes back `false` the tactic reports the
proposition it decided — and a proposition mentioning the witness cannot be printed at this
size. A reader of a failing build should meet a name and a pointer, not a page. -/
def deGreyCertified : Bool := deGreyDiffs.Certifies deGreyTable deGrey

-- The `fail` branch is unreachable *when the geometry checks*, which is exactly when the
-- linter runs. It is reachable on the day it matters, and that is the day this file exists
-- for, so the linter is silenced here rather than the directive deleted.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
theorem deGrey_certifies : deGreyCertified = true := by
  -- `decide` can only say no, and at this size it cannot even *print* the proposition it
  -- decided — the pretty-printer runs out of recursion depth on the witness. So the
  -- failure carries a directive instead of a wall of term.
  first
  | decide +kernel
  | fail "the geometry does not check. For the culprit, in a file with \
           `import Proofs.HadwigerNelson.PackedDiagnose` and inside `namespace \
           HadwigerNelson`:  #eval deGreyDiffs.faultReport deGreyTable deGrey"

/-- Every listed edge is a real unit distance. -/
theorem deGrey_valid : deGrey.Valid = true :=
  deGrey.valid_of_diffWitness deGreyTable deGreyDiffs deGrey_verts deGrey_certifies

end HadwigerNelson
