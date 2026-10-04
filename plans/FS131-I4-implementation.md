# FS131-I4 — wave 4's implementation record (branch `fs131-w4`)

Implementer: de Bruijn on Sonnet 5.5. Brief `data/fs131/briefs/FS131-I4-wave4.md`; plan `plans/FS131-w4-kernel-plan.md` (§ 13 the plan per leaf,
§ 14 the handoff). Iteration tools: `data/fs131/i4/iter.sh <module…>` (compile oleans into a scratch mirror, never evidence) and
`data/fs131/i4/chk.sh <module or abs path>`.

## Theorems this phase proved

(Axioms from `#print axioms` prints only until the gate runs; the gate's saved log supersedes.)

- see the stages below, one line per row theorem.

## Stage 1 — SAVED: the readback

**Quotations checked against `plans/FS131-w4-kernel-plan.md` § 14.2 and `plans/FS131-close-inventory.md` line 650**: all three match their sources
verbatim (the "It may" and "It may not" sentences, the "Wave 4 note" on `noBoth`'s cusp case).

**What I may change**: add children anywhere in the wave's modules (the seven engines and every child § 13 names; engines in the foundation
`Plane/ValidMap/Basic`, sorry-free, each with a spec example); add supporting lemmas to the foundation modules (wave 4's `Basic`, wave 3's
`Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's `Plane/Chord`, `Diameter`, `Basic`), statements unchanged; change imports (updating
`ARCHITECTURE.md`'s Imports cell, adding each new record to `scripts/Axioms.lean`, then `tools/fs131_k4_decls.py --check`).
**What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2; any definition of `Plane/ValidMap/Basic`; the fragments' definitions
(`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) except a coordinate slip found against the source tool (a finding, with the tool's output);
the read-backs' conventions; no new `axiom`, no `native_decide`. A statement that cannot be proved as written goes to Keryx with the stuck goal.
`lebesgue_covering_square` is FS131-LEB's. `noBoth`: if its proof reaches the cusp case (item 112), stop that leaf and message Keryx.

**The worktree build as given** (`f620977c`): started under the slot (log `data/fs131/i4/build-stage1.log`); edits to `Basic`, `StuckChain`,
`Contact` were made while it ran, so it is not a clean "as given" build. Wave 3's modules are still `sorry`-bearing here (`LocalStructure` 12,
`Tiles` 20, `RingGerm` 36, `RingBand` 15, `Lens` 2, `SixFragment` 12), so wave 4's leaves that read them are proved over their statements.

## Stage 2 — SAVED: engine 4 (frame algebra), engine 1, and `StuckChain` (5/5)

First two hard-ish leaves re-price: `n4_fin` (graded M) took one pass (two inductions via `inv_curvUp`, `inv_curvDown`); `rayLower_pencil`
(M) one pass over engine 4. These E/M leaves cost minutes, not the planner's table.

Added to `Basic` (sorry-free): `e_add_pi_div_two`, `frame_normSq`, `sq_dist_normalPt`, `sq_dist_N`, `sq_dist_S`, `tanAbove_one_iff`,
`tanBelow_one_iff`, `tanAbove_neg_one_iff`, `tanBelow_neg_one_iff`, `tanHeight_eq_of_ne_zero`, `tanAbove_iff_of_pos`, `tanBelow_iff_of_pos`,
`sq_dist_frame` (the frame is an isometry), `frameX/Y_add_normal`, `frameX/Y_{self,N,S}`; engine 1 `ArcMap.Valid.of_agreesOff`.
`StuckChain`: `curvUp_curvDown`, `n4_fin` (children `inv_curvUp`, `inv_curvDown`, `n4_fin_u_nonpos`), `ray_chain`, `exists_oneSided_chain`,
`rayLower_pencil` (children `rayLower_neg`, `rayLower_eq_curvDown`). `Contact`: `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`.
