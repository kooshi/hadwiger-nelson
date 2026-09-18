# FS-62 — does the value 6 ever occur? The measured value set

*Recorded 2026-09-17. Instrument: `tools/fq_chi.py` (naive and deliberately independent of
`tools/fplane.py`, so it can control it). Records: `dim2.jsonl`, `dim3.jsonl` — one line per `(q, n)`,
produced by the committed code. Reading: `CLAUDE.md` G64, `plans/STUB-six-is-not-a-value.md`.*

**Nothing here is trusted.** A value is a value because CaDiCaL said UNSAT at `k−1` and SAT at `k` under a
symmetry-broken encoding; an `undecided` is a fact about that encoding at that budget and **never** about the
graph (G21). Budget: 90 s per satisfiability call.

---

## The question

Every chromatic number this project has ever pinned for a plane over a coefficient structure is **2, 3, 4, 5
or 7**, never 6 — and by G64 *"no field is exactly six-chromatic"* is equivalent to `χ(ℝ²) ∈ {5, 7}`. The
norm reading (G64) says 6 is skipped because it is the smallest integer that is neither `a² + b²` nor
`a² + ab + b²`. **That reading predicts the skipping is specific to dimension two**, where the unit vectors
generate a quadratic order whose norms omit 6; in higher dimensions the relevant orders are quaternionic and
omit nothing. So: **does 6 occur in dimension 3?**

## Controls, run first (G30)

| control | expected | got |
|---|---|---|
| `χ(UD(𝔽_q,2))` at `q = 3, 7, 9, 11, 19` | 3, 4, 3, 5, 5 — `[Moorhouse2010]` Table 6.1, and the kernel at 11 (`chromaticNumber_finitePlane11`) | **3, 4, 3, 5, 5** ✅ |
| clique numbers at the same `q` | 3, 2, 3, 3, 2 — `[Krebs2022]` Thm 5.2 (`ω = 3` iff char 3 or 3 is a square) | **3, 2, 3, 3, 2** ✅ |
| characteristic 2 refused | the form `x² + y²= (x+y)²` is degenerate there; those targets are `Cay(𝔽_{Q²}, μ_{Q+1})` (FS-54) | **refused at `q = 2, 4, 8`** ✅ |

The clique control is the more informative of the first two: it is an independent closed form the instrument
was not built to satisfy.

## Dimension 2 — the value set, with `q ≡ 1 (mod 4)` included

`q ≡ 1 (mod 4)` makes `−1` a square, so the "circle" degenerates and these planes **seal no field** — they
are outside the residue method and are here only as value-set data.

| `q` | vertices | degree | ω | χ |
|---|---|---|---|---|
| 3 | 9 | 4 | 3 | **3** |
| 5 | 25 | 4 | 2 | **3** |
| 7 | 49 | 8 | 2 | **4** |
| 9 | 81 | 8 | 3 | **3** |
| 11 | 121 | 12 | 3 | **5** |
| 13 | 169 | 12 | 3 | **5** |
| 17 | 289 | 16 | 2 | ≥ 5, undecided at 5 |
| 19 | 361 | 20 | 2 | **5** |
| 25 | 625 | 24 | 3 | ≥ 5, undecided at 5 |
| 29 | 841 | 28 | 2 | ≥ 5, undecided at 5 |

**Prior art:** 3, 7, 9, 11, 13, 17 are `[Moorhouse2010]` Table 6.1 (13 measured 5 here at the M58 pivot, 17
left bracketed at `{5,6,7}` and narrowed to `{5,6}` at FS-53). **5, 25 and 29 were not found recorded here**;
they are almost certainly his table's too and are **not claimed** — prior art unchecked, owed to FS-62's gate.

**Value set so far: {3, 4, 5}. No 6.**

## Dimension 3 — and this probe returned NOTHING

| `q` | vertices | degree | ω | χ |
|---|---|---|---|---|
| 3 | 27 | 6 | 3 | **3** |
| 5 | 125 | 30 | 3 | ≥ 7, undecided at 7 |
| 7 | 343 | 42 | 4 | ≥ 7, undecided at 7 |
| 9 | 729 | 90 | 4 | ≥ 8, undecided at 8 |
| 11 | 1331 | 110 | 3 | ≥ 7, undecided at 7 |

**The test could not have produced a 6.** Every three-dimensional case the budget decides is either 3 (at
`q = 3`) or at least 7 — the values leap straight past the range in question, and there is no case near six
for an answer to land on. So **whether the value-skipping is specific to the plane is untested**, and this is
a null about the probe's design, not evidence for the reading.

**The design error, stated so it is not repeated:** the probe confirmed that a six was reachable *in
principle* in dimension 3 and never that it was reachable *at the sizes the budget could decide*. That is
`CLAUDE.md`'s own rule — *state the uninformative outcome and confirm it is reachable, before believing a
control's pass or proposing a discriminator* — broken by someone who had read it the same hour.

**What would make the probe informative:** find a family whose three-dimensional values pass through six.
The jump from 3 to ≥ 7 between `q = 3` and `q = 5` suggests looking at other structures of intermediate
degree rather than at larger `q`, where the values only grow.

## What this does and does not support

* It **adds two decided values** to the dimension-2 record (`q = 5, 13`) and **no new value** anywhere.
* It **does not** support the norm reading beyond restating it — the reading's own killing tests are
  elsewhere: a six-colouring at 17 (`χ ∈ {5,6}`), at `U₆₄` (`χ ∈ [6,8]`, FS-57), or at any window member.
* The three `undecided at 5` rows (17, 25, 29) are the encoding's limit at 90 s, nothing more. 17 is the one
  that matters, and FS-55's antipodal quotient is the instrument pointed at it.
