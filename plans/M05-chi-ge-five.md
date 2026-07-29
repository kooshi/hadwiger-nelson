# M05 — χ(ℝ²) ≥ 5  *(stub — carry-forward notes only)*

> Cube split, certificates ingested, `¬ Colorable 4`, the headline theorem, trust receipt.
> Terminal test: `chromaticNumber_plane_ge_five` green, zero `sorry`, `#print axioms` recorded,
> `lean4checker` re-check.

Not yet subplanned. This file holds what M03 established and deliberately deferred.

## The trust position, settled at M03

**`LRAT.check` does not kernel-reduce, at any size.** Measured on the smallest unsatisfiable CNF
there is: `decide` is stuck immediately, `decide +kernel` gets as far as `Formula.performRupAdd` and
sticks there after ~40 s, `native_decide` succeeds. Core's own `bv_decide` uses native evaluation
for the same step. Consequences M05 must plan around:

* **The cube split's justification is solver tractability and memory, not trust.** The earlier hope
  that many small certificates might be kernel-reducible where one large one is not is false — none
  of them are.
* χ(ℝ²) ≥ 5 will carry a **native-evaluation axiom**, one per certificate-backed declaration. It is
  named per declaration, listed in `ARCHITECTURE.md` § 5, and said out loud in the write-up.
* At v4.32.0 the axiom is `<decl>._native.native_decide.ax_N_M`, **not** `Lean.ofReduceBool`. Grep
  for `native_decide.ax`.
* ~~The only route to a kernel-only bound is an LRAT checker written to reduce, with its own
  soundness proof.~~ **Superseded 2026-07-29 — see `plans/spike-kernel-lrat.md`.** Core's generic
  `lratChecker` already kernel-reduces a real refutation with an axiom-clean soundness theorem, so no
  new soundness proof is needed for correctness — only speed. Measured: core is ~430× too slow
  (22.6 days for de Grey), a big-integer mask checker is 1.26 hours. Also superseded there: the claim
  above that `decide +kernel` sticks in `performRupAdd` after ~40 s. It sticks in
  `DefaultClause.ofArray`, in under a second, because of `Std.HashMap`.

## Deferred from M03

* **Colour symmetry.** Max clique in a plane unit-distance graph is 3, and these graphs are full of
  unit triangles; fixing one triangle to colours `0,1,2` is sound via a permutation of `Fin k` and
  cuts the cube space by `4! = 24`. A real theorem plus a pure optimization — worth it only at
  de Grey scale.
* **Certificate trimming** (`Lean.Meta.Tactic.BVDecide.LRAT.Trim`), binary LRAT, and the question of
  what to do with certificates too large to embed as a Lean source literal. M03's were 658 bytes;
  de Grey's will not be.
* **Which `W` to split on.** An empirical question about de Grey's graph, not about the bridge.
  `tools/cubes.py` exists from the M02-era exploration.

## Inherited call site

M03 built the single theorem M05 calls, and proved it type-checks with real data in it
(`four_le_chromaticNumber_plane_certified`):

```lean
theorem UDCert.add_one_le_chromaticNumber_plane_of_cubes (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hk : 0 < k) (W : List (Fin n))
    (hu : ∀ cb ∈ allCubes k W, (colouringCNF k n c.edges ++ cubeCNF k cb).Unsat) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber
```

`hu` is discharged cube by cube, `fin_cases hcb; exacts [...]` — the same shape as
`UDCert.valid_of_chunks` on the geometry side.

**Do not reorder `deGrey.edges` after M04.** LRAT clause ids refer to the DIMACS clause order, which
is the order of `colouringCNF`'s output, which is the order of the edge list.
