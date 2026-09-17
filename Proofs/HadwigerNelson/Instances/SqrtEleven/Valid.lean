import Proofs.HadwigerNelson.Instances.SqrtEleven.Geom00

/-!
# `eleven204` — the geometry, glued

`eleven204_valid` below is the whole geometric claim in one line: all 455 listed
pairs are exactly one unit apart. It is assembled from the 3 per-chunk
theorems, which are *cited* — deciding again here would repeat every edge.

The argument is `∀ chunk, the chunk checks`, supplied as one tuple; `List.Forall` over a
literal list is a nested conjunction, and `List.forall_iff_forall_mem` is the standard
bridge from that to the membership form the lemma takes.

**This file is generated bookkeeping.** For what `eleven204` does and does not certify,
read `Instances/DeGrey.lean`.
-/

-- `hjoin` below is `rfl` over the whole edge list. The certificate's `edges` field is the
-- parts appended while `Chunks` is a list of chunks, so reconciling them walks every
-- edge: deep, but linear and paid once.
set_option maxRecDepth 400000

namespace HadwigerNelson

/-- **Every one of the 455 listed edges has exact squared distance
`150²`** — so every one of them is a real unit distance in the plane.
Kernel-checked, chunk by chunk. -/
theorem eleven204_valid : eleven204.Valid = true :=
  eleven204.valid_of_chunks eleven204Chunks rfl
    (List.forall_iff_forall_mem.mp
      ⟨eleven204Chunk000_valid,
       eleven204Chunk001_valid,
       eleven204Chunk002_valid⟩)

end HadwigerNelson
