# FS-91 Stage 1, job J12 — one prime: ONE-a (U3), ONE-b (`MS₄({5})`), ONE-c (U5)

*The derivation agent's record (de Bruijn, Opus 5.5), crunch of 2026-09-25, from the brief
`data/crunch-2026-09-25/briefs/J12-M1-one-prime.md` and `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. Data under
`data/fs91/j12/`; tools `tools/crunch_j12_*.py`. No finite-witness search (the ban to 2026-10-01); exact arithmetic only.
My blind verifier is J13; nothing here is addressed to it.*

## Stage 1 — SAVED (quotation check; C0)

### 1.1 Quotation check (every statement the brief quotes, against its source; read from disk 2026-09-25)

| # | the brief's text | source | result |
|---|---|---|---|
| Q1 | ONE-a: "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`." | `plans/FS91-character-local-global.md` line 472 | **verbatim** |
| Q2 | ONE-b: "Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?" | same file, line 473 | **agrees**; the source carries it unquoted, the words identical |
| Q3 | ONE-c: "Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each member checked by an exact finite computation; never a list extended in search of a pattern." | same file, lines 474–475 | **verbatim** |
| Q4 | §M.2: "a minimal set meeting `T + A` is a leaf circle, so a counterexample is a switching character with bounded run lengths in both directions that is uniformly recurrent; the obligation is whether S0B-T5's tree admits switches at bounded gaps." | same file, lines 559–561 | **verbatim** (the source's sentence begins "ONE-b reduces to one construction and one lemma:") |
| Q5 | U3's source: "`RS₄({p})` fails for every single prime `p ≡ 1 (mod 4)`, by S0B's lens (the parity and order-3 discs meet, `√2/6 < 1/4`, independently of `p`)." and "Only `p = 5` is proved (FS89-S0B-T3)" | `plans/FS89-rational-band-rigidity.md` §0.3, lines 66–67 | **verbatim** (the source writes "(S0B-T3)") |
| Q6 | "the step rule `e_{m+1} − w̄_p e_m ∈ π_p^{−1}ℤ[i]` depends on `p`, the lens does not" | the brief's own gloss of §M.2 line 558–559 ("the lens `√2/6 < 1/4` is `p`-free, the step rule is not") | **agrees in content**; not a quotation |
| Q7 | "Berend's Lemma 3.3 (`[Berend1984min]`) says one parameter always has minimal sets of positive dimension" | `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf` p. 502, Lemma 3.3 ("Σ is not a one-parameter semigroup") | **agrees with a scope note**: the proof builds, for a *hyperbolic* toral `σ`, an `S(σ)`-minimal set of positive Hausdorff dimension from a minimal subshift of exponential complexity; non-hyperbolic `σ` is Lemma 3.1's case (minimal ellipses). It is about the whole torus, never about minimal sets **inside a band set** — so it does not by itself answer ONE-b |
| Q8 | "`torsion-points-k4-N130.txt`: 12 orders below 130, a finite measurement" | `plans/FS89-S0B-band-set.md` §4, S0B-L4 | **agrees** |
| Q9 | "D predicts `MS₄({5})` false (0.75)" | `plans/FS89-S1D-derivation.md` line 18 | **agrees** ("false (a uniformly recurrent switching family, Berend's Lemma 3.3 shape) \| 0.75") |
| Q10 | the advisor: "as complete enumerations fixed by a derivation, and logged" | `plans/POROS-2026-09-25-crunch-plan.md` line 130 | **verbatim** (the source: "briefed as complete enumerations fixed by a derivation, and logged") |
| Q11 | the owner's news items 1–3 (J01-7 verified; CLG verified with J10's g3 GAP; J08's counts verified) | the owner's launch message | taken as given; none is load-bearing below except where cited |

No quotation in the brief is wrong. One scope note (Q7) is carried into Stage 3.

### 1.2 C0 — predictions, written before any written derivation or tool

*Honest timing: written after reading the sources in full and about fifteen minutes of thought, in which sketches of ONE-a and ONE-c
occurred to me; the sketches are named so the probabilities can be scored against what they knew.*

| id | statement | probability | basis at the time of writing |
|---|---|---|---|
| C0-a | ONE-a holds at **every** `p ≡ 1 (mod 4)`, no exceptions | **0.93** | sketch: glue `τ₃` on `S₊ = ℤ[i][1/π̄_p]` to `θ₂ + λ_{C−P}` on `S₋ = ℤ[i][1/π_p]`; the margins 1/4 and 1/12 look `p`-free because 3 is inert (`U_p mod 3 ⊆ μ₄`); the step rule is never crossed. Risk: a slip in the pushout or in the margin of `X₃` at some `p` |
| C0-b | ONE-b answered **"no"** (a non-`T + A` minimal set exists) | **0.55** | Berend's shape and a positive-entropy set argue for it; the isometric archimedean direction (piecewise rotations have zero entropy, Buzzi) argues against it |
| C0-b′ | ONE-b **decided** (either way) in this job | **0.25** | it is a minimal-set question for a piecewise-rotation correspondence; expected outcome GAP with the obligation sharpened |
| C0-b″ | §M.2's reduction survives the check unchanged | **0.30** | its "switching character" presupposes a classification of `Θ₄(R₅)` by the parity and `X₃` leaves that S0B did not prove |
| C0-c | ONE-c answered **"unbounded"** by a derived infinite family | **0.80** | sketch: a closing lemma for the isometric orbit model (a segment returning near its start, with `ω^L` far from 1, closes to a periodic orbit = a band torsion character); the parity/`X₃` switching words should supply infinitely many |
| C0-c′ | the family is the advisor's (primes dividing `Φ_k(w₅)`) | **0.35** | the closing lemma's orders divide norms of `1 − ω^L`, i.e. of `Φ_k(ω)`, `k ∣ L`, so the pointer and a two-parameter family may coincide in the primes |

## Theorems this phase proved

*(filled stage by stage)*

## Would-have-searched-here log

*(filled stage by stage)*
