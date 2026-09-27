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
- **HOLE-t / C-Q-HOLEa** — holes whose points are all within `t < ε/2` of the coloured set fill, at a loss of `2t` in the band. [hand, one mind] — §4.1.
- **TQ-EPS2** — every partial 6-colouring with `Leb ⊗ Leb`-null band pairs leaves lower density `≥ ε²/78` uncovered. [hand, one mind; C-CS-2] — §4.2.
- **TQ-ERODE / C-Q-LOCAL** — erosion by `κ` removes every multichromatic coloured point and widens the slack, at cost `O(κ)`; C-Q-LOCAL for
  `δ > δ₆`. [hand, one mind; Parts [external]] — §4.3.
- **TQ-HIT** — strips of width `2ε` at spacing `1/2` (density `4ε`) are effective holes meeting every unit circle and bicycle: a hitting-form
  argument proves at most `O(ε)`. [hand, one mind] — §4.4.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. The controls are exact geometry plus one float grid check of a hand inequality (`hex_pairs`, 425 pairs), which checks a
  derived bound and hunts for nothing.
- Stage 4: an optimiser over periodic grid-square partial six-colourings with slack `ε`, to trace `1 − µ₆(ε)` as `ε → 0`. Instead: the bracket
  `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` was derived (§4.2, §4.3), and the experiment is proposed for after the ban.

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

## Stage 4 — SAVED: C-Q-HOLEa, C-Q-LOCAL, C-Q-STAB

### 4.1 C-Q-HOLEa — **TRUE** as stated [hand, one mind], with a general form

**HOLE-t (general form).** Let a colouring of `U₃(0) ∖ H` be proper for `[1 − ε, 1 + ε]`, and let every `q ∈ H ∩ U₃(0)` lie at distance `< t` from
`U₃(0) ∖ H`, with `2t < ε`. Then it extends to a colouring of `U₃(0)` proper for `[1 − (ε − 2t), 1 + (ε − 2t)]`.

*Proof.* For each `q ∈ H ∩ U₃(0)` pick `p(q) ∈ U₃(0) ∖ H` with `|q − p(q)| < t` (choice), and give `q` the colour of `p(q)`. A pair of the new
colouring at a distance `ℓ` in the shrunk band, both ends coloured `j`, moves to a pair of old points of colour `j` at a distance in
`(ℓ − 2t, ℓ + 2t) ⊂ (1 − ε, 1 + ε)`. The old points are distinct, since `ℓ − 2t > 0`, so this contradicts the hypothesis. ∎

**C-Q-HOLEa is HOLE-t with `t = 2r`.** Let `H` be a union of pairwise disjoint closed discs of radius `≤ r`, and let `q ∈ D ∩ U₃(0)`, where `D` has
centre `c` and radius `r′ ≤ r`.
- *Countability and accumulation.* The discs are countably many (each holds a rational point). At every point `b ∈ ∂D ∩ U₃(0)`, points of
  `U₃(0) ∖ H` accumulate. Otherwise a small closed convex neighbourhood of `b` in `U₃(0)` would be a continuum covered by countably many pairwise
  disjoint closed sets, at least two of them non-empty (`D` and whatever covers the points outside `D` near `b`), against Sierpiński's theorem.
- *Distance.* Leave `D` along the segment from `q` toward `0` (it stays in `U₃(0)`). The exit point is on `∂D ∩ U₃(0)` at distance `≤ 2r′` from
  `q`. Equality forces `q ∈ ∂D`, and then `q` itself is such a boundary point. If `0 ∈ D`, then `D ⊂ int U₃(0)` and the nearest point of `∂D` is
  within `r′`. Either way `dist(q, U₃(0) ∖ H) < 2r`.
- So HOLE-t applies with `t = 2r`, `2t = 4r < ε`. ∎

Holes well inside `U₃(0)` give `t = r`, halving the loss.

*What it says* (the advisor's A8a in its general form): **a hole all of whose points are within `ε/2` of the coloured set is invisible** — it can be
filled at the cost of shrinking the band. So a hole that matters must contain points at distance `≥ ε/2` from the coloured set.

### 4.2 TQ-EPS2 — every band-proper partial six-colouring leaves at least `ε²/78` uncovered [hand, one mind; input C-CS-2, two minds]

*Statement.* If `C₁, …, C₆` have `Leb ⊗ Leb`-null monochromatic pairs at distances in `[1 − ε, 1 + ε]`, `0 < ε ≤ 2`, then the uncovered set has
lower density `≥ ε²/78`. Hence `µ₆(ε) ≤ 1 − ε²/78`.

*Proof.*
- Lemma T turns the family into a tile colouring that is band-proper **everywhere** for `ε′ = ε − 2√2h`, with no more uncovered measure.
- Fix `z`. If every uncovered point of `U₃(z)` were within `t < ε′/2` of the coloured points of `U₃(z)`, HOLE-t would give a six-colouring of
  `U₃(z)` proper for a band of positive width. That contradicts C-CS-2: V-1.3 in its band form, `plans/FS106-V-verification.md` l. 112 and
  `plans/FS106-VB-verification.md` l. 147, TRUE at two minds, one blind.
- So for every `t < ε′/2` some `q ∈ U₃(z)` has `B(q, t) ∩ U₃(z)` uncovered. That set has area `≥ 0.4645·πt²` (`disc_cap`: the least fraction of
  a disc of radius `t ≤ 1` centred in `U₃` that lies in `U₃`).
- So every `U₃(z)` holds uncovered area `≥ 0.4645·π ε′²/4`. Averaging over `z` (`∫_{B_R}|H ∩ U₃(z)| dz ≤ 9π|H ∩ B_{R+3}|`) gives density
  `≥ 0.4645 ε′²/36 ≥ ε′²/78`. Let `h → 0`. ∎

*Consequences.*
- A third proof of `µ₆(ε) < 1`, with no compactness.
- The first half of the two-sided bracket `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` (the right side from §4.3).
- **It is the best any argument of this form can give.** An argument that finds, in each disc of bounded radius, one hole containing a disc of
  radius `≍ ε` yields `Θ(ε²)`. This matches S–V §9's "`S(ε) = Ω(ε2)`", which they state for the area to remove from a map. TQ-EPS2 is a lower
  bound for every partial colouring. Not found in print in this form (§PA below).

### 4.3 C-Q-LOCAL — **TRUE for every `δ > δ₆`**; **MISSTATED at `δ = δ₆`**, where the construction gives nothing [hand, one mind; Parts's tiling [external]]

**TQ-ERODE (the lemma).** Take a partial colouring by closed tiles in which:
- each tile has diameter `≤ 1`;
- two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1` (a "Siamese" pair, `[Parts2020c]` p. 2);
- tile boundaries have finite length density.

Replace each tile `τ` by `τ_κ = {x : B(x, κ) ⊆ τ}`. Then:
- the result has **no** monochromatic pair at a distance in `(1 − 2κ, 1 + 2κ)`;
- distinct eroded tiles are `≥ 2κ` apart;
- the uncovered density grows by `≤ κ·(boundary length density) + O(κ²)`.

*Proof.* For `p ∈ τ_κ`, `q ∈ τ′_κ` and `u = (q − p)/|q − p|`:
- `p + κu ∈ τ` and `q − κu ∈ τ′` are at distance `|p − q| − 2κ`. If all cross-distances are `≥ 1`, then `|p − q| ≥ 1 + 2κ`.
- `p − κu ∈ τ` and `q + κu ∈ τ′` are at distance `|p − q| + 2κ`. If all cross-distances are `≤ 1`, then `|p − q| ≤ 1 − 2κ`. Inside one tile
  (`τ′ = τ`), the same computation gives an eroded diameter `≤ 1 − 2κ`.
- The discs `B(p, κ) ⊆ τ` and `B(q, κ) ⊆ τ′` have disjoint interiors, so `|p − q| ≥ 2κ`. ∎

*C-Q-LOCAL from it.*
- `[Parts2020c]`'s six-tiling (p. 7: 17-gons with wavy sides and curved pairs, rhombic and arrowhead voids, `δ₆ = 1/6992.1655504123`) is of this
  kind, by his definitions: "inner (tile width less than 1) and outer (distance between tiles greater than 1)" constraints, Siamese pairs allowed
  (p. 2). This is taken on his word — his tiling is a numerical optimum, not verified here: **[external]**.
- Eroding by `κ` gives a partial six-colouring with slack `ε < 2κ` and uncovered density `δ₆ + O(κ)`. By averaging over translations, a translate
  covers `≥ 1 − δ₆ − O(κ)` of `U₃(0)`.
- **Every coloured point has chromaticity 1**, not merely `≤ 2`: within distance `2κ` it sees only its own tile. So for every `δ > δ₆` there are
  `ε > 0` and a colouring as claimed, with no trichromatic point, and not even a bichromatic one.
- At `δ = δ₆` the construction needs `κ = 0`. Parts's own tiling has no slack (his constraints are equalities, p. 3 and §2.5: "constraints should
  be set in the form of equalities"). Whether some band-proper partial six-colouring reaches exactly `δ₆` is unknown. The claim's "at least"
  should read "greater than".

*The consequence the claim asks to be stated and graded.*
- **(L1) TRUE** [hand, one mind]. Every band-proper partial six-colouring can be tiled (Lemma T, whose squares have boundary density `4/h`) and then
  eroded at `κ ≪ h`, which *widens* its slack at an uncovered cost `≤ 4κ/h`. So C-Q-STAB is unchanged if restricted to colourings whose coloured
  set has no multichromatic point at all: every class a union of closed squares `≥ 2κ` from every other square. **No argument that locates
  trichromatic (or bichromatic) points *in the coloured set* can prove it.** The features Voronov reads must be looked for at the holes, as limits
  or as holes' boundaries.
- **(L2) TRUE as a statement about arguments of a named form** [derived, one mind]. "An obstruction spread over a set of positive measure" is sharpened
  in 4.4.

### 4.4 A no-go for counting circles and bicycles — **TQ-HIT** [hand, one mind]

The brief names "an averaged count of circles or bicycles" as the candidate non-local obstruction. Such an argument works like this:
- it exhibits a family `𝒞` of configurations — unit circles `T₁(u)`, or bicycles `T₁(u) ∪ T₁(v)` with `1 < |u − v| < 2` — each of which, in a
  band-proper colouring, leads to Voronov's contradiction unless an **effective** hole meets it;
- an effective hole is one containing a point `≥ ε/2` from the coloured set, since thinner holes fill (HOLE-t);
- it concludes that the holes are large because they must meet every member of `𝒞`.

**Such an argument can never give more than `δ = O(ε)`.**
- Let `W_ε` be the horizontal strips of width `2ε` centred on the lines `y ∈ ℤ/2`. Its density is `4ε`.
- Every point of `W_ε`'s centre lines is at distance `ε ≥ ε/2` from the complement, so the strips are effective holes.
- Every unit circle has vertical extent 2, so it crosses a centre line. Every circle and every bicycle therefore meets `W_ε`.

So the requirement "every member of `𝒞` meets a hole" is met at density `4ε`, whatever `𝒞` is (among circles and bicycles). An argument of this form
proves at most `1 − µ₆(ε) ≳ ε`. That is the advisor's "robust Voronov, linear in `ε`" (its hunch `robust-voronov-is-the-cheapest-decisive-route`,
stage 1). By TQ-EQ it would not decide the problem: a bound tending to 0 gives nothing in the limit.

*Caveat, in the headline's scope (G21).* TQ-HIT constrains **arguments** of the hitting form. It is not a construction: the strips do not make the
remaining plane six-colourable with slack. It says that **a proof of C-Q-STAB must use how the holes sit relative to the colouring, not merely that
they meet certain curves.** Equivalently, it must force either
- holes of a size `ρ₀` independent of `ε`, or
- a set of holes whose total measure does not scale with `ε`, so that at width `≍ ε` they number `≳ ε⁻²` per unit area (spacing `≍ ε`).

Neither is supplied by any mechanism in `[Voronov2023]` or `[SokolovVoronov2025]`, whose certificates are point-and-circle configurations of
bounded number per unit disc. Hence TQ-EPS2's `ε²`, and, with a positive-measure family of certificates, TQ-HIT's `ε`.

### 4.5 C-Q-STAB — **GAP**: it *is* Hadwiger–Nelson's measurable form. The advisor's radius-3 wording is a sufficient condition, not an equivalent. Not decided [hand, one mind for every link below]

1. **S–V §9's form (plane, `µ∗₆` independent of `ε`) ⟺ `lim µ₆(ε) < 1` ⟺ `χ_m⁰(ℝ²) ≥ 7`** (§1.1's reading of D-MU; TQ-EQ). So "decide C-Q-STAB" is
   "decide `χ_m⁰(ℝ²)`". Given MR (rows 128, 130), TRUE is `χ(ℝ²) = 7`. With no MR, FALSE is `χ(ℝ²) ≤ 6` (I-EASY).
2. **The advisor's form, "for some δ > 0 and every ε > 0, no colouring of the radius-3 disc by six band-proper colours plus a free seventh colour of
   density at most δ exists", implies the plane form** (average over translates: `µ₆(ε) ≤ µ₆^{U₃}(ε)`). The exact disc equivalent is "**for some**
   radius `R`" — which then holds for every larger `R`, since `1 − µ₆^{R′} ≥ (1 − µ₆^{R})((R′ − R)/R′)²` by sub-disc averaging. For "for all `R`"
   read negated: if `lim_ε µ₆^R(ε) = 1` for every `R`, Lemma P gives `lim µ₆ = 1`. Whether radius 3 suffices is S–V's Question 1 ("the minimum area of
   a convex region …") in stability form, open. **Verdict on the wording: MISSTATED as an equivalent of the plane question; as a claim, GAP.**
3. **What is proved toward it.**
   - `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` for every `ε` (TQ-EPS2; TQ-ERODE with Parts). So `0 ≤ 1 − µ₆⁰ ≤ 1.43·10⁻⁴`.
   - The whole question is whether the left side can be made uniform.
4. **What a refutation must be** (FALSE = a construction; TQ-EQ (e), TQ-EPS2, row 129, C-AE-SLACK):
   - a sequence of *periodic grid-square* partial six-colourings with slack `ε_n → 0` and uncovered density `δ_n → 0`, necessarily
     `δ_n ≥ ε_n²/78`;
   - each class of density `≤ m₁(ℝ²) ≤ 0.2470`;
   - WLOG no multichromatic coloured point;
   - its Route II limit is an a.e.-proper measurable six-colouring that has **no slack** (C-AE-SLACK) — the wildness is all in the limit.
5. **What a proof must be.** An argument that
   - is **integral**: one-class-at-a-time and fractional arguments stop below `4.37` colours (row 129, G60), and the fractional relaxation of
     `µ₆⁰` is 1;
   - **sees only effective holes** (HOLE-t);
   - does not look for multichromatic coloured points (L1);
   - is **not of the hitting form** (TQ-HIT).
   The named missing step: **a mechanism forcing holes of `ε`-independent total measure — a Voronov-type contradiction robust to a free colour on
   any set that is thin at scale `ρ₀`, for every band `ε ≪ ρ₀`.** No such mechanism is known. Its a.e.-regular special cases (C-AE-Q2, C-AE-POLY,
   C-AE-FA, the tight map forms) are all implied by C-Q-STAB, since each is a case of `χ_m⁰ ≥ 7`. None implies it.
6. **What `[Parts2020c]` says about a refuting sequence** (read in full, 2026-09-27):
   - (a) His six-tilings are **tight** — constraints are equalities (§2.5) — so they are points of `µ₆⁰`, not of `µ₆(ε)`. Erosion (TQ-ERODE)
     converts them.
   - (b) His voids sit at **every vertex** (type A rhombi at the degree-4 vertices, type B arrowheads at the degree-3 ones), and he reports that
     "vertices in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)" (§2.5 a). His optimum
     has no trichromatic coloured point: L1's picture, found numerically.
   - (c) His refinements are a **convergent** sequence, with `ρ₆` from 6197.58 to 6992.17 (Table 1), inside a class of congruent, highly
     symmetric tilings (§3: "restricted ourselves to the case of highly symmetrical tilings with only a few tiles in the repeating cell"). The
     voids keep a **fixed** size (the rhombus half-diagonals `l = 0.0133`, `r = 0.0055`). No parameter of his family drives `δ → 0`, so his
     constructions give no refuting sequence, only the ceiling `δ₀ ≤ 1.43·10⁻⁴` on any stability constant.
   - (d) His count observation (§2.4), that no known Siamese-free 7-tiling has fewer than 1/8 of its tiles in the seventh colour, bears on
     proper seventh colours. It does not bear on free holes: his six-tiling's voids are numerous (about one per vertex) and small in area. A
     refutation needs the area of the holes to vanish, not their count.
   - (e) His pigeonhole remark (p. 4, "only parallel translations are used") is the finite shadow of `µ₆⁰ ≥ 1 − δ₆`: every unit-distance graph of
     order `≤ 6992` is six-colourable.

### 4.6 Verdicts, stage 4

| claim | verdict | minds / grade |
|---|---|---|
| C-Q-HOLEa | **TRUE** as stated; general form HOLE-t (loss `2t`) | [hand], one mind |
| TQ-EPS2 (new) | **TRUE**: `1 − µ₆(ε) ≥ ε²/78` | [hand], one mind; input C-CS-2 (two minds, one blind) |
| C-Q-LOCAL | **TRUE for `δ > δ₆`**, with chromaticity 1, not only `≠ 3`; **MISSTATED at `δ = δ₆`** ("at least" → "greater than") | [hand], one mind; Parts's tiling [external] |
| C-Q-LOCAL consequence | (L1) **TRUE**: C-Q-STAB may assume no multichromatic coloured point; (L2) sharpened as TQ-HIT | [hand], one mind |
| TQ-HIT (new) | **TRUE**: hitting-form arguments over circles or bicycles are capped at `O(ε)` | [hand], one mind |
| C-Q-STAB | **GAP** at "a mechanism forcing holes of `ε`-independent measure" — it is `χ_m⁰(ℝ²) ≥ 7`; the radius-3 wording is sufficient, not equivalent (MISSTATED as an equivalent) | [hand], one mind |

### 4.7 §PA for the new statements (standing rule 11; a short gate, not a full one)

Queries sent to the zbMATH Open API on 2026-09-27, with their results:

| query | results |
|---|---|
| `ab:"partial coloring" & ab:"plane" & ab:"unit distance"` | 0 |
| `ab:"fraction of the plane" & ab:"colors"` | 1: `[Parts2020c]` |
| `ab:"forbidden" & ab:"interval" & ab:"fraction"` | 4, all off-topic |
| `ab:"unit distance" & ab:"almost every"` | 1, off-topic |
| `ab:"measurable" & ab:"chromatic number of the plane" & ab:"stability"` | 0 |
| `ab:"six colors" & ab:"plane" & ab:"uncolored"` | 0 |
| `au:"Parts, Jaan"` | 12 (`au:"Parts, J"` returns 0 — a tool note) |
| `au:"Pritikin, D"` | 33 |

Two titles in the author listings touch this job:
- Parts 2022, *On lower bounds of the order of `k`-chromatic unit distance graphs* — the pigeonhole transfer from covered fractions. **Not held;
  a prior-art debt**; listing only.
- Pritikin 1998, *All unit-distance graphs of order 6197 are 6-colorable* (`[Pritikin1998]`, unheld).

**Verdict.** Not found in print: TQ-EQ's converse direction, TQ-SUP, TQ-EPS2 or TQ-HIT. S–V §9 states the conditional one way, with the heuristic
`S(ε)` for maps. Parts computes the tight fraction.

*Would have searched here:* a tabu or local-search optimiser over periodic grid-square partial six-colourings with slack `ε`, to trace `1 − µ₆(ε)`
as `ε → 0` (TQ-EQ (e) makes it the natural numerical experiment). Instead: the two-sided bracket `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` was derived, and
the experiment is proposed for after 2026-10-01 (stub proposal in the report).

## Stage 4 — SAVED
