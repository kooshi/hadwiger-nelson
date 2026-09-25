# M3 S1A — FS-76 in rank one: every phase rigid ⟹ no wall? (crunch job J18, derivation)

*de Bruijn (Opus 5.5), 2026-09-25, from `data/crunch-2026-09-25/briefs/J18-M3-rank-one-derivation.md` (with `STANDING-RULES.md`).
The owner reviews by artifact; J20 verifies blind (not read, not messaged). Stages saved as they close.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, address)*

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
