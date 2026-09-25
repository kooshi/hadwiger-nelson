# M3 S1A — FS-76 in rank one: every phase rigid ⟹ no wall? (crunch job J18, derivation)

*de Bruijn (Opus 5.5), 2026-09-25, from `data/crunch-2026-09-25/briefs/J18-M3-rank-one-derivation.md` (with `STANDING-RULES.md`).
The owner reviews by artifact; J20 verifies blind (not read, not messaged). Stages saved as they close.*

## Theorems this phase proved

*(one line per theorem, grade, address; filled at each stage)*

| id | statement (one line) | grade | address |
|---|---|---|---|
| J18-F3 | one-dimensional SFT facts: some phase not a single cycle ⟹ `h > 0`; all single cycles ⟹ `h = 0`, `X` countable, and (wall ⟺ `X` infinite) | hand (standard) | §2.0 |
| J18-K0loc | a periodic point of a rigid phase is gap-free, its Kempe components are two-sided infinite and cross every cut, its `m`-windows carry `≥ k − 1` colours (⟹ A-K0) | hand | §2.1 |
| J18-K0H | the rank-one form of FS86-dB-H with two-sided gap-freeness is false (T30's rigid–rigid walls) | hand + FS-79 tools | §2.1 |
| J18-AK1 | A-K1 | hand | §2.2 |
| J18-AK2 | A-K2, and a wall leaves a phase only at a left gap whose second colour survives | hand | §2.3 |
| J18-AKq | A-Kq for the labelled quotient; its rigidity clause false for the plain quotient (`D = {1}`) | hand | §2.4 |
| J18-EQ | A-T1 ⟺ A-T1′ ⟺ A-T2 (T35 re-derived) ⟺ A-K3; and route (ii)'s potential exists on all-rigid shifts iff A-T1 | hand | §2.5, §3.1 |
| J18-DC | the Δ-completion theorem: A-T1 fails iff some heteroclinic four-colouring `c` has an all-rigid `X₄(D_c(M))` | hand | §3.2 |
| J18-CTL | the control `{1,5,7,10}` reproduced (18/17/15); `χ = 3`; 8 of 9 BFS wall points have trivial completion to `M = 100`; all 9 satisfy KE | tools exact | §3.3, `data/m3/j18/` |
| J18-DPR | `X₄({1,5,7,10,13,27,33})`: 25 phases, 24 rigid, one non-rigid; one rigid–rigid wall, which satisfies KE | tools exact | §3.4, `data/m3/j18/completion-81-49-M40.txt` |
| J18-KE⟹ | KE ⟹ A-T1 | hand | §3.5 |

---

## Stage 1 — SAVED (the quotation check, C0, the EES attempt)

### 1.1 The quotation check (standing rule 5)

| # | quotation in the brief | source | result |
|---|---|---|---|
| Q1 | the definitions block "for finite `D ⊂ ℤ_{>0}`, `G(ℤ, D)` has vertex set ℤ … a derivation says which it uses." | `plans/M3-exotic-colourings.md` §S, "Definitions for Q1" | **verbatim** (whitespace-normalised string comparison, exact) |
| Q2 | the nine claims A-T1 … A-C | same file, §S, "Q1's target statements" | **verbatim** (whitespace-normalised string comparison of the whole list, exact) |
| Q3 | the FS-76 stub: "the rank-1 criterion is exact (T35: … ) — the cheapest open item here." | `plans/STUB-four-colour-inheritance.md`, "Re-aimed at FS-79's close", first bullet | **verbatim**; the stub's inner double quotes around *every phase rigid ⟹ no wall* are kept |
| Q4 | FS79-T35: "The exact rank-1 criterion at four colours: `P ≠ F` iff every cyclic phase of the window-state graph is a single cycle and a wall exists." | `plans/FS79-derivation.md` T35 heading | **verbatim** |
| Q5 | FS79-T34: "a counterexample to inheritance periodic in `r − 1` directions has two distinct rigid ends, at least one chiral, so never an additive end; with Coxeter's repair when `Λ/W` has torsion." | `plans/FS79-derivation.md` T34 heading | **verbatim** after the source's prefix "C2 (de Bruijn):" |
| Q6 | "the rank-1 walls are **FS73-T30** … FS79-T30 is a face-flux no-go, not an input" | `plans/FS73-derivation.md` T30 ("Rank-1 walls at four colours, and the wall criterion"); `plans/FS79-derivation.md` T30 (C4′) | **correct**: the brief's own correction of the launch message's slip holds |
| Q7 | EES review: "There are finite sets D for which there exists aperiodic proper colourings using only χ(D) colours" | zbMATH 0698.05033 (reviewer's review, K. Engel), read through the API today | **verbatim** (the review numbers it "3)"). **Context the brief omits:** the paper is about *prime* distance sets `D`, where `χ(D) ≤ 4` |
| Q8 | paraphrase: "FS-79 proved that a four-colouring separating a pair every periodic four-colouring identifies exists exactly when every phase is rigid and a wall exists (FS79-T35)" | T35 | faithful |
| Q9 | paraphrase: "a scan to `max D = 14`, `\|D\| ≤ 5` found none" | T36: "`11 ≤ max D ≤ 14`, `3 ≤ \|D\| ≤ 5`, gcd 1", with FS73-T30 below 11 | faithful in effect; the lower bounds are T36's (and `\|D\| ≤ 2` gives `χ ≤ 3`, hence entropy by A-K1, so nothing is lost) |
| Q10 | "`LEDGER.md` row 45 (the entropy floor, `EntropyFloor.lean`)" | row 45: "the entropy floor (a k-colourable graph on ≥ k·n vertices has ≥ 2ⁿ proper (k+1)-colourings, `two_pow_le_card_coloring`)" | correct |
| Q11 | "FS85-dB2 (`G(ℤ, D)`, `\|D\| = 70`, exactly 24 four-colourings) — `LEDGER.md` row 86: an all-rigid, wall-free inhabitant" | FS85-dB2: "every proper four-colouring is `x ↦ f(x mod 4)`, exactly 24 of them" | correct: `X₄(D)` is 24 period-4 points, so every phase is one cycle and there is no wall |
| Q12 | "FS86-dB-H (Theorem H …) — A-K2 is its rank-one form" | FS86-dB-H: "a proper colouring agreeing with a gap-free periodic colouring `γ` on `{h ≤ ε(z mod Q)}`, `h ≠ 0`, equals `γ`" | **only with a changed hypothesis.** Theorem H assumes `γ` gap-free (two-sided closed neighbourhoods); A-K2 assumes *left*-gap-free. The literal rank-one transcription with two-sided gap-freeness is **false**: FS73-T30's rigid–rigid walls leave gap-free periodic colourings (Lemma K0-loc, stage 2). Recorded so that no reader carries Theorem H's hypothesis into rank one |

No quotation in the brief is wrong. Two precisions are owed (Q7's prime context; Q12's hypothesis), both carried below.

### 1.2 C0 — registered before the derivation

*Disclosure (G21):* while reading the inputs I checked A-K0, A-K1 and A-K2 mentally and noticed a defect in A-Kq's one-line proof
(§M of the plan). The numbers below are therefore registered after that informal reading, not before any thought; the stage-2
proofs are the first written derivations.

| claim | P(true) | note |
|---|---|---|
| A-K0 | 0.97 | |
| A-K1 | 0.97 | |
| A-K2 | 0.98 | |
| A-Kq, labelled quotient (edges from `[w]` = the letters that extend `w`) | 0.90 | |
| A-Kq, plain quotient (edges = orbits of `(m+1)`-words) | 0.05 | `D = {1}` looks like a counterexample (stage 2) |
| A-T1′ ⟺ A-T1 (the equivalence) | 0.97 | standard one-dimensional SFT facts |
| A-T1 (R2) | 0.45 | 377 of 377 plus 11 of 11 are range-limited (G21): chirality, which T34 requires of a counterexample, needs complex phases, and those come from sparse `D` |
| A-T1′, A-T2 | 0.45 each | equivalent to A-T1 (A-T2 through T35) |
| A-K3 | 0.45 | **logically equivalent to A-T1**: A-K3 ⟹ A-T1 by T34's orbit step, and A-T1 makes A-K3 vacuous. So A-K3 is a *form* of the theorem, not a smaller obligation (stage 2 states this) |
| A-C (existence of such a `D`) | 0.55 | complement of A-T1 |
| J18 proves A-T1 this crunch | 0.10 | |
| J18 constructs and checks an A-C instance this crunch | 0.10 | |
| J18 stalls at a named step with A-K0, A-K1, A-K2 proved | 0.80 | the planner's P-A3 was 0.55 |
| P-A6 (EES's aperiodic colourings all sit in positive-entropy shifts) | not scorable this crunch | the paper is not reachable (§1.3) |

### 1.3 `[EggletonErdosSkilton1990]` — the attempt

- DOI **10.1007/BF01787476** (OpenAlex: title match, `oa_status: closed`).
- `rd.springer.com/content/pdf/10.1007/BF01787476.pdf` returns the article's landing page (HTML), not a PDF. Its abstract reads:
  "Four colours are necessary and sufficient to colour all the integers so that any two with difference equal to a prime have
  different colours. We investigate the corresponding problem when the set D of prescribed differences is a proper subset of the
  primes. In particular, we prove that if D contains {2, 3} and also contains a pair of twin primes (one of which may be 3), then four
  colours are necessary. Numerous results regarding periodic colourings are also obtained. However, the problem of characterizing
  those sets D which necessitate four colours remains open." The page says: "This is a preview of subscription content".
- **Recorded unread** (about five minutes spent; the ten-minute limit was not reached). The debt stays open. The route that works for
  closed Springer papers is Kooshi's browser (memory note on paper fetch routes); I name it for the owner, not attempted.
- **What the review's context already settles:** the sets are prime, so `2 ∈ D` or `D` is all odd. An all-odd `D` gives a bipartite
  connected graph (two colourings when gcd 1), so it has no aperiodic colouring. So EES's aperiodic examples have `2 ∈ D` and
  `χ(D) ∈ {3, 4}`. When `χ(D) = 3`, the four-colouring shift has positive entropy (A-K1), so those examples cannot be A-C. Only
  prime sets with `χ(D) = 4` and a zero-entropy four-colouring shift could be; whether EES's examples are of that kind is unread.

### 1.4 The would-have-searched log (opened)

| # | the move a search would have made | what was done instead |
|---|---|---|
| W1 | recompute the phases of T36's 377 all-rigid sets and classify them by chirality, to see whether the null ever sampled a chiral rigid phase | not run (a scan over many `D`); the question is kept as a reading in stage 3: T34 makes an all-achiral shift wall-free for free, so the null may measure achirality, not R2 |

---

## Stage 2 — SAVED (the local lemmas)

### 2.0 Setting and the one-dimensional facts used

`k ≥ 2` colours (the claims are at `k = 4`; every lemma below is stated for general `k` where it costs nothing), `D ⊂ ℤ_{>0}` finite,
`m = max D`, `X = X_k(D)`. `X` is a shift of finite type with window `m + 1`: a sequence `c ∈ [k]^ℤ` lies in `X` iff each of its
`(m+1)`-words is proper on its own positions, since every edge `{x, x + d}` (`d ≤ m`) lies in some window of length `m + 1`. `G̃` is the
window-state graph of the brief (vertices `L_m(X)`, edges `L_{m+1}(X)`, the edge `u` running from `u[0, m)` to `u[1, m + 1)`). Every
vertex of `G̃` has in- and out-degree ≥ 1, and `c ↦ (c[x, x + m))_{x ∈ ℤ}` is a bijection from `X` onto the bi-infinite paths of `G̃`
(the window property). A **phase** is a cyclic strongly connected component (SCC); **rigid** means a single cycle, equivalently (for a
cyclic SCC) every vertex has exactly one out-edge inside the SCC.

- **F1 [hand, standard].** A finite path whose first and last vertices lie in one SCC `C` lies in `C`.
- **F2 [hand].** Let `C` be rigid. If the path of `c ∈ X` is in `C` at times `s < t`, it follows `C`'s cycle between them (F1, and one
  out-edge per vertex inside `C`). Hence a point whose path lies in `C` for all `x ≤ 0` and returns to `C` at some later time agrees on
  `ℤ` with the periodic point `p` of `C` that it follows for `x ≤ 0`; in particular a point with both limit phases equal to a rigid `C`
  is a point of `C`'s periodic orbit.
- **F3 [hand; standard, Lind–Marcus §4.3–4.4, recalled, not re-read].** (a) If some phase is not a single cycle, `h(X) > 0`: a vertex
  `v` with two in-SCC out-edges carries two closed walks `γ₁, γ₂` at `v` with different first edges, of lengths `a, b`; the words in
  `{γ₁, γ₂}` decode uniquely (the first edge after each return to `v` names the block), so `|L_n(X)| ≥ 2^{⌊(n − m)/max(a,b)⌋}`.
  (b) If every phase is a single cycle, a path of length `n` is fixed by the sequence of SCCs it visits (a path in the condensation,
  which is acyclic: at most `2^s` choices, `s` the number of SCCs), its entry and exit times (at most `(n + 1)^{2s}`), and its entry
  vertices (at most `|G̃|^{s}`), because inside a single cycle it is deterministic and a non-cyclic SCC is one vertex visited once: so
  `|L_n(X)|` is polynomial, `h(X) = 0`, and `X` is countable. (c) If every phase is a single cycle: a point confined to one phase is
  periodic (one orbit per phase, finitely many), and a point visiting two phases crosses a wall; conversely a wall `C → C′` extends to
  bi-infinite paths (backwards round `C`, forwards round `C′`), one for each position of the crossing, pairwise distinct. So **given
  every phase rigid: a wall exists ⟺ `X` is infinite ⟺ `X` has a non-periodic point.**

### 2.1 A-K0, in a local form

**Lemma K0-loc [hand].** Let `p` be a periodic point of a **rigid phase** `C` (no hypothesis on the other phases). Then:
- (b) every two-colour Kempe component of `p` is infinite;
- (a) every closed neighbourhood `N[x] = {x} ∪ (x ± D)` carries all `k` colours;
- (c) every Kempe component of `p` is unbounded in both directions, so it has an edge crossing every cut `(t − 1 | t)`;
- (d) every `m`-window `p[t − m, t)` carries at least `k − 1` colours; at `k = 4`, at least three.

*Proof.* (b) Let `K` be a finite non-empty `{e, f}`-component. Swapping `e ↔ f` on `K` is proper (a Kempe swap) and changes every vertex
of `K`, so `p′ ≠ p`, and `p′ = p` outside a bounded interval. The path of `p′` is then in `C` for `x ≪ 0` and again for `x ≫ 0`, so F2
gives `p′ = p`: a contradiction. (a) If `N[x]` misses `e`, then `{x}` is a whole `{p(x), e}`-component (the neighbours of `x` avoid `p(x)`
by properness and `e` by hypothesis), finite, contradicting (b). (c) Let `L` be a period of `p`. The `{e,f}`-subgraph `H` is
`σ^L`-invariant, so `σ^L` permutes its components, and at most `L` components meet `[0, L)`. `K` is infinite by (b), so unbounded on one
side, say the right; then `σ^{−jL}K` meets `[0, L)` for infinitely many `j`, two coincide, and `K` is invariant under a non-zero shift,
hence unbounded on both sides. A connected graph with vertices on both sides of a cut has an edge crossing it. (d) By (a) `p` uses
all `k` colours. If `p[t − m, t)` missed two colours `e, f`, no `{e,f}`-edge would cross the cut at `t` (its left end lies in
`[t − m, t)`, since edges have length `≤ m`), contradicting (c). ∎

**A-K0 [hand]** follows (its hypothesis "every phase rigid" is stronger than K0-loc's).

**Corollary K0-H (a correction of the brief's gloss on Theorem H) [hand + FS-79 tools].** The rank-one transcription of FS86-dB-H with
two-sided gap-freeness is **false**: FS73-T30's sets carry walls between two rigid phases (FS79-C-deBruijn §3a: `{1,5,7,10}`,
`{3,5,9,10}`, `{3,7,9,10}`, `{5,7,9,10}`), the periodic point of the wall's left end is gap-free by K0-loc (a), and the wall point
agrees with it on a left half-line and differs from it. So in rank one, two-sided gap-freeness does not give unique continuation; only
the one-sided form (A-K2) does. **And rigid–rigid walls exist in four-colouring shifts:** R2 excludes them only through the *global*
hypothesis that no phase anywhere has entropy.

### 2.2 A-K1

**A-K1 [hand].** If every phase of `X₄(D)` is rigid and `X₄(D) ≠ ∅`, then `χ(G(ℤ, D)) = 4`.
*Proof.* `X₄ ≠ ∅` gives `χ ≤ 4`. If `χ ≤ 3`, then `X₃(D) ≠ ∅`, and its (finite, non-empty, essential) window graph has a cycle, so `X₃`
has a periodic point `p₃`. Read as a four-colouring, `p₃ ∈ X₄` is periodic, so its path is a closed walk, which lies in one phase of
`X₄`, rigid by hypothesis. But `p₃` never uses the fourth colour, so every `N[x]` misses it, against K0-loc (a). ∎ (A second route is
row 45's entropy floor: a periodic three-colouring's class of density `≥ 1/3` can be recoloured freely into the fourth colour, `h ≥ (log 2)/3`.)

### 2.3 A-K2

**A-K2 [hand].** Let `c ∈ X_k(D)` be **left-gap-free**: for every `x`, `{c(x − d) : d ∈ D} ∪ {c(x)}` is all `k` colours. If `c′ ∈ X_k(D)`
agrees with `c` on `{y < x₀}`, then `c′ = c`.
*Proof.* By properness `c(x) ∉ {c(x − d)}`, so `{c(x − d) : d ∈ D}` has exactly `k − 1` colours and `c(x)` is the one left. Induct on
`x ≥ x₀`: `c′(x) ∉ {c′(x − d)} = {c(x − d)}`, so `c′(x) = c(x)`. ∎
**Where a wall leaves [hand].** If a path of `G̃` leaves a phase `C`, its last vertex `w` in `C` has two out-edges (one along `C`, one
out), so two letters extend `w`; both avoid the letters at positions `m − d`, `d ∈ D`, so those positions carry at most `k − 2` colours:
the next colour is not determined by the window. Equivalently (F2): a wall leaves `C` iff some `c ∈ X` agrees with the periodic `p` of
`C` on a left half-line `(−∞, t)` and differs at `t`; then `p` has a left gap at `t`, and `c(t)` is a colour missing from `p`'s left
neighbourhood of `t` other than `p(t)`.

### 2.4 A-Kq — true for the labelled quotient, false for the plain one

Two readings of "its quotient by colour permutations": the **plain quotient** `G_pl` (vertices `L_m/S_k`, edges the `S_k`-orbits of
`(m+1)`-words) and the **labelled quotient** `G_lab` (vertices `L_m/S_k`; out of `[w]`, one edge for each letter `a` with `w·a ∈ L_{m+1}`,
`w` a fixed representative, to `[w[1,m)·a]`). `G_lab` is what FS-79's tool computes (`data/fs79/comp-debruijn/tools/rank1_phases.py`,
`build`: one edge per extending colour of the canonical word), so T35 and T36 are statements about `G_lab`.

**A-Kq (labelled) [hand].** Every phase of `G̃` is rigid iff every phase of `G_lab` is; a wall exists in `G̃` iff one exists in `G_lab`.
*Proof.* (i) *Lifting.* For `v = g·w`, the edge `a` of `[w]` lifts to the unique edge `v → v[1,m)·(g a)`; so the out-edges of `v` in `G̃`
are in bijection with those of `[v]` in `G_lab`, and every path of `G_lab` lifts from every lift of its start. (ii) *The orbit step.* A
path `v → g·v` in `G̃` gives `v → gv → g²v → ⋯ → g^{ord g}v = v`, so `gv` lies in the SCC of `v`. (iii) *SCCs.* `[v]`, `[w]` share an SCC of
`G_lab` iff `v` shares an SCC of `G̃` with some `g·w`: lift a path `[v] → [w]` from `v` (ending at some `gw`) and a path `[w] → [v]` from
`gw` (ending at some `hv`), then (ii). Cyclicity transfers the same way (lift a closed walk at `[v]` to `v → gv` and apply (ii)). (iv)
*Rigidity.* An edge `v → v′` of `G̃` stays in `SCC(v)` iff its image stays in `SCC([v])`: ⟹ by projection; ⟸ since `[v′] ∈ SCC([v])`
gives `v′ ~ gv` by (iii), so `v → v′ → ⋯ → gv` and (ii) puts `v′` in `SCC(v)`. With (i) the in-SCC out-degrees of `v` and `[v]` agree,
and a cyclic SCC is a single cycle iff every in-SCC out-degree is 1. (v) *Walls.* A wall `C → C′` in `G̃` cannot have `C′ = gC` (by
(ii) that would put them in one SCC), so by (iii) it projects to a wall `[C] → [C′]`; conversely a wall of `G_lab` lifts by (i) to a
path from `C` to some `gC′ ≠ C` (else `[C] = [C′]`), a wall. ∎

**A-Kq (plain) is false [hand].** `D = {1}`: `L_1 = {a, b, c, d}`, one orbit; `L_2` = the twelve words `xy`, `x ≠ y`, one orbit. `G_pl`
is one vertex with one loop: its only phase is a single cycle. `G̃` is the complete digraph on four vertices (out-degree 3), one phase,
not a single cycle (`h = log 3`). The **wall** clause does hold for `G_pl` (it depends only on vertices and adjacency, which `G_pl` and
`G_lab` share), and **`G_lab` rigid ⟺ `G_pl` rigid and every vertex of every phase carries at least `k − 1` colours** (a vertex with
trivial stabiliser has no two letters identified; conversely K0-loc (d) applies to the lifts, which are periodic-point windows).
*Where the planner's one-line proof (§M item 1) breaks:* "an edge's lift is determined by its source" fails exactly at vertices with
non-trivial stabiliser, i.e. windows with at most `k − 2` colours. **Correction owed** to `plans/M3-exotic-colourings.md` §M item 1 and to
the parenthesis "the claims below hold in either form": they hold for `G_lab`, and A-Kq's rigidity clause fails for `G_pl`.

### 2.5 A-T1′ ⟺ A-T1, and the others' logical places

- **A-T1 ⟺ A-T1′ [hand; F3].** Given A-T1: if `h(X) = 0` then every phase is a single cycle (F3 a), so no wall (A-T1), so `X` is finite
  (F3 c). Given A-T1′: if every phase is rigid then `h = 0` (F3 b), so `X` is finite, so no wall (F3 c). ∎
- **A-T2 ⟺ A-T1 [hand; T35, re-derived here].** T35 re-derived: if every phase is rigid and a wall exists, the finitely many periodic
  points have a common period `N`, so `Nℤ ⊆ P`, while a wall point is non-periodic, so `F = 0 ≠ P`; if some phase is not a single cycle,
  its periodic points `(γ₁^a γ₂)^∞` have unbounded least periods, so `P = 0 = F`; if every phase is rigid and there is no wall, every
  point is periodic and `P = F`. So `P ≠ F` iff every phase is rigid and a wall exists, and A-T2 is A-T1 for every `D`.
- **A-K3 ⟺ A-T1 [hand].** A-K3 ⟹ A-T1 by the orbit argument (the plan's §M, T34's step 5): walls `C → C′ → gC → gC′ → ⋯` close up since
  `S_k` is finite, putting `C` and `C′` in one SCC. A-T1 ⟹ A-K3 vacuously (no wall under the hypothesis). **So A-K3 is not a smaller
  obligation: it is the theorem in "reversal" form.** Its only value is as a route: a proof of A-K3 must construct, from a wall, a
  return wall (or reach a contradiction), and T30's rigid–rigid walls (K0-H) show that the construction must pass through a phase with
  entropy whenever one exists.

### 2.6 What the local lemmas give the hard step (forward to stage 3)

In an all-rigid shift: every periodic point is gap-free with all Kempe components two-sided and crossing every cut (K0-loc), every
window carries at least three colours (so `G̃ → G_lab` is a free quotient on phases), and a wall leaves `C` only at a left gap of its
periodic point where a second colour survives (A-K2). **Nothing so far uses `k = 4`**: K0-loc, A-K1 (with `k`), A-K2, A-Kq and the
equivalences hold for every `k`. At `k = 3` walls are excluded by FS73-T24 (density), a height argument with no analogue at four.

---

## Stage 3 — SAVED (the hard step: no proof, no counterexample; a stall at a named step, a reformulation, one derived killing test)

**Registered 2026-09-25, before the run (P-J18-DC):** the derived set `D′ = {1, 5, 7, 10, 13, 27, 33}` — the Δ-completion at `M = 40`
(twice the common period 20) of the BFS wall point from rigid phase 81 to rigid phase 49 of the control `X₄({1,5,7,10})` (§3.2) — has
**every phase rigid with probability 0.20** (which would be A-C, with the wall `81 → 49` surviving by construction), and a non-rigid
phase with probability 0.80. Both outcomes reachable: the wall and its two rigid ends survive by construction (§3.2), and nothing
forces the control's entropic phase to survive `13, 27, 33`. Priced first: 20,023 canonical proper words of length 33.

**Result of P-J18-DC (read after the run, `data/m3/j18/completion-81-49-M40.txt`):** 20,023 states; 25 phases, **24 rigid and one not**
(10,817 states); 3 walls, one of them rigid–rigid (`3637 → 96`, both ends chiral). The non-rigid outcome (0.80) happened; **A-C is not
landed**.

### 3.1 What A-K3 is, and what the two planned routes are

- **A-K3 ⟺ A-T1** (§2.5). So A-K3 is not a step below the theorem, and J19 should not be launched on it "as a step".
- **Route (ii), a reflection-invariant potential that strictly decreases along walls, is also the theorem itself.** Given a wall
  `C → C′`, reflection gives a wall `C′^R → C^R`, so such a potential gives `Φ(C) > Φ(C′) = Φ(C′^R) > Φ(C^R) = Φ(C)`. So its existence on
  all-rigid shifts is equivalent to A-T1. It cannot be read off the phase graph alone, because the control has walls; it must use the
  absence of entropy.
- **Route (i), a Kempe swap on a one-sided component,** is where the data below points. It is the stall's route (§3.5).
- **Where `k = 4` enters: nowhere yet.** Every lemma of stage 2 and the reformulation §3.2 hold for every `k`. At `k = 3`, walls are
  excluded outright (FS73-T24, density), whatever the rigidity. So P-A5 ("the proof holds for every `k ≥ 4`") is not reached.

### 3.2 The Δ-completion theorem: A-T1 as a statement about single colourings

For a colouring `c : ℤ → [4]` and `M ≥ 1`, let `D_c(M) = {d ∈ [1, M] : c(x) ≠ c(x + d) for every x}`: the distances up to `M` at which
`c` has no monochromatic pair. Then `c ∈ X₄(D_c(M))`, and `X₄(D_c(M))` is the smallest four-colouring shift of a distance graph with
`max D ≤ M` that contains `c`.

**Theorem J18-DC [hand].** A-T1 fails iff there are a four-colouring `c` of ℤ that is eventually periodic in both directions and not
periodic, and an `M ≥ 1` with `D_c(M) ≠ ∅`, such that every phase of `X₄(D_c(M))` is a single cycle.
*Proof.* (⟸) `c ∈ X := X₄(D_c(M))` is non-periodic, and every phase of `X` is rigid, so `c`'s path visits two phases (F3 c): a wall.
(⟹) Let `D` be all-rigid with a wall. Take a wall point `c`: it is non-periodic (F3 c), and eventually periodic both ways (its path ends
in single cycles). With `M = max D`, `D ⊆ D_c(M)`, so `X₄(D_c(M)) ⊆ X₄(D)`. A subshift of a zero-entropy shift has zero entropy, so every
phase of `X₄(D_c(M))` is a single cycle (F3 a). ∎
*What it does.* It removes `D`. A-T1 says: **every heteroclinic four-colouring of ℤ has a positive-entropy completion at every window**
(the completions shrink as `M` grows). A counterexample is one heteroclinic colouring whose completion is all-rigid. This is the
construction route for A-C, and it replaces "find `D`" by "find `c`".

### 3.3 The control `{1,5,7,10}`: what its rigid–rigid walls are made of (`tools/crunch_j18_phases.py`, `data/m3/j18/`)

- **Reproduced independently** (my code, not FS-79's): 583 states in the labelled quotient; 18 phases, 17 rigid, 15 walls
  (`data/m3/j18/controls.txt`, matching FS79-C-deBruijn §3a). The 9 rigid–rigid walls run from phases 65, 67, 81 to 23, 49, 55; all six
  end phases are **chiral** (period-20 words), as T34 requires.
- **`χ({1,5,7,10}) = 3`:** `1, 5, 7, 10 ≢ 0 (mod 3)`, so `x ↦ x mod 3` is proper. So the control's entropy is A-K1's (a three-colouring
  inside a four-colouring shift). **The wall junctions contain period-3 three-colour stretches** ("…0310310…", "…3213210…"): the walls
  pass through patterns of the entropic phase without entering it.
- **Completions (§3.2) of the 9 BFS wall points:** for 8 of them, `D_c(100) = {1,5,7,10}`, so their maximal shift at every `M ≤ 100` *is*
  the control. These walls cannot be separated from the entropy by adding any distance. This explains, for them, FS-79's observation that
  adding one distance killed every wall whenever it killed the entropy. The ninth (`81 → 49`) has `D_c(100) = {1,5,7,10} ∪ {n ≡ 7, 13 (mod 20) : 13 ≤ n ≤ 93}`.
- **Kempe swaps (`tools/crunch_j18_swaptail.py`, `data/m3/j18/swaptail.txt`):** in each of the 9 wall points, some two-colour Kempe
  component bounded on exactly one side (in the finite window; size ≥ 10) swaps to a tail in the **non-rigid** phase 57. Some other
  one-sided swaps keep the tail in its own phase (e.g. the `{2,3}` swaps of `65 → 23`).

### 3.4 The one derived check (registered above, before the run)

`D′ = D_c(40)` for `c` the BFS wall point `81 → 49` of the control: `D′ = {1, 5, 7, 10, 13, 27, 33}`. The choice of `M` was fixed by the
derivation: `M = 40` is twice the common period 20, the least window holding one representative of each new residue class mod 20
(`27 ≡ 7`, `33 ≡ 13`). It kills the mod-3 colouring (`27, 33 ≡ 0 (mod 3)`). **The result:** one non-rigid phase survives, and the
surviving rigid–rigid wall `3637 → 96` again has one-sided Kempe swaps landing in the non-rigid phase (2 of 2 pairs, 4 of 4 swaps). So:
**10 of 10 rigid–rigid wall points examined, in two shifts, satisfy KE below.** This measures one BFS wall point per wall, in two shifts
(G21).

### 3.5 The stall — the smallest statement I could not prove that implies A-T1

**KE (the Kempe–entropy lemma), verbatim:**
"Let `D ⊂ ℤ_{>0}` be finite, and let `c ∈ X₄(D)` agree with a periodic point `p` of a rigid phase `C` on a left half-line and with a
periodic point `q` of a rigid phase `C′ ≠ C` on a right half-line. Then some two-colour Kempe component of `c` is bounded on exactly one
side, and swapping its two colours gives a point whose tail on the unbounded side lies in a phase that is not a single cycle."

- **KE ⟹ A-T1 [hand]:** in an all-rigid shift no phase fails to be a single cycle, so no such `c` exists; every wall of an all-rigid
  shift joins two rigid phases, so there is no wall.
- **Its two halves.** **KE1:** "some two-colour Kempe component of `c` is bounded on exactly one side". **KE2:** "swapping it moves that
  tail out of the rigid phases".
- **Warnings for J19.** KE is *stronger* than A-T1: it constrains shifts that have entropy. It can be false while A-T1 is true. It is
  falsifiable on the controls without any search: a rigid–rigid wall point all of whose one-sided swaps keep both tails in rigid phases
  kills it. Swapping a one-sided component `K` turns the tail `q` into `q_I` (`q` with the `{e,f}`-strands `I` that `K` contains swapped). This is a
  periodic point, and in an all-rigid shift K0-loc makes it gap-free with two-sided strands. **So KE2 is a statement about which partial
  strand-swaps of a rigid periodic point stay rigid.** That is where the mechanism, if any, lives.
- **Routes tried and dropped (so J19 need not re-sample them).** (a) Push the departure right by swapping the `{p(0), c(0)}`-component of
  the departure vertex (vertex 0 has no left neighbour in that subgraph, in `p` or `c`). It works while the component is finite, and gives
  nothing when the component is infinite and reaches the left through the right. (b) A strand count across the junction per colour pair.
  No conservation law was found (T29: the only loop invariant at four colours is a relation's length parity, the same for every colouring).
  (c) Route (ii) (§3.1).
- **The counterexample-side step, for completeness:** "find a heteroclinic `c` with an all-rigid completion `X₄(D_c(M))`" (§3.2). The one
  derived attempt failed (§3.4). The control's other walls have trivial completions.

### 3.6 The would-have-searched log (continued)

| # | the move a search would have made | what was done instead |
|---|---|---|
| W2 | rerun the completion of `81 → 49` at `M = 60, 100` (the completion shrinks as `M` grows) | not run: one derived `D` only, with `M` fixed by the derivation before the run |
| W3 | test KE on FS73-T30's other three wall sets and the triangle-chain family | not run: only the named control and the one derived `D` were computed |
| W4 | enumerate non-BFS wall points of the control, to hunt one whose swaps all stay rigid (a KE falsifier) | not run; named in §3.5 as KE's killing test |
| W5 | scan sets near the control for an all-rigid completion (an A-C hunt) | not run; §3.2 turns A-C into a question about single colourings, for derivation |

---

## Stage 4 — SAVED (the claims, the reviewer's view, C0 scored)

### 4.1 The claim list (J20's fixed list, verdicts; grades per `CLAUDE.md` § Notation)

| claim | verdict | grade | address |
|---|---|---|---|
| A-T1 (R2) | **GAP at KE** (neither proved nor refuted) | — | §3.5 |
| A-T1′ | GAP (equivalent to A-T1; the equivalence proved) | hand | §2.5 |
| A-T2 | GAP (equivalent to A-T1 through T35, re-derived) | hand | §2.5 |
| A-K0 | **TRUE**, in the stronger local form K0-loc (one rigid phase suffices) | hand | §2.1 |
| A-K1 | **TRUE** | hand | §2.2 |
| A-K2 | **TRUE** | hand | §2.3 |
| A-Kq | **TRUE for the labelled quotient** (FS-79's tool's); the rigidity clause **FALSE for the plain quotient** (`D = {1}`); the wall clause true for both | hand | §2.4 |
| A-K3 | GAP: **logically equivalent to A-T1**, so not a smaller step | hand (the equivalence) | §2.5, §3.1 |
| A-C | **not landed**: one derived candidate, `{1,5,7,10,13,27,33}`, keeps a non-rigid phase | tools exact | §3.4 |
| J18-DC (new) | A-T1 fails iff some heteroclinic four-colouring has an all-rigid Δ-completion | hand | §3.2 |
| J18-KE⟹ (new) | KE ⟹ A-T1 | hand | §3.5 |
| J18-K0H (new) | the rank-one form of FS86-dB-H with two-sided gap-freeness is false | hand + FS-79 tools | §2.1 |

### 4.2 What someone who trusts none of this must check (in order of evidential value)

1. **F2** (§2.0): inside a single cycle a path is deterministic, so a point with both limit phases one rigid `C` is on `C`'s orbit.
   K0-loc, A-K1 and the Kempe half of everything rest on it.
2. **A-Kq (ii)–(iii)** (§2.4): the orbit step `v → gv ⟹ gv ∈ SCC(v)` and the SCC correspondence. The plain-quotient counterexample
   `D = {1}` checks by hand in a minute.
3. **J18-DC** (§3.2): the one non-trivial step is "a subshift of a zero-entropy SFT has only single-cycle phases", which is F3 (a) applied
   to the smaller shift's own window graph.
4. **The tools-grade rows** (J18-CTL, J18-DPR): `python3 tools/crunch_j18_phases.py --controls` reproduces FS-79's independent numbers
   for the control; `--plant` must print two FIRED lines. `python3 tools/crunch_j18_phases.py 1,5,7,10,13,27,33` gives the derived check
   in seconds. **Not load-bearing for any theorem:** the Kempe classification in `tools/crunch_j18_swaptail.py` reads "bounded on one
   side" off a finite window (about 1,450 positions on each side of the junction, periodic outside it). It is evidence for the stall only.
5. **Not claimed:** anything about `k ≠ 4` beyond the lemmas' stated generality; EES's examples (unread).

### 4.3 C0 scored

| C0 entry | registered | outcome |
|---|---|---|
| A-K0, A-K1, A-K2 | 0.97, 0.97, 0.98 | proved |
| A-Kq labelled / plain | 0.90 / 0.05 | proved / refuted (`D = {1}`) |
| the equivalences | 0.97 | proved |
| A-T1, A-K3, A-C | 0.45, 0.45, 0.55 | open |
| J18 proves A-T1 / constructs A-C / stalls with A-K0–A-K2 proved | 0.10 / 0.10 / 0.80 | the stall happened |
| P-J18-DC (non-rigid phase survives in `D′`) | 0.80 | happened |
| the planner's P-A1 / P-A2 / P-A3 / P-A4 | 0.25 / 0.10 / 0.55 / 0.10 | P-A3 happened |
| the planner's P-A5, P-A6 | 0.50 / 0.85 | not reached / not scorable (EES unread) |

### 4.4 Edits proposed for the front-page lane (not made here)

- `plans/M3-exotic-colourings.md` §M item 1 and §S's parenthesis "the claims below hold in either form": correct to "the labelled
  quotient; the plain quotient's rigidity clause fails (`D = {1}`)" (§2.4).
- The brief's "A-K2 is its rank-one form" (of FS86-dB-H): add "with *left*-gap-freeness; the two-sided form is false in rank one" (K0-H).
- FS-76's stub, rank-1 item: A-K3 is equivalent to R2; R2 is reformulated by J18-DC (a statement about single heteroclinic colourings)
  and reduced to KE; 8 of 9 BFS wall points of the control have trivial completions, which explains FS-79's "11 of 11".
- `BIBLIOGRAPHY.md` `[EggletonErdosSkilton1990]`: DOI 10.1007/BF01787476, closed access; abstract read from the publisher's page; paper
  still unread (ask Kooshi for a browser save).
