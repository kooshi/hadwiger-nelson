# FS107-V — blind verification of competitor R's five statements (FS-107, stability)

*Job FS107-V, de Bruijn (Opus 5.5), blind verifier. Brief: `data/fs107/briefs/V107-blind-verifier.md`, instance block
`data/fs107/briefs/V107-instance-R.md`, standing rules `data/fs107/briefs/STANDING-RULES.md`. Started 2026-09-27 at HEAD `209ce4f2`.
Read before stage 1: the brief, the instance block, the standing rules; `CLAUDE.md` from disk (§ The aim, § Counter-priors, G21, G82);
`LEDGER.md` rows 131–132; `data/fs107/claims.md` in full; `data/fs106/claims.md` §§0–2; `plans/FS106-TS-derivation.md` stage 4 (C-T-TAN)
and stage 5; `[Parts2020c]` §§1, 2.3 (text layer); A8b's line in `plans/POROS-2026-09-26-fs106-regular-half.md`.*

**Fences.** None touched. R's record `plans/FS107-R-stability.md` stays unopened until stage 3 is committed. I did run
`grep -c` for the words "fat", "CP", "blocking" over the unfenced plans and briefs, to learn whether R's definitions had been
copied anywhere I may read (they had not: the only hits are the instance block itself, `χ_CP`, and "fat Cantor set").

## Stage 1 — SAVED: quotation check, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

The instance block's five statements are R's own theorems. They are quoted from R's record, which is fenced, so they cannot
be checked against their source until stage 4. What can be checked now is every term and reference they borrow from the
claim list.

| item | what the instance block says | checked against | result |
|---|---|---|---|
| definitions | "Definitions (band-proper, partial six-colouring, junction, fat, void, SEQ, LIM) are in `data/fs107/claims.md`, D-JUNC among them, and in `LEDGER.md` row 131." | `claims.md` §0 and the objects list; row 131 | **Partly false.** SEQ, LIM, D-JUNC ("junction", "type", "complementary types"), band-properness (D-MU, row 131) and partial colourings are there. **"Fat", "void" (as a term with a radius `r`), "blocking toward `w`", the angle `µ`, the scale `s`, `t₁′`, "saturated", `A_ε(z)`, "swap", "flat boundaries of scale `s`" and "facing half-discs" are defined in neither.** They are R's definitions, in R's fenced record. So items 1, 2, 4 and 5 are not self-contained: I verify them against definitions I reconstruct (§1.2) and compare at stage 4. |
| item 1's reference | "on LIM the cone case of TS's C-T-TAN, quantified" | `claims.md` K-TAN; `plans/FS106-TS-derivation.md` stage 4, C-T-TAN | matches: C-T-TAN is TRUE there [hand, one mind], stated with slice sets `T_u`, `T_v` and a parallelogram `Π`; its failure set at cone points is tangent interfaces and bowties. |
| the killing tests the instance block paraphrases | "A CP-type bound that survived the pinhole or strip test, or that forced more than `δ₆ + O(ε)` of holes on the eroded Parts tiling, would contradict a held constraint." | `claims.md` §3, R's tests 1, 3, 5 | a faithful paraphrase of tests 1, 3 and 5 (the owner's words, not a quotation). |
| item 2's references | "(A) branch (ii)", "R, and a C-VOID disc" | `claims.md` §1 (R = C-Q-STAB, R′ = C-VOID) | R and C-VOID match `claims.md` §1; "branch (ii)" is R's own case split, unverifiable before stage 4. |
| item 5's "(hitting form)" | "capped at `O(εs)` per swap (hitting form)" | `claims.md` §0 "Hitting-form argument" (QB §1.2) | the term is defined there; whether a one-colour argument at a swap is of that form is part of the verdict. |

### 1.2 The statements in my own words, with the definitions I reconstruct

Notation (mine): `C₁, …, C₆` disjoint measurable classes, *band-proper at `ε`*: `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`
for each `j` (for LIM, `ε = 0` read as `Leb ⊗ σ`-null unit pairs, D-M). `H = ℝ² ∖ ⋃ C_j`, the uncovered set. `A_ε(z) = {y : 1 − ε ≤ |y − z| ≤ 1 + ε}`.

1. **CP.** Reconstructed reading: a junction at `u` is *fat at scale `s` with void `r`* if each colour of its three-element type
   fills (up to a null set) a connected open region `A_j ⊆ B(u, s) ∖ B(u, r)` whose projection on a line through `u` is long;
   *blocking toward `w`* (with `|w − u| = |w − v| = 1`) means the projections of the three regions at `u` on `e_u = w − u` share an
   interval of length `≍ s·sin(µ/2)`, and likewise at `v` on `e_v = w − v`. In my words: **if two junctions of complementary types, at
   distance in `[η, 2 − η]`, each have their three colours filling regions of size `s` that all "reach" the same side of the unit circle
   through `w`, then a region near `w` of area at least `(t₁ − 2r)(t₁′ − 2r′)` is uncovered, whatever `ε` is; shrinking or repairing the
   colouring inside radius `ρ` of the junctions changes this by `O(ρs)`, and the region contains a disc.** It is Voronov's Prop. 2.2
   (V-P2.2) made quantitative: the pinhole that V-P2.2 finds at `w` becomes a region of fixed size when the colour pieces at `u` and `v`
   are fat.
2. **The implication.** If every band-proper partial six-colouring with small holes in `U_R` has such a pair (A), fat at a scale bounded
   below independently of `ε`, with small voids (B), then CP gives an `ε`-independent amount of hole in a fixed disc, so C-Q-STAB (R)
   holds: either the holes are already `≥ δ` or CP supplies `(s₀ sin(µ/2)/6)²`.
3. **SAT.** Reconstructed reading of *saturated*: no class can be enlarged by a positive-measure piece of `H` and stay band-proper. In
   my words: **for such a colouring the holes are, up to a null set, exactly the points whose band annulus meets every one of the six
   classes in positive area — and that set is open.**
4. **SW.** Reconstructed reading: `p`, `q` with `|p − q| = 1`, each with multicolour `{a, b}`, and inside `B(p, s)`, `B(q, s)` the colouring
   is two half-discs separated by a straight boundary through the centre, up to holes. In the cheapest orientation (boundaries
   perpendicular to `pq`, the colours mirrored) one colour's half-discs face away from each other and the other colour's face each
   other. In my words: **such a pair forces holes of area at least `εs`; for the away-facing colour a strip of width `ε` achieves this
   order, so it is sharp; the facing colour forces `≳ s³`, which does not depend on `ε` [R: sketch].**
5. **OB′.** In my words: **a lower-bound argument whose only input at a swap is the band-properness of one colour's pairs can certify at
   most `O(εs)` of hole there** — because a strip of width `ε` satisfies that input.

### 1.3 Registered expectations (before any derivation; both outcomes reachable)

| item | expected verdict | probability | the other reachable outcome, and what would show it |
|---|---|---|---|
| 1 CP | TRUE as an exclusion lemma; the `ε`-independence is elementary (the exclusion of colour `j` from `A_j + S¹` holds for every `ε ≥ 0`) | 0.7 | MISSTATED at the constants (0.25): the curvature of unit circles moves the linear projection by `O((s + |b|)²)`, so `t₁ = s sin(µ/2)/3` and containment in `B(w, µ/4)` need a smallness condition on `s` relative to `µ` and `η` that the statement does not show; FALSE (≤ 0.05) only if the exclusion step itself fails |
| 2 implication | TRUE, possibly after a radius repair | 0.7 | GAP (0.3) if the quantifiers of (A), (B) let `s₀`, `µ` or `η` depend on `ε`, or if CP needs `s` bounded above and (B) does not provide it |
| 3 SAT | TRUE | 0.9 | MISSTATED if "saturated" is not maximality under adding positive-measure pieces of `H` |
| 4 SW, `εs` | TRUE | 0.85 | FALSE if some flat orientation is cheaper than `εs` |
| 4 SW, `s³` | TRUE | 0.65 | FALSE or smaller order if the facing colour's conflicts can be removed by holes of area `o(s³)` |
| 5 OB′ | TRUE for the away-facing colour; **MISSTATED if "one colour" may be the facing colour and the `s³` bound holds** (then reading that colour certifies `≳ s³`, not `O(εs)`) | 0.5 / 0.5 | decided by item 4's `s³` part and by R's definition of "reads only one colour's pairs" |

**Would have searched here:** nothing yet.

## Stage 2 — SAVED: the killing tests on CP, then derivations

Tools written (standing rule 7): `tools/fs107_v_cp_check.py` (exclusion geometry of two complementary junctions; outputs in
`data/fs107/fs107-v/cp_check.out`) and `tools/fs107_v_sw_check.py` (the inequalities behind the `s³` proof; outputs in
`data/fs107/fs107-v/sw_check.out`). Each has a planted fault that fired for its own reason: `--plant` in the first drops the
inner-radius candidate from the closed-form maximum distance, and its brute-force self-test goes red (worst excess 0.55 against
`10⁻⁹`); `--plant` in the second swaps in the away-facing colour's half-discs, and inequality (i) reads 0 instead of `≥ 1`. A
third red was unplanned and is recorded because it was mine: the first on-axis cross-check in the CP tool used a hand closed form
that forgot the inner corners of the junction; the grid disagreed (lower end 0.000087 against 0.003023), the grid was right, and
the closed form now takes both corners.

### 2.1 Item 1 (CP): the five killing tests, run on the statement's shape before deriving it

The shape read from the statement alone: fat colour pieces at `u` and `v` exclude their colours from every point whose unit circle
passes through them (band-properness, for every `ε ≥ 0`); two complementary triples exclude all six colours from a region near `w`;
that region is uncovered. Six is spent where "all six" is used.

| test (`claims.md` §3) | result on CP | held constraint it would have contradicted |
|---|---|---|
| 1 Parts calibration | **not a kill.** CP is a local deduction valid in every band-proper colouring (derived in §2.2), so it cannot force more holes on the eroded Parts tiling than the tiling has. What the test constrains is R's use of CP: in `[Parts2020c]` §2.3 the voids sit **at** the degree-4 vertices (rhombic/dodecagonal, `l ≈ 0.0133`, `r ≈ 0.0055`) and at type-B corners, not at points `w` at distance 1 from two junctions. So wherever the eroded Parts tiling satisfies CP's hypotheses, the forced region must lie in one of those voids, which caps the constants: a forced area `(s₀ sin(µ/2)/6)²` must fit in a void of area `~10⁻⁵–10⁻⁴`, so `s₀ sin(µ/2) ≲ 0.05`, or else (A) ∧ (B) is false on the Parts tiling. Not run per junction: the paper's text layer does not give the colour assignment of the tiles. | K-CEIL (`1 − µ₆(ε) ≤ δ₆ + O(ε)`) |
| 2 Seven-colour control | **passes.** The region is excluded from every colour in `type(u) ∪ type(v)`; with seven colours a seventh fills it. Six is spent at "complementary types exhaust the palette" (K-C6). | K1 rule (TS) |
| 3 Strip test | **passes (not hitting form).** CP reads the holes only as "the complement of the classes". Replacing the holes by strips of width `2ε` leaves the region near `w` coloured, and then the exclusion step says those coloured points make band pairs with the fat pieces: the strip configuration is not band-proper, so the step does not go through. CP's conclusion is a region of `ε`-independent area, which no strip of width `2ε` contains. | K-HIT (cap `ε`) |
| 4 Normalization | **passes.** CP bounds uncovered area in `B(w, µ/4)`; R's implication divides by a disc's area. | — |
| 5 Pinhole test | **passes**, for the same reason as the strip test: a disc of radius `≍ ε` at `w` cannot contain the forced region, and a pinhole configuration with such junctions is not band-proper. | A8b / K-AD (cap `ε²`) |

So CP contradicts no held constraint. It survives the tests because it is not an argument about holes at all: it is an exclusion
lemma about fat colour pieces, and the whole difficulty sits in (A) and (B), which R grades GAP.

### 2.2 Item 1 (CP): derivation, and a counterexample to the statement's constant

**Definitions I use** (R's are fenced). `σ = sin(µ/2)`. A junction at `u` of type `{1, 2, 3}` is *fat at scale `s` with void
`r`, blocking toward `w` on the outer side*, if for each `j` the class `C_j` contains, up to a null set, a connected open cone piece
`A_j ⊆ B(u, s) ∖ B(u, r)` whose linear projection `{(a − u)·e_u : a ∈ A_j}` contains the interval `(r, sσ)`, with `e_u = w − u`,
`|w − u| = 1`. (The inner side is the mirror image. In the ring junctions of the tool, a colour whose cone has opening `µ` and
straddles the direction `e_u^⊥` has exactly this projection.)

**Step 1, exclusion [hand].** Let `A` be open and connected with `A ⊆ C_j` a.e. If some `a ∈ A` has `|z − a| = 1`, then the band
annulus `A_ε(z)` meets `A` in an open non-empty set, so `|A_ε(z) ∩ C_j| > 0` (for `ε = 0`: the unit circle about `z` meets `A` in an
arc of positive length). By Fubini, band-properness makes `|A_ε(z) ∩ C_j| = 0` for a.e. `z ∈ C_j`. So `X_j = A + S¹` meets `C_j` in a
null set, **for every `ε ≥ 0`**. And since `A` is connected, `z ∈ X_j` iff `min_{a ∈ A}|z − a| ≤ 1 ≤ max_{a ∈ A}|z − a|` (strictly,
up to null sets).

**Step 2, where six is spent.** `X = X₁ ∩ ⋯ ∩ X₆` is uncovered up to a null set, because the six colours are the whole palette.

**Step 3, the region [hand].** Write `z = u + (1 + ρ)ω`, `ω = e^{iφ}e_u`. Then `|z − a| = 1` iff
`h(a′) := a′·ω − |a′|²/(2(1 + ρ)) = F(ρ) := ρ(2 + ρ)/(2(1 + ρ))`, with `a′ = a − u`, and `ρ − ρ²/2 ≤ F(ρ) ≤ ρ` for `ρ ≥ 0`.
`h(A_j − u)` is an interval with `|h(a′) − a′·e_u| ≤ s|φ| + |a′|²/2`, the curvature term only lowering `h`. Points with projection
just above `r` give `h ≤ r + s|φ|`; points with projection just below `sσ` give `h ≥ sσ − s|φ| − s²/2`. **If `s ≤ σ`**, the last is
`≥ sσ/2 − s|φ|`, so colour `j` is excluded whenever `ρ ∈ (r + s|φ| + ρ²/2, sσ/2 − s|φ|)`. For `|φ| ≤ σ/16` this band has length
`≥ sσ/2 − sσ/8 − r − 0.09(sσ)² ≥ sσ/4 − r`. In the bipolar coordinates `(|z − u|, |z − v|)`, whose Jacobian is `sin∠uzv ≤ 1` and
which are 1-Lipschitz, the product of the two bands pulls back to a region of area `≥ (sσ/4 − r)(s′σ/4 − r′)` containing a disc of
radius `min(sσ/4 − r, s′σ/4 − r′)/2`. It lies within `|z − w| ≤ sσ/sin θ` (`sin θ = d√(4 − d²)/2`, `d = |u − v|`), so the condition
`|φ| ≤ σ/16` holds when `s ≤ sin θ/18`, and then the region is inside `B(w, σ/16) ⊂ B(w, µ/4)`.

**V-CP (proved, [hand, one mind]):** *if `s, s′ ≤ min(sin(µ/2), sin θ/18)`, two fat junctions of complementary types blocking toward
`w` on one side force, for every `ε ≥ 0`, `|H ∩ B(w, µ/4)| ≥ (s sin(µ/2)/4 − r)(s′ sin(µ/2)/4 − r′)`, and `H` contains a disc of radius
`min(…)/2`. A repair inside `B(u, ρ)` only raises the inner radius from `r` to `max(r, ρ)`, so it moves the bound by `O(ρs)`.* My
constant `sσ/4 − r` is cruder than R's `sσ/3 − 2r` for small `r`; the tool finds R's constant comfortably met in that regime
(forced area 11× R's bound at `s = 0.02`, 6× at `s = 0.1`; `cp_check.out`, C2 and C3).

**Without `s ≤ sin(µ/2)` the constant fails [tools, float, grid-converged; the on-axis band also in closed form].** The
curvature term `|a′|²/2` caps the exclusion of a colour whose cone reaches the projection `sσ` only near the direction `e_u^⊥`: its
exact range ends at `≈ σ²/2` once `s > σ`, while `t₁ = sσ/3` keeps growing. Configuration C1 of the tool: `d = √2`, `µ = 20°`,
`s = 0.33`, `r = 0.0005`; at each junction the annulus is cut at `−80°, 80°, 100°` from the direction to `w` (colour 2 is the 20° cone
centred on `e^⊥`, colours 1 and 3 fill the rest); the linear projections share `(0.0001, 0.0573)`, exactly `s sin(µ/2)` long. On the
axis through `u` and `w` the exact band is `(0.000087, 0.015427)` (colours 2, 3: `(1 + ρ) sin 80° < 1`; colour 1: its inner corner),
length `0.01534`, **below R's per-side `t₁ − 2r = 0.01810`**; the area forced in `B(w, µ/4)` is `2.165·10⁻⁴` **against R's bound
`3.277·10⁻⁴`**. The local colouring made of the two rings plus every other point of `B(w, µ/4)` coloured by a colour not excluded
there is band-proper for small `ε` (the near-`w` points are within `0.18` of each other; each avoids the band of its colour's ring by
construction; the rings are islands of diameter `0.66`; the two junctions' colours are disjoint), so its holes in `B(w, µ/4)` are
exactly the forced set: **a counterexample to CP as stated, in my reading of "fat" and "blocking".** The failure window for this
geometry is `1.54 σ ≲ s ≲ 2σ` (at `s = 0.36` the area is `3.67·10⁻⁴` against `3.94·10⁻⁴`; at `s ≥ 2σ` colour 1's outer corner
extends the band below `ρ = 0` and the area grows again, `2.27·10⁻³` at `s = 0.45`).

**Two further facts the tool shows, recorded for R's programme.** C4: a junction whose three pieces leave a large void (no common
projection) forces nothing, as it must. **C5: a full-ring junction with an interface exactly along `e_u^⊥` — C-T-TAN's tangent
exceptional case, linear blocking length 0 — still forces area `6.8·10⁻⁵` at `s = 0.1`**: at positive scale the curvature gives an
overlap of depth `≍ s²`, so tangency is exceptional only in the blow-up limit. A ring junction (three colours filling the whole
annulus) therefore blocks toward every `w`, at second order at worst.

### 2.3 Item 2: the implication "(A) and (B) ⟹ R", given CP

- **Arithmetic:** `t₁ − 2r ≥ sσ/3 − sσ/6 = sσ/6 ≥ s₀σ/6` when `r ≤ sσ/12`. ✓
- **Location (a slip):** `w ∈ U_{R+1}`, but `B(w, µ/4)` need not lie in `U_{R+1}`; the bound is on `|H ∩ U_{R+1+µ/4}|`. Harmless: R
  asks only for some radius.
- **Quantifiers:** R needs `δ₀` independent of `ε`. Take `R* = R + 1 + µ/4 + s` (the cones must lie in the domain). A partial
  colouring of `U_{R*}` either has `|H ∩ U_R| ≥ δ|U_R|`, or (A), (B) and CP give `|H ∩ U_{R*}| ≥ (s₀σ/6)²`; so
  `δ₀ = min(δ|U_R|, (s₀σ/6)²)/|U_{R*}|` works **provided `R, η, µ, δ, s₀` do not depend on `ε`**, which the quoted (A), (B) say.
- **CP's range (the substantive repair):** by §2.2, CP's constant needs `s ≤ sin(µ/2)` (and, in my proof, `s ≤ sin θ_η/18`), while
  (B) bounds `s` only below. Fat cones pass to smaller scales (a cone truncated at `s* = min(s, σ, sin θ_η/18)` keeps a projection
  containing `(r, s*σ)`), so the implication goes through with `s₀` replaced by `min(s₀, σ, sin θ_η/18)` — **but only if the voids
  are small at that scale, `r ≤ s*σ/12`**, which (B)'s `r ≤ sσ/12` does not give when `s > s*`. A void of large radius is not
  automatically a large hole (a hole component of radius `r` can be thin). So (B) must be strengthened to voids small relative to
  `min(s, sin(µ/2))·sin(µ/2)`, an `ε`-independent condition of the same kind. With that, the implication is TRUE.
- **"and a C-VOID disc":** CP's region contains a disc, so in the branch "holes `< δ` in `U_R`" there is an uncovered disc of
  radius `≍ s₀σ`; but C-VOID asks for a disc in **every** colouring, and in the other branch (holes `≥ δ`, possibly spread thin) the
  argument gives none. So (A) ∧ (B) ⟹ C-VOID does not follow as quoted; (A) ∧ (B) ⟹ R does.

### 2.4 Item 3 (SAT): derivation [hand, second mind]

*Saturated*, my reading: no class can be enlarged by a positive-measure subset of `H` and stay band-proper.
`g_j(z) = |A_ε(z) ∩ C_j| = (1_{C_j} ∗ 1_{A_ε(0)})(z)` is continuous (`L^∞ ∗ L¹`), so `O = ⋂_j {g_j > 0}` is open. (i) `O ⊆ H` a.e.:
by Fubini, band-properness gives `g_j = 0` a.e. on `C_j`. (ii) `H ⊆ O` a.e.: if `Z_j = {z ∈ H : g_j(z) = 0}` had positive measure,
take a density point and `Z′ = Z_j ∩ B(x, ρ)` with `2ρ < 1 − ε` and `|Z′| > 0`; then `C_j ∪ Z′` is band-proper — pairs inside `Z′` are
shorter than `1 − ε`, and pairs between `C_j` and `Z′` have measure `∫_{Z′} g_j = 0` — against saturation. **TRUE.** It needs
`ε > 0` (at `ε = 0` the annulus is a circle and `g_j ≡ 0`).

### 2.5 Item 4 (SW): derivation

Reading: `p = (0, 0)`, `q = (1, 0)`, multicolour `{a, b}` at both, and in `B(p, s)`, `B(q, s)` two half-discs split by straight
lines through the centres, up to holes. Tilted boundaries make both colours' projections on `pq` overlap on an interval of length
`≍ s·(tilt)`, which costs more, so the cheapest case is boundaries perpendicular to `pq`, mirrored: colour `a` on `{x < 0}` at `p` and
`{x > 1}` at `q` (away-facing), colour `b` on `{x > 0}` at `p` and `{x < 1}` at `q` (facing). The two colours' costs add (their
half-discs are disjoint).

**The away-facing colour: `≥ 2ε√(s² − ε²)`, and a strip of width `ε` achieves `≤ 2εs` [hand].** With `a = (−α, y)`,
`b = (1 + β, y′)`, `d² = (1 + α + β)² + (y′ − y)² ≥ 1`. Cut the heights into intervals `I` of length `τ√ε`. For `y, y′ ∈ I`, every
pair with `α + β ≤ c = √((1 + ε)² − τ²ε) − 1` is a band pair. Band-properness and Fubini give, for a.e. `(y, y′) ∈ I²`,
`m_p(y) + m_q(y′) ≥ c`, where `m` is the essential infimum of the kept depths below `c` in the fibre (and the fibre below `m` is all
hole). Integrating, the holes in the rows over `I` are `≥ |I|·c`; summing over the heights where both fibres reach depth `ε` and
letting `τ → 0` gives `≥ 2ε√(s² − ε²)`. Removing `{−ε < x < 0} ∩ B(p, s)` kills every band pair of colour `a` (then `d ≥ 1 + ε`) at
cost `≤ 2εs`. So **"`≥ εs`" is TRUE** — the sharp constant for half-discs of radius `s` is `2εs`; R's `εs` is the bound for a
boundary segment of length `s` — and **"sharp for one colour" is TRUE.**

**The facing colour: `≥ s³/256`, for every `ε ≤ s²/32`, `s ≤ 1/2` [hand, and the inequalities checked, `sw_check.out`].** Take
`a = (α, y)`, `b = (1 − β, y′)`, `P = {0 < α < s²/32, −s/2 < y < −s/4}`, `P_good = P ∩ {y < −3s/8}`, `Q = {0 < β < s², 0 < y′ < s/2}`,
all inside the half-discs. For `a ∈ P_good` and every `y′`, the lateral offset `Δ = y′ − y ∈ (3s/8, s)` puts the unit-distance depth
`β* = 1 − α − √(1 − Δ²) ∈ (5s²/128, 0.53s²)` inside `Q`, and the band in `β` is an interval of length
`√((1 + ε)² − Δ²) − √((1 − ε)² − Δ²) ≥ 2ε`, inside `(0, s²)` when `ε ≤ s²/32`: so (i) `|band(a) ∩ Q| ≥ εs`. For every `b ∈ Q`,
(ii) `|band(b) ∩ P| ≤ 0.6εs` (derivative bound `2.4ε` per fibre over a height range `s/4`; measured `≤ 0.19εs`). Then
`0 = ∫_{P∖H} |band(a) ∩ (Q∖H)| da ≥ εs(|P_good| − |H ∩ P|) − 0.6εs|H ∩ Q|`, so
**`|H ∩ P| + |H ∩ Q| ≥ |P_good| = s³/256`, independent of `ε`**. The same count with `σ`-measure on circles gives the tight case: on
LIM a flat facing pair cannot occur at all (consistent with TS-U). **R's `[sketch]` is TRUE, with the constant `1/256`** (crude).

### 2.6 Item 5 (OB′)

An argument whose only input at a swap is the band-properness of the **away-facing** colour's pairs cannot certify more than
`2εs(1 + o(1))`, because the strip of §2.5 satisfies that input: TRUE, and of K-HIT's type. But the proof of §2.5's `s³` bound reads
**only the facing colour's pairs** and certifies `s³/256`, which does not tend to 0 with `ε`. So OB′ holds for one of the two colours
of a flat swap and fails for the other.

### Would have searched here

- The extent of CP's failure: I would have scanned `(s, µ, d, cut angles)`. Instead: one geometry derived from the curvature
  argument, its on-axis band in closed form, and a dial of six values of `s` and five of `d` on that named configuration (seconds).
- The Parts calibration per junction: I would have coloured the Parts tiling from its figure and scanned its complementary pairs.
  Not done (the colour assignment is not in the text layer); the test was run at the level of constants (§2.1).

## Stage 3 — SAVED: verdicts (before reading R's record)

All verdicts are on the statements as quoted in the instance block, read with **my** definitions of the terms the claim list does
not define (§1.1: fat, void, blocking, `µ`, `s`, saturated, swap, flat boundaries). "Minds" counts derivations: R's and mine,
mine blind to R's.

| # | statement | verdict | minds / grade | the reason in one line |
|---|---|---|---|---|
| 1 | FS107-R-CP | **MISSTATED.** Corrected (V-CP): with the scale restricted, `s, s′ ≤ min(sin(µ/2), sin θ/18)`, two fat complementary junctions blocking toward `w` force `|H ∩ B(w, µ/4)| ≥ (s sin(µ/2)/4 − r)(s′ sin(µ/2)/4 − r′)` for every `ε ≥ 0`, with an uncovered disc, stable to `O(ρs)` under repairs inside radius `ρ` — **TRUE**. As stated, with `s` unrestricted, **FALSE in my reading**: configuration C1 (`µ = 20°`, `s = 0.33`) is a band-proper local colouring whose holes in `B(w, µ/4)` are `2.165·10⁻⁴` against R's bound `3.277·10⁻⁴`; failure window `≈ 1.54 sin(µ/2) < s < 2 sin(µ/2)` for that geometry. `ε`-independence, the repair clause, the disc and the LIM reading are TRUE. | V-CP: two (R; V) if R's definitions carry a scale restriction, else one (V) / [hand] + [tools, float] for the counterexample and the constant check | the curvature of unit circles subtracts up to `s²/2` from a colour's exclusion range; R's `t₁ = s sin(µ/2)/3` is the linear value, right only while `s ≲ sin(µ/2)` |
| 1′ | the five killing tests on CP | passes tests 2–5; test 1 constrains (A) ∧ (B), not CP (a forced area `(s₀ sin(µ/2)/6)²` must fit in a Parts void, so `s₀ sin(µ/2) ≲ 0.05` or (A) ∧ (B) fails on the eroded Parts tiling). **CP contradicts no held constraint** (K-CEIL, K-HIT, A8b/K-AD). | one (V) / [hand] | CP is an exclusion lemma about fat colour pieces, not an argument about holes |
| 2 | (A) and (B) ⟹ R, given CP | **TRUE after two repairs:** the disc is `U_{R+1+µ/4}`, not `U_{R+1}` (a slip); and CP's scale restriction must be threaded into (B) — voids small relative to `min(s, sin(µ/2))·sin(µ/2)` — since (B) bounds `s` only from below. The quoted "and a C-VOID disc" does **not** follow for C-VOID as stated (GAP at the branch "holes `≥ δ`", where no disc is produced). | one (V), R's a second if R's record has the repairs / [hand] | quantifiers check: `δ₀ = min(δ|U_R|, (s₀σ/6)²)/|U_{R*}|`, all `ε`-independent |
| 3 | FS107-R-SAT | **TRUE** (needs `ε > 0`) | two (R; V) / [hand] | `g_j = 1_{C_j} ∗ 1_{A_ε}` is continuous; Fubini one way, saturation plus a density point the other |
| 4a | FS107-R-SW, `εs` part | **TRUE**; sharp constant `2εs` for half-discs of radius `s` (strip of width `ε`); every flat orientation costs at least this order | two (R; V) / [hand] | fibre argument on the away-facing colour; tilted boundaries only add overlap |
| 4b | FS107-R-SW, `s³` part | **TRUE** — R's sketch promoted: `|H ∩ (B(p,s) ∪ B(q,s))| ≥ s³/256` for `s ≤ 1/2`, every `ε ≤ s²/32`, independent of `ε` | two (R's sketch; V's proof) / [hand] + [tools] for the two inequalities | double count of band pairs between two regions of the facing half-discs |
| 5 | FS107-R-OB′ | **MISSTATED.** Corrected: *an argument that reads at a flat swap only the pairs of the away-facing colour is capped at `2εs(1 + o(1))` per swap (hitting form)* — TRUE. As stated ("one colour"), FALSE for the facing colour, whose pairs alone certify `s³/256`. | one (V) / [hand] | 4a's strip realises the cap; 4b's proof reads only the facing colour |

**Audit of the flattering results at a FALSE's rate.** The results that would move R toward the answer are CP's `ε`-independence
(held, and I found its constant too generous, not too weak) and 4b's `ε`-independent `s³` (flattering to R). 4b was re-checked on
the points a G21 reader would press: both regions lie inside the facing half-discs; the band interval lies inside `Q`'s depth range
for every `y′` when `ε ≤ s²/32` (`β* ∈ (5s²/128, 0.53s²)`, margin `1.2ε`); the double count uses only that inside `Q` every point is
colour `b` or a hole, which is the flat-boundary hypothesis; the planted swap to the away-facing colour sends (i) to 0. Its reach is
narrow: it prices flat facing configurations, which a colouring avoids by curving its boundaries (TS-U's side cones); it is not a
door to R by itself.

**Predictions scored** (§1.3): CP — the "MISSTATED at the constants" branch fired (registered 0.25), but through the curvature
window, not the location condition I had in mind; implication — TRUE after repair (registered 0.7) ✓; SAT ✓; SW `εs` ✓; SW `s³` ✓
(0.65); OB′ — MISSTATED (0.5) ✓.
