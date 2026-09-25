# M3 S1V — blind verification of the rank-one claims (crunch job J20)

*De Bruijn, blind verifier, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J20-M3-rank-one-verifier.md` (with
`STANDING-RULES.md`). The claims verified are the brief's fixed list (A-T1, A-T1′, A-T2, A-K0, A-K1, A-K2, A-Kq, A-K3, A-C) and,
added by the owner's launch message, J19's three (J19-KC, J19-FRZ, J19-KEF). Fenced and unopened: J18's and J19's records, tools, data,
briefs and reports; `plans/M3-exotic-colourings.md`; `plans/M3-close-inventory.md`; `plans/CRUNCH-2026-09-25-INDEX.md`; J18/J19
commits' contents. No fenced file has been opened.*

## Theorems this phase proved

(Filled stage by stage; one line each, grade and address.)

## Stage 1 — SAVED

### 1.1 What the owner told me at launch (logged, because it is information a blind verifier would not otherwise hold)

- J18 reports A-T1 (R2) and A-K3 as GAP, and reports A-K3 logically equivalent to A-T1. (Owner's launch message; not a quotation of a
  statement, so not checkable against a source I may open.)
- J19's three claims, quoted by the owner from `plans/M3-S1B-rank-one.md` lines 14, 16, 17 (fenced; **not checked against the source**):
  - "**J19-KC** — in an all-rigid `X₄(D)`: strands of periodic points are `σ^N`-invariant; Kempe classes of periodic points are finite
    sets of periodic points; the Kempe class of a wall point consists of wall points whose tails lie in different labelled phases. [hand]"
  - "**J19-FRZ** — a wall point with Kempe-frozen tails: every point of its Kempe class has relabellings of the same tails. [hand]"
  - "**J19-KEF** — KE fails at every rigid–rigid wall whose one-sided components are all total, in particular between Kempe-frozen
    tails; so KE ⟹ KE♯. [hand]"
  - My brief defines none of: *strand*, *`N`*, *Kempe class*, *labelled phase*, *Kempe-frozen*, *one-sided component*, *total*, *KE*,
    *KE♯*. Each verdict on these three states the reading it verifies.

### 1.2 The quotation check

| quotation in the brief | source | result |
|---|---|---|
| FS79-T35, "The exact rank-1 criterion at four colours: `P ≠ F` iff every cyclic phase of the window-state graph is a single cycle and a wall exists." | `plans/FS79-derivation.md` line 272 (T35's title) | **verbatim match** |
| "FS79-T35 states its criterion with phases taken modulo colour permutation" | `plans/FS79-C-deBruijn.md` §3a ("the window-state graph modulo colour permutation") and its tool `data/fs79/comp-debruijn/tools/rank1_phases.py` | **matches**; and the tool's quotient is specific: vertices are canonical (first-occurrence) words, and the out-edges of a class are the out-edges of its canonical representative, **with multiplicity** (one edge per admissible next colour); "rigid" counts those edges. This definition matters for A-Kq (§2) |
| FS79-T34 and its proof in `plans/FS79-C-deBruijn.md` §3 | same, §3 "Claim C2" | present; proof read (steps 1–5) |
| FS73-T24 "(three colours: periodic colourings dense, so no walls)" | `plans/FS73-derivation.md` line 225 | a gloss, not a quotation; consistent with T24's statement and T30's "at three colours there are no walls" |
| FS73-T30 "(rank-1 walls at four colours, all beside positive entropy)" | `plans/FS73-derivation.md` line 284; "beside positive entropy" is `plans/FS79-C-deBruijn.md` §3a's finding | a gloss; consistent (T30 itself says "every one with `P = F = 0`") |
| FS85-dB1, dB2; FS86-dB-H; `LEDGER.md` rows 45, 86 | `plans/FS85-derivation.md` lines 72, 82; `plans/FS86-derivation.md` line 328; `LEDGER.md` lines 67, 109 | present and read |
| The fixed list (A-T1 … A-C) | `plans/M3-exotic-colourings.md` §S | **fenced: not checked**; verified as the brief states them |
| The definitions for Q1 (window-state graph, phase, rigid, wall, `F_k`, `P_k`) | the brief itself, "quoted" from J18's/J20's shared text | taken as the brief states them |

Observation logged at the check (not a quotation defect): FS79's tool builds its states from **locally** proper `m`-words, while the
brief's vertices are words **occurring in some point**. The two graphs have the same cyclic SCCs and the same walls (every vertex on a
cycle, or on a path between two cycles, occurs in a bi-infinite path), so T35 and the scan are unaffected.

### 1.3 C0 — probabilities before any written derivation

Honest timing: these were formed while reading the statements and the verified inputs. Two things were already visible in my head at
that moment and are recorded so the priors are not mistaken for pre-thought: (i) A-T1, A-T1′, A-T2 and A-K3 looked mutually
equivalent (the finite/zero-entropy dichotomy, T35, and C2's orbit argument); (ii) the literal "quotient by colour permutations" at
`D = {1}` collapses `K₄`'s complete digraph to a single loop — a doubt about A-Kq.

| claim | P(true) | why |
|---|---|---|
| A-T1 | 0.50 | 377 of 377 all-rigid sets without a wall (T36) and walls always beside entropy (T30, §3a); against: zero-entropy countable SFTs are routine in general, and two derivation agents stalled |
| A-T1′ | 0.50 | expected equivalent to A-T1 |
| A-T2 | 0.50 | expected equivalent to A-T1 given T35 |
| A-K0 | 0.95 | a one-point or one-component repaint of a periodic point in a single-cycle phase must return to the cycle |
| A-K1 | 0.93 | from A-K0 via a periodic three-colouring |
| A-K2 | 0.95 | backward-determined colours propagate |
| A-Kq | 0.55 | the `D = {1}` collapse; true if the quotient keeps edge multiplicities |
| A-K3 | 0.50 | expected equivalent to A-T1 (vacuous if A-T1 holds; implies A-T1 by C2's orbit) |
| A-C | 0.45 | the negation of A-T1 with a named `D`; a verdict TRUE needs the name |
| J19-KC | 0.75 | clause 1's `N` undefined |
| J19-FRZ | 0.90 | frozen tails have one strand per colour pair |
| J19-KEF | 0.50 | KE, "total", KE♯ undefined in my brief |

### 1.4 "Would have searched here" log

- (none yet)
