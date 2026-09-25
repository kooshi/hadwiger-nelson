# M3 S1B — FS-76 in rank one, second mind on J18's stalled step (crunch job J19, derivation)

*Brief: `data/crunch-2026-09-25/briefs/J19-M3-rank-one-second-mind.md` with `STANDING-RULES.md`. Owner's ruling at launch: the target is
**A-T1 (R2) itself**; KE is the recommended route, a counterexample to KE is a finding about KE only; J18-DC's side is open to derivation
or explicit construction, never search. A proof of A-T1, a counterexample to A-T1, or a sharper named obstruction are all complete
outcomes. First mind: J18, `plans/M3-S1A-rank-one.md`.*

## Theorems this phase proved

*(one line per theorem, grade (`CLAUDE.md` § Notation), address; filled at each stage)*

| id | statement (one line) | grade | address |
|---|---|---|---|
| J19-KC | in an all-rigid `X₄(D)`: strands of periodic points are `σ^N`-invariant; Kempe classes of periodic points are finite sets of periodic points; the Kempe class of a wall point consists of wall points whose tails lie in different labelled phases | hand | §2.3 |
| J19-ENDS | the ends partition: each strand of a tail has exactly one end-component in a wall point; finite components meet the junction; a swap changes the tails by the strand swaps of its ends | hand; tools exact on the control | §2.4, `tools/crunch_j19_ends.py` |
| J19-FRZ | a wall point with Kempe-frozen tails: every point of its Kempe class has relabellings of the same tails | hand | §2.5 |
| J19-KEF | KE fails at every rigid–rigid wall whose one-sided components are all total, in particular between Kempe-frozen tails; so KE ⟹ KE♯ | hand | §2.5 |
| J19-TW | every wall has a chiral end (FS79-T34's core, re-derived); a wall with an achiral end yields a twin wall `E → gẼ` | hand | §2.5 |
| J19-BIN | for `D ⊇ {1,2}`, `X₄(D)` is a 24-to-1 extension of a binary return-time shift `Y(D)`; phases, rigidity, walls and mirroring transfer | hand | §2.7 |
| J19-CTL | the control's 9 rigid–rigid walls run from {65,67,81} to the mirror family {55,23,49}; of their 62 one-sided components the 10 total ones keep the tail rigid and the 52 proper ones send it to 57, matching J18's data exactly | tools exact | §2.2, `data/m3/j19/` |
| J19-AF✗ | in the all-rigid `X₄({2,6,11,13,14})` every one of the 94 rigid periodic points is non-frozen (a 6-strand couple of pairs); single-strand swaps stay rigid, connect all 94 phases, and join every chiral phase to its mirror | tools exact (one `D`, at the ban's edge) | §2.6, `data/m3/j19/frozen-2-6-11-13-14.txt` |
| J19-KT | KE ⟹ KT ⟹ A-T1, and KT ⟹ KE♯; so A-T1 = FW ∧ A-T1ⁿᶠ, with FW invisible to Kempe moves | hand | §2.8 |

---

## Stage 1 — SAVED (the quotation check, C0, the reading log)

### 1.1 The quotation check (standing rule 5)

Every quotation in the brief and in the owner's launch message, against its source, read from disk 2026-09-25:

| # | quotation (brief's place) | source | result |
|---|---|---|---|
| Q1 | KE, verbatim | `plans/M3-S1A-rank-one.md` §3.5, first paragraph | **identical**, character for character |
| Q2 | KE1, KE2, verbatim | same, bullet "Its two halves" | **identical** |
| Q3 | "KE ⟹ A-T1 [hand]: in an all-rigid shift no phase fails …" | same, first bullet | **identical** |
| Q4 | A-T1, verbatim | `plans/M3-exotic-colourings.md` §S, line "A-T1 (R2)" | **identical** |
| Q5 | "A-K3 is logically equivalent to A-T1 … (§2.5, "J18-EQ")" (a gloss, marked statements only) | J18's theorem table, row J18-EQ: "A-T1 ⟺ A-T1′ ⟺ A-T2 (T35 re-derived) ⟺ A-K3; …" | **faithful** (the row states more: A-T1′ and A-T2 are in the same chain) |
| Q6 | "KE is *stronger* than A-T1 and can fail where A-T1 holds (§3.5)" | §3.5 bullet "Warnings for J19": "KE is *stronger* than A-T1: it constrains shifts that have entropy. It can be false while A-T1 is true." | **faithful** |
| Q7 | the definitions, verbatim | `plans/M3-exotic-colourings.md` §S, "Definitions for Q1" | **identical** |
| Q8 | "J18's record fixes the reading as the labelled quotient, or the unquotiented graph; the plain quotient differs (§2.4)" | §2.4 heading and A-Kq (labelled): "Every phase of `G̃` is rigid iff every phase of `G_lab` is; a wall exists in `G̃` iff one exists in `G_lab`." | **faithful** |
| Q9 | owner: "J18-DC … A-T1 fails iff some heteroclinic four-colouring has an all-rigid Δ-completion" | §3.2, Theorem J18-DC: "A-T1 fails iff there are a four-colouring `c` of ℤ that is eventually periodic in both directions and not periodic, and an `M ≥ 1` with `D_c(M) ≠ ∅`, such that every phase of `X₄(D_c(M))` is a single cycle." | **faithful** (the gloss omits `D_c(M) ≠ ∅`, harmless: `D_c(M) = ∅` gives the full shift, never all-rigid) |
| Q10 | FS79-T34, T35, T36; FS73-T24, T30; FS85-dB1, dB2; FS86-dB-H (cited by name only) | their derivation files | all present, statements read |

**Reading discipline, and one slip of mine (logged, not hidden).** The brief allowed J18's §2.0, the *statement* of K0-loc, the
statement of A-Kq, J18-DC's statement, §3.3's bullets, and §3.5's KE statement and its "Warnings" bullet, and forbade §3.5's "Routes tried
and dropped" and every proof. I read those sections with `sed` line ranges, and two ranges were wider than the allowance: **I read
K0-loc's proof (§2.1), and §3.5's "Routes tried and dropped" bullet** (three routes: (a) swap the `{p(0), c(0)}`-component of the
departure vertex to push the departure right; (b) a strand count across the junction per colour pair; (c) route (ii) of §3.1). I also
read the first lines of A-Kq's proof. So this derivation is **not blind to J18's dropped routes**; it avoids them deliberately rather than
by ignorance, and a reviewer should weigh any overlap accordingly. I read no other proof in J18's record.

### 1.2 C0 — registered before the derivation (both outcomes of each reachable)

| id | prediction | prior | both outcomes reachable? |
|---|---|---|---|
| C0-1 | this job proves A-T1 for every finite `D` | 0.08 | yes: a proof, or none |
| C0-2 | this job constructs a counterexample to A-T1 (a named `D`, all-rigid, with a wall), checked exactly on the one derived `D` the brief allows | 0.05 | yes: the one exact check can come back all-rigid-with-wall, or with a non-rigid phase, or with no wall |
| C0-3 | this job ends at a named obstruction sharper than J18's KE (a statement strictly weaker than KE that still implies A-T1, or an exact reformulation with fewer quantifiers), or at a proof of A-T1 on a named subclass | 0.80 | yes |
| C0-4 | KE (J18's statement, not A-T1) is refuted by a derived argument or a derived instance | 0.10 | yes |
| C0-5 | on the control `{1,5,7,10}`, every rigid–rigid wall runs from a chiral phase to a phase of the mirror family (so the control's rigid–rigid walls are "twin boundaries") | 0.6 | yes (checked in §2 on the one given control; the tool is J18's, frozen) |

Priors are mine and uncalibrated. The standing warning (rule 4, G21): a proof I like is audited as hard as a counterexample.

### 1.3 The owner's mid-stage message (2026-09-25)

The owner reports `[EggletonErdosSkilton1985]` (R. B. Eggleton, P. Erdős, D. K. Skilton, "Colouring the Real Line", J. Combin. Theory
Ser. B 39 (1985) 86–100) newly held at `~/source/library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf` (15 pages, a scan
with an OCR layer), and asks me to read its sections on periodic and non-periodic colourings when they serve the target, record per
section what I read, and say whether the 1990 paper (`[EggletonErdosSkilton1990]`, "Colouring prime distance graphs", Graphs Combin. 6,
still unheld) is still needed. Done in §2.1 below, before the derivation.

### 1.4 The would-have-searched log (opened)

| # | move I would have made by search | what I did instead |
|---|---|---|
| W1 | enumerate candidate distance sets `D` (or candidate heteroclinic colourings `c`) and test each for all-rigid-with-wall | nothing; the counterexample side is attempted only by derivation (§2), with at most the one exact check the brief allows |

### 1.5 Registered before the one exact check (added during stage 2, committed before the run)

**The check (at the ban's edge, logged):** `tools/crunch_j19_frozen.py 2,6,11,13,14` — the complete window-state graph of
`X₄({2,6,11,13,14})` and the strand counts of its rigid periodic points. **Why this `D`:** it is the all-rigid set with the most phases
(94) in the existing FS-79 scan (`data/fs79/comp-debruijn/runs/rank1_scan.jsonl`), chosen by that rule before the run; one `D`, no
sweep. **The claim it checks (conjecture AF, formed in §2):** "in an all-rigid `X₄(D)`, every periodic point is Kempe-frozen (one strand
per colour pair)". **Prediction C0-6:** all 94 rigid periodic points frozen, prior **0.35** (the control's rigid points are all
non-frozen, and nothing I have proved forces freezing). Both outcomes reachable: the tool reports non-frozen points on the control
(positive control passes, plant fires).

**Order-of-events note (a slip, logged):** the registration above was written to disk before the run, but its commit failed on a git
lock held by another job, and the run went ahead; the commit (`956ce452`) landed seconds after the run. So the registration's precedence
is attested by the order of my tool calls, not by the commit order.

---

## Stage 2 — SAVED (the step: no proof and no counterexample of A-T1; four theorems, a refutation of KE on a named class, one prediction lost, a sharper named obstruction)

### 2.1 `[EggletonErdosSkilton1985]` — read for the owner, per section

R. B. Eggleton, P. Erdős, D. K. Skilton, "Colouring the Real Line", J. Combin. Theory Ser. B 39 (1985) 86–100
(`~/source/library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf`, a scan with an OCR layer; read through `pdftotext`).

| section | read | what it holds for this job |
|---|---|---|
| 1 Introduction, 2 Definitions | in full | `G(ℝ, D)`, "distance set"; chromatic number only |
| 3–5 (closed interval, open interval, infinitely many intervals of distances) | theorem statements only (Thms 1–8) | real-line intervals; nothing on `ℤ` colouring spaces |
| 6 Finite set of distances | in full | `G(ℤ, D)` defined; Thm 9 (`χ(1,…,m) = m+1`), Thm 10 (`χ(r,s) = 3` for coprime opposite parity), Thms 11–14 (`{1,…,m}∖{k}`); every colouring given is explicit and periodic |
| 7 Prime distances | in full to Thm 16 (Thm 17's statement truncated in the OCR) | Lemma 6 (`χ(ℤ, primes) = 4`, `χ(2,3,5) = 4`), Thm 15 (classes of `D ⊆` primes), Thm 16 (`{2,3,p}` in class 3); a hand forcing chain for `{2,3,11,13}` |
| 8 Concluding remarks | in full | asks about colourings with at least `k` colours in every open interval; promises a sequel on distance sets not bounded away from 0 |

**Verdict for the owner:** the 1985 paper says **nothing about periodic versus non-periodic colourings or the structure of the
colouring space** (the OCR text contains no "periodic"; every colouring in it is an explicit periodic formula). It does not bear on
R2/A-T1. **The 1990 paper (`[EggletonErdosSkilton1990]`, "Colouring prime distance graphs", Graphs Combin. 6) is still needed**: its
Theorem 2 (periodic `χ(D)`-colourings exist; aperiodic ones may coexist, per the zbMATH review and the MathOverflow note) is the only
prior statement of the rank-one periodic/aperiodic question we know of. Bibliography row proposed in §3.4.

### 2.2 The control's rigid–rigid walls are twin-family walls, and the one-sided swaps split exactly into "total" and "proper"

On `{1,5,7,10}` (the one given control; J18's frozen tool; `tools/crunch_j19_mirror.py`, `data/m3/j19/mirror.txt`):
- **Mirror pairs among the rigid phases:** 23↔67, 49↔81, 55↔65, 63↔110; the other ten are achiral. **The nine rigid–rigid walls run from
  the family {65, 67, 81} to its mirror family {55, 23, 49}**: three are *twin walls* (a phase to its own mirror: 65→55, 67→23, 81→49)
  and six cross the families. **C0-5 is met.** Every one of the nine also factors through the non-rigid phase 57 (the walls 65/67/81→57
  and 57→23/49/55 are in the wall list).
- **The ends partitions** (`tools/crunch_j19_ends.py`, `data/m3/j19/ends-*.txt`; theorem J19-ENDS below says what they are): in every
  rigid phase of the control each colour pair has 1 strand or 5 strands (one complementary couple of pairs has 5, the other two couples
  have 1). Call a one-sided component **total** if its ends are *all* the strands of its tail for that pair, **proper** otherwise.
  Across the nine walls there are **62** one-sided components (of the size J18's swap tool reads): **10 total, 52 proper.**
- **Against J18's swap data (`data/m3/j18/swaptail.txt`, 62 control rows), exactly:** the 10 swaps that kept the tail rigid are the 10
  total components (65→23 pair {2,3}; 67→23, 67→49, 67→55 pair {0,3}; 81→23 pair {0,1}; each once on each side), and all **52**
  proper components sent the tail to the non-rigid phase 57. A total swap is a colour relabelling of the tail (`(ef)∘p`), so it can
  never leave the rigid phases. So J18's "some other one-sided swaps keep the tail in its own phase" is explained: those are exactly the
  relabellings.
- **But proper strand swaps of rigid periodic points do not in general leave the rigid phases:** over all 17 rigid phases of the
  control, the 170 single-strand swaps land 120 times in a rigid phase and 50 times in 57 (`tools/crunch_j19_frozen.py`). The 52 wall
  instances are special. (My first positive control asserted "all proper swaps → 57"; it failed on the true tool, which is how this was
  found; the control was replaced by two facts not computed by the tool — §2.6, and the slip is logged in §3.)

### 2.3 Theorem J19-KC — Kempe closure in an all-rigid shift [hand]

Let `D` be finite and `X = X₄(D)` all-rigid. A **Kempe move** on `c ∈ X` swaps the two colours on one whole component of one two-colour
subgraph `H_c^{ef}`; it gives a point of `X`, and it does not change the components of `H^{ef}`. The **Kempe class** of `c` is the set of
points reached by finitely many Kempe moves.

1. `Per(X)` is finite; every two-colour component (*strand*) of a periodic point is two-sided infinite and invariant under `σ^N`, where
   `N` is the least common multiple of the least periods in `Per(X)`.
2. The Kempe class of a periodic point consists of periodic points; so it is finite.
3. The Kempe class of a non-periodic point consists of non-periodic points.
4. Every non-periodic point of `X` is a wall point whose two tails lie in **different labelled phases**; so this holds for every point
   in the Kempe class of a wall point.

*Proof.* (1) Finitely many phases, each one orbit (F3 c); strands are two-sided and cross every cut (K0-loc b, c). A strand `S` crosses
the cut at 0, so it meets `[−m, 0)`: at most `m` strands per pair, permuted by `σ^P` (`P` the period), so `S` is `σ^{Pr}`-invariant for
some `r ≥ 1`, and the swapped point `p_S` is `Pr`-periodic, hence in `Per(X)`, hence `N`-periodic. If `σ^N S ≠ S`, then for `y ∈ S`,
`y + N ∈ σ^N S`, a different strand, so `p_S(y + N) = p(y + N) = p(y) ≠ p_S(y)`: not `N`-periodic. So `σ^N S = S`. (2) By (1) a Kempe
move on a periodic point gives a periodic point; induct. (3) If a move on `c` gave a periodic `c′`, then `c` is a move on `c′` (same
components), periodic by (2). Induct. (4) A non-periodic point's path meets two SCCs (F3 c); its tails are periodic points `p′` of
rigid phases `C₁ ≠ C₂`. If `C₂ = gC₁` for a colour permutation `g`, the wall `C₁ → gC₁` and its images under `g, g², …` give a closed
path `C₁ → gC₁ → ⋯ → g^{ord g}C₁ = C₁` (reachability is transitive), so `C₁` and `gC₁` are one SCC, and the point has both tails in
one rigid SCC and is periodic (F2): a contradiction. ∎

**What it gives.** In an all-rigid shift, the tail pairs `([left], [right])` of the Kempe class of a wall point avoid the diagonal of
the (finite) set of labelled phases. **So A-T1 follows from any lemma that reaches the diagonal by Kempe moves** — the weakened form of
KE named in §2.8.

### 2.4 Theorem J19-ENDS — the ends partition of a wall point [hand; tools exact on the control]

Let `c ∈ X₄(D)` agree with `p` on `(−∞, a)` and with `q` on `(b, ∞)`, where `p` and `q` are periodic points all of whose two-colour
components are two-sided infinite (for instance points of rigid phases, by K0-loc). Fix a pair `{e, f}`. Then:
1. **(one-endedness)** for each `{e,f}`-strand `S` of `p` there is exactly one component of `H_c^{ef}` that contains `S ∩ (−∞, t)` for
   some `t` (its *left end*); the left-unbounded components are exactly the components holding a left end, and they partition the
   strands of `p`. Likewise on the right.
2. every finite component of `H_c^{ef}` meets `[a − m, b + m]`;
3. swapping a component whose left ends are the strand set `A` and right ends `B` gives a point that agrees with `p_A` on a left
   half-line and with `q_B` on a right half-line (`p_A`: `p` with the strands in `A` swapped).

*Proof.* (1) `S` is connected and `σ^{P′}`-invariant (`P′` a multiple of `p`'s period). Pick `v₀ ∈ S` and a finite connected `W ⊆ S`
containing `v₀`, `v₀ + P′`, and a path in `S` from `v₀` to each vertex of `S ∩ [v₀, v₀ + P′)`; let `w = max W − v₀`. Consecutive
translates `W + jP′`, `W + (j+1)P′` share `v₀ + (j+1)P′`, so `U_J = ⋃_{j ≤ −J} (W + jP′)` is connected, contains `S ∩ (−∞, v₀ − JP′)`,
and lies in `(−∞, v₀ − JP′ + w]`. For `J` with `v₀ − JP′ + w < a − m`, `c = p` on `U_J` and on all its neighbours, so `U_J` is a
connected subgraph of `H_c^{ef}`. Any left-unbounded component contains vertices left of every strand's threshold, each in some
strand's `U_J`. (2) A component missing `[a − m, b + m]` lies on one side of it (edges are shorter than the interval), where `c` equals
`p` (or `q`) on the component and its neighbours; so it is a component of `H_p` (or `H_q`), infinite. (3) Immediate from (1). ∎

On the control the partitions are computed exactly (`data/m3/j19/ends-*.txt`); the tool asserts (1) at every run (a strand splitting
among components of `c` in the far-left region aborts it).

### 2.5 Theorems J19-FRZ, J19-KEF, J19-TW [hand]

Call a periodic point **Kempe-frozen** if each of its six two-colour subgraphs is connected (one strand per pair).

**J19-FRZ.** If `c` is a wall point whose tails `p`, `q` are Kempe-frozen, then every point in the Kempe class of `c` has tails that are
colour relabellings of `p` and of `q`. *Proof.* By J19-ENDS each pair has one left end and one right end, so an infinite component is
through (both ends: swapping relabels both tails by `(ef)`) or one-sided and total (relabels one tail); finite components do not touch
the tails. A relabelling of a frozen point is frozen; induct along the Kempe sequence. ∎

**J19-KEF (KE is false on a named class).** KE fails at every rigid–rigid wall point `c` all of whose one-sided components are total —
in particular at every rigid–rigid wall point whose two tails are Kempe-frozen. *Proof.* Swapping a total one-sided component turns
its tail `p` into `(ef)∘p`, a periodic point of the rigid phase `(ef)·C`, which is a single cycle; so no one-sided swap satisfies KE2. ∎
So **KE implies KE♯: "in no `X₄(D)` does a rigid–rigid wall join two Kempe-frozen periodic points"** — entropy elsewhere allowed. KE♯ is
a statement J18's route needs and does not mention. It is **not** refuted here: I know no rigid–rigid wall between frozen points (the
control's walls all have a five-strand pair on each side), and I did not search for one (would-have-searched W2).

**J19-TW (chirality and twin walls).** For a phase `C`, its mirror `C̃` is the SCC of the mirrored windows (mirroring reverses edges, so
it maps SCCs to SCCs); `C` is achiral if `C̃ = gC` for some colour permutation `g`. In every `X₄(D)`: (a) a wall `C → C′` has a chiral
end (FS79-T34's rank-one core, re-derived: two achiral ends give `C′ →* hC` and the orbit cycle); (b) if one end is achiral, a **twin
wall** exists — a wall from a chiral phase `E` to `gẼ` (if `C` is achiral, `C̃′ → gC → gC′` with `E = C̃′`; if `C′` is achiral,
`C → C′ → g′⁻¹C̃`). *Proof:* mirror the wall point; compose walls through the middle phase (reachability is transitive). ∎
With (b), every all-rigid counterexample to A-T1 either contains a twin wall or has all its walls between two chiral phases that are
not mirror images of each other's relabellings — the two shapes the control shows side by side (§2.2).

### 2.6 The one exact check: `X₄({2,6,11,13,14})` — C0-6 lost, conjecture AF false

`tools/crunch_j19_frozen.py 2,6,11,13,14` (`data/m3/j19/frozen-2-6-11-13-14.txt`; 2.0 s CPU; registration §1.5). Positive control on
`{1,5,7,10}` against two facts the tool does not compute (the period-4 phase's strand counts `{0,2}: 5, {1,3}: 5`, others 1, derived by
hand: the only distance `≡ 2 (mod 4)` is 10, so the even positions split into the five classes mod 10; and J18's datum that a
`{0,3}`-swap of phase 65 lands in 57): passes. Plant (the swap skipped): fires, on (b) only, as it should.

**Result.** All 94 phases rigid, no wall (FS-79's numbers reproduced). **Every one of the 94 rigid periodic points is non-frozen**: each
has one complementary couple of pairs with **6 strands** each (periods 4, 8, 12, 24; 46 of the 94 phases chiral). **Every single-strand
swap lands in a rigid phase** (0 of the swaps leave the rigid phases — J19-KC (1–2) seen to hold on an independent computation), no swap
returns to its own labelled phase, **the single-strand swap graph on the 94 phases is connected**, and **every chiral phase is
Kempe-connected to its mirror.**
- **C0-6 (all frozen, 0.35): lost.** Conjecture AF ("all-rigid ⟹ every periodic point frozen") is **false**.
- **What it says about the step.** The richest all-rigid shift we hold has none of the frozen structure that makes Kempe moves inert, a
  connected Kempe family of rigid phases, chiral phases with their mirrors in the same Kempe family — and no wall. So wherever the
  evidence for A-T1 lives, it is not in the frozen class; and a Kempe-transport argument (§2.8) has, on this example, all the room it
  could want on the periodic side. What it lacks is a handle on the wall point itself: which Kempe moves a wall's ends partitions permit.

### 2.7 Theorem J19-BIN — for `D ⊇ {1, 2}`, the colouring shift is a binary return-time shift [hand]

If `1, 2 ∈ D`, every three consecutive colours are distinct, so each `c(y)` is either `c(y − 3)` (letter **R**) or the colour missing
from `c(y−3), c(y−2), c(y−1)` (letter **N**). The word `w(y − 1) ∈ {R, N}` is a sliding block code of `c`, and `c` is recovered from `w`
and one rainbow triple: `X₄(D)` is a 24-to-1 extension of a binary shift `Y(D)`.
- **The constraint.** Read `w` leftwards from `y − 1` with the automaton on `{1,2,3,4}` started at 3: `3 —R→ 1`, `3 —N→ 4`, `4 —R→ 4`,
  `4 —N→ 1`, `1 → 2 → 3` on either letter. It is at 3 after `t` letters iff `c(y − t) = c(y)`. So **`Y(D)` is the set of binary words in
  which, from no position, the leftward automaton returns to 3 at a time in `D`**; the same-colour gaps are 3 (an R) or `4 + k` (a block
  `N R^k N` read leftwards). Small distances in the language of words: `3 ∈ D` ⟺ no R (then `Y = {N^∞}`, the `K₄` chain); `4 ∈ D` ⟺ no
  `NN`; `5 ∈ D` ⟺ no `NRN`; `6 ∈ D` ⟺ no `R??R` and no `NRRN`; `7 ∈ D` ⟺ no `NN??R`, `R??NN`, `NRRRN`.
- **What transfers.** Colour permutations fix `w`; mirroring `c` reverses `w` (`w̃(x) = w(1 − x)`); the labelled quotient of `X₄(D)`
  is the window graph of `Y(D)` (an `m`-word up to relabelling is its letter word of length `m − 3`), so by A-Kq (labelled) phases,
  rigidity and walls of `X₄(D)` are those of `Y(D)`. **A-T1 on this class is: "a binary return-time shift `Y(D)` whose periodic points
  are all isolated in their SCCs has no heteroclinic point."** A-K1 on this class: some `d ∈ D` is a multiple of 3 (else `R^∞`, the
  three-colouring `x mod 3`, lies in `Y(D)` with a free fourth colour).
- *Proof.* `c(y+1) ∉ {c(y−1), c(y)}` leaves `c(y−2)` or the missing colour; the automaton tracks, reading leftwards, where the colour
  `c(y)` sits in the moving window `(c(x−2), c(x−1), c(x), missing)`: an R rotates the first three slots, an N all four. ∎
Not used further here; it is the concrete model in which the §2.8 step can be attacked on a subclass (stub proposed, §3.4).

### 2.8 The step: where it stands, and the sharper named obstruction

**No proof of A-T1, no counterexample** (C0-1, C0-2 not met). What this job adds to J18's KE:

1. **KE is false on a named class** (J19-KEF): at every rigid–rigid wall whose one-sided components are all total — in particular one
   between Kempe-frozen tails. KE therefore needs KE♯, which nobody has proved. C0-4 (KE refuted by a derived *instance*) is not met;
   what is met is a derived *class* on which KE fails, whose non-emptiness is open.
2. **KE's first half must be KE1′, not KE1.** A total one-sided component (all strands of its tail) only relabels the tail, so KE1 is
   satisfiable uselessly; the content is **KE1′: "some two-colour component of `c` is bounded on exactly one side and its ends are a
   proper subset of that tail's strands."** On the control, every one of the 52 proper one-sided swaps sends its tail out of the rigid
   phases, and every one of the 10 total ones keeps it (§2.2).
3. **The sharper obstruction — KT, the Kempe transport lemma:** *"Let `c ∈ X₄(D)` agree with a periodic point of a rigid phase `C` on a
   left half-line and with a periodic point of a rigid phase `C′ ≠ C` on a right half-line. Then finitely many Kempe moves turn `c` into
   a point whose two tails lie in one labelled phase, or into a point one of whose tails lies in a phase that is not a single cycle."*
   - **KE ⟹ KT** (one move, the second alternative), and **KT ⟹ A-T1** (J19-KC (4): in an all-rigid shift both alternatives are
     impossible). KT is strictly weaker than KE as a statement: it allows many moves and a second exit.
   - **KT still fails at frozen-tailed walls** (J19-FRZ: Kempe moves only relabel their tails), so **KT ⟹ KE♯**. Hence **A-T1 splits as
     FW ∧ A-T1ⁿᶠ**: FW, "no all-rigid `X₄(D)` has a wall between Kempe-frozen periodic points", is the part of A-T1 that *no* argument
     by Kempe moves can reach and needs a different invariant; A-T1ⁿᶠ, the rest, is where KT acts, and §2.6 shows the periodic side of
     an all-rigid shift can give KT a connected Kempe family to move in.
   - **The missing step, named:** for a rigid–rigid wall with a non-frozen tail, **show that the ends partitions (J19-ENDS) of the
     points in its Kempe class allow the two tails to be moved into one Kempe orbit of labelled phases**; J19-KC turns that into A-T1.
     I could not prove it: a through component moves both tails at once, and I found no quantity that proper one-sided moves decrease.


---

## Stage 3 — SAVED (the claims, the reviewer's view, C0 scored, proposals)

### 3.1 The claims (verdicts; grades per `CLAUDE.md` § Notation)

| claim | verdict | grade | where |
|---|---|---|---|
| **A-T1 (R2)** | **GAP** at the step named in §2.8 item 3 ("the ends partitions of the Kempe class move the two tails into one Kempe orbit of labelled phases"); split exactly as FW ∧ A-T1ⁿᶠ | — | §2.8 |
| **KE** (J18) | **FALSE on a named class** (every rigid–rigid wall whose one-sided components are all total, e.g. between Kempe-frozen tails); whether that class is non-empty is open (KE♯). KE's first half should read **KE1′** (proper one-sided components) | hand | §2.5, §2.8 |
| KT ⟹ A-T1; KE ⟹ KT; KT ⟹ KE♯ | TRUE | hand | §2.8 |
| J19-KC, J19-ENDS, J19-FRZ, J19-KEF, J19-TW, J19-BIN | TRUE | hand (ENDS also tools exact on the control) | §2.3–§2.7 |
| J19-CTL | TRUE on the one control | tools exact | §2.2 |
| conjecture AF ("all-rigid ⟹ periodic points frozen") | **FALSE** (94 of 94 non-frozen in `X₄({2,6,11,13,14})`) | tools exact | §2.6 |
| `[EggletonErdosSkilton1985]` bears on R2 | FALSE (nothing on periodicity); the 1990 paper still needed | read | §2.1 |

### 3.2 What someone who trusts none of this must check (in order of evidential value)

1. **J19-KEF** (§2.5), two lines: a total one-sided component's swap is a colour relabelling of its tail, and a relabelling of a
   periodic point of a single-cycle phase is a periodic point of a single-cycle phase. This is the whole of the finding about KE.
2. **J19-KC (4)** (§2.3): the orbit-step cycle and F2. It is what makes KT imply A-T1.
3. **J19-ENDS (1)** (§2.4): the one-endedness of a periodic strand's left tail (the translates `W + jP′` chain up). Everything about
   "ends" rests on it; `tools/crunch_j19_ends.py` asserts it on every run.
4. **J19-CTL's exact match** (§2.2): rerun `python3 tools/crunch_j19_ends.py 1,5,7,10 i j` for the nine walls and compare the total/proper
   classes with `data/m3/j18/swaptail.txt` (62 rows: 10 rigid = the 10 total, 52 NONRIGID = the 52 proper). `--plant` fires.
5. **J19-AF✗** (§2.6): `python3 tools/crunch_j19_frozen.py --control` (passes against two facts the tool does not compute), `--plant`
   (fires on the swap fact only), then `python3 tools/crunch_j19_frozen.py 2,6,11,13,14` (2 s).
6. **J19-BIN** (§2.7): run the automaton by hand on `N^∞` (returns every 4), `R^∞` (every 3) and `(RN)^∞` (returns at `0, 3, 5 mod 8`,
   the colouring `03213012` repeated).
7. J19-TW, J19-FRZ, J19-KC (1–3): short hand arguments.

**Not load-bearing:** the mirror table (§2.2, first bullet) is description; the factoring through 57 is read off J18's wall list.

### 3.3 C0 scored

| id | prediction | prior | outcome |
|---|---|---|---|
| C0-1 | proves A-T1 | 0.08 | not met |
| C0-2 | a counterexample to A-T1 | 0.05 | not met (no construction attempted beyond the class analysis; the one exact check was spent on AF) |
| C0-3 | a sharper named obstruction, or A-T1 on a named subclass | 0.80 | **met** as an obstruction: KT (weaker than KE, still implies A-T1), and the split A-T1 = FW ∧ A-T1ⁿᶠ with FW out of reach of every Kempe argument; no subclass proved |
| C0-4 | KE refuted by a derived argument or instance | 0.10 | **half met**: refuted on a derived class; no instance (the class's non-emptiness, KE♯, is open) |
| C0-5 | the control's rigid–rigid walls are twin-family walls | 0.6 | **met** |
| C0-6 | the 94 rigid points of `X₄({2,6,11,13,14})` are all frozen | 0.35 | **lost** (0 of 94) |

### 3.4 Proposals for the front-page lane (not made here)

- **`BIBLIOGRAPHY.md`:** a row `[EggletonErdosSkilton1985]` — Eggleton, Erdős, Skilton, "Colouring the real line", J. Combin. Theory Ser. B 39
  (1985) 86–100; held at `~/source/library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf`; read: §§1, 2, 6, 7 (to Thm 16), 8 in
  full, §§3–5 theorem statements only; bears on FS-76's rank one only as the origin of `G(ℤ, D)`; says nothing on periodic colourings.
  The `[EggletonErdosSkilton1990]` row stays "not held" — **still needed** for its Theorem 2.
- **J18's record (for its owner, not edited here):** KE's first half is better stated as KE1′ (proper one-sided components); total ones are
  relabellings (J19-CTL explains J18 §3.3's last bullet).
- **Stub to mint or fold into FS-76's rank-one stub — "FW: walls between Kempe-frozen periodic points"**: the part of A-T1 no Kempe
  argument reaches (J19-FRZ). First question, by derivation: is there any `X₄(D)` (entropy allowed) with a rigid–rigid wall between
  frozen points (KE♯)? A yes refutes KE outright; post-ban, a construction may be checked.
- **Stub — "A-T1 on `D ⊇ {1,2}` in the binary return-time model"** (J19-BIN): a binary SFT question with an explicit forbidden-word
  automaton, where zero entropy and walls can be read off letter patterns; the natural subclass on which to try KT or a direct proof.
- **FS-76's provisional-bearings line:** J19-KC, J19-KEF, J19-AF✗ (all-rigid shifts are Kempe-rich, not frozen).

### 3.5 The would-have-searched log (continued)

| # | move I would have made by search | what I did instead |
|---|---|---|
| W2 | search `D` for a rigid–rigid wall between Kempe-frozen periodic points, to instantiate J19-KEF and refute KE outright | stated the class and KE♯ by derivation; left open |
| W3 | sweep `D ⊇ {1,2}` through the binary model for all-rigid shifts with walls | derived the model (J19-BIN) only |
| W4 | run the strand tool over all 377 all-rigid sets of the FS-79 scan to test AF broadly | one `D`, chosen by a stated rule before the run (§1.5), at the ban's edge |
| W5 | search Kempe sequences from a control wall point toward the diagonal (to test KT beyond one move) | none needed on the control (KE's one move already exits the rigid phases 52 times); KT left as a lemma |

### 3.6 Slips (mine)

1. Read two passages the brief withheld (K0-loc's proof; §3.5's "Routes tried and dropped") through over-wide `sed` ranges (§1.1).
2. A positive control that asserted a false claim ("every proper strand swap of a rigid point lands in 57"); caught because it failed on
   the true tool; replaced by two facts the tool does not compute (§2.2, §2.6). Had it passed, its plant's firing would have proved
   nothing.
3. The §1.5 registration's commit lost a git-lock race; the run preceded its commit by seconds (order of tool calls attested only).
