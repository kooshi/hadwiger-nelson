# M43 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer. Enumeration: `plans/M43-fine-tail.md` read in full (§0a D1–D7,
§0f A1–A6, §R including "P7: the literature check fired", "The core, the autopsy, and the kernel", "What was NOT
done"). Grades are `CLAUDE.md` § Notation's. G28 already carries this milestone's headline demotion (the "does not
factor" claim, withdrawn by M45) — not re-derived here, only pointed at.*

## The theorems

**M43-T1 — Closed-form threshold formulas for the constraint graph's bands. [hand; the M43 implementer, "each
hand-verified twice"]** For a lattice offset `d = (a,b)` with canonical representative `0 ≤ a ≤ b`, write
`Q = Q(a,b) = a² + ab + b²`. Then the constraint graph `G(p)`'s (M39) threshold interval for `d` has **`depart(a,b)
= Q + 2(a+b) + 4/3`** (the max, attained at an `H`-vertex, uniformly across every class including the axis), and
**`arrive(a,b)`** is `(b−1)²` on the axis class `(0,b)` (the perpendicular foot lands at an edge midpoint of the
difference body `H`, so **every integer `T` is a threshold scale**, `(0,n+1)` arriving exactly at `T² = n²`) or
`Q − 2(a+b) + 4/3` on an interior class `1 ≤ a ≤ b` with `a ≤ 2/3`'s in-segment condition failing (the foot leaves
the edge, so the minimum moves to the nearest `H`-vertex) — and **non-axis thresholds are always `≡ 1/3 (mod 1)`**.
*Proof:* `plans/M43-fine-tail.md` §0a D1, a polarization computation against `H`'s six vertices and six edge-midpoint
normals; checked for consistency against every threshold M40's table and M42's kernel windows (`3/13`, `3/28`)
already fixed, and against §0f A1's norm-49 double-check (`(7,0)` arrives at 36, `(3,5)` at `103/3`).
*Proof verdict:* closes (a direct computation from the convexity criterion `M39-T1` already establishes, made
fully explicit and cross-checked against every previously-computed threshold with no discrepancy). *Rests on it:*
M43's own flank-band table (D2, [tools]-grade instance, already captured by row 40); D5 (below) applies the
axis-vs-interior split directly. *Prior art:* not searched as a citable closed form; the underlying convexity fact
is
M39-T1's. zbMATH: `ab:"Voronoi cell" & ab:"polarization" & ab:"lattice"` (0 hits, 2026-09-22), `ti:"triangular
lattice" & ab:"threshold" & ab:"constraint graph"` (0 hits). Nearest held key: none on point. *Kernel:* declined —
M40-T1's general orbit-band fact already covers the qualitative claim; no module states the closed formula, and the
specific windows that reached the kernel (M42) were hand-computed per-instance rather than from this general form.

**M43-T2 — The scaled-shell 7-clique windows are exactly `M ∈ {1, 3, 4}`, and there are no others, ever. [hand; the
M43 implementer; corrects two earlier claims]** A scaled closed shell `z·\text{shell}` (the seven points `0, ±z,
±z(1+ζ₆), ±2z` in address form — difference classes of norm `M = Q(z)`, `3M`, `4M`) is a 7-clique on some band of
`G(p)` iff its three class windows overlap, which by M43-T1's formulas reduces to the binding inequality
`depart(z) > arrive(2z)` for non-axis `z`, i.e. **`Q(z) < 2·s(z)`** (`s = a+b` of the canonical representative) —
satisfied only by `z = (1,1)` (giving `M = 3`) — and to `3k² − 6k − 1/3 < 0` for the axis case `z = (0,k)`, satisfied
only by `k ≤ 2` (giving `M = 1` and `M = 4`). **So the complete list of scaled-shell 7-clique windows is
`z ∈ {1, 1+ζ₆, 2}`, i.e. `M ∈ {1, 3, 4}` — the classical window (M38), the `√3` window (M39), and the `M = 4` window
(M42) — and no others exist at any scale.** *Proof:* `plans/M43-fine-tail.md` §0a D5, a two-case exhaustion (axis and
non-axis) directly from M43-T1's closed formulas. *Proof verdict:* closes (a complete case analysis over the two
possible shapes of `z`, each reducing to a single-variable inequality solved exactly). *Rests on it:* **corrects two
earlier claims in the same corpus**: M39 §0e's original assertion ("the scaled-shell route is exhausted... at
`M ∈ {1,3}`"), already recorded as demoted in `plans/M39-derivation.md`'s "Conjectures surfaced" (found false by
M40's own correction banner, which located the `M = 4` band); and the stub `plans/M43-fine-tail.md` itself flags
its predecessor's registered-but-wrong prediction ("the M = k copy at `p ≈ 1/(2k)` predicts sevens recur") as WRONG
— D5 replaces both with the final, complete, correct classification, closing the question M39 opened and M40 only
partially corrected. *Prior art:* not searched as a citable classification; the mechanism (a one-parameter family of
candidate cliques, classified by an explicit inequality in the offset's norm and coordinate sum) is elementary once
M43-T1's closed forms exist. zbMATH: `ti:"triangular lattice" & ab:"clique" & ab:"scaled"` (0 hits, 2026-09-22),
`ab:"seven-clique" & ab:"hexagonal lattice"` (0 hits). Nearest held key: none on point. *Kernel:* declined — no
module states the general classification; the three individual windows it certifies (M38, M39/M42's `G*`,
M42's `M=4`) are each separately kernel-checked already.

## Readings and measurements that were called theorems

- The whole flank-band census (D2, D3, D4; the 1/7 flanks' exact edge classes, the ball/torus SAT results, the
  160-vertex core) is [tools]/[cert] measurement, already correctly captured by row 40's "nineteen further bands ≥ 7"
  and its own honesty ledger. **This includes the seed's G24 target "the Hoffman bracket at p = 1/7"**: §R states
  "the certified Hoffman bracket at the coarse flank is χ ≥ 3.56 (degree 114, `λ_min ∈ [−44.4937, −44.4737]`,
  converged 246,635 boxes)" — a [tools]-grade *instance* of M40-T3's torus-wrap Hoffman bound (already filed, this
  milestone's `tools/celllat.py` inherited from M40), computed at the flank adjacent to `p = 1/7`, not a separate
  theorem; nothing new to file.
- **D6, "coset sixes are already dead at every scale."** A one-line corollary of M37's kernel theorem
  (`Coset.seven_le_card`, already established); not independent content.
- **D7's soundness argument for the pinning ladder** (items 1–5, the SAT-encoding design) is method, not mathematics
  about the object; item 3's observation that "the literal fan pin is UNSOUND... what IS sound is the fan as a
  DECOMPOSITION" restates A1, the criticality factorization, already kernel (row 30/31, M33→M34).
- **P7's literature-check consequence**: `[Voronov2023]` Theorem 1.1 (already held, already the standing conditional
  of row 40) conditionally implies `χ(G(p)) ≥ 7` for the entire cell family at every band — a *derived consequence*
  of an external theorem, not a new theorem of this project's own, already correctly flagged as conditional in row
  40 ("the whole family is ≥ 7 at every scale conditional on `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]`").

## Conjectures surfaced, not claimed

- **"THE AUTOPSY: the 1/7 seven-forcing does NOT factor as pigeonhole × kill" — withdrawn, and already recorded as
  a demotion in `CLAUDE.md` G28.** M43's §R states this as a finding ("zero virtual edges at k = 6 on the largest
  colourable stage... the first clique-free forcer in the family that refuses the factorization"), from six anchored
  asks on the 241-vertex R = 8 ball. G28's demotion record (already in the ledger, not repeated here in full):
  M45 re-asked 9,636 pairs on the identical stage (fingerprint `9d9599be0db64677`) and **found the seven** virtual
  edges G28 now reports, at offset norms 27, 28, 31 — none among the six smallest non-edge classes M43 checked, "so
  the claim measured its acceptance set, not the object (G21's second instance)." Nothing from this section is
  filed as a theorem here, matching the seed's own instruction; the seven virtual edges are M45's measurement,
  filed (if at all) under `plans/M45-derivation.md`.

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M43-T1 | declined — no consumer beyond the qualitative fact M40-T1 already states |
| M43-T2 | declined — the three certified windows it classifies are separately kernel already |
