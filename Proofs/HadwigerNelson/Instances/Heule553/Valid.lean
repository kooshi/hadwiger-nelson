import Proofs.HadwigerNelson.Instances.Heule553.Geom00
import Proofs.HadwigerNelson.Instances.Heule553.Geom01
import Proofs.HadwigerNelson.Instances.Heule553.Geom02
import Proofs.HadwigerNelson.Instances.Heule553.Geom03
import Proofs.HadwigerNelson.Instances.Heule553.Geom04
import Proofs.HadwigerNelson.Instances.Heule553.Geom05
import Proofs.HadwigerNelson.Instances.Heule553.Geom06
import Proofs.HadwigerNelson.Instances.Heule553.Geom07

/-!
# `heule553` — the geometry, glued

`heule553_valid` below is the whole geometric claim in one line: all 2722 listed
pairs are exactly one unit apart. It is assembled from the 16 per-chunk
theorems, which are *cited* — deciding again here would repeat every edge.

The argument is `∀ chunk, the chunk checks`, supplied as one tuple; `List.Forall` over a
literal list is a nested conjunction, and `List.forall_iff_forall_mem` is the standard
bridge from that to the membership form the lemma takes.

**This file is generated bookkeeping.** For what `heule553` does and does not certify,
read `Instances/DeGrey.lean`.
-/

-- `hjoin` below is `rfl` over the whole edge list. The certificate's `edges` field is the
-- parts appended while `Chunks` is a list of chunks, so reconciling them walks every
-- edge: deep, but linear and paid once.
set_option maxRecDepth 400000

namespace HadwigerNelson

/-- **Every one of the 2722 listed edges has exact squared distance
`288²`** — so every one of them is a real unit distance in the plane.
Kernel-checked, chunk by chunk. -/
theorem heule553_valid : heule553.Valid = true :=
  heule553.valid_of_chunks heule553Chunks rfl
    (List.forall_iff_forall_mem.mp
      ⟨heule553Chunk000_valid,
       heule553Chunk001_valid,
       heule553Chunk002_valid,
       heule553Chunk003_valid,
       heule553Chunk004_valid,
       heule553Chunk005_valid,
       heule553Chunk006_valid,
       heule553Chunk007_valid,
       heule553Chunk008_valid,
       heule553Chunk009_valid,
       heule553Chunk010_valid,
       heule553Chunk011_valid,
       heule553Chunk012_valid,
       heule553Chunk013_valid,
       heule553Chunk014_valid,
       heule553Chunk015_valid⟩)

end HadwigerNelson
