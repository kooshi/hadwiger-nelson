# FS106-TQ — the quantitative route: is Hadwiger–Nelson's measurable form the stability of Voronov's theorem?

*Job FS106-TQ (de Bruijn, Opus 5.5), wave 2 of FS-106, opened 2026-09-27. Brief: `data/fs106/briefs/TQ106-quantitative.md` (the owner's
re-brief block first) with `data/fs106/briefs/STANDING-RULES.md`. Not blind to the print or to wave 1; blind to FS106-TS until stage 4 is
committed. Claims are `data/fs106/claims.md` §6; definitions §0 (D-MU, D-NF, D-SLACK, D-CP, D-M). Checks: `tools/fs106_tq_checks.py`, output
`data/fs106/fs106-tq/checks.out`, plants `data/fs106/fs106-tq/plants.out`.*

## Theorems this phase proved

*(filled stage by stage; grades per `CLAUDE.md` § Notation; "one mind" = this job, sighted unless said.)*

- **TQ-CORE** — at a density point `x` of a class `D` whose unit pairs are `Leb ⊗ σ`-null, every `y` with `|x − y| = 1` has density 0 in `D`;
  threshold `η(r) < θ/(4π)`. [hand; FS103-M's D1 re-derived sighted] — §2.1.
- **TQ-REM-i** — kept points (two radii `ε/2, 2ε`, `η = 1/20`) of one colour are never at distance in `[1 − ε, 1 + ε]`, for every `ε > 0`, in
  every a.e.-proper measurable (partial) colouring. [hand, one mind] — §2.2.
- **TQ-REM-ii** — for a CP colouring (jointly measurable modification, stationary moments), `P(0 not kept at ε) → 0`; bounded-region form for
  every measurable `f`; the uniform form fails on the zigzag colouring. [hand, one mind] — §2.3.
- **TQ-P, TQ-T** — periodisation with gaps 2; Prop. 2.1 for partial colourings (grid squares, band shrunk by `2√2 h`). [hand, one mind] — §3.1.
- **TQ-SUP** — `µ₆⁰ = lim µ₆(ε) = lim µ₆^tile(ε) = lim µ₆^per(ε)`: the tight and slack suprema coincide. [hand, one mind] — §3.2.
- **TQ-COMP-i** — coverage `→ 1` by a.e.-proper partial 6-colourings (upper density suffices) gives `χ_m⁰ ≤ 6` and `χ_CP ≤ 6`; two routes, one
  deterministic (weak-* local limit, maximal inequality, one-threshold rounding) using only M1's Step 2. [hand, one mind each] — §3.3.
- **TQ-COMP-ii** — `µ₆(ε)` is attained by a stationary random family and by a deterministic one; `µ₆(ε) < 1` given V-1.3 (C-AE-SLACK) or V-1.1
  (D4). [hand, one mind] — §3.4.
- **TQ-EQ** — `χ_m⁰(ℝ²) ≤ 6 ⟺ χ_CP ≤ 6 ⟺ µ₆⁰ = 1 ⟺ lim µ₆(ε) = 1 ⟺` periodic grid-square slack partial 6-colourings with vanishing holes `⟺`
  near-covering a.e.-proper colourings of every disc. No MR, no Voronov. [hand, one mind] — §3.5.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. The controls are exact geometry plus one float grid check of a hand inequality (`hex_pairs`, 425 pairs), which checks a
  derived bound and hunts for nothing.

## Stage 1 — SAVED: quotation check and controls

### 1.1 Quotation check (standing rule 5), each against its source on disk

| quoted in | the quotation | source | result |
|---|---|---|---|
| brief, claims C-Q-STAB | S–V §9: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the fraction of the plane that can be correctly colored in 6 colors with forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow definitively that χmap (R2 ) = 7." | `[SokolovVoronov2025]` p. 26 (text layer of `library/pdf/arXiv-2502.01958-maptype.pdf`) | **verbatim** (line breaks aside). The next sentence, not quoted anywhere: "Unfortunately, we only know that there exists a 6-coloring in which the 1/6997 part of the plane remains uncolored [8]." |
| brief | `[Parts2020c]`: "more than 99.985698 %" six-coloured; "95.99 %" five-coloured | abstract, `arXiv-2010.12668` p. 1: "a tiling of more than 99.985698% of the Euclidean plane with six colors … a tiling of more than 95.99% of the plane with five colors" | verbatim in substance; the re-brief's "95.99 % … five-coloured" drops "more than" (harmless) |
| claims C-Q-STAB | the advisor's wording "for some δ > 0 and every ε > 0, no colouring of the radius-3 disc by six band-proper colours plus a free seventh colour of density at most δ exists" | FS106-A | **not on disk in that form.** The advisor's record (`plans/POROS-2026-09-26-fs106-regular-half.md` l. 188) holds only "six band-proper colours plus a free seventh of density ≤ δ"; the long form is the planner's transcription of a message. Used below as the claim list's wording, attributed to it |
| claims I-D1, I-D4 | D1 and D4 | `plans/FS103-M-derivation.md` §3.1 | verbatim; I-D4's "…" drops D4's definition of `supp S_j`, as the advisor noted (stage 4 of its record) |
| claims I-M1 | "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)`" | `LEDGER.md` row 130 | verbatim (a substring of "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`") |
| claims V-1.1, V-1.3 | Voronov Thms 1.1, 1.3 | `[Voronov2023]` pp. 2–3 | verbatim |
| re-brief | wave 1's state: V-1.1–1.3 TRUE after local repairs (two minds, one blind); C-AE-SLACK TRUE; C-CS-2 TRUE | `plans/FS106-V-verification.md` l. 112–113, `plans/FS106-VB-verification.md` l. 147, 241 | matches: C-CS-2 TRUE at V and VB (two minds, one blind); C-AE-SLACK TRUE at V only (**one mind**, "given V-1.3") |

**Reading of D-MU used throughout.** `µ₆(ε)` is non-increasing in `ε` (a family null on a wider band is null on a narrower one), so
`lim_{ε→0} µ₆(ε)` exists and equals `sup_ε µ₆(ε)`. S–V's "an upper bound … µ∗6 < 1 … ε > 0" with `µ∗₆` independent of `ε` is therefore exactly
`lim_{ε→0} µ₆(ε) < 1`; an `ε`-dependent bound `µ₆(ε) < 1` could not give their conclusion (§3 shows it always holds).

### 1.2 The controls, before any argument

| control | what the argument must do there | exact facts (`tools/fs106_tq_checks.py`) |
|---|---|---|
| **C1, the tight hexagonal 7-colouring**: regular hexagons of side `1/2` (diameter exactly 1), coloured by the index-7 sublattice | it is a.e.-proper and has **no** slack in form (a): each open hexagon holds a positive-measure set of pairs at distances in `[1 − ε, 1)`, near opposite vertices. So REM (i) must hold there only because those pairs are not kept, and C-Q-EQ must not turn it into a six-colouring | `hex_tight`: diameter `= 1` exactly, same-colour gap `(√21 − 2)/2 = 1.2913 > 1`. `hex_pairs` (hand bound, float check at `ε = 0.05`, 425 pairs): every pair of one hexagon at distance `≥ 1 − ε` has a point within `4ε/3` of a vertex. `hex_nonkept`: such a point `x` has `B(x, 2ε) ⊇ B(v, 2ε/3)`, of which the hexagon covers `1/3`, so the outside fraction is `≥ 2/27 > 1/20`: **not kept** at `η = 1/20` |
| **C2, the zigzag colouring** (`plans/FS103-M-derivation.md` §2.4): the slack hexagonal 7-colouring (side `2/5`) with every edge in the annulus `j ≤ |z| < j + 1` replaced by a zigzag of amplitude `ε₀/4`, wavelength `1/j` | proper at **every** edge, Borel, but its `L¹` modulus degrades at infinity. A uniform-in-space form of REM (ii) must **fail** there; the statement must be at the origin of a stationary colouring (the claim's form) or on one bounded region at a time (my route, §3) | at scale `ε ≫ 1/j` a point of a zigzag band has both colours at density near `1/2` in `B(x, ε/2)`, so it is not kept; the bands fill a fixed fraction `≍ ε₀·(perimeter/area)` of every far annulus. So `sup_z |{x ∈ Q + z : x not kept at ε}| ≥ c₀ > 0` for every `ε`, while for each fixed box it tends to 0 |
| **C3, `[Parts2020c]`'s six-tiling** | any stability constant `δ` must satisfy `δ ≤ δ₆`; any claim that six colours cover density `≥ 1 − δ₆ − o(1)` must be consistent with it | `parts`: `δ₆ = 1/6992.1655504123 = 1.430172·10⁻⁴`, coverage `0.9998569828 > 0.99985698`. His straight-sided void formula at his published optimum gives `ρ = 6985.23`, against his Table 1 "straight, wavy" `6985.378399`: consistent to 0.002 %, the curving increment being the rest |

**Plants** (`data/fs106/fs106-tq/plants.out`): each of the eight checks has a planted fault, and each fires alone, for its named reason. One
plant could not fire at first. `hex_pairs` tested a `2ε` tolerance, but the true bound is `4ε/3`, so a plant at `ε` also passed. That is a control
that cannot fail. I sharpened the check to the hand bound and planted `0.4ε`, below the axis pair `a = b = ε/2`; it now fires, on 154 pairs.

## Stage 1 — SAVED

## Stage 2 — SAVED: C-Q-REM

Notation. `f : ℝ² → [k]` measurable, or a *partial* colouring: disjoint measurable `C₁, …, C_k` (uncoloured points allowed). *a.e.-proper*:
`(Leb ⊗ σ){(x, w) : x, x + w ∈ C_j} = 0` for each `j`. `S̃_j` = the points of density 1 of `C_j` (`|S̃_j Δ C_j| = 0`). Throughout I use the
exchange identity, for measurable `A, B ⊆ ℝ²`:

  (EX) `(Leb ⊗ σ){(x, w) : x ∈ A, x + w ∈ B} = (1/2π) ∫_A H¹(S(x, 1) ∩ B) dx = (1/2π) ∫_B H¹(S(z, 1) ∩ A) dz`

(the map `(x, w) ↦ (x + w, −w)` preserves `Leb ⊗ σ`). In particular replacing `C_j` by `S̃_j` changes the monochromatic unit pairs by a null set.

### 2.1 The pointwise core — **TRUE** [hand; this derivation sighted (after FS103-M's D1 and the advisor's A3), so it adds a check, not a blind mind]

*Statement (claims §6, verbatim):* "if `x` is a density point of a class `D` avoiding distance 1 at every pair, then every point at distance 1 from
`x` has density 0 in `D`." It holds with "at every pair" weakened to "at `Leb ⊗ σ`-almost every pair".

*Proof.* Suppose `|x − y| = 1` and `θ := limsup_{r→0} |D ∩ B(y, r/2)|/|B(y, r/2)| > 0`. Let `η(r) = |B(x, r) ∖ D|/|B(x, r)| → 0`. Take `r ≤ 1` along the
limsup with `|D ∩ B(y, r/2)| ≥ θπr²/8`.
- *Good pairs.* For `x′ ∈ B(y, r/2)`, `D′ = |x′ − x| ∈ [1 − r/2, 1 + r/2]`, and the unit circle about `x′` meets `B(x, r)` in an arc of length `≥ r`
  (its half-angle `θ_m` has `cos θ_m = (1 + D′² − r²)/(2D′) ≤ 1 − (3r²/8)/(1 + r/2) ≤ cos(r/2)`). By (EX),
  `(Leb ⊗ σ){x′ ∈ D ∩ B(y, r/2), x′ + w ∈ B(x, r)} ≥ (1/2π)(θπr²/8)·r = θr³/16`.
- *Bad pairs.* Those with `x′ + w ∈ B(x, r) ∖ D` number, by (EX), at most `(1/2π)·η(r)πr²·(πr/2) = πη(r)r³/4`, since a unit circle meets
  `B(y, r/2)` in an arc of length `≤ πr/2`.
- So the pairs with both ends in `D` have measure `≥ (θ/16 − πη(r)/4) r³ > 0` once `η(r) < θ/(4π)`, contradicting the hypothesis. ∎

Check: `core_constant` (the inequality at `θ = 1/100`; plant at `η = θ/(2π)` fires). This is FS103-M's D1 with the roles of the two points exchanged,
as the advisor's A3′ records; the explicit threshold `η < θ/(4π)` is new here.

### 2.2 C-Q-REM (i) — **TRUE for every `ε > 0` at `η = 1/20`** (any `η < 1/(1 + 4π) = 0.0737`) [hand, one mind]; deterministic

*Statement proved.* Let `f` be a measurable colouring or partial colouring, a.e.-proper, with density-1 sets `S̃_j`. Call `x ∈ C_j` *kept at scale
`ε`* if `|B(x, ρ) ∩ S̃_j| ≥ (1 − η)|B(x, ρ)|` for `ρ = ε/2` and `ρ = 2ε`, with `η = 1/20`. Then **no two kept points of one colour are at a distance
in `[1 − ε, 1 + ε]`**, for every `ε > 0` and **every** such `f` — no "almost surely": the kept sets are, colour by colour, everywhere band-proper.

*Proof, `ε ≤ 1/2`.* Let `x, y` be kept of colour `j` with `d = |x − y| ∈ [1 − ε, 1 + ε]`; put `A = S̃_j ∩ B(x, ε/2)`, `B = B(y, 2ε)`.
- *Chord lemma.* For `x′ ∈ B(x, ε/2)`, `D′ = |x′ − y| = 1 + t` with `|t| ≤ 3ε/2`. The unit circle about `x′` meets `B` in an arc of half-angle
  `θ_m`, `cos θ_m = 1 + (t²/2 − 2ε²)/(1 + t) ≤ 1 − (7ε²/8)/(1 + 3ε/2) ≤ 1 − ε²/2 ≤ cos ε` (the middle step is `ε ≤ 1/2`). So the arc has length
  `≥ 2ε` (`rem_chord`, float check: minimum ratio 1.0107; plant with radius `ε` fires).
- *Good pairs:* by (EX), `(Leb ⊗ σ){x′ ∈ A, x′ + w ∈ B} ≥ (1/2π)·(1 − η)(πε²/4)·2ε = (1 − η)ε³/4`.
- *Bad pairs:* `x′ + w ∈ B ∖ S̃_j` has measure `≤ (1/2π)·η·4πε²·(πε/2) = πηε³` (a unit circle meets `B(x, ε/2)` in an arc `≤ πε/2`).
- The monochromatic unit pairs of colour `j` then have measure `≥ ((1 − η)/4 − πη)ε³ = 0.0804 ε³ > 0` at `η = 1/20` (`rem_constant`; plant at
  `η = 1/10` fires), contradicting a.e.-properness. ∎

*Proof, `ε > 1/2`: no point is kept.* Then `R = 2ε > 1`. For `x′` in a disc `B` of radius `R ≥ 1`, the unit circle about `x′` has at least a third
of its length inside `B`: a boundary point of a radius-1 disc has exactly `1/3` (`1 − arccos(−1/2)/π`), and larger discs give more. So the pairs of
`B` have `(Leb ⊗ σ)`-measure `≥ |B|/3`. If `S̃_j` covered `(1 − η)` of `B`, the monochromatic ones would have measure `≥ (1/3 − 2η)|B| > 0`
(remove the `≤ η|B|` pairs with an end off `S̃_j`, each end counted by (EX)). So the condition at `ρ = 2ε` fails for every `x`, and (i) is
vacuous. ∎

*On the constant.* The advisor's message gave "`η < 1/48`" for a one-radius form (its record, stage 2); with two radii `ε/2`, `2ε` the threshold is
`1/(1 + 4π)`. Any absolute `η` below the threshold works; nothing downstream uses its value.

*Control C1.* The tight hexagons are a.e.-proper and hold monochromatic pairs at every distance in `[1 − ε, 1)`. (i) says none of them is a kept
pair, and the geometry agrees: each such pair has a point within `4ε/3` of a vertex (`hex_pairs`), and such a point is not kept (`hex_nonkept`: the
outside fraction of `B(x, 2ε)` is `≥ 2/27 > 1/20`). The kept sets are band-proper; the non-kept set is a strip of width `O(ε)` along the edges.

### 2.3 C-Q-REM (ii) — **TRUE** in the stated form (the origin of a stationary colouring) [hand, one mind]; its uniform form **FALSE** (C2)

*Statement proved.* Let `c` be a CP `k`-colouring of `ℝ²` (D-CP). Then `c` has a jointly measurable modification `c̃`, its realisations are a.s.
measurable colourings proper at `Leb ⊗ σ`-a.e. unit pair, and `P(0 is not kept at scale ε) → 0` as `ε → 0`, where "kept" is read in the
realisation `c̃(·, ω)`.

*Proof.*
1. *A jointly measurable modification.* A stationary process with `P(c(x) ≠ c(y)) → 0` as `y → x` is uniformly continuous in probability. Put
   `c^n(x) = c(2^{−n}⌊2^n x⌋)` (componentwise floor), jointly measurable. Choose `n_m` with `sup_x P(c^{n_m}(x) ≠ c(x)) ≤ 2^{−m}`. By
   Borel–Cantelli, for each `x`, `c^{n_m}(x) = c(x)` for all large `m`, a.s. Let `c̃(x, ω)` be the eventual value of `c^{n_m}(x, ω)` where it
   stabilises and `1` elsewhere. Then `c̃` is jointly measurable, and `c̃(x) = c(x)` a.s. for each `x`.
2. *Stationarity survives.* For bounded Borel `g, h` and `φ ∈ L¹`, the joint moments of `g(c̃(x))` and `∫ φ(y − x) h(c̃(y)) dy` are, by Fubini,
   integrals of finite-dimensional laws. These laws are translation-invariant. The two variables are bounded, so their joint law is determined by
   these moments and does not depend on `x`. In particular `P(x is not kept at ε)` does not depend on `x`.
3. *Realisations are a.e.-proper.* `E (Leb ⊗ σ){(x, w) ∈ Q × S¹ : c̃(x) = c̃(x + w)} = ∫_Q ∫ P(c(x) = c(x + w)) dσ dx = 0` (C-FMT (b)'s Fubini). So (i)
   applies to almost every realisation.
4. *The limit.* For each `ω`, Lebesgue's density theorem makes almost every `x` a density point of its own class, so `1{x not kept at ε} → 0` as
   `ε → 0` for a.e. `x`. The map `(x, ω) ↦ 1{x not kept at ε}` is jointly measurable, because `x ↦ |B(x, ρ) ∩ S_j(ω)|` is continuous. Hence
   `P(0 not kept at ε) = E|{x ∈ Q : x not kept at ε}| → 0` by dominated convergence (`|Q| = 1`). ∎

Step 4 uses only stationarity and measurability, never properness. Properness enters (i) alone.

*The bounded form (ii′), used in §3, and the uniform form (ii″).* For every measurable `f` and every bounded `Q`, `|{x ∈ Q : x not kept at ε}| → 0`
(step 4 on one realisation) — **TRUE**, no stationarity. The uniform form `sup_z |{x ∈ Q + z : x not kept at ε}| → 0` is **FALSE** for one
colouring: control C2's zigzag colouring is proper at every edge, and at every `ε` its far annuli hold zigzag bands, of fixed density, of points
not kept. So the claim's choice — the origin of a stationary colouring — is the right one for a statement about one scale everywhere, and (ii′) is
enough for the equivalence in §3, which never needs uniformity.

### 2.4 Verdicts, stage 2

| claim | verdict | minds / grade |
|---|---|---|
| C-Q-REM pointwise core | **TRUE**, also with "almost every pair" | [hand]; this check sighted; with FS103-M's D1, the advisor's A3 and VB's check of I-D1 (`plans/FS106-VB-verification.md` l. 241) |
| C-Q-REM (i) | **TRUE for every `ε > 0` at `η = 1/20`** (threshold `1/(1 + 4π)`), deterministic, for partial colourings too | [hand], one mind; constants checked (`rem_constant`, `rem_chord`) |
| C-Q-REM (ii) | **TRUE** as stated (CP form); (ii′) bounded-region form TRUE for every measurable `f`; (ii″) uniform form FALSE (C2) | [hand], one mind |

## Stage 2 — SAVED

## Stage 3 — SAVED: C-Q-COMP and C-Q-EQ

Four suprema, each over families of disjoint measurable `C₁, …, C₆ ⊆ ℝ²`, of the upper density of `C₁ ∪ ⋯ ∪ C₆`:
- `µ₆(ε)` — D-MU: `Leb ⊗ Leb`-null monochromatic pairs at distances in `[1 − ε, 1 + ε]`;
- `µ₆^tile(ε)` — each `C_j` a union of half-open grid squares, with **no** monochromatic pair at a distance in `[1 − ε, 1 + ε]`;
- `µ₆^per(ε)` — the same, periodic;
- `µ₆⁰` — a.e.-proper at the unit distance only: `(Leb ⊗ σ)`-null monochromatic unit pairs (no band).

Each of the first three is non-increasing in `ε`.

### 3.1 Two lemmas

- **Lemma P (periodisation).** Let a partial colouring of a square `Q_R` of side `R` be band-proper inside `Q_R` for `ε < 1` (everywhere, or
  `Leb ⊗ Leb`-null, or `Leb ⊗ σ`-null at distance 1). Its copies on the lattice `(R + 2)ℤ²` form a periodic partial colouring of the plane of the
  same kind. Its density is `|covered ∩ Q_R|/(R + 2)²`. *Proof:* two points in different copies are at distance `≥ 2 > 1 + ε`. ∎
- **Lemma T (tiles; Voronov's Prop. 2.1 for partial colourings).** Let a family have `Leb ⊗ Leb`-null monochromatic pairs in `[1 − ε, 1 + ε]`,
  and let `2√2 h < ε`. Colour each half-open grid square `τ` of side `h` by the least `j` with `|C_j ∩ τ| > 0`, and leave it blank if there is
  none. The result has **no** monochromatic pair at a distance in `[1 − ε′, 1 + ε′]`, `ε′ = ε − 2√2 h`, and it covers `⋃ C_j` up to a null set.
  *Proof.* Suppose `τ, τ′` are coloured `j` and hold a pair at a distance in the shrunk band. Every pair of `τ × τ′` is then at a distance in
  `[1 − ε, 1 + ε]`, and `(C_j ∩ τ) × (C_j ∩ τ′)` has positive measure: a contradiction. The points of `C_j` lying in blank squares form a null
  set. ∎

### 3.2 The tight and the slack suprema coincide — **TQ-SUP: `µ₆⁰ = lim_{ε→0} µ₆(ε) = lim_{ε→0} µ₆^tile(ε) = lim_{ε→0} µ₆^per(ε)`** [hand, one mind]

- `µ₆^per ≤ µ₆^tile ≤ µ₆`: the classes only widen.
- `µ₆(ε) ≤ µ₆^tile(ε − 2√2 h)`: Lemma T. So the limits of `µ₆` and `µ₆^tile` agree.
- `µ₆^tile(ε) ≤ µ₆^per(ε)`: restrict a tile colouring to a box of side `R` (a multiple of `h`), where its coverage is at least its upper density
  minus `o(1)` along a sequence of boxes, then apply Lemma P with a gap rounded up to a multiple of `h`.
- `µ₆^tile(ε) ≤ µ₆⁰`: a colouring with no monochromatic pair in the band has none at distance 1.
- `µ₆⁰ ≤ lim_{ε→0} µ₆^tile(ε)`: take an a.e.-proper partial 6-colouring of upper density `d`, and boxes `Q_{R_i}` whose coverage tends to `d`.
  For a fixed box, TQ-REM-i makes the kept set at scale `ε` band-proper everywhere, and the bounded form (ii′) makes its measure in `Q_R` tend to
  the coverage of `Q_R` as `ε → 0`. Lemma P turns it into a periodic family of density `≥ |kept ∩ Q_R|/(R + 2)²`; Lemma T (at a mesh
  `h ≪ ε`) makes it tiled. Let `ε → 0`, then `R = R_i → ∞`. ∎

So S–V §9's quantity has four equal readings. The stability limit is the same number whether the colourings are tight and measurable, slack and
measurable, slack and polygonal, or slack, polygonal and periodic. The order of limits is safe because every function of `ε` above is monotone.

### 3.3 C-Q-COMP (i) — **TRUE**, by two routes [hand, one mind each]; true with *upper* density too

*Statement (claims §6):* "If for every `δ > 0` there are disjoint measurable `C₁, …, C₆ ⊆ ℝ²`, each with `Leb ⊗ σ`-null monochromatic unit pairs,
whose union has lower density at least `1 − δ`, then `χ_CP(ℝ²) ≤ 6`."

**Route I (stationary; M1 with holes).**
- Work in `M′ = {g ∈ L^∞(ℝ², ℝ⁶) : g_j ≥ 0, Σ_j g_j ≤ 1}`, weak-* compact and metrisable. Let `F_δ = (1_{C_j})_j`.
- As in `plans/FS103-M-derivation.md` §2.2 Step 1, the laws of `τ_Z F_δ`, `Z` uniform on `[−m, m]²`, have translation-invariant limits `μ_δ`.
- `Ψ(g) = ∫_Q Σ_j g_j` is weak-* continuous, and `∫Ψ dμ_δ ≥ 1 − δ` (take the `m`'s along which the density is approached).
- Step 2 of M1 (decay of `σ̂ = J₀`) shows that `Φ(g) = ∫_Q ⟨g, g ⋆ σ⟩` is weak-* continuous. Each `Φ ∘ τ_t` (`t ∈ ℤ²`) vanishes on the orbit of
  `F_δ`, so `μ_δ` is carried by the closed set `K = {g : Φ(τ_t g) = 0 ∀ t ∈ ℤ²}`.
- A limit `μ` of the `μ_δ` is invariant and carried by `K`, with `∫Ψ dμ = 1`. Since `Ψ ≤ 1`, invariance gives `Σ_j g_j = 1` a.e., `μ`-a.s. So `μ`
  is carried by M1's `M`, and Steps 3–5 of M1 give a CP 6-colouring.

**Route II (deterministic; no stationarity, no continuity in probability).**
- Let `u` be the uncovered indicator of a family of upper density `≥ 1 − δ`, and `B = B(0, M)` a large disc with `∫_B u ≤ 2δ|B|`.
- By the weak (1,1) maximal inequality (constant 9 in the plane), the points `z ∈ B(0, M/2)` with `sup_{r ≤ M/2} ⨍_{B(z, r)} u > √δ` have measure
  `≤ 18√δ |B| < |B(0, M/2)|` once `δ` is small. Centre the family at a good `z`.
- Along `δ_n → 0` with `M_n → ∞`, the centred families `g_n` have a weak-* limit `g` in `M′`. Then `∫_{B_r}(1 − Σ g_j) = lim ∫_{B_r}(1 − Σ g_{n,j}) = 0`
  for every `r`, so `Σ_j g_j = 1` a.e.
- By M1's Step 2 on each unit square, `⟨g(x), g(x + w)⟩ = 0` for `Leb ⊗ σ`-a.e. `(x, w)`.
- **One threshold rounds it deterministically.** Put `c_U(x) = min{j : Σ_{i≤j} g_i(x) > U}`. Then `c_U(x) = c_U(y) = j` forces `U` into two
  intervals of lengths `g_j(x)` and `g_j(y)`, one of which is empty when `g_j(x)g_j(y) = 0`. So `∫₀¹ (Leb ⊗ σ){c_U(x) = c_U(x + w)} dU = 0`, and
  for almost every `U` the map `c_U` is a measurable 6-colouring proper at a.e. unit pair: `χ_m⁰(ℝ²) ≤ 6`, hence `χ_CP(ℝ²) ≤ 6` by M1.

Route II uses only M1's Step 2 (the compactness of the localised circle convolution). **Its conclusion `χ_m⁰ ≤ 6` is reached without M1's orbit
closure or continuity in probability.** Both routes need upper density only. Neither route uses Voronov, MR, or the value 6.

### 3.4 C-Q-COMP (ii) — **TRUE**: attainment [hand, one mind, no Voronov]; `µ₆(ε) < 1` [hand, one mind, given V-1.3]

*Statement (claims §6):* "For each `ε > 0`, `µ₆(ε)` (D-MU) is attained by a stationary random family, and `µ₆(ε) < 1`."

*Attainment.* Run Route I with `ν_ε`, the normalised Lebesgue measure on the closed annulus `{1 − ε ≤ |w| ≤ 1 + ε}`, in place of `σ`.
- `ν_ε` is absolutely continuous, so `ν̂_ε → 0` by Riemann–Lebesgue, and `Φ_ε(g) = ∫_Q ⟨g, g ⋆ ν_ε⟩` is weak-* continuous (Step 2 verbatim).
- The family maximises: `∫Ψ dμ ≥ µ₆(ε)`.
- Steps 3–4 of M1 hold for any invariant measure on `M′`. They give `φ(w) = E⟨G̃(0), G̃(w)⟩` continuous with `∫φ dν_ε = 0`, so `φ = 0` on the whole
  closed annulus.
- Round by `U`, leaving `x` blank when `U ≥ Σ_j G̃_j(x)`. The result is a stationary random partial colouring with `P(c(x) = c(y) ≠ blank) = 0`
  for **every** pair at a distance in `[1 − ε, 1 + ε]`, and `P(c(0) ≠ blank) = ∫Ψ dμ ≥ µ₆(ε)`.
- A jointly measurable modification (§2.3 step 1) has realisations with `Leb ⊗ Leb`-null band pairs (Fubini).
- By reverse Fatou, `E limsup_R (coverage of Q_R)/R² ≥ µ₆(ε)`, so some realisation attains it: `µ₆(ε)` is a maximum, over deterministic families
  as well.

*`µ₆(ε) < 1`.* If it were 1, the attaining stationary family would have `P(blank) = 0`. Its realisations are then measurable 6-colourings of the
plane (the null blank set coloured arbitrarily) with slack `ε` in form (a). That contradicts C-AE-SLACK (`plans/FS106-V-verification.md` l. 113,
TRUE given V-1.3, one mind). The same holds without attainment, by D4 (`c = min{j : x ∈ supp S_j}` is proper everywhere on the open band) and
V-1.1 at `ε/2`. Stage 4 gives a third route, quantitative and with no compactness: `µ₆(ε) ≤ 1 − (ε − o(1))²/144` (TQ-EPS2).

### 3.5 C-Q-EQ — **TRUE** [hand, one mind; inputs TQ-REM-i (one mind) and M1's Step 2 (two derivations); no MR, no Voronov]

**Theorem TQ-EQ.** The following are equivalent:
- (a) `χ_m⁰(ℝ²) ≤ 6`;
- (b) `χ_CP(ℝ²) ≤ 6`;
- (c) `µ₆⁰ = 1`;
- (d) `lim_{ε→0} µ₆(ε) = 1`, the negation of S–V §9's `µ∗₆ < 1`;
- (e) for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, with no monochromatic pair at any
  distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered;
- (f) for every `R` and every `δ > 0` there is an a.e.-proper measurable partial 6-colouring of the disc `U_R(0)` (pairs inside it) leaving at
  most `δ|U_R|` uncovered.

*Proof.*
- (a) ⟺ (b): M1 and C-FMT (b), row 130.
- (a) ⇒ (f): restriction.
- (f) ⇒ (c): Lemma P on the square inscribed in `U_R`.
- (c) ⟺ (d) ⟺ (e): TQ-SUP.
- (c) ⇒ (a): C-Q-COMP (i), Route II.

The claim's form, `χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1`, is (a) ⟺ (d) negated. ∎

*Controls.*
- **C1 at seven colours.** The theorem holds verbatim with 7 for 6. The slack hexagonal colouring gives `µ₇(ε) = 1` for small `ε`, consistent with
  `χ_m⁰ ≤ 7`. At six the tight hexagons give only `µ₆⁰ ≥ 6/7` (delete a colour), and nothing in the proof turns that into a six-colouring.
- **FS103-M's C3** (`Cay(ℝ², {±e₁})`, `σ̂ = cos ξ₁`, no decay). Route II's centring can land where the limit is the constant `(1/2, 1/2)`, and
  properness is lost. So the Rajchman step is used, as in M1. It is the step that fails there, not the equivalence: `χ_m⁰ = 2` there anyway.
- **C3 (Parts).** `µ₆⁰ ≥ 1 − δ₆ = 0.99985698…`, so by TQ-SUP `lim µ₆(ε) ≥ 0.99985698`. Eroding his tiles by `κ` (§4.3) gives the same bound
  directly at each `ε = 2κ`.

*What it does and does not do (the G21 audit asked for).* **It moves the difficulty and removes none of it.**
- It decides nothing: (d) is exactly as open as (a).
- What it buys:
  1. S–V §9's conditional, as printed, concludes `χ_map = 7`. Its hypothesis is in fact **equivalent** to `χ_m⁰(ℝ²) = 7`, hence given MR (rows
     128, 130) to `χ(ℝ²) = 7`. And its failure gives `χ(ℝ²) ≤ 6` **with no MR** (I-EASY).
  2. **The wild/regular dichotomy of link 5 dissolves at the level of single objects.** A refutation never needs a wild set. By (e) it is a
     sequence of *periodic polygonal colourings with slack*, whose uncovered density tends to 0; the wildness exists only in the limit that
     Route II takes. A proof, dually, may assume slack `ε > 0` and grid-square classes, at the price of holes.
  3. The stability limit is one number with four readings (TQ-SUP), so `[Parts2020c]`'s tight constructions and S–V's slack question measure the
     same thing.
- The flattering reading — "the problem is now a quantitative question, hence easier" — is not supported. The quantitative question is the
  measurable question.

## Stage 3 — SAVED
