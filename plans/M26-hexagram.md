# M26 — The hexagram: 6 pivots + metapivot, unconditionally (PRE-SUBPLAN STUB)

*Recorded 2026-08-08 (Kooshi's construction, corrected geometry). Numbers
tentative; order shiftable.*

## Scope

The **6+1 system**: pivot hexagon of circumradius 1/√3 about the metapivot m —
equivalently the M23 triangle T₁ = {0, 1, ζ₆} PLUS its point-reflection
through m, T₂ = the three MIRROR CENTROIDS promoted to pivots (they are
already certified as the inner∩inner(m) glue points —
`Triangle.inner_inter_metaInner`). Seven ladders; all cross-webs; complete
chord lists; the colouring theorem.

The distance census (verified in discussion, 2026-08-08):

| Pair type | Count | Distance | Coupling |
|---|---|---|---|
| Same-triangle | 6 | 1 | full unit-axis apparatus (M24 theorems) |
| Hexagon neighbours (T₁–T₂) | 6 | 1/√3 | mutual inner-circle membership; four two-point gluings (axis-1/√3 apparatus, M24/M25) |
| Pivot–metapivot | 6 | 1/√3 | same |
| Opposite (v, 2m−v) | 3 | 2/√3 | oo and oi two-point; **ii TANGENT at m** — all three opposite pairs' inner circles meet at the metapivot: a triple tangency |

## Ask

* The axis-2/√3 chord derivations (including the tangent ii case — the first
  consumer of `sphere_inter_sphere`'s tangency degeneracy) if M24 did not
  already bank them.
* Loop census re-run with 7 centres: PREDICTION to register — pure-seam
  relations of length 4 exist (pivot parallelograms: ζ₆⁰−ζ₆¹ = −(ζ₆³−ζ₆⁴)),
  impossible at the triangle where 6 was minimal.
* The colouring; same χ = 4/5 fork logic as M25.

## Evidence in hand

T₂ = the mirror centroids (kernel-certified as glue points — the construction
is SELF-SEEDING: promoting distinguished points of the M23 object, no new
geometry); the six triangle-centroids of the hexagram lie on inner(m) and form
a 1/√3-scaled 30°-rotated copy of the pivot hexagon (the recursion's
self-similarity, visible in one object); D₆ × point-reflection symmetry; all
coordinates remain in the seam field (centroids are rational combinations).


## M25 carry-forward (recorded at the M25 close, 2026-08-09)

What the M26 subplan can take as settled, and where the tooling lives:

* **The engine transfers whole.** `√3·ζ₁₂ = 1 + ζ₆` (`MetaLadder.sqrt3_mul_zeta12`)
  eliminated the twelfth root from every 1/√3-axis equation; the mirror-centroid
  axes are again ζ₁₂-coset directions at 1/√3 (and 2/√3 = 2·(1/√3) for the
  opposite pairs), so the same clearing applies. The expected master shape stays
  `κ − Tr(g·w₁) − μ·Tr(g·W) + λ·Tr(V) = 0` with new (κ, μ, λ) per radius pair —
  re-derive by the `build/m25-design2.py` pattern (exact tree vs exact ground
  truth over a window) BEFORE writing Lean; every M25 decide passed first try
  because of that discipline, and the one decide that was false as first stated
  (a boundary quantified over unrealizable addresses) was caught by it… by the
  kernel; the script check is what would have caught it earlier. Constrain
  boundary decides to REALIZABLE addresses (x₃ and y are functions of A, c and
  the seam signs — quantifying them freely can make a true kill undecidable).
* **The fusion-κ trick is anchor-generic**: a coincidence classification is the
  chord classification at normSq = 0, i.e. the same κ-parameterized spine at a
  shifted constant (M25: oo 4→7, oi/io 2→5, ii 0→3√3). Plan M26's decode
  well-definedness as κ-instances from the start, not as a separate enumeration.
* **`adjacent_kill` / `adjacent_mod9`** (two g-traces at heights h, h+1 never
  sum to 9·anything; residues pinned to {1,4,7} mod 9) closes height-unbounded
  endgame branches; it is address-table-generic over the gE/gF tables and
  should port to whatever coefficient tables the mirror-centroid webs produce
  (re-verify the 36-pair scan for the NEW tables first).
* **Public vs private in `MetaLadder.lean`**: public — `hexTrace`,
  `hexTrace_coords`, `inRing_hexTrace`, `gTr`/`uTr`, `gTrace_clear`/`uTrace_clear`,
  `gAddr`/`uAddr`, `hexTrace_rows`, `hexTrace_add`, `hexTrace_zero_height`,
  `hexTrace_eq_zero`, `hexTrace_pin`, `not_three_dvd_pin`, `alone_dvd`, `phi_dvd`,
  `phi_g_dvd`, `gE`/`gF` + their table facts, the bridges and fusion bridges, the
  four completeness and four fusion theorems, the transports. Private (re-derive
  locally per the house §0 pattern, or promote at the M26 experience pass) —
  `hexTrace_rows_const` (the κ-row extractor), `adjacent_kill`/`adjacent_mod9`,
  `web_master`/`web_master_eq`/`web_master_rev`, the per-family masters and
  cleared lemmas, the pin-kill wrappers (`g_pin_kill`, `u_pin_kill_dvd`,
  `u_pin_one`, `g_zero_ne_kappa`), `metaRot_inj`, the re-addressing lemmas
  (`outer0_to02` etc). Promoting `hexTrace_rows_const`, `adjacent_kill` and the
  pin-kill trio to public is probably the right M26 experience-pass call.
* **Lean idioms that cost time in M25** (all recorded in the session memory too):
  `Eq.trans` chains instead of `rw … at hspec` when the hypothesis mentions an
  `Exists.choose` whose ∃-type contains the rewritten term;
  `linear_combination (norm := (push_cast; ring)) h` whenever `h` carries
  compound casts; keep pow-atoms syntactically identical for `omega` (no
  `norm_num at` on them); multiline `.trans` continuations must indent past the
  `have` column.
* **The M26-specific new work** (unchanged from the stub above): the 2/√3-axis
  derivations including the tangent ii case at m (the first
  `sphere_inter_sphere` tangency consumer), the 7-centre loop census with the
  registered length-4 parallelogram prediction, and the D₆ symmetry decision —
  whether to prove one web per orbit and transport by the point-reflection
  (M25's 120°-transport pattern doubled), which is where the biggest line-count
  saving lives.
