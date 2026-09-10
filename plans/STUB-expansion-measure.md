# STUB — FS-35: the expansion step's missing measure

*Minted 2026-09-10 at the M64 close, from what M64 §R5 handed over. Written for a reader with zero
memory of the session that minted it.*

## §0 — Why this exists

`[Parts2020a]`'s algorithm alternates **reduction** (shrink a graph while keeping it
non-4-colourable) and **expansion** (add material and try again). M63 §O(3) established that **his
outer loop has no termination measure at all** — nothing in the paper says when a run is making
progress, and his own stated escape from a local minimum is *"increasing the number of new vertices
introduced in the expansion stage"*, which is a knob and not a criterion.

**The reduction half is now finished as a research problem.** M63 reproduced it exactly and ran it
~150× faster than his own implementation; M64 gave its output a complete structural account — the
correction-set hypergraph `Y` as a stored artifact, the atom decomposition into necessary / paired /
residual, the exchange classes, and a solver-free upper bound on the minimum at every symmetry rung.
**Everything left in his loop is expansion**, and it is the one place a population method still has
something an exact solver does not.

## §1 — What M64 hands over as candidate measures

1. **The exchange classes and their totals.** A complete level set's profile set has affine
   dimension far below its ambient: on M63's two stages, 2 of 4 and 2 of 3, cut out by classes of
   varying orbits whose fillings sum to a constant (two classes summing to 12 on the L side; one
   class of three summing to 27 on the S side). That is **a short integer vector per iteration**,
   and it moves when the problem changes.
2. **The closure bound, per rung.** `min_M |cl_H(M)|` upper-bounds the rung-`H` minimum and costs no
   solver (M64 §R5). Measured on the L stage it ranges from `+0` at the live involutions to `+16` at
   the full stabiliser, and on the S stage from `+8` to `+24`. **So before any search, a run can
   say how expensive each symmetry is** — which is exactly the quantity his `24 → 6 → 3 → 2 → 1`
   ladder walks blind.
3. **`Y`'s small layers.** The degree-1 layer is the stable orbits, the degree-2 layer is the
   matching that makes the conservation laws; both are now stored per run.

## §2 — The questions, in order

1. **Does the exchange-class vector move monotonically along his own recorded path?** His four-state
   path is transcribed in M63 §4 phase E; his published `{M}` columns for `374_m6c`, `374_m6ab`,
   `375_m6ab`, `376_m6a` are on disk. *Falsifier: the vector is constant across his moves, so it
   carries no information about progress.*
2. **Does the closure bound predict which rung the expansion should target?** M64 measured that a
   rung with an empty invariant level has its minimum strictly above; the bound says by at most how
   much. *Falsifier: the bound is uncorrelated with where his path actually goes.*
3. **Can the expansion be stated as an integer program over profile coordinates?** This is M64's C3,
   **not run**. *Falsifier, registered by M64: the useful directions leave the current base's orbit
   support entirely, so no inequality over the present orbits can see them.*

## §3 — Bearing on χ(ℝ²) ≥ 6

**Indirect, and it must be said so.** This is a measure for a search loop, not a construction. Its
value is that M62/FS-6's own angle is an expansion strategy, and today it has no way to tell a
working expansion from a stalled one.

## §4 — Instruments and addresses

`tools/parts_faces.py` (the decomposition, the exchange classes, the rung census, 19 controls),
`tools/parts_reduce.py` (now storing `Y`), `tools/parts_stage.py` (`rung_maps=` for an arbitrary
rung), `data/m62/m64-{rungs,faces,orbit-closure,phaseD,phaseD-layers}.json`,
`data/m62/parts-table2-orbit-fillings.json` (his four published `{M}` columns),
`data/m62/parts-ref11/JP/Large/` (his 43 exact objects). **Prior art to consult first** (M64 §PA):
the symmetric-IP literature — core points, orbitopes, orbital branching, Margot's survey — which
owns the symmetry side, and idealness/blocking theory, which owns the hitting-set side.
