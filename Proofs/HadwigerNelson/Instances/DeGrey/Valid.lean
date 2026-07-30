import Proofs.HadwigerNelson.Instances.DeGrey.Geom00
import Proofs.HadwigerNelson.Instances.DeGrey.Geom01
import Proofs.HadwigerNelson.Instances.DeGrey.Geom02
import Proofs.HadwigerNelson.Instances.DeGrey.Geom03
import Proofs.HadwigerNelson.Instances.DeGrey.Geom04
import Proofs.HadwigerNelson.Instances.DeGrey.Geom05
import Proofs.HadwigerNelson.Instances.DeGrey.Geom06
import Proofs.HadwigerNelson.Instances.DeGrey.Geom07
import Proofs.HadwigerNelson.Instances.DeGrey.Geom08

/-!
# `deGrey` — the geometry, glued

`deGrey_valid` below is the whole geometric claim in one line: all 7877 listed
pairs are exactly one unit apart. It is assembled from the 45 per-chunk
theorems, which are *cited* — deciding again here would repeat every edge.

The argument is `∀ chunk, the chunk checks`, supplied as one tuple; `List.Forall` over a
literal list is a nested conjunction, and `List.forall_iff_forall_mem` is the standard
bridge from that to the membership form the lemma takes.

**This file is generated bookkeeping.** For what `deGrey` does and does not certify,
read `Instances/DeGrey.lean`.
-/

-- `hjoin` below is `rfl` over the whole edge list. The certificate's `edges` field is the
-- parts appended while `Chunks` is a list of chunks, so reconciling them walks every
-- edge: deep, but linear and paid once.
set_option maxRecDepth 400000

namespace HadwigerNelson

/-- **Every one of the 7877 listed edges has exact squared distance
`768²`** — so every one of them is a real unit distance in the plane.
Kernel-checked, chunk by chunk. -/
theorem deGrey_valid : deGrey.Valid = true :=
  deGrey.valid_of_chunks deGreyChunks rfl
    (List.forall_iff_forall_mem.mp
      ⟨deGreyChunk000_valid,
       deGreyChunk001_valid,
       deGreyChunk002_valid,
       deGreyChunk003_valid,
       deGreyChunk004_valid,
       deGreyChunk005_valid,
       deGreyChunk006_valid,
       deGreyChunk007_valid,
       deGreyChunk008_valid,
       deGreyChunk009_valid,
       deGreyChunk010_valid,
       deGreyChunk011_valid,
       deGreyChunk012_valid,
       deGreyChunk013_valid,
       deGreyChunk014_valid,
       deGreyChunk015_valid,
       deGreyChunk016_valid,
       deGreyChunk017_valid,
       deGreyChunk018_valid,
       deGreyChunk019_valid,
       deGreyChunk020_valid,
       deGreyChunk021_valid,
       deGreyChunk022_valid,
       deGreyChunk023_valid,
       deGreyChunk024_valid,
       deGreyChunk025_valid,
       deGreyChunk026_valid,
       deGreyChunk027_valid,
       deGreyChunk028_valid,
       deGreyChunk029_valid,
       deGreyChunk030_valid,
       deGreyChunk031_valid,
       deGreyChunk032_valid,
       deGreyChunk033_valid,
       deGreyChunk034_valid,
       deGreyChunk035_valid,
       deGreyChunk036_valid,
       deGreyChunk037_valid,
       deGreyChunk038_valid,
       deGreyChunk039_valid,
       deGreyChunk040_valid,
       deGreyChunk041_valid,
       deGreyChunk042_valid,
       deGreyChunk043_valid,
       deGreyChunk044_valid⟩)

end HadwigerNelson
