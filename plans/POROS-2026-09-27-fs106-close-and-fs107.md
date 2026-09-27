# Poros — FS-106's last comparison and FS-107's design (job FS106-A2, 2026-09-27)

*Advisor's record. Brief: `data/fs106/briefs/A2-106-advisor-compare.md` with `data/fs106/briefs/STANDING-RULES.md`. Predecessor: FS106-A,
`plans/POROS-2026-09-26-fs106-regular-half.md`. Working files: `data/fs106/fs106-a2/`. Stages 2 and 3 run first because the blind reports
(`data/fs106/reports/FS106-SB.md`, `FS106-QB.md`) did not exist at 06:11 UTC; stage 1 waits for them.*

## Theorems this phase proved

- **PD-EQ (sketch)** — for six colours, `χ_m⁰(ℝ²) ≥ 7` holds iff some `c > 0` and `ε₀ > 0` make every measurable six-colouring's
  monochromatic pairs at distances in `[1 − ε, 1 + ε]` a fraction at least `c` of all band pairs, for every `ε < ε₀`. This is TQ-EQ with the
  defect counted in pairs instead of holes. Grade: [hand, sketch, one mind]; stage 2, hunch 4.

## Would-have-searched-here log

- Stage 3: a numerical trace of `1 − µ₆^per(ε)` along eroded `[Parts2020c]` tilings, to see whether the hole gap is flat or falling. Instead it
  goes to FS-107 as a registered dial for after 2026-10-01, with both outcomes stated.

## Stage 0 — quotation check and inventory (standing rule 5)

**Quotations in my brief, checked against their sources.**
- TQ-EQ as "`χ_m⁰(ℝ²) ≥ 7` ⟺ `lim_{ε→0} µ₆(ε) < 1`": matches `plans/FS106-TQ-derivation.md` §3.5, "The claim's form".
- Rule 0's Kooshi quotation: matches `CLAUDE.md` § Counter-priors, as FS106-A found.
- **A dropped qualifier (not in quotation marks, so not a rule-5 breach, but it matters for stage 3).** The brief, and close inventory item 52,
  give R's target as a Voronov contradiction "on thin sets". TQ's own words are "robust to a free colour on any set thin at a scale `ρ₀`, not of
  the hitting form" (TQ §5.4), and "for every band `ε ≪ ρ₀`" (TQ §4.5 item 5). The scale is dropped. Moreover, "thin at a scale `ρ₀`" is
  **defined nowhere in TQ's record** (grep: two uses, no definition). Stage 3 replaces it with TQ's own exact form, the disc statement of §4.5
  item 2.

**Evidence inventory** (each item read against an expectation written before the read).
- `plans/FS106-TQ-derivation.md` §§1, 2.2, 3, 4.2, 4.4–4.6, 5 — expected: TQ-EQ correct, with the hard direction resting on one compactness
  step — surprised: yes, once. The hard direction is two easy steps. Route II (weak-* limit, compactness of the circle convolution, one-threshold
  rounding) proves `µ₆⁰ = 1 ⟹ χ_m⁰ ≤ 6`. REM-i proves the other direction. I re-derived the chord lemma's constants and Route II's continuity
  step, and found no fault. The surprise is §4.4 (stage 2, hunch 4).
- `plans/FS106-TS-derivation.md`, all stages — expected: gaps concentrated at SV's Conditions 5 and 6 — surprised: yes. [G2](c), spiralling
  boundaries, is a third escape, and it is a regularity feature, not a unit-distance one.
- The predecessor's record, stages 1–4 — read in full.
- `plans/FS106-close-inventory.md` items 1–59 — read.
- The plan's §IQ, §5 — read.
- `data/fs106/claims.md`: D-MU, C-AE-Q2, C-T-L1b to C-T-BIKE, C-Q-STAB — read.
- `plans/PROTOCOL-competitor-and-advisor.md` §§0–1 — read.
- Not yet read: `plans/FS106-SB-verification.md`, `plans/FS106-QB-verification.md` (fenced until their reports exist); V3's comparison section of
  `plans/FS106-V-verification.md` (for stage 1).


## Stage 1 — expectation, written before either blind report exists (committed 06:14 UTC; neither report file present)

*Read the blind records only after this is committed. Probabilities are G21 instruments, scored in stage 1.*

**QB on TQ.**
- TQ-EQ: TRUE, 0.85. The likeliest divergence is a route one. QB may prove `(c) ⟹ (a)` stationarily (Route I), or flag a definition:
  - upper versus lower density in D-MU;
  - whether (d) is the negation of S–V's printed `µ∗₆ < 1`, which needs `µ∗₆` read as uniform in `ε`.
  A GAP, if there is one, sits at the weak-* continuity of `∫_Q⟨g, g ⋆ σ⟩` (M1's Step 2), which I re-derived above as a compact-operator fact.
- TQ-EPS2: TRUE, 0.75. The constant may differ. The load-bearing input is C-CS-2 at radius 3.
- TQ-SUP: TRUE, 0.8. A divergence could come at the order of limits or at the box sequence.
- TQ-HIT: TRUE as a statement about strips, 0.9. QB may say that "hitting form" is undefined as a class of proofs, which is a scope point, not a
  truth point.
- C-Q-REM: TRUE, with other constants.
- C-Q-COMP: TRUE, 0.85.
- C-Q-LOCAL: TRUE for `δ > δ₆`, 0.7, graded conditional on Parts [external].

**SB on TS.**
- TS-C: TRUE, 0.85.
- TS-T: TRUE, 0.7. A GAP could come at "fills strictly grow" or at the hull's finiteness.
- TS-U: TRUE, 0.75.
- TS-L1: TRUE, 0.7.
- C-AE-POLY: TRUE except `d = 2`, 0.6. A blind reader may grade SV-L3's transplanted bicycle (V2, sketch) as a GAP.
- C-AE-CONV: TRUE given C-AE-POLY, 0.65. A possible divergence: the merged regions may be non-simply-connected, against S–V's map conditions.
- C-T-IND corrected: TRUE, 0.7.
- C5: TRUE as a local configuration, 0.75.

**V3's comparison of V2 with VB** (read at stage 5 of my inventory, sighted):
- V3's closed-form crossing checks: the small root `ρ₋ ≈ s_b²/(2 sin β)` of `ρ² − 2ρ(s_b cos β + sin β) + s_b² = 0` is simple and positive for
  `β ∈ (0, π)`.
- TS's stage-3 region-only Prop. 7 is a second written version, sighted (it saw V2's assertion, not V3's text). SB is the first blind mind on it.

## Stage 1a — SAVED: TQ against QB (blind)

*Read after QB's report existed (`data/fs106/reports/FS106-QB.md`): `plans/FS106-QB-verification.md` §§2.3–2.4, 2.8–2.11, 3.1–3.2 and 4.1–4.5;
TQ §4.3 re-read. SB's record is still fenced.*

### 1a.1 Agreement and divergence, claim by claim

| claim | truth | route | settled by |
|---|---|---|---|
| **TQ-EQ** | agree: TRUE, no MR, no Voronov | differ at `(c) ⟹ (a)`. TQ: a weak (1,1) maximal inequality to centre, and a random threshold `U` to round. QB: averaging at radius `δ^{−1/4}` to centre, and support selection `min{j : F_j > 0}` to round | both valid. The one analytic input is the same in both (the circle measure is Rajchman: weak-* continuity of `∫_B f(f ∗ σ)`, QB Lemma K). I re-derived it at stage 0 as a compact-operator fact |
| TQ-SUP | agree: TRUE | QB proves more: `µ₆^per(ε) = µ₆(ε)` at each `ε`, and `µ₆⁰` is attained | both |
| **TQ-EPS2** | agree: TRUE, **conditional on V-1.3** (TQ's grade bracket names C-CS-2; the sheet's quotation dropped the bracket, QB §4.1) | constant: TQ `ε²/78`, QB `ε²/(6 + ε)²` | **QB's constant is right and better.** Checked below |
| **TQ-HIT** | agree: TRUE as a limit on hitting-form arguments | cap: TQ `4ε`, QB `ε` | **QB is right.** Checked below. The headline `O(ε)` is unchanged |
| C-Q-REM (i), (ii), core | agree: TRUE | TQ `η = 1/20`, QB `η = 1/10` | QB's caveat "false for large `ε`" was QB's slip; QB conceded (T1): TQ's "no point is kept for `ε > 1/2`" holds |
| C-Q-COMP (i), (ii) | agree: TRUE. "`µ₆(ε) < 1`" is conditional on a Voronov theorem, and equivalent to V-1.1 over all `ε` | — | — |
| C-Q-LOCAL, `δ > δ₆` | agree: TRUE (chromaticity 1) | — | Parts [external] |
| **C-Q-LOCAL, `δ = δ₆`** | **diverge**: TQ says MISSTATED, QB says GAP (likely TRUE) | — | **QB is right that MISSTATED is not established.** See 1a.2 |
| L1 = pixel lemma P | agree: TRUE | QB sharpens it: a trichromatic-point step carries C-Q-STAB's full strength at every `δ` | QB's form is the one to carry |

**TQ-EPS2, QB's constant, checked.**
- Lemma F: if every `x ∈ U₃(z)` has `|B(x, r) ∖ H| > 0` with `r < ε/2`, then `c′(x) = min{j : |C_j ∩ B(x, r)| > 0}` colours `U₃(z)`. It is
  proper for `[1 − (ε − 2r), 1 + (ε − 2r)]` at every pair, because all cross pairs of the two `r`-balls lie in the band.
- The hypothesis holds when `|H ∩ B(z, 3 + r)| < πr²`.
- The closures of `c′`'s classes are closed, cover `cl U₃(z)`, and realise no unit distance (the band is open around 1). That contradicts V-1.3.
- Hence every disc `B(z, 3 + r)` holds at least `πr²` of the uncovered set, and averaging gives lower density `≥ (r/(3 + r))² → ε²/(6 + ε)²`.
- It is better than TQ's `ε²/78` because no tiling step and no disc-cap factor (0.4645) are needed. **QB's form should replace TQ's in the
  ledger.**

**TQ-HIT's cap, checked.**
- Centre lines on `y ∈ 2ℤ`: every unit circle's `y`-range `[b − 1, b + 1]` is closed and of length 2, so it contains an even integer.
- At a tangency the touching point lies on a centre line, `ε` from the complement, so it is effective in TQ's own sense (a point `≥ ε/2` from the
  coloured set).
- The density is `2ε/2 = ε`. At half-width exactly `ε/2` (the borderline HOLE-t leaves effective) it is `ε/2`.
- The constant is immaterial to the no-go.

### 1a.2 C-Q-LOCAL at `δ = δ₆`: the verdict

**QB is right that MISSTATED is not established.**
- The claim is existential: some `ε > 0` and some colouring of a subset of `U₃(0)`, with density `≥ 1 − δ₆`.
- TQ's "needs `κ = 0`" reads the hole fraction of the **average** translate. The claim may use the **best** translate.
- `φ(x) = |H ∩ U₃(x)|/|U₃|` is continuous and periodic with mean `δ₆`. If it is non-constant, some translate has `φ < δ₆` by a margin `η₀`, and an
  erosion with `O(κ) < η₀` keeps coverage `≥ 1 − δ₆`: TRUE.
- Even a constant `φ` would not make the claim MISSTATED, since other colourings could reach `δ₆`. MISSTATED needs a proof that none does, and
  TQ has none.

**Grade:** GAP at the endpoint, likely TRUE. The missing step is QB's: the non-constancy of `1_H ∗ 1_{U₃}`, which fails only if every
dual-lattice Fourier coefficient of `H` off the origin sits on a zero circle of `J₁(6π|k|)`.

A sketch of why that fails [hand, sketch, one mind; it needs Parts's exact geometry, which is external and numerical]:
- along a ray `m·k₁` of the dual lattice, for `|m k₁| ≲ 3`, the coefficients are close to `Σ_v a_v e^{−2πi m k₁·x_v}` (voids of area `a_v > 0`);
- a sum with positive grouped weights cannot vanish at the many consecutive `m` (Vandermonde) that the Bessel zeros, whose ratios are not
  integer, leave uncovered.

**Consequence: none.** Both sides agree on the consequence (the pixel lemma). **Recommended wording for `data/fs106/claims.md`:** keep "at
least"; grade it "TRUE for `δ > δ₆`; GAP at `δ = δ₆` (TRUE if `1_H ∗ 1_{U₃}` is non-constant)". This replaces TQ's close item 50 ("at least" →
"greater than").

### 1a.3 My stage-1 expectation, scored (QB half)

| expectation | outcome |
|---|---|
| TQ-EQ TRUE, 0.85; the divergence a route one at `(c) ⟹ (a)` | met: TRUE, route divergence at exactly that step |
| a definitional flag | met: QB found `µ₆⁰` undefined in `claims.md`, and the dropped grade bracket |
| TQ-EPS2 TRUE, 0.75, constant may differ, input C-CS-2 | met: the constant differs, and the input is named |
| TQ-SUP TRUE, 0.8 | met, with a stronger form |
| TQ-HIT: a scope point | **missed**: QB found a constant point (`ε`, not `4ε`), no scope point |
| C-Q-REM TRUE with other constants | met (`η = 1/10`) |
| C-Q-COMP TRUE, 0.85 | met |
| C-Q-LOCAL TRUE for `δ > δ₆`, 0.7 | met; the endpoint divergence was not foreseen |

### 1a.4 Count of minds, the TQ half

| result | minds | grade and input |
|---|---|---|
| **TQ-EQ** | **2**: TQ; QB blind, by a different route at `(c) ⟹ (a)` | [hand]. `(a) ⟺ (b)` rests on row 130 [hand, two]. My stage-0 check is a sighted reading, not counted |
| TQ-SUP | 2 (QB blind, stronger form) | [hand] |
| TQ-EPS2 | 2, **conditional on V-1.3** (V and VB, two minds, one blind, after repairs) | [hand]. The constant to carry is QB's `ε²/(6 + ε)²` |
| TQ-HIT | 2 | [hand]. The cap to carry is `ε` (QB) |
| C-Q-REM, C-Q-COMP (i) and attainment, L1 / pixel lemma | 2 each | [hand] |
| C-Q-LOCAL `δ > δ₆` | 2 | [hand] over Parts [external] |
| C-Q-LOCAL `δ = δ₆` | GAP | QB's missing step, my sketch |

### 1a.5 For the close

- **Correction owed:** TQ §3.4's `ε²/144` against §4.2's `ε²/78` (QB §4.4). Carry QB's `ε²/(6 + ε)²` instead.
- **Correction owed:** TQ §4.4's "density `4ε`" → "`ε`".
- **Correction owed:** close item 50's C-Q-LOCAL edit is withdrawn; use the wording in 1a.2.
- **Ledger shape (a recommendation, G21):** QB §3.2: "the novelty of TQ-EQ over row 130 is modest: the slack side and the periodic/pixelated
  forms". Record TQ-EQ as an **addendum to row 130**, not a new headline row. Its value is the reformulation (S–V §9's hypothesis is equivalent to
  `χ_m⁰ ≥ 7`) and W's regular target, not a new bound.
- **Stage 3 stands.** Its condition, "if QB confirms TQ-EQ", is met at two minds. W's reward rests on the easy direction:
  - TQ reaches it by Lemma T and Route II;
  - QB reaches it by Lemma B, Lemma K and Lemma S.

## Stage 2 — SAVED: the predecessor's expectation and hunches, scored

Sources for "what landed": close inventory items 21, 24, 28, 33, 39, 41–44, 46, 49, 55, with the records they cite. "One mind" means the
verdict's own count; nothing below is promoted by my agreement.

### 2.1 The expectation (inventory items 7, 8, 12)

| # | the predecessor expected | what landed | score |
|---|---|---|---|
| 1 | Voronov uses closedness once, as compactness giving a band. The method consumes the band, so the heart is "band versus no band". | C-CS-1 and C-CS-2 are TRUE at V and VB (two minds, one blind). The band's uses matched: Prop. 4.1's swap exclusion, and the bicycle's `α < ε/2`. | **met** |
| 2 | S–V's two extra hypotheses (no unit arcs; no trichromatic vertex of degree ≥ 4) are exactly where a tight colouring escapes. | TS: C-AE-Q2 is a GAP at [G1] and [G3] (unit arcs) and at [G2] (a bowtie, a unit arc through `u`, and **spiralling boundaries**). C-T-TAN adds cusps and blow-ups that converge only weak-*. | **met in kind, missed in "exactly"**: the escape list is at least five long, and two items (spirals, weak-* limits) are regularity features that S–V's conditions do not name |
| 3 | S–V's Question 2 is the wall in its regular form, and should be the first target. | TS: C-AE-Q2 is a GAP, with no counterexample; it produced TS-U, TS-L1, TS-C, TS-T and C5. TQ-EQ (e): the regular form of the wall is **periodic grid-square slack colourings with holes**, not maps with unit arcs. Q2 is a special case (null boundaries only, TS §6 item 1): it is implied by `χ_m⁰ ≥ 7` and does not imply it. | **missed** as the wall's form; **met** as a productive first target (its lemmas are the constraints stage 3 hands on) |
| 4 | `[Townsend1981]` has no proof. Its content is a unit-arc counterexample to Woodall 1973. | V, VB and V3: no proof printed. V3: the ⅔π counterexample checks, is sharp, and uses a unit-arc boundary. | **met** |
| 5 | The a.e. forms: slack holds (high); closed is a tight question (the first honest target); nice maps hold (medium-high); polygons hold (medium); maps-six hold (medium, shaky in print). | Slack: C-AE-SLACK TRUE (V). Closed: C-AE-CLOSED is a GAP equivalent to the tight question for essentially closed classes (V). Nice: C-AE-NICE TRUE (TS; V3). Polygons: C-AE-POLY TRUE except the `d = 2` edge case (TS region-only; V2; V3). Maps-six: Townsend's Thm 5 is a GAP at (c), repaired via Woodall at one mind; C-AE-MAP6 is a GAP (V3; TS). | **met on all five**; the maps-six "verify before building" call was right |
| 6 | The planner's quantitative route (C-Q-EQ) was reached independently by the advisor (item 8). | TQ-EQ TRUE (one mind, TQ); QB's blind check is running. | **met**, pending QB |
| 7 | C-T-TRI is misstated because of cusps; C-Q-HOLE is misstated because the obstruction must be non-local (item 8). | C-T-TRIa FALSE (two minds: the advisor's example, checked by TS). C-Q-LOCAL TRUE for `δ > δ₆`; C-Q-STAB is a GAP at "a mechanism forcing holes of `ε`-independent measure" (TQ). | **met** |
| 8 | (R1) an asymptotic band; (R2) a tangent multicolour; (R3) a finite-perimeter topology (ACMM). | R1 conceded as D1 (three checks now, TS §6 item 4). R2 is C-T-TAN (TS, one mind). R3 was never used by any job. | R1, R2 **met**; R3 **not tested** |

### 2.2 The hunch ledger

```
hunch: bicycle-tight-is-3-colourable
  claim: with the single forbidden distance 1, T_1(u) ∪ T_1(v), 1 < |u−v| < 2, has a proper 3-colouring by finitely many arcs
  basis: derived
  falsifier: a derivation that every arc 3-colouring of the tight bicycle has a monochromatic unit pair
  registered: 2026-09-26
  status: open (not tested). TS C-T-BIKE proves three colours are needed at every d (a triangle at |x − v| = √3) and reduces 3-colourability
          to the forced set F on one circle per (d, φ); the scan that would decide it is banned. The basis is supported: the band's only role in
          Thm 1.2 is to exclude a simultaneous swap (TS (ii); VB control 3).

hunch: tangent-2.2-names-SV-conditions
  claim: the tangent form of Prop. 2.2 fails only at bowtie tangents and at unit-curvature interfaces, and nowhere else
  basis: derived
  falsifier: a tangent configuration at trichromatic u with I_u of positive length where the curvature term still permits a completion
  registered: 2026-09-26
  status: split. Confirmed for cone blow-ups (TS C-T-TAN, a derivation, one mind). Killed in "nowhere else": cusps (the predecessor's own
          A7; C-T-TRIa, two minds) and blow-ups converging only weak-* (TS §4).

hunch: ae-polygon-holds
  claim: SokolovVoronov Thm 2 holds with boundaries free (a.e.-proper polygonal colourings need seven)
  basis: analogy
  falsifier: an a.e.-proper polygonal six-colouring, or a step of SV's proof that colours a boundary point and has no a.e. substitute
  registered: 2026-09-26
  status: confirmed by derivation except one named case. TS's region-only Props. 7/8 and V2's repaired SV-2 are two routes, and V3 checks that
          V2's route answers VB's Obs. 1 configuration. The d = 2 antipodal edge case is open (V3 reduced it). Grade: [hand], one mind per route.

hunch: robust-voronov-is-the-cheapest-decisive-route
  claim: a linear-in-ε lower bound on monochromatic band-pair density for measurable six-colourings is provable by stabilizing Voronov's
         argument, and gives χ_m⁰ = 7 without any regularity
  basis: prior
  falsifier: a measurable six-colouring with monochromatic band-pair density o(ε) along a sequence
  registered: 2026-09-26
  status: open. "Decisive" is confirmed, and PD-EQ below makes it an equivalence. "Cheapest" is empty: TQ-EQ shows the route is the whole
          problem. "Provable by stabilizing" is untested. **TQ §4.4 scored this hunch on the wrong quantity**; see the note below.
```

**Note on TQ §4.4's scoring (a correction owed; the "exactly one thing may differ" rule, `CLAUDE.md` § Make the gate fail).** TQ-HIT
writes: "An argument of this form proves at most `1 − µ₆(ε) ≳ ε`. That is the advisor's 'robust Voronov, linear in ε' … By TQ-EQ it would not
decide the problem." The two quantities have different denominators.
- **TQ-HIT's quantity** is uncovered area over plane area. A bound `≳ ε` tends to 0, so it decides nothing. That is correct.
- **The hunch's quantity** (predecessor stage 1, route 2: "a lower bound, linear in `ε`, on the density of monochromatic pairs at distances in
  `[1−ε, 1+ε]` … Every a.e.-proper colouring has that density `o(ε)`") is monochromatic band pairs per unit area. The band has measure `≈ 4πε`,
  so "linear in `ε`" there means the monochromatic fraction of band pairs stays at least a constant `c`. That bound does not tend to 0. It is
  decisive:
  - **One direction** is the predecessor's own: a CP six-colouring (row 130) is continuous in probability, so its band fraction tends to 0.
  - **The other direction** is PD-EQ below.
- **What TQ-HIT does bear on:** the hunch's "provable by stabilizing". A hitting-form stabilization is capped in these units too. Its bad set can
  be TQ's strips, which touch a band-pair fraction of order `ε`. That transfer is my sketch; TQ did not write it.

**PD-EQ** [hand, sketch, one mind]. Six colours: `χ_m⁰ ≥ 7` ⟺ `liminf_{ε→0} inf_f p_f(ε) > 0`, where `p_f(ε)` is the monochromatic fraction of
band pairs, upper-density-averaged.
- ⟸: if `χ_m⁰ ≤ 6`, row 130 gives a CP colouring, and continuity in probability makes `p(ε) → 0`.
- ⟹: take colourings `f_n` and widths `ε_n → 0` with `p_{f_n}(ε_n) → 0`. Centre them as in TQ's Route II, and take a weak-* limit `g` in `M′`.
  - The step to check: `∫_Q⟨g_n, g_n ⋆ ν_{ε_n}⟩ → ∫_Q⟨g, g ⋆ σ⟩`.
  - It holds because `ν_{ε_n} → σ` and the `ν̂_ε` decay uniformly (`|ν̂_ε(ξ)| ≲ |ξ|^{−1/2}`), so the localized convolutions are uniformly
    compact and converge in operator norm.
  - Then `⟨g(x), g(x+w)⟩ = 0` for `Leb ⊗ σ`-a.e. `(x, w)`, and TQ's one-threshold rounding gives `χ_m⁰ ≤ 6`.
  - The operator-norm convergence is the step I have not written in full.

**Two further hunches**, registered at the predecessor's stages 2–3:
- `stable-voronov-needs-lemma-6.1-with-holes` — **split.** Its first half ("a vanishing-density defect set can contain every trichromatic
  point") is confirmed by derivation: TQ-ERODE and L1, one mind. Its second half ("a version of Lemmas 2.2/6.1 with holes as a free colour
  closes it") is killed, three times:
  - by the predecessor's own A8b (feature-local obstructions cost `O(ε²)`);
  - by C-Q-LOCAL;
  - by TQ-HIT (hitting-form versions are capped).
  A free seventh colour cannot contradict anything by itself, since seven colours suffice. The contradiction must count the holes'
  measure non-locally.
- `cusp-is-the-third-configuration` — **confirmed**: C-T-TRIa is FALSE at two minds, and TS carried the support form, C-T-TRIb.

### 2.3 What the misses teach

1. **An equivalence outranks a special case, even a named one.** The predecessor held S–V §9 (the stability bound) at stage 1, and heard of
   the planner's REM + COMP equivalence at stage 2. It still ranked Question 2 (maps with unit arcs) first, calling it "the wall in its regular
   form". TQ-EQ (e) shows the wall's regular form is a family of *periodic polygonal colourings with holes*. Q2 is one special case, and it
   implies nothing about the whole. Rule: **once an equivalent form of the question is on the table, rank every special case below it.** Special
   cases are worth pursuing for the lemmas they yield (TS's are real) or for a counterexample, never as "the wall". This is G72's structural
   form, applied at ranking time.
2. **A list of exceptional configurations is a list for the class it was derived in.** "Nowhere else" was derived at the blow-up level of
   piecewise-smooth objects. Within a day the list grew by a cusp (its own A7), spirals, and weak-* limits. Rule: every "only at X" states the
   class of objects it was proved for.
3. **A quantitative hunch names its denominator.** Hunch 4 said "linear in `ε`" and did not write that the band's own measure is `≈ 4πε`. The
   next reader (TQ) supplied the other denominator and scored it wrong. Rule: write every rate as a fraction, with numerator and denominator in
   words (`CLAUDE.md`'s "exactly one thing may differ").
4. **Reading predictions scored well, route predictions less so.** Expectation items 1, 4, 5 and 7 are reports of what printed proofs use,
   and all were met. Items 2 and 3 are predictions of where the wall is, and were half-missed. The prior is sound on reading, and weaker at
   choosing the frame.
5. The review sent before the read (the predecessor's stage-3 slip) left no false claim in the list, but it is the failure the ledger exists
   for. My rule: no message about a file goes out in the tool round that first reads it.

## Stage 2 — SAVED

## Stage 3 — SAVED: FS-107's design

### 3.1 The frame correction first (object axis)

FS-107's stub calls its contest "regularity against pathology", with W building "a tight, wild, almost-everywhere-proper five- or six-colouring"
from "fat Cantor sets, self-similar and random constructions". **TQ-EQ removes that frame.** TQ §3.5: "A refutation never needs a wild set. By (e)
it is a sequence of *periodic polygonal colourings with slack*, whose uncovered density tends to 0; the wildness exists only in the limit that
Route II takes."
- The contest is therefore **stability**: does the uncovered fraction of band-proper six-colourings stay bounded below as the band closes?
  Regularity is not the question.
- W's material becomes **regular, finite and exactly checkable**: a periodic tiling given by formula, with rational data. This is the
  standard of evidence `CLAUDE.md` asks for (certificate plus checker).
- The stub's wild material (fat Cantor sets, random constructions) is misaimed as a route, and useful only as TS's control K3.
- **Proposed correction for the close** (the close writes it): rename FS-107 "stability against near-colourings"; rewrite `CLAUDE.md` § The aim
  link 5 and the stub's W paragraph in TQ-EQ's terms.
- **Confidence: high, conditional on TQ-EQ.** QB's blind verdict on TQ-EQ is the one fact that would change it.

### 3.2 Two objects, and which material belongs to which

TQ-SYN names the split; the hand-over mixes material addressed to two different objects.
- **The sequence object (TQ):** periodic grid-square partial six-colourings with slack `ε_n → 0` and holes `δ_n → 0`.
  - On it, TS's gaps [G1] and [G3] (unit-arc boundaries) cannot arise: every boundary is an axis-parallel segment.
  - [G2]'s bowtie is a grid vertex, which Voronov's slack argument already handles (his tile discretization has such vertices).
  - C-T-IND's finiteness is automatic.
  - **The only gap on this object is the hole gap.**
- **The limit object (TS):** W's Route II limit, a tight a.e.-proper six-colouring in D-NF. Here TS's gaps are the whole content: [G1]–[G3],
  C-T-L1b's two steps, C-T-TRIb's hull step, C-T-BIKE, and C-T-IND without finiteness.

So TS's material is legitimately R's, **as R's second route, on the limit object**. It is not a sub-lemma of the hole gap. TS's lemmas are
constraints on W's limit; on W's grid objects most of them hold trivially. **Each FS-107 brief should name its object, and label the other
record's material "applies to the limit object" or "to the sequence object".**

### 3.3 The two competitors' exact questions (quoted from the records)

**R (stability).** Prove C-Q-STAB in its exact disc form, TQ §4.5 item 2: *"The exact disc equivalent is 'for some radius `R`'"*. Written
out: for some `R` and `δ₀ > 0` and every `ε > 0`, every partial six-colouring of `U_R(0)` with no monochromatic pair at distance in
`[1 − ε, 1 + ε]` leaves at least `δ₀|U_R|` uncovered.
- With TQ-EQ this is `χ_m⁰(ℝ²) ≥ 7`, and given MR, `χ(ℝ²) = 7`.
- The mechanism R must supply, TQ §4.5 item 5 verbatim: *"a mechanism forcing holes of `ε`-independent total measure — a Voronov-type
  contradiction robust to a free colour on any set that is thin at scale `ρ₀`, for every band `ε ≪ ρ₀`."*
- R may choose its object:
  - (R-Q) the sequence, as above;
  - (R-S) the limit: *"Hadwiger–Nelson's measurable form is 'Voronov's argument on regular colourings, robust to a free colour of vanishing
    density'"* (TQ §5.2), run from TS's side. The named steps are TS's [G1]–[G3], C-T-L1b (1)–(2), C-T-TRIb's hull step and C-T-BIKE (TS §2.6,
    §4, §5).

**W (near-colourings).** TQ-EQ (e) verbatim: *"for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid
squares, with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered"*.
- Or, equivalently, (c): `µ₆⁰ = 1`. Tight polygonal tilings in `[Parts2020c]`'s framework with voids tending to 0 would do, because TQ-SUP
  equates the tight and slack suprema.
- Success gives `χ_m⁰ ≤ 6` by Route II, and `χ(ℝ²) ≤ 6` **with no MR** (I-EASY).
- **The direction W relies on is the easy one.** It uses Lemma T and Route II only, not REM-i. W's reward therefore rests on the part of TQ-EQ
  with the fewest steps.

### 3.4 Shared constraints (every one is held; both sides get the list verbatim)

| constraint | statement and address | grade |
|---|---|---|
| floor on holes | `1 − µ₆(ε) ≥ ε²/78` for every `ε` (TQ-EPS2, TQ §4.2): a W family with `δ < ε²/78` is wrong, and an R bound below this is already held | [hand], one mind; input C-CS-2 at two minds |
| ceiling on any stability constant | `1 − µ₆⁰ ≤ δ₆ = 1.430172·10⁻⁴`, and `1 − µ₆(ε) ≤ δ₆ + O(ε)` (Parts's tiling; TQ-ERODE, §4.3) | [external] + [hand], one mind |
| class density | each class `≤ m₁(ℝ²) ≤ 0.2470` (row 129's input) | [external] |
| integrality | one-class-at-a-time and fractional arguments stop below 4.37 colours; the fractional relaxation of `µ₆⁰` is 1 (row 129, G60; TQ §4.5 item 5) | [hand], two minds (row 129) |
| thin holes are free | HOLE-t: a hole whose points all lie within `t < ε/2` of the coloured set fills, at a band loss of `2t` (TQ §4.1) | [hand], one mind |
| no multichromatic coloured point, WLOG | TQ-ERODE / L1: erosion removes every multichromatic coloured point at cost `O(κ)` (TQ §4.3). R may not start from a trichromatic *coloured* point | [hand], one mind |
| not hitting form | TQ-HIT: strips of width `2ε` at spacing `1/2` meet every circle and bicycle, at density `4ε` (TQ §4.4) | [hand], one mind |
| the limit is tight | C-AE-SLACK: an a.e.-proper colouring with slack needs seven (V, l. 113) | [hand], one mind |
| the limit is not polygonal, not a nice map | C-AE-POLY (except `d = 2`), C-AE-NICE (TS §3; V3) | [hand], one mind per route |
| islands | band-proper same-colour pieces have diameter `≤ 1 − ε`; two of them are all within `1 − ε` or all beyond `1 + ε` (TQ §5.1; TS-C, TS-C′) | [hand], one mind |
| the limit's exceptional set | wherever W's limit has two points of disjoint three-element multicolours within distance 2, they sit at a tangent interface, a bowtie, a cusp, or a blow-up converging only weak-* (C-T-TAN, TS §4). Whether such pairs must exist is C-T-TRIb / C-T-PIG, a GAP | [hand], one mind |
| the ban | to 2026-10-01: no optimiser, no SAT, no survivor sweep. W's families are given by formula and analysed by hand; exact arithmetic that *checks* a given tiling is allowed | owner's rule |

### 3.5 Killing tests

**R's.** Each would kill R's argument, not R's claim.
1. **Parts calibration.** Apply R's mechanism to `[Parts2020c]`'s tiling, eroded to slack `2κ`. If the argument forces more than
   `δ₆ + O(ε)` of holes there, it is wrong.
2. **Seven-colour control.** The argument must fail on the slack hexagonal 7-colouring, and must name the step where "six" is spent (TS's K1
   rule).
3. **Strip test.** Replace the holes by TQ-HIT's strips. If every step still goes through, the argument is in hitting form and capped at
   `O(ε)`.
4. **Normalization.** R states its bound as uncovered area over plane area, never as pairs over band (stage 2, note).

**W's.**
1. **Exact check.** Every member of W's family, at given `(ε, δ)`, is a finite periodic tile colouring with rational data. Its falsifier is a
   monochromatic pair of squares whose distance interval `[min, max]` meets `[1 − ε, 1 + ε]`. The check is exact and seconds long, and it
   checks a given object, so it is allowed under the ban.
2. **Floor.** The family's claimed `δ(ε)` never falls below `ε²/78`.
3. **Class density.** Each class's density is at most 0.2470.
4. **A driving parameter.** The family has an explicit parameter that drives `δ → 0`. TQ §4.5 item 6 (c): Parts's own family has none; its
   voids keep a fixed size.

**The joint dial, after 2026-10-01.** Trace `1 − µ₆^per(ε)` along eroded Parts tilings and along W's families. Informative both ways: a flat
curve near `10⁻⁴` is R's evidence, a falling one W's. TQ §5.4 registered it.

### 3.6 Where each would have to break the other (pre-registered break table)

| the other side's step | how W breaks R | how R breaks W |
|---|---|---|
| R: holes of `ε`-independent measure in some disc of radius `R₀` | holes spread uniformly: a periodic family with density `→ 0` in every `R₀`-disc | show that holes concentrate: some bounded disc keeps `≥ δ₀` |
| R: the argument reads how holes sit relative to the colouring (it must, by TQ-HIT) | put the holes exactly where the multichromatic points would be (Parts's voids "at every vertex", TQ §4.5 item 6 (b)), and shrink them with `ε` | show that a vertex void cannot shrink without a new void appearing elsewhere: C-Q-LOCAL says local repairs cost `O(ε²)`, so the forced quantity must be non-local |
| W: a parameter shrinking the vertex voids | (W's own step) | derive a lower bound on the void at a degree-3 junction of three colours that does not depend on `ε`, from the islands constraint and the six-colour count |
| W: the Route II limit exists as a tight six-colouring | (automatic, by Route II) | R-S: prove that the limit's disjoint-multicolour pairs cannot all sit in C-T-TAN's exceptional set; close C-T-TRIb and C-T-IND without finiteness |
| both | — | the advisor asks each side, before round 1, to name the step of the other's programme it expects to fail. Retractions are counted from there (G51: zero means the disagreement has not started) |

### 3.7 Staffing, protocol and the alternatives weighed

- **The choice:** split FS-107 as TQ recommends. R works on stability and chooses R-Q or R-S. W works on periodic near-colourings. One
  advisor. Three agents, all Opus 5.5.
- **The alternative weighed:** (B), the TS split — R closes [G1]–[G3], W builds a six-coloured map with unit arcs (C-AE-Q2 FALSE).
  - W winning (B) is decisive but strictly narrower: every a.e.-proper Q2 map with null boundaries gives a W sequence (erosion costs `O(ε)`,
    S–V §9), and not conversely.
  - R winning (B) is not decisive: Q2 is implied by `χ_m⁰ ≥ 7` and does not imply it.
- **Why the split wins:** both of its outcomes decide the problem (R given MR; W with no MR), and W's objects are checkable.
- **Confidence: high**, if QB confirms TQ-EQ. If QB finds a fault in Route II, W's reward falls back to (B)'s; if the fault is in REM-i, R's
  target falls back to "a special case".
- **Protocol points** (`plans/PROTOCOL-competitor-and-advisor.md` §1):
  - identical mathematics in both briefs: the §3.4 table, TQ-EQ, and TS's lemmas, each labelled with its object;
  - each side told what the other is for;
  - teasing hints only;
  - fences as in the protocol's §1 (transcripts, `chats-bak/`, the shared scratchpad by path);
  - working files in each side's own scratch until hand-back;
  - neutral commit subjects;
  - a blind verifier on whichever side finishes first (rule 11).
- **A rung for R, not decisive:** improve TQ-EPS2's `ε²` to `ε`, where hitting-form arguments are allowed and TQ-HIT's strips show `ε` is the
  most they can give. It measures whether circle-counting reaches its own cap.

## Stage 3 — SAVED
