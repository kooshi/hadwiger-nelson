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

## Stage 2 — SAVED (ONE-a at every split prime)

**Verdict: ONE-a is TRUE at every prime `p ≡ 1 (mod 4)`, with no exceptions. [hand; tools exact at `p = 5, 13, 17, 29`]** The step
rule, which does depend on `p`, is never crossed by the construction: the character is glued from two half-rings, not from two orbits,
so nothing at the junction has to be checked.

*Notation.* `p = π π̄` in `ℤ[i]` (any choice of `π`), `w := π/π̄`, `R := R_{{p}} = ℤ[i][1/p]`, `U := ⟨i⟩ × ⟨w⟩` (§0.1 of the FS-89 plan:
the unit vectors of `ℚ(i)` with `p`-power denominators), `S₊ := ℤ[i][1/π̄]`, `S₋ := ℤ[i][1/π]`. `⟨c, x⟩ := Re(c̄ x)`; `λ_d := ⟨d, ·⟩ mod 1`;
`τ_c := ⟨c, ·⟩ mod 1` on `ℤ[i]` for `c ∈ ℚ(i)`, extended uniquely to `R` when its order is prime to `p`. `P := (1+i)/2`, `C := (1+i)/3`,
`θ₂ := τ_P`, `τ := τ_C`.

**Lemma A1 (the two halves).** `S₊ ∩ S₋ = ℤ[i]` and `S₊ + S₋ = R`; and `U ⊆ S₊ ∪ S₋`, with `iᵏwᵐ ∈ S₊` for `m ≥ 0` and `∈ S₋` for `m ≤ 0`.
*Proof.* `ℤ[i]` is a UFD and `π`, `π̄` are coprime, so an element with a `π̄`-power denominator and a `π`-power denominator is integral.
Write `1 = απ + βπ̄` (`α, β ∈ ℤ[i]`); expanding `1 = (απ + βπ̄)^{2n}` and dividing by `pⁿ = πⁿπ̄ⁿ`, each term has denominator a power of `π̄`
alone (exponent of `π` at least `n`) or of `π` alone, so `p^{−n} ∈ S₊ + S₋`. Finally `wᵐ = π^m π̄^{−m}`. ∎

**Lemma A2 (gluing).** Characters `χ₊` of `S₊` and `χ₋` of `S₋` that agree on `ℤ[i]` are the restrictions of exactly one character of `R`.
*Proof.* `θ(s₊ + s₋) := χ₊(s₊) + χ₋(s₋)` is well defined because two decompositions differ by an element of `S₊ ∩ S₋ = ℤ[i]`; it is
additive; uniqueness is `S₊ + S₋ = R`. ∎

**Lemma A3 (the two leaves, `p`-free).** For every `u ∈ U`: `θ₂(u) = 1/2`, and `τ(u) ∈ {1/3, 2/3}`.
*Proof.* `θ₂` factors through `R/(1+i)R ≅ 𝔽₂`, where every unit maps to 1, and `θ₂(1) = 1/2`. `τ` factors through `R/3R ≅ ℤ[i]/3 = 𝔽₉`
(3 is inert and prime to `p`); `u ū = 1` in `R` and conjugation reduces to Frobenius, so the image of `u` has norm `u⁴ = 1`, i.e. lies in
`{±1, ±i}`; and `τ(±1) = ±1/3`, `τ(±i) = ±⟨C, i⟩ = ±1/3`. ∎ *(Margins: `θ₂` has margin 1/4 and `τ` margin 1/12 at every `p`; S0B §2 had them
at `p = 5`.)*

**Theorem ONE-a.** Let `θ` be the gluing (A2) of `χ₊ := τ|_{S₊}` and `χ₋ := (θ₂ + λ_{C−P})|_{S₋}`. Then `θ ∈ Θ₄(R_{{p}})` and `θ ∉ T + A`.
Hence `Θ₄(R_{{p}}) ⊄ T + A` for every prime `p ≡ 1 (mod 4)`.
*Proof.*
1. *They agree on `ℤ[i]`:* `⟨P, x⟩ + ⟨C − P, x⟩ = ⟨C, x⟩`. So `θ` exists (A2).
2. *Band:* by A1 every `u ∈ U` lies in a half. On `S₊`, `θ(u) = τ(u) ∈ {1/3, 2/3}` (A3). On `S₋`, `θ(u) = 1/2 + ⟨C − P, u⟩` with
   `|⟨C − P, u⟩| ≤ |C − P|·|u| = √2/6 < 1/4` (`|u| = 1`). Both lie in `[1/4, 3/4]`.
3. *Not `T + A`:* suppose `θ = σ + λ_d` with `σ` torsion, of order `N`. On `S₊`, `λ_d = τ − σ` is killed by `3N`, so `3N d` lies in the dual of
   `S₊` under `⟨,⟩`, which is `⋂_n (π̄^{−n}ℤ[i])^* = ⋂_n πⁿℤ[i] = 0` (the dual of `aℤ[i]` is `ā^{−1}ℤ[i]`). So `d = 0` and `θ = σ` is torsion.
   Then on `S₋`, `λ_{C−P} = σ − θ₂` is torsion, and the same argument with `⋂_n π̄ⁿℤ[i] = 0` gives `C − P = 0`, false. ∎

*Remarks.*
- **Where one prime is used:** only in A1 — `U ⊆ S₊ ∪ S₋` and `S₊ + S₋ = R`. With two primes the unit `w₅w₁₃` lies in no half-ring of
  this kind, and V5's square fill puts the band on the off-axis sites, where FS-89's row 95 shows it fails. This is the structural form of
  "one prime is not enough".
- **The brief's worry about the step rule:** in the orbit model (S0B-T1, V5 at `r = 1`) the layer sequence is `e_m = c_τ(m)` for `m ≥ 0` and
  `e_m = P + w̄ᵐ(C − P)` for `m ≤ 0`; the steps `m → m+1` for `m ≥ 0` are the forward character's and for `m < 0` the backward character's,
  and both have `e₀ = C`. No step of the rule is ever checked against both. The tool checks the step rule across the junction anyway, as an
  independent test that the gluing is a character.
- **The general form (Lemma HL, the heteroclinic lemma).** If `τ₁, τ₂` are band torsion characters of `R_{{p}}` with margins `r₁, r₂` and
  there are `d₁, d₂` with `|d_j| ≤ r_j` and `τ₁ + λ_{d₁} = τ₂ + λ_{d₂}` on `ℤ[i]`, then gluing `τ₁ + λ_{d₁}` on `S₊` to `τ₂ + λ_{d₂}` on `S₋` is a band
  character, and it is outside `T + A` iff `τ₁ ≠ τ₂` (step 3 verbatim, with `d₂ − d₁ ≠ 0`). The condition is S0B §2's "the leaf discs meet on
  layer 0". The margins are `p`-dependent in general (they are read on `U_p mod N`); for the pair (parity, order 3) they are not (A3).
- S0B-T4's proof ran through "`τ = τ₁` on `S₊ ⊇ ℤ[i]`"; step 3 above is the same argument written as a dual-lattice computation.

**Exact check** — `tools/crunch_j12_onea.py` → `data/fs91/j12/onea-check.txt` (0.8 s, Fractions only). At `p = 5, 13, 17, 29`
(`π = 1+2i, 2+3i, 1+4i, 2+5i`; `w mod 3 = −i, 1, i, i`, so the three cases `±i`, `1` of A3's `μ₄` all occur):
- `w mod 3 ∈ μ₄`; the gluing identity on `1, i`; the band on `iᵏwᵐ`, `|m| ≤ 40`, `k = 0..3`, from the half each unit lies in: **all pass**;
- the orbit-model step rule `e_{m+1} − w̄e_m ∈ π^{−1}ℤ[i]` for every `−40 ≤ m < 40`, junction included: **passes at every `p`**.
- Plants, each firing for its own reason at every `p`:
  - **P1** band `[1/3, 2/3]`: 0 forward failures and 80 backward ones (the parity margin at three colours is `1/6 < √2/6`: the lens is empty).
    Its named wrong-reason red — a forward failure — did not occur.
  - **P2** step lattice `π̄^{−1}ℤ[i]`: the step check fails (70 of 80 steps at `p = 5`, all 80 elsewhere).
  - **P3** junction fault (backward displacement `C − P + 1/60`, so the halves disagree on `ℤ[i]`): the gluing identity fails and the step check
    fails at the junction step `−1 → 0` **and nowhere else**.

**C0-a scored:** predicted 0.93; met. The one risk named (the `X₃` margin at some `p`) is removed by A3's inertness argument.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J12-A1 | `S₊ ∩ S₋ = ℤ[i]`, `S₊ + S₋ = R_{{p}}`, `U_p ⊆ S₊ ∪ S₋` | hand | Stage 2 |
| J12-A2 | characters of `S₊`, `S₋` agreeing on `ℤ[i]` glue uniquely to `R_{{p}}` | hand | Stage 2 |
| J12-A3 | at every `p ≡ 1 (4)`: `θ₂ = 1/2` and `τ_{(1+i)/3} ∈ {1/3, 2/3}` on `U_p` (margins 1/4, 1/12, `p`-free) | hand; tools exact at 5, 13, 17, 29 | Stage 2 |
| J12-ONEa | **ONE-a (U3): `Θ₄(R_{{p}}) ⊄ T + A` for every prime `p ≡ 1 (mod 4)`**, by the heteroclinic `τ` on `S₊`, `θ₂ + λ_{C−P}` on `S₋` | hand; tools exact (4 primes, `\|m\| ≤ 40`, three plants) | Stage 2; `tools/crunch_j12_onea.py` |
| J12-HL | the heteroclinic lemma at `p`: two band torsion leaves whose discs meet on layer 0 give a band character outside `T + A` | hand | Stage 2 |

## Would-have-searched-here log

- **Stage 2.** I would have scanned primes `p ≡ 1 (mod 4)` up to some bound for a heteroclinic; instead A3 proves the two margins
  `p`-free, and the tool checks four primes fixed in the brief (a check of a derived claim, not a scan).
