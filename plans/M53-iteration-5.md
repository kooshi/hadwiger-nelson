# M53 — iteration 5 from the culled plain object (pre-subplan stub; the DEFAULT next milestone)

*Stub drafted 2026-09-02 during M52's implementation, to be finished at M52's close with the cull's
final numbers. Per the stub rule it carries everything the deciding session knew. Companion:
`plans/M52-copy-lock-objects.md` (§R0–R3, §13′: the findings that shaped this), `plans/M51-descent-
engine.md` (DEFERRED at its iteration-4 commit — this milestone is its continuation), the engine's
`plans/WO-14-culler-subplan.md` (the culler that replaces the floor census and the cull).*

## Why this is the default

M52 asked which of the copy-lock objects is the strongest base for the next iteration, and the
answer was the plain one: a ρ₁₅ copy of the unit part is 4-colourable material attached through a
few dozen chords, and at five colours the fifth colour colours around it — zero of 15,218 classes
killed, exactly, on the ranking batch (M52 §R3). So the copies are 5-chromatic unit-distance
witnesses (a certificate target, `plans/STUB-certify-core883.md`) and not descent material, and the
loop resumes from the plain iteration-4 object AFTER M52's exact cull has removed every cheat that
was redundant given the halos already committed — the dial reading the loop never had, because no
cull had ever finished.

## The object (filled at the close)

| | |
|---|---|
| base | the plain iteration-4 object `…-vdel28-it2v2-depth1` (1,981 points, 13,796 unit edges; every point in ℚ(√3, √11), T14) with M52's culled standing set |
| standing cheats | 273 before the cull → **N after** (27 floor + the batch-kept, every kept cheat witnessed; the final one-hot + 3-bit certify on the culled set) |
| the dial | 446 → 273 (halos, M49–M51) → **N (the cull, M52)** |
| χ(unit part) | 4 (the copy makes it 5, but the copy is not committed material) |

## What changes in the loop, and why

1. **The floor census and the cull are `descent cull --census` / `descent cull --groups cheats`**
   (WO-14, the hard-clause encoding: 121 s where the guarded selectors sat at 1,302 s). The
   iteration's phase 0 drops from 2,657 s at twelve workers to minutes, and the cull becomes a
   per-iteration column: after every halo commit, cull again (the committed material makes more
   cheats jointly redundant — M52's loop found 32 of the first 32 candidates droppable).
2. **The batch is chosen from the CULLED standing set.** With the redundant cheats gone, every
   standing cheat is individually necessary (witnessed), so the sub-batch curve (`tools/subbatch.py`)
   starts from a floor that IS the standing set — the enumeration's class count per absent cheat is
   the same law, over fewer cheats.
3. **Everything else is iteration 4's pipeline unchanged**: enumerate (Rust), profile on the depth-1
   pool (Rust replay; the pool of the plain object is the cached `m51-pool-c446…` at 1.47 M points
   — no rebuild), hitting set, design (Rust), certify (Python, two encodings), commit, columns.
   D38 (the provenance dialect for rotated copies) is NOT needed for a plain base.

## Registered questions carried from M52 (not run there, priced for here)

* **The composed object's partner lattice.** The copies kill nothing themselves, but their glue
  points with the original are new points in ℚ(√3, √5, √11) — a lattice the plain object does not
  have. Whether THOSE kill classes is a pool question: build the depth-1 pool of `it4+206p`
  (~3,900 points → ~5.8 M pool points, ~6 h at the vectorized rate) and replay one batch's classes
  against it beside the plain pool. Registered prediction: the copy-side glue points kill a
  non-zero fraction that the plain pool does not (they are 5-field material — G19's "5-tight" is
  the question), confidence low. Run only if the plain iteration stalls.
* **The culled object's own floor after the next halo.** G33's compounding predicts the floor
  keeps falling; the cull column measures it exactly now.

* **The out-of-field kill census (RISKS R1's test, first).** Before iteration 5's design: export
  the depth-1 pool restricted to out-of-field points (the pool builder's provenance pairs → the
  radicand's square class, `tools/pool_field_census.py`) and replay one batch's classes against it;
  then the full-pool profile with per-point field tags on every kill. If out-of-field points kill
  classes the in-field pool cannot, iteration 5's design offers them explicitly (a field-aware tier).

* **The in-field pool (Kooshi, 2026-09-03), conditional on the census above reading ZERO.** *"For
  all iterations until we hit a wall — keep only the √3 and √11 points. That's a tradeoff between the
  field-wall monitor and the compute exponent, but it may be worth it to quickly eliminate all the
  cheats that we can within this field."* The in-field slice is 15 % of the depth-1 pool (280,390 of
  ~1.9 M points on the iteration-4 object), so the pool build (in-field pairs only: 140,195 of
  950,371), the profile's per-worker memory (~8 GB → ~1.3 GB, hence more workers), and the design's
  candidate set all shrink by ~6×. It is SOUND by the rule the loop already uses for restricted
  pools (T11, K3): a class killed on the in-field pool is killed; a class that survives it is
  adopted as unknown against the full pool, never folded. Iteration 4's `pdeg12` restricted pool
  (points with ≥ 12 object neighbours, 42/42 hard classes killed at 3.13× the speed) is very
  likely this slice by another name — the census can say exactly. **The condition:** the
  out-of-field kill census reads zero (no class killed by an out-of-field point that the in-field
  pool does not kill). **The monitor kept:** once per iteration, one batch's survivors on the
  in-field pool are re-asked against the full pool; the first out-of-field-only kill is the wall
  arriving, and the restriction is lifted. R1's "does a design ever keep an out-of-field point"
  then reads on the full-pool re-ask rather than on the design.

* **The copy kill census after the crossing (Kooshi's intuition, timed).** Once χ(unit part) reads 5
  (the halt-and-certify event), before the next design: the two-enumeration copy census on one
  batch. Prediction: the ρ₁₅ copy that killed 0 of 15,218 classes at χ(unit) = 4 kills a positive
  fraction once the unit part's 5-colourings are rigid — the copy trick becoming the endgame's
  tool exactly when the spare colour is gone.

## Carried unknowns (Kooshi, 2026-09-04: "unknowns just get carried")

* **The 52 undecided cheats** of M52's cull (6 of them decided NECESSARY by the 300M-rung re-ask before it was stopped; 46 remain) stay in the standing set as kept-undecided; their re-ask
  at the 300M rung is deferred until after iteration 5's commit, when the more rigid object makes
  the asks easier (the same rule the loop has used for every unknown: carried, never folded). The
  culler's journal `build/m52-rustcull-it4/cull.jsonl` resumes by the same command.
* **The whole-object point shrink under the culled set** (the cull for points: which committed halo
  points are still necessary now that 124 cheats are gone) — zero geometry, value = object size,
  priced at ~1.1 CPU-h per probe; a server job, or after iteration 5.
* **Seed-vertex deletion after the it-4 commit** was not re-run; after the cull it frees no cheat
  (every kept cheat is necessary), so its only value is size; folded into the point shrink above.

## Halt clauses, verbatim

μ ≤ 1 at five colours ⟹ HALT AND VERIFY. χ(unit part) 4 → 5 ⟹ HALT and certify the new witness. A
REFUSED certificate ⟹ INVESTIGATE, never retry. Any hardware event ⟹ HALT. An unknown is never
folded. Every headline carries its population and its conditioning.
