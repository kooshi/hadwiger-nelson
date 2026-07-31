import Proofs.HadwigerNelson.Instances.Heule510.Geom00
import Proofs.HadwigerNelson.Instances.Heule510.Geom01
import Proofs.HadwigerNelson.Instances.Heule510.Geom02
import Proofs.HadwigerNelson.Instances.Heule510.Geom03
import Proofs.HadwigerNelson.Instances.Heule510.Geom04
import Proofs.HadwigerNelson.Instances.Heule510.Geom05
import Proofs.HadwigerNelson.Instances.Heule510.Geom06

/-!
# `heule510` — the geometry, glued

`heule510_valid` below is the whole geometric claim in one line: all 2504 listed
pairs are exactly one unit apart. It is assembled from the 14 per-chunk
theorems, which are *cited* — deciding again here would repeat every edge.

The argument is `∀ chunk, the chunk checks`, supplied as one tuple; `List.Forall` over a
literal list is a nested conjunction, and `List.forall_iff_forall_mem` is the standard
bridge from that to the membership form the lemma takes.

**This file is generated bookkeeping.** For what `heule510` does and does not certify,
read `Instances/DeGrey.lean`.
-/

-- `hjoin` below is `rfl` over the whole edge list. The certificate's `edges` field is the
-- parts appended while `Chunks` is a list of chunks, so reconciling them walks every
-- edge: deep, but linear and paid once.
set_option maxRecDepth 400000

namespace HadwigerNelson

/-- **Every one of the 2504 listed edges has exact squared distance
`96²`** — so every one of them is a real unit distance in the plane.
Kernel-checked, chunk by chunk. -/
theorem heule510_valid : heule510.Valid = true :=
  heule510.valid_of_chunks heule510Chunks rfl
    (List.forall_iff_forall_mem.mp
      ⟨heule510Chunk000_valid,
       heule510Chunk001_valid,
       heule510Chunk002_valid,
       heule510Chunk003_valid,
       heule510Chunk004_valid,
       heule510Chunk005_valid,
       heule510Chunk006_valid,
       heule510Chunk007_valid,
       heule510Chunk008_valid,
       heule510Chunk009_valid,
       heule510Chunk010_valid,
       heule510Chunk011_valid,
       heule510Chunk012_valid,
       heule510Chunk013_valid⟩)

end HadwigerNelson
