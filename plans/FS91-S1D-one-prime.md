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

## Stage 3 — SAVED (ONE-b: `MS₄({5})` is FALSE — a minimal set outside `T + A` exists)

**Verdict: ONE-b is answered "no". There is a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A`. [hand, one mind; tools
exact for the model and the first two levels of the construction]** §M.2's reduction is corrected on the way (3.2): its first clause
holds, its second presupposes a classification nobody proved, and its obligation is answered "yes" by periodic orbits, which are `T + A`,
so it could not decide the question.

### 3.1 The model: nine rotations by one angle

*Notation (`p = 5`, the plan's normalization).* `π = 2 + i`, `w = π/π̄ = (3+4i)/5`, `u := iw` (so `U₅ = ⟨i⟩ × ⟨u⟩`), `ω := ū = −iw̄ = (−4−3i)/5`,
`P = (1+i)/2`, `Q₀ := [−1/4, 1/4]²`. `R_c(z) := c + ω(z − c)`, the rotation by `ω` about `c`.

**J12-B1 (the nine-centre model).** `Θ₄(U₅)` is homeomorphic to
`X := {(z_m)_{m∈ℤ} ∈ Q₀^ℤ : z_{m+1} = R_{c_m}(z_m) for some c_m ∈ C₉}`, `C₉ := {0, (±1 ± i)/6, ±1/3, ±i/3}`,
by `z_m := lift_Q(ī^m e_m) − P`, where `(e_m)` is S0B-T1's layer sequence; the shift of `X` is `θ ↦ θ∘u`, and `θ ↦ θ∘i` is `z ↦ −iz`.
*Proof.*
1. *Frame.* `e′_m := ī^m e_m` satisfies `e′_{m+1} − ωe′_m = ī^{m+1}(e_{m+1} − w̄e_m) ∈ π^{−1}ℤ[i]` (the lattice is `i`-stable), and `e_m ∈ Q ⟺
   e′_m ∈ Q` (`Q = [1/4, 3/4]²` is `i`-stable mod `ℤ[i]`). Conversely `e_m := i^m e′_m` recovers S0B-T1's sequence. Layer data of `θ∘u` is the
   shifted sequence (`(θ∘u)(u^m y) = θ(u^{m+1}y)`).
2. *Centre.* `(1 − ω)P = 3(1+2i)/5 = 3i/π ∈ π^{−1}ℤ[i]`, so `g_m := z_{m+1} − ωz_m ∈ π^{−1}ℤ[i]`.
3. *Alphabet.* `|g_m| ≤ |z_{m+1}| + |z_m| ≤ √2/2`; `g = a/π` with `|a|² = 5|g|² ≤ 5/2`, so `a ∈ {0, ±1, ±i, ±1 ± i}` (9 elements). The
   rotation `z ↦ ωz + g` has centre `c = g/(1 − ω) = a/(π(1−ω)) = a/(3(1+i)) = a(1−i)/6`, which runs over `C₉`.
4. The identification is a continuous bijection of compact Hausdorff spaces. ∎

*Reading.* Every band character of `R₅` at four colours is a bi-infinite orbit of **one irrational rotation `ω`, applied about one of nine
centres at each step** (a 3 × 3 block of the lattice `((1+i)/6)ℤ[i]`), staying in a square of side 1/2. Parity is the centre 0; the four
`X₃` leaves are the four diagonal centres (`c₀ := −(1+i)/6` is the leaf through `C = (1+i)/3`); the four edge centres `±1/3, ±i/3` lie outside
`Q₀` and belong to no leaf of period one. A centre word is admissible from `z` if every point stays in `Q₀`.

**J12-B2 (`T + A` is periodicity).** `θ ∈ T + A` iff its centre sequence `(c_m)` is periodic.
*Proof.* (⟸) Period `L`: the composite over one period is `z ↦ ω^L z + t`, with fixed point `q := t/(1 − ω^L)`. The sequence from `q` with the
same centres is `L`-periodic; by V5 (band-free) it is a character `σ`, and `σ∘u^L = σ` (periodic layer data), so `σ` kills the finite-index ideal
`(u^L − 1)R₅` and is torsion. Since each step is an isometry `z ↦ ωz + g_m` with the same `g_m`, `z_m − q_m = ω^m(z₀ − q)`, which is the layer
data of `λ_d` with `d = z₀ − q` (`λ_d`'s rotating-frame data is `ω^m d`). So `θ = σ + λ_d`. (⟹) If `θ = σ + λ_d`, `σ` of order `N`, then `σ∘u^L = σ`
for `L` the order of `u` in `(R₅/NR₅)^×`; by S0B-T2 `σ` is band with margin `≥ |d|`, so `z_m = q̃_m + ω^m d` with `q̃_m` `σ`'s lifted points,
and `c_m = (q̃_{m+1} − ωq̃_m)/(1 − ω)` is `L`-periodic. ∎

**J12-B3 (margins; displaced orbits).** If `(q_m)` is an admissible orbit with centre word `W` and `r := min_m (1/4 − ‖q_m‖_∞)`, then the orbit
from `q₀ + δ` with the same centres is `q_m + ω^m δ`, and it is admissible whenever `|δ| ≤ r` (a disc of radius `r` about `q_m` lies in `Q₀`).
For a periodic orbit, `r` is S0B-T2's margin.

**J12-B4 (minimal sets meeting `T + A`).** A `U₅`-minimal `M ⊆ Θ₄(R₅)` that meets `T + A` is a finite union of leaf circles
`{σ′ + λ_{d′} : |d′| = ρ}` over a finite `U₅`-orbit of torsion `σ′`, or a finite torsion orbit (`ρ = 0`). *Proof.* The orbit closure of `σ + λ_d`:
`(σ + λ_d)∘v = σ∘v + λ_{v̄d}`; on each coset of the (finite-index) stabilizer of `σ`, `v̄d` is dense in the circle of radius `|d|` (the
stabilizer contains a power of `w`, not a root of unity). ∎

**J12-B5 (the reduction, corrected).** `MS₄({5})` fails iff some `θ ∈ Θ₄(R₅)` is uniformly recurrent and has a non-periodic centre sequence.
*Proof.* (⟸) Its orbit closure is minimal; if it met `T + A` it would lie in it (B4), making `θ ∈ T + A`, whose centre sequence is periodic
(B2). (⟹) Points of a minimal set are uniformly recurrent; if `M ⊄ T + A` then `M ∩ (T + A) = ∅` (B4), and B2 makes every centre sequence in
`M` non-periodic. ∎

**J12-B6 (no free concatenation).** If blocks `A`, `B` (centre words) are both admissible from every point of a nonempty compact `K ⊆ Q₀` and
map `K` into itself, then `A` and `B` are powers of one word. *Proof.* Isometric self-maps of a compact metric space are onto, so the group
`⟨f_A, f_B⟩` preserves `K` and fixes its Chebyshev centre `q`. The periodic sequences from `q` with words `A^∞`, `B^∞` are torsion characters
(B2's (⟸), band-free) with the same layer-0 point `P + q`; torsion characters of order prime to 5 are determined on `ℤ[i]` (`R₅ = ℤ[i] + NR₅`), so
they are equal, their centre sequences agree, and `A^∞ = B^∞` makes `A`, `B` powers of a common word. ∎ *So a non-`T + A` minimal set cannot be
built as a full shift of blocks over a compact fibre: it must be window-coded.* (Also: two distinct band torsion characters never share a
layer-0 point.)

### 3.2 §M.2's reduction checked (quoted in 1.1 as Q4)

| clause | verdict | reason |
|---|---|---|
| "a minimal set meeting `T + A` is a leaf circle" | **TRUE**, precisely "a finite union of leaf circles, or a finite torsion orbit" | B4 |
| "so a counterexample is a switching character" | **GAP** (unsupported) | nothing proves every non-`T + A` point of `Θ₄(R₅)` switches between the parity and `X₃` leaves: the alphabet has nine centres (B1), the four edge centres belong to no period-one leaf, and there are infinitely many other leaves (3.3, Stage 4) whose periodic words mix letters. The correct reduction is B5 |
| "with bounded run lengths in both directions" | **incomplete** | in a non-`T + A` minimal set *every* periodic pattern has bounded runs (otherwise the closure holds a periodic centre sequence, `T + A` by B2); bounded runs of the parity and `X₃` letters alone does not exclude `T + A` — the leaves `c^a 0^b` of 3.3 have bounded runs of both and are torsion |
| "the obligation is whether S0B-T5's tree admits switches at bounded gaps" | **answered "yes", and it does not decide ONE-b** | periodic switching orbits exist (3.3, level 2), and they are `T + A`. The obligation that decides is B5: uniform recurrence **and** aperiodicity |

### 3.3 The construction: a hierarchy of leaves, closed by a two-leaf closing lemma

**J12-CL (closing lemma, two leaves).** Let `τ′, τ` be band torsion characters (admissible periodic orbits) with primitive centre words
`W′, W`, phase-0 points `Q′, Q`, certified margins `r′, r > 0`, and `D := |Q − Q′| > 0`. Let `Ω_W := ω^{|W|}`, so the block `W` acts as the
rotation `R(z) = Q + Ω_W(z − Q)` and `W′` as `R′(z) = Q′ + Ω_{W′}(z − Q′)`. For `a, b ≥ 1` put `x := Ω_W^a`, `y := Ω_{W′}^b`, and let `Q″` be the
fixed point of `R′^b ∘ R^a`. In coordinates with `Q = 0`, `Q′ = D > 0`: `Q″ = D(1 − y)/(1 − xy)`. If
`|Q″ − Q| ≤ r` and `|R^a(Q″) − Q′| ≤ r′`, then the periodic orbit with word `W^a W′^b` from `Q″` is admissible, with margin at least
`depth(Q″) := min(r − |Q″ − Q|, r′ − |R^a Q″ − Q′|)`.
*Proof.* The `W^a` part is `τ`'s orbit displaced by `Q″ − Q` (B3, `|·| ≤ r`), ending at `R^a(Q″)`; the `W′^b` part is `τ′`'s orbit displaced by
`R^a Q″ − Q′` (`|·| ≤ r′`), ending at `R′^b R^a(Q″) = Q″`. Each point is within the displacement of a point at distance `≥ r` (resp. `r′`) from
`∂Q₀`. ∎

**J12-CL′ (the reachable points: a dense subset of the lens).** Let `𝓛 := B(Q, r) ∩ B(Q′, r′)` (open), assumed nonempty. The map
`(x, y) ↦ D(1 − y)/(1 − xy)` sends the open set of `(x, y) ∈ S¹ × S¹` satisfying the two strict inequalities onto `𝓛` minus the axis `ℝ`; its
inverse is `Q″ ↦ (x, y) = (Q̄″/Q″, (Q″ − D)/(Q̄″ − D))` (check: `D(1−y)/(1−xy) = Q″`, and `R^a Q″ = xQ″ = Q̄″`, with `|Q̄″ − D| = |Q″ − D|`).
Since `Ω_W`, `Ω_{W′}` are not roots of unity, `{(Ω_W^a, Ω_{W′}^b) : a, b ≥ 2}` is dense in `S¹ × S¹`. **So the closed-up points `Q″` for
`a, b ≥ 2` are dense in `𝓛`,** and `Q″` can be taken off the axis at depth as close to `max_𝓛 depth` as wished. A necessary condition, by
`|sin(α+β)| ≤ |sin α| + |sin β|`: `r + r′ > D` (the discs overlap).

**J12-H (the hierarchy).** There are admissible periodic orbits `τ₀, τ₁, τ₂, …` with centre words `W₀ = 0`, `W₁ = c₀`,
`W_{n+1} = W_n^{a_n} W_{n−1}^{b_n}` (`a_n, b_n ≥ 2`), phase-0 points `Q_n`, and certified margins `r_n > 0`.
*Proof, by induction.* Base: `Q₀ = 0`, `r₀ = 1/4`; `Q₁ = c₀`, `r₁ = 1/12`; `r₀ + r₁ = 1/3 > √2/6 = D`. Step: given `τ_{n−1}, τ_n` with
`r_{n−1} + r_n > |Q_n − Q_{n−1}| > 0`, CL′ gives `a_n, b_n ≥ 2` with `Q_{n+1} ∈ 𝓛_n` off the axis and `depth(Q_{n+1}) > 0`; CL makes `τ_{n+1}`
admissible with `r_{n+1} := depth(Q_{n+1}) > 0`. Then `|Q_{n+1} − Q_n| ≤ r_n − r_{n+1} < r_n + r_{n+1}`, and `Q_{n+1} ≠ Q_n` (off the axis), so the
next pair satisfies the hypothesis. ∎ *(No uniform lower bound on `r_n` is needed; compactness does the rest.)*

**J12-W (the words).** Every `W_n` is primitive, `|W_n|` is strictly increasing, and `W_nW_n` is a factor of `W_{n+1}`.
*Proof.* Lyndon–Schützenberger: `x^a y^b = z^k` with `a, b, k ≥ 2` forces `x, y, z` to be powers of one word. If `W_{n+1}` were a proper power,
`W_n, W_{n−1}` would be powers of one word `ρ`; then `W_{n−2}^{b_{n−1}}` is a power of `ρ`, so `W_{n−1}, W_{n−2}` commute, and descending,
`W₁ = c₀` and `W₀ = 0` would be powers of one word — two distinct letters. `a_n ≥ 2` gives `W_nW_n`. ∎

**J12-Ω (the subshift).** Let `𝓛` be the set of factors of the `W_n`, and `Ω := {s ∈ C₉^ℤ : every factor of s is in 𝓛}`. Then `Ω` is a
minimal subshift with no periodic point.
*Proof.* By induction every `W_m`, `m ≥ n + 1`, is a concatenation of `W_n`- and `W_{n−1}`-blocks in which the `W_{n−1}`-runs have length `b_n`
and are separated by non-empty `W_n`-runs (both `W_{n+1}` and `W_{n+2}` begin with `W_n^{a_n}`, and junctions never merge two `W_{n−1}`-runs).
So every word of `𝓛` of length `≥ (b_n + 1)|W_{n−1}| + 2|W_n|` contains `W_n`, hence every factor of `W_n`: the language is uniformly recurrent
and `Ω` is minimal. A periodic `s = V^∞ ∈ Ω` would contain `W_nW_n` for `|W_n| > |V|`; by Fine–Wilf `W_n` would have period `gcd(|W_n|, |V|)
< |W_n|`, contradicting primitivity. ∎

**Theorem J12-MS (`MS₄({5})` is false).** There is a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A`.
*Proof.*
1. Let `θ_n ∈ Θ₄(R₅)` be `τ_n` placed with a `W_n` beginning at time 0; its centre sequence is `W_n^∞`. By compactness a subsequence converges,
   to `θ_∞ ∈ Θ₄(R₅)` (closed).
2. The centre map `c : X → C₉^ℤ`, `c_m = (z_{m+1} − ωz_m)/(1 − ω)`, is continuous into a discrete alphabet. Every window of `c(θ_∞)` is a window
   of `W_{n}^∞` for large `n`, i.e. a factor of `W_nW_n`, hence of `W_{n+1}`: `c(θ_∞) ∈ Ω`.
3. Let `Y` be the `⟨u⟩`-orbit closure of `θ_∞` and `M ⊆ Y` a `⟨u⟩`-minimal subset. `c(M)` is a nonempty closed shift-invariant subset of the
   minimal `Ω`, so `c(M) = Ω`, and no point of `M` has a periodic centre sequence. By B2, `M ∩ (T + A) = ∅`.
4. `M′ := M ∪ iM ∪ i²M ∪ i³M` is `U₅`-minimal (`i` commutes with `u`; a closed `U₅`-invariant `N ⊆ M′` meets some `iᵏM` in a closed
   `u`-invariant set, hence contains it, hence contains all four), and `T + A` is `i`-stable. ∎

*Remarks.*
- **What kind of set it is.** `M` lies in the closure of the band torsion characters but meets no leaf: the torsion points of `Θ₄(R₅)` are
  infinite (Stage 4) and accumulate off `T + A`. Its coding `Ω` is an S-adic subshift of the continued-fraction kind (`W_{n+1} = W_n^a W_{n−1}^b`),
  not Berend's positive-entropy subshift; whether `M` has positive dimension is not decided here. **Berend's Lemma 3.3 is not used** (Q7):
  its minimal sets live in the whole torus; the content here is that one lives inside the band set.
- **Where one prime is used:** B1 (a single rotation `ω`) and CL′ (density of `(Ω^a, Ω′^b)` for two powers of the same `ω`). With two primes
  the same construction runs into row 95.
- **At every `p ≡ 1 (mod 4)`.** The construction uses only the parity and `X₃` leaves, whose margins are `p`-free (J12-A3), the rotating frame
  with `ε_p := w̄_p mod 3 ∈ μ₄` in place of `i` (so the `X₃` centre is fixed), and that `ω_p := ε̄_p w̄_p` is not a root of unity. *Stated for
  every `p` as a corollary, one mind, the model B1 re-derived only at `p = 5`*: `MS₄({p})` is false for every prime `p ≡ 1 (mod 4)`.
- **D's prediction** (`MS₄({5})` false, 0.75, "a uniformly recurrent switching family, Berend's Lemma 3.3 shape") is met in its verdict; the
  mechanism is a closing-lemma hierarchy, not Berend's construction.

**Exact checks** — `tools/crunch_j12_oneb.py` → `data/fs91/j12/oneb-check.txt` (0.2 s, Fractions):
- B1: the complete set of nine kicks maps onto exactly `C₉`; `(1 − ω)P ∈ π^{−1}ℤ[i]`; `π(1 − ω) = 3(1+i)`; ONE-a's heteroclinic at `p = 5`,
  converted to the rotating frame, has centre `−(1+i)/6` at every `m ∈ [0, 30)` and `0` at every `m ∈ [−30, 0)`.
- Level 2 (`W₂ = c₀^a 0^b`, the complete box `2 ≤ a, b ≤ 12`, a finite set the derivation fixes): CL's sufficient condition admits 16 pairs,
  **all 16 verified directly** (orbit iterated exactly, every point in `Q₀`, exact return); e.g. `(a, b) = (2, 5)`: `|W| = 7`,
  `Q = (−38 − 41i)/249`, exact margin `29/996`.
- Level 3 (`W₃ = W₂^a W₁^b` from the level-2 member `(2, 10)`, margin `773/20592`; the box `2 ≤ a, b ≤ 6`): 17 admitted, **all 17 verified**;
  e.g. `(2, 2)`: `|W₃| = 26`, margin `31082011/1419263044`.
- Plants: **P1** (the non-rotating frame) makes the forward centre sequence non-constant and leaves the backward one constant — fires on the
  forward side only, its reason; **P2** (the `X₃` margin taken as 1/6) admits 39 pairs of which 23 fail the direct check, and none of the 16
  pairs admitted under the true margin fails — fires for its reason.

**C0 scored.** C0-b ("no", 0.55): met. C0-b′ (decided, 0.25): decided. C0-b″ (reduction unchanged, 0.30): not unchanged (one clause GAP, one
incomplete, the obligation non-deciding). The owner's registered P-MS5 ("no", 0.60): met.

## Stage 4 — SAVED (ONE-c: the orders are unbounded)

**Verdict: ONE-c is answered "unbounded". The band torsion characters of `R₅` at four colours have unbounded orders, by an explicit
two-parameter family that the closing lemma derives; every member named here is checked by three exact code paths. [hand; tools exact]**
The primes of the orders are the advisor's (primes at which the rotation has order dividing the word length), but the family is a closing
family, not a list of `Φ_k` quotients.

**J12-C1 (the criterion).** Let `e ∈ N^{−1}ℤ[i]/ℤ[i]` have order `N`, `5 ∤ N`, and `τ_e := ⟨e, ·⟩` on `ℤ[i]`, extended to `R₅`. Then `τ_e` is band on
`U₅` iff every point of the orbit `{w̄^m e}` lies in `Q = [1/4, 3/4]²` mod `ℤ[i]`, where `w̄` acts on `N^{−1}ℤ[i]/ℤ[i] ≅ ℤ[i]/N` as multiplication by
`t π̄²`, `t ≡ 5^{−1} (mod N)`. In the rotating frame: iff the periodic orbit of B1 through `e − P` stays in `Q₀`.
*Proof.* `τ_e` factors through `R₅/NR₅ ≅ ℤ[i]/N`; `τ_e(wy) = τ_e(π² t y) = ⟨π̄² t e, y⟩`, so the parameter of `τ_e∘w^m` is `(tπ̄²)^m e = c_τ(m)`
(S0B-T2), and S0B-T1's band condition is `c_τ(m) ∈ Q` for all `m` (`Q` is `i`-stable, which covers the `iᵏ` factors). ∎

**J12-C2 (the closing lemma, one segment).** If an admissible segment `z₀, …, z_L` with centre word `V` has margin `r` (every point at distance
`≥ r` from `∂Q₀`) and `|z_L − z₀| ≤ r|1 − ω^L|`, then the periodic orbit `V^∞` through `q := (fixed point of V's composite)` is admissible, so `V^∞`
is a band torsion character (B2). *Proof.* `q − z₀ = (z_L − z₀)/(1 − ω^L)` (from `F(z) = ω^L z + t`, `q = t/(1 − ω^L)`, `z_L = F(z₀)`), so
`|q − z₀| ≤ r`, and B3. ∎ *(The two-leaf form J12-CL is the case the construction uses.)*

**J12-C3 (the family).** For every `a, b ≥ 1` such that `(x, y) = (ω^a, ω^b)` satisfies CL's two conditions with the `X₃` leaf (`Q = c₀`, `r = 1/12`)
and the parity leaf (`Q′ = 0`, `r′ = 1/4`), the word `c₀^a 0^b` closes to a band torsion character `τ_{a,b}`. The set of such `(a, b)` is infinite
(CL′: the conditions define a nonempty open subset of `S¹ × S¹`, and `{(ω^a, ω^b)}` is dense). **The orders are unbounded:** the word
`c₀^a 0^b` is primitive, so the centre sequence of `τ_{a,b}` has least period `L := a + b`; the layer sequence of an order-`N` character is periodic
with period dividing the order of `u` in `(ℤ[i]/N)^×`, which is `< N²`; hence `N_{a,b} > √(a + b)`, and `a + b` is unbounded on the family. ∎

**J12-C4 (where the orders live).** `N_{a,b}` divides `2·Nm(β_L)`, `β_L := π^L − (−i)^L π̄^L = π^L(1 − ω^L) = ∏_{k∣L} Φ_k^{hom}(π, −iπ̄)`.
*Proof.* The composite of the word is `z ↦ ω^L z + t` with `t = Σ_j ω^{L−1−j}(1 − ω)c_j`, `(1 − ω)c_j ∈ π^{−1}ℤ[i]`, `ω^j ∈ π^{−j}ℤ[i]`; so
`t ∈ π^{−L}ℤ[i]`, `q = tπ^L/β_L ∈ β_L^{−1}ℤ[i]`, and `e₀ = P + q ∈ (2β_L)^{−1}ℤ[i]`; multiply by `β̄_L`. ∎ So every odd prime of an order in the family
is a prime at which `ω = ū` (`u = iw`) has order dividing `a + b`: the advisor's pointer ("primes dividing `Φ_k(w₅)`"), read in the rotating
frame, where `ω ≡ 1 (mod 3)` makes 3 divide every `β_L`.

**At every `p ≡ 1 (mod 4)`** (corollary, one mind; the family re-derived only at 5): the same argument runs with `ω_p = ε̄_p w̄_p`, `ε_p = w̄_p mod 3`
(J12-A3 makes both leaves `p`-free and fixes the `X₃` centre in that frame), and `ω_p` is not a root of unity; so the orders of band torsion
characters of `R_{{p}}` at four colours are unbounded at every split prime.

**Exact checks** — `tools/crunch_j12_onec.py` → `data/fs91/j12/onec-check.txt` (0.1 s). The **complete** box `1 ≤ a, b ≤ 10` (a finite set CL
fixes; logged as the ban's edge): CL's exact sufficient condition admits **14 pairs**; for each, all of the following pass:
- the rotating-frame orbit verified directly (every point in `Q₀`, exact return);
- `5 ∤ N`; `N ∣ 2·Nm(β_L)` (C4); `N > √L`;
- **C1 in the original frame** (modular arithmetic in `ℤ[i]/N`, the full `w̄`-orbit to its return; period `4L` or a divisor);
- **a third code path in S0B-L4's convention** (`τ(x + yi) = (Ax + By)/N` tested on the whole group `⟨i, w⟩ mod N` built by breadth-first closure),
  re-implemented for the one character — S0B's own tool was **not** run past its `N ≤ 130`, since that would extend a list.

| `(a, b)` | `L` | order `N` | factors | `\|U₅ mod N\|` |
|---|---|---|---|---|
| (3, 5) | 8 | 224 | 2⁵·7 | 32 |
| (1, 5) | 6 | 234 | 2·3²·13 | 24 |
| (2, 5) | 7 | 498 | 2·3·83 | 56 |
| (4, 5) | 9 | 3834 | 2·3³·71 | 72 |
| (6, 5) | 11 | 6074 | 2·3037 | 88 |
| (1, 10) | 11 | 9111 | 3·3037 | 44 |
| (2, 10), (7, 5) | 12 | 20592 | 2⁴·3²·11·13 | 48 |
| (9, 5) | 14 | 50962 | 2·83·307 | 56 |
| (10, 5) | 15 | 56142 | 2·3²·3119 | 120 |
| (4, 10) | 14 | 152886 | 2·3·83·307 | 56 |
| (6, 10) | 16 | 236096 | 2⁶·7·17·31 | 64 |
| (7, 10) | 17 | 848643 | 3·282881 | 68 |
| (9, 10) | 19 | **2029123** (prime) | 2029123 | 76 |

Thirteen distinct orders; none is `≤ 130`, so the list does not overlap S0B-L4's (no conflict; S0B's 12 orders are not this family's).
Controls and plants: **K3** (three colours) — CL admits no pair (the lens is empty) and the original-frame checker at `[1/3, 2/3]` rejects all 14
members (FS81-T3's side: no order dividing 6 is among them); **P1** (the division by 5 forgotten in the multiplier) — rejected; **P2** (each
parameter shifted by `1/N`) — all 14 rejected by C1 and by the third path. All as named.

**C0 scored.** C0-c ("unbounded" by a derived family, 0.80): met. C0-c′ (the family is the advisor's, 0.35): **met in the primes, not in the
family** (C4). The owner's P-U5 (0.35): met. S0B §4's reading ("unbounded, at the primes dividing the norms of `Φ_k(w)`") is promoted to a
theorem; its heuristic mechanism ("a band character exists at a prime `p` when roughly `p·2^{−2k} ≳ 1`") is not the proof's mechanism, which is
the isometric closing lemma.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J12-A1 | `S₊ ∩ S₋ = ℤ[i]`, `S₊ + S₋ = R_{{p}}`, `U_p ⊆ S₊ ∪ S₋` | hand | Stage 2 |
| J12-A2 | characters of `S₊`, `S₋` agreeing on `ℤ[i]` glue uniquely to `R_{{p}}` | hand | Stage 2 |
| J12-A3 | at every `p ≡ 1 (4)`: `θ₂ = 1/2` and `τ_{(1+i)/3} ∈ {1/3, 2/3}` on `U_p` (margins 1/4, 1/12, `p`-free) | hand; tools exact at 5, 13, 17, 29 | Stage 2 |
| J12-ONEa | **ONE-a (U3): `Θ₄(R_{{p}}) ⊄ T + A` for every prime `p ≡ 1 (mod 4)`**, by the heteroclinic `τ` on `S₊`, `θ₂ + λ_{C−P}` on `S₋` | hand; tools exact (4 primes, `\|m\| ≤ 40`, three plants) | Stage 2; `tools/crunch_j12_onea.py` |
| J12-HL | the heteroclinic lemma at `p`: two band torsion leaves whose discs meet on layer 0 give a band character outside `T + A` | hand | Stage 2 |
| J12-B1 | `Θ₄(U₅)` ≅ bi-infinite orbits in `Q₀ = [−1/4,1/4]²` of the rotation `ω = (−4−3i)/5` about one of nine centres per step | hand; tools exact (alphabet, heteroclinic) | Stage 3 |
| J12-B2 | `θ ∈ T + A` iff its centre sequence is periodic | hand | Stage 3 |
| J12-B3 | displaced orbits: same centres from `q₀ + δ` give `q_m + ω^mδ`, admissible when `\|δ\| ≤` margin | hand | Stage 3 |
| J12-B4 | a minimal set meeting `T + A` is a finite union of leaf circles or a finite torsion orbit | hand | Stage 3 |
| J12-B5 | `MS₄({5})` fails iff some band character is uniformly recurrent with a non-periodic centre sequence (§M.2 corrected) | hand | Stage 3 |
| J12-B6 | two blocks freely concatenable over a compact set are powers of one word; distinct band torsion characters never share a layer-0 point | hand | Stage 3 |
| J12-CL | the two-leaf closing lemma (fixed point `D(1−y)/(1−xy)`, admissible with margin `≥ depth`) | hand; tools exact (levels 2, 3) | Stage 3 |
| J12-CL′ | the closed-up points for `a, b ≥ 2` are dense in the lens of two leaf discs | hand | Stage 3 |
| J12-H | an infinite hierarchy of band torsion characters with words `W_{n+1} = W_n^{a}W_{n−1}^{b}` | hand; tools exact (levels 2, 3) | Stage 3 |
| J12-W, J12-Ω | the words are primitive; their S-adic subshift is minimal and aperiodic | hand | Stage 3 |
| **J12-MS** | **`MS₄({5})` is false: a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A` exists** | hand, one mind | Stage 3; `tools/crunch_j12_oneb.py` |
| J12-MSp | the same at every `p ≡ 1 (mod 4)` (corollary; B1 re-derived at 5 only) | hand, one mind | Stage 3 remarks |
| J12-C1 | a torsion `τ_e` of order `N` is band iff the `w̄`-orbit of `e` in `N^{−1}ℤ[i]/ℤ[i]` stays in `Q` (`w̄ ↦ tπ̄²`, `t ≡ 5^{−1}`) | hand | Stage 4 |
| J12-C2 | one-segment closing lemma: margin `r`, return `\|z_L − z₀\| ≤ r\|1 − ω^L\|` ⟹ a band torsion character | hand | Stage 4 |
| **J12-C3** | **ONE-c (U5): the orders of band torsion characters of `R₅` are unbounded** — the family `c₀^a 0^b`, `N_{a,b} > √(a+b)` | hand; tools exact (complete box `a, b ≤ 10`: 14 members, three code paths) | Stage 4; `tools/crunch_j12_onec.py` |
| J12-C4 | `N_{a,b} ∣ 2·Nm(π^L − (−i)^Lπ̄^L)`, `L = a+b`: the orders' primes are those of `Φ_k^{hom}(π, −iπ̄)`, `k ∣ L` | hand; tools exact (14 members) | Stage 4 |
| J12-C3p | the same at every `p ≡ 1 (mod 4)` (corollary; family re-derived at 5 only) | hand, one mind | Stage 4 |

## Would-have-searched-here log

- **Stage 2.** I would have scanned primes `p ≡ 1 (mod 4)` up to some bound for a heteroclinic; instead A3 proves the two margins
  `p`-free, and the tool checks four primes fixed in the brief (a check of a derived claim, not a scan).
- **Stage 3.** (i) I would have searched for a uniformly recurrent aperiodic switching orbit by running long switching policies (as S0B's
  prefixes did) and looking at their itineraries; instead the hierarchy J12-H is derived and its limit handled by compactness and minimality
  of the S-adic subshift. (ii) The level-2 and level-3 checks enumerate **complete boxes** (`2 ≤ a, b ≤ 12`; `2 ≤ a, b ≤ 6`) of the
  two-parameter set CL′ fixes, and each admitted pair is verified exactly — logged as the ban's edge (a complete enumeration of a set a
  derivation fixed); no member is load-bearing for J12-MS, whose proof is existential. (iii) I would have searched the level-2 box for the pair
  of largest margin to seed level 3; the tool takes the largest margin *within the complete box* instead, and the proof needs no choice.
- **Stage 4.** (i) I would have extended S0B-L4's list of orders past 130 to "see" whether they stop; instead the closing lemma derives an
  infinite family. (ii) The complete box `1 ≤ a, b ≤ 10` of that family is enumerated and every admitted member checked by three exact code
  paths — a complete enumeration of a finite set the derivation fixed, logged as the ban's edge; no order was scanned. (iii) S0B's
  `torsion_points.py` was not run past its own `N ≤ 130`; its test was re-implemented for the fourteen fixed characters only.
