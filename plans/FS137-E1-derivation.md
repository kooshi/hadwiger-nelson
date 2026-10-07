# FS137-E1 — what a ring can afford at six: the opening, and the six first claims (the deriver's record)

*Job FS137-E1 (Ephodos; brief `data/fs137/briefs/FS137-E1-opening.md`; plan `plans/FS137-the-ring-budget.md`; scripts and
outputs `data/fs137/e1/`). Opened 2026-10-07 (UTC). **Every statement in this record is about weak colourings that already
have labelled corners at named points; no weak six-colouring is known to have one, and nothing here fixes or bears on the
value of χ(ℝ²).** Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS137-E1-derivation.md`, from `plans/`.*

## Theorems this phase proved

*(Filled stage by stage; each line: the entry, its verdict and grade, its address below.)*

- Stage 0, Stage 1: none (readback; the opening).

## Stage 0 — SAVED: the readback, and the kernel lane's relay

### 0.1 The brief's quotations

`data/fs137/e1/quote_check.py` (copied from `data/fs136/e2/quote_check.py`, the brief's path changed): every line of every
quotation in the brief is found verbatim in the file its source line names — `quotations=15 mismatches=0`
(`data/fs137/e1/quote_check.out`); with one character of the first quotation altered it exits 1
(`quote_check.fault.out`: `mismatches=1`). No mismatch: no finding about the brief.

### 0.2 What was read, and how far

| source | read |
|---|---|
| the brief; `plans/STANDING-RULES.md` | whole |
| `plans/STUB-collars.md` | whole (the card, both forms, the six first claims, the registered numbers, the stop) |
| `data/fs137/claims.md`; `plans/FS137-close-inventory.md` | whole |
| `plans/FS136-derivation.md` | head; §§ 1–2 whole (C136-TABLE, -COVER, -ONE, -CORNERS, -CLASS, -FORCED, -CLOSE, -COLLAR and their controls); § 4 whole (the stops); §§ 3, 5–7 not read beyond their headings |
| `data/fs136/e2/closure.py` | whole — the engine; copied unchanged to `data/fs137/e1/engine.py` (`cmp` identical) and imported from there |
| `data/fs136/e2/out/bowtie12.txt` | the seed lines and the scan of both unit circles |
| `plans/POROS-2026-10-07-fs136-derived.md` | § 0.3 (the hunches H-a … H-d), § 0.4 (its expectations), §§ 2.1–2.3 (the reframe, the choice, the stop); the rest by headings |
| `plans/FS116-derivation.md` ll. 635–671 and `plans/FS116-N2-proof.md` § 2.1–2.3 | FS116-N2-SIXRING and FS116-N2-FIVERING: statements, *uses only*, and **both arguments whole**; -N2-STAR, -N2-RECIP, -N2-ANTI: arguments read |
| `plans/FS124-derivation.md` C124-BOTH | statement, *uses only*, *not claimed*, prior art; its argument in `FS124-E2-derivation.md` **not read** |
| `plans/FS112-derivation.md` FS112-N3-COR3 | statement only |
| `plans/FS114-derivation.md` (route T) | FS114-N2-ENDS and -N2-FIVE statements; `plans/STUB-route-t-count.md` by its frontier line only |
| `plans/SEARCH-QUEUE.md` | lines 15–21 |

### 0.3 The relay from the kernel lane (FS136-K1, by the coordinator, mid-stage) — how it changes this job

Received while reading; addressed before anything else was written. The four statements this job stands on (C136-TABLE,
the two counts, the label half of C136-FORCED) are kernel-checked on a branch by routes found blind; C136-CLASS, the
collar and the rest of C136-CORNERS are typed, not proved. Its findings 5–8, and what each does here:

- **Finding 8 — "Purity at w is necessary for a label to be present on a side, not sufficient."** Accepted, and it is how
  every claim below is to be read: a **palette is an upper bound** — the labels the table leaves possible on a side at
  `w` — and says of no label that it is present. The only lower bound available anywhere in this job is the trivial
  one: almost every point has *some* label, so a side whose palette is one label has it (C136-FORCED) and a side whose
  palette is empty is in no domain. Every count below is therefore of the form "what is present ⊂ what a palette
  allows" plus "something is present"; **no statement here says a label of a palette occurs.** Each *not claimed* line
  says so. The two-discs example is the tangent case, where a class is decided by curvature: it sits at the end points
  of windows, a finite set of directions, so the lengths in C137-BUDGET are unaffected, and C137-SIXTY and C137-OWN are
  stated at single directions through C136-FORCED, which reads the table at `w` only.
- **Finding 6** (the collar holds for any connected subset of `S(x) ∩ U`): C137-OWN is stated at that form.
- **Finding 5** (the second sentence of the forward step on the open set `T`) and **finding 7** (`ρ ≤ ρ₀` is
  load-bearing in C136-CORNERS): no claim of this job reads either; C137-MEET is stated on the cell (the set of points
  on chosen sides), which needs no connectedness.
- Nothing in the relay changes the claim list or the order of work.

### 0.4 Two things seen in the readback, before any derivation (each is taken up at its claim)

1. **The card's count has a pointwise form.** For corners filling a neighbourhood of `x` and a direction `θ` whose
   tangent directions `θ ± 90°` are not edge directions, the tangent line at `x` to `S(x + e(θ))` passes through exactly
   two corners (one, if a corner is reflex); every other corner is inner or outer. So the number of pure labels is
   `m − 2` at **every** such direction, not on average — the saved scan of `q₂` reads 3 = 5 − 2 on each of its ten arcs
   (`data/fs136/e2/out/bowtie12.txt`: inner 2,1,2,1,0,1,2,1,2,3 and outer 1,2,1,2,3,2,1,2,1,0 own labels). Claim 1 is taken
   at that form.
2. **"Whatever the corners" fails for a label with two corners.** The card's bound is by the number of corners `c`; by
   the number of labels `m` it is false when a label repeats at the point (`a, c, b, c` in cyclic order: both `a` and `b`
   pure on open sets of directions, windows summing to more than `180°·(m − 2)`). The mean `k − 1 − m/2` is for
   one-corner labels only. Claim 1's statement says which.

## Stage 0 — SAVED
