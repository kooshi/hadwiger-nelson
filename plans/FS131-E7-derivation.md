# FS131-E7 — a model or a contradiction for four hypothesis sets, and a stuck vertex in a terminal map

*Job FS131-E7 (Ephodos, one mind). Brief: `data/fs131/briefs/FS131-E7-models.md`. Claim list: `data/fs131/claims-E7.md`. Scripts and scratch:
`data/fs131/e7/`. Report: `data/fs131/reports/FS131-E7.md`. Nothing in `Proofs/`, in any worktree or on any branch but `main` is changed by this
job; no search is run (standing rule 5): every object below is given by formula and every computation checks a derived shape.*

## Theorems this phase proved

Filled as the stages land; each line carries its grade and its address in this record.

- (stage 1) none — the readback.

## Stage 1 — SAVED (FS131-E7): the readback, the questions restated, what was read, the predictions

### 1.1 The quotations, checked by script

`data/fs131/e7/e7_quotecheck.py` reads the brief's 19 quotations against the files they name and the claim list's 31 Lean blocks against
their Lean files (text up to whitespace, and the line number of each declaration): **50 of 50 match, exit 0**. Planted fault (`--plant`, one
word of the first quotation misspelt): 1 failure, exit 1. The control is `quotes-brief` below.

Two things about the brief that are not mismatches of text:

- The brief and the claim list are dated 2026-10-06; this job's clock read 2026-10-06 04:53 (UTC) at its start. A time zone, not a defect.
- The brief's inference "a model inside [`sixFrag`] would sit at a point other than `0`" is checked in § 3.6: no point of `sixFrag` other than
  `0` qualifies either (a point `v` with `Covers v 1` has `|v| < 1/2`, and such a point carries one, two or six colours).

One drift, not a mismatch: at this job's start the claim list's line number for `n3_end_four_colours` (l. 1767 of `Terminal.lean` in the
worktree `fs131-w5c`) was exact; forty minutes later the declaration stood at l. 1768, the text unchanged (another job is editing that
branch). The script checks text in a live worktree and reports a drifted line as a note.

control: quotes-brief
  of: nb4p-half-hnb — the readback it rests on: every quotation of the brief and every Lean block of the claim list against its source
  run: python3 ../data/fs131/e7/e7_quotecheck.py | tail -1
  expect: quotations checked: 50  failures: 0
  fault: python3 ../data/fs131/e7/e7_quotecheck.py --plant | tail -1

### 1.2 The five questions, verbatim from `data/fs131/claims-E7.md` § The questions

> **Q1 — `a4six`.** Is there a `k`, an `F : ArcMap k`, a point `v` and colours `a`, `b` satisfying `hF`, `hv`, `hab`, `habs` and `hno` at once? Answer with such an object exhibited exactly, each of the five checked on it; or with a derivation that the five are contradictory; or with the step where neither is reached.

> **Q2 — `straddlers_third`.** Is there a `k`, an `F : ArcMap k`, a point `v`, an angle `θ` and colours `X`, `X'` satisfying `hF`, `hv`, `hcompl`, `hX`, `hX'` and `hna` at once? Answer in the same three forms.

> **Q3 — `nb4p`.** The theorem concludes `False` from `hF`, `hv`, `h4`, `hy`, `hring` and `hnb`. Is there a `G : ArcMap 6` with `v`, `ψ`, `X`, `X'` satisfying the first four at once; one satisfying the first four with `hring`; and one satisfying the first four with `hnb`? Answer each in the same three forms.

> **Q4 — `flank_ne_of_doublyShadowed`.** Is there a `k`, an `F : ArcMap k`, a point `v`, reals `α`, `κ₁`, `κ₂` and colours `g`, `h` satisfying `hF`, `h5`, `hv`, `h1`, `h12`, `h2`, `hg`, `hh` and `hD` at once? Answer in the same three forms.

> **Q5 — a stuck vertex in a terminal map of the plane.** Is there a `k ≥ 7`, an `F : ArcMap k` and a point `v` with `F.Valid`, `F.IsPlaneMap`, `F.Terminal` and `F.IsStuck v`? Answer with such a map exhibited exactly, with a derivation that none exists, or with the step where neither is reached.

> *Not claimed*: anything at six colours on a map of the plane (an object there is a valid six-map of the plane, the open problem); the truth of the five theorems (each is kernel-checked, or, for `n3_end_four_colours`, proved on its branch); any other theorem of FS131-QA4's lists.

I call Q3's three sub-questions **Q3a** (`hF`, `hv`, `h4`, `hy`), **Q3b** (those with `hring`) and **Q3c** (those with `hnb`).

### 1.3 What was read, and how far

| source | read | what it gave |
|---|---|---|
| `Proofs/HadwigerNelson/Plane/ArcMap.lean` | whole | `ArcMap`, `Γ`, `interiorPts`, `region`, `coloursAt`, `Valid`, `Covers`: the model is point-set; `k` is any natural number; a colour may be idle |
| `Plane/ValidMap/Basic.lean` l. 28–176 | the definitions | `frameX`, `tanHeight`, `TanAbove`, `hornSet`, `curvDown`, `curvUp`, `shadow`, sectors, horns, flanks, the three moves, `Terminal`, `IsStuck`, `allowedCone`, contact types |
| `Plane/LocalMap.lean` l. 97–280 | the ring vocabulary | `GermIn`, `OnRingArc` (any sub-arc of `ω(p)` inside `Γ`), `IsChangePoint`, `IsQArc` |
| `Plane/SixFragment.lean` l. 1–140 and its theorem list | header, definitions | `sixFrag`: sector flower, lenses, gaps; domain `B(0, 3/2)`; six colours at `0`; `ω(0) ⊆ Γ` |
| `Plane/ValidMap/UnitArc.lean` l. 6317–6479 | `nb4p`'s proof, whole | **the proof reads `hnb` only through its first conjunct** (§ 1.4) |
| `Plane/Woodall/Merge.lean` l. 636–700 | `recolour`, `recolour_valid` | the library's planting step: a set `W` recoloured `c`, valid when `W` has no unit pair and none with `F`'s class of `c` |
| `Plane/ValidMap/BaseSteps.lean` | the list of `bowtie_*` theorems only | the bowtie's facts at `0`, `±i`; its body (about 2,700 lines) not read |
| `plans/FS131-QA4-audit.md` §§ 2–6 | whole | the audit's rows; its two planting proposals (§ 3.2 (b), § 3.5) |
| `plans/FS112-derivation.md` l. 28–70, 250–300 | the entries | FS112-NB4P, FS112-A4SIX ("On the strip its hypothesis is vacuous in the union sense and met in the disjoint sense"), the strip, the disk, FS112-BUDGET2 |
| `plans/FS112-N-proof.md` l. 60–84, 104–110, 136–215 | § 1.4 row 1, § 2.1 W1 | NB-4's argument (straddlers, the alternation, the half-plane count); (E1) and (E2) |
| `plans/FS110-N-proof.md` § 2.2, `plans/STUB-stuck-ray.md`, `plans/FS131-E6-derivation.md` §§ 3.1–3.3 | **not read** at this stage | Q4 and Q5 are derived below from the Lean definitions; the three are read, or named as unread, in their stages |
| `LEAN.md` § The gate | the two quoted lines only | — |

### 1.4 A finding met on the way: `nb4p` never reads half of `hnb`

In `nb4p`'s proof (`UnitArc.lean` l. 6317–6477) the hypothesis `hnb` occurs once, as `(hnb k hk).1` (l. 6384): the clause about `ω(y_{j+1})`.
Its second conjunct, `¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) − 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))`, the clause about `ω(y_{j−1})`, is
never used. So the theorem holds with `hnb` weakened to its first half. It bears on Q3b and Q3c: the hypothesis that collides with the other
five is one rotational sense of (E2), not both. Inventory kind: generalization.

derivation: nb4p-half-hnb
  statement: the proof of `nb4p` at `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` l. 6317–6477 uses `hnb` only through its first conjunct, `¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) + 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))` for `j < 6`; so `False` follows from `hF`, `hv`, `h4`, `hy`, `hring` and that conjunct at every `j < 6`
  uses only: the text of the proof: `hnb` occurs once after the signature, as `(hnb k hk).1` (l. 6384), feeding `straddlers_third`
  not claimed: that the second conjunct alone suffices in Lean (true by the mirror `z ↦ z̄` at [hand], § 5.4, and not checked by the kernel); that either conjunct can be dropped from the hand statement FS112-NB4P without re-reading its three minds' proofs
  argument: § 1.4 A finding met on the way: `nb4p` never reads half of `hnb`
  verdict: derived
  grade: hand
  minds: 1
  model: `nb4p`'s own proof text; the count is the control `hnb-occurrences`
  prior art: owed — not searched; a fact about this repository's proof, not about the literature
  handoff: de Bruijn — the planner's choice: restate `nb4p` with the one conjunct (a strictly stronger theorem, no proof change beyond the binder), or leave it and note the idle half in the docstring

control: hnb-occurrences
  of: nb4p-half-hnb — the uses of `hnb` inside `nb4p`'s proof body, each printed with whether it takes the first projection
  run: python3 ../data/fs131/e7/e7_hnb.py
  expect: uses of hnb in the proof body: 1  through .1: 1  through .2 or whole: 0
  fault: python3 ../data/fs131/e7/e7_hnb.py --plant

### 1.5 Predictions, registered before any written derivation

Said plainly: by the time these were written I had worked each question in my head from the definitions, so these are predictions about what
the written derivations and their checks will confirm, not priors formed cold. Each decides what the next stage builds.

| id | prediction | probability | decides |
|---|---|---|---|
| P1 | Q1: a model at `k = 6` with both absent colours live on the ring (a four-petal Reuleaux flower) passes its exact checks | 0.85 | whether Q1's verdict is "model at the readers' parameter" or "model only with idle colours (`sixFrag` padded, `k = 8`)" |
| P2 | Q2: the same flower with one small cell recoloured is a model at `k = 6` | 0.8 | whether Q2 needs a second object |
| P3a, P3c | Q3a and Q3c: that recoloured flower is a model of both | 0.8 | the same |
| P3b | Q3b: neither a model nor a contradiction is reached in this job; if decided later, a model exists | 0.7 that it stalls here; 0.6 for a model, given a decision | whether `hnb` is idle (it is, if Q3b is contradictory) |
| P4 | Q4: a model at `k = 9`, two fresh colours planted in `sevenBrickMap`, each shadow coming from a horn at the pole on the far side; no contradiction | 0.85 | whether `flank_ne_of_doublyShadowed` is empty where N4-STUCK reads it |
| P5 | Q5: yes, at `k = 12`: a small bowtie planted in three bricks of `sevenBrickMap`, terminal because no other point has a repeated colour or a horn | 0.75 | the bearing line for `plans/STUB-stuck-ray.md` and the stuck family's docstrings |
