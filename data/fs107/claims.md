# FS-107 — the fixed claim list (statements only)

*Written by the milestone planner (job FS107-P), 2026-09-27. **Statements only: no proof, no sketch, no route.** Every quotation is verbatim, with
its source address; text outside quotation marks is this list's own and says so. Grades are `CLAUDE.md` § Notation's; "minds" counts derivations.
Where A2's table (`plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3.4, written before FS-106's close) and the close (`plans/FS106-derivation.md`)
differ, both are quoted and **the close's statement and grade govern**. Give every claim you work one verdict — **TRUE** (with your derivation),
**FALSE** (with a counterexample), **GAP at a named step**, or **MISSTATED** (with the corrected statement, graded) — with your count of minds and
your grade. FALSE and GAP are results, as valuable as TRUE (standing rule 4).*

**Objects.** Every claim names its object:
- **SEQ, the sequence object** (A2 §3.2): "periodic grid-square partial six-colourings with slack `ε_n → 0` and holes `δ_n → 0`". A2: "The only gap on
  this object is the hole gap."
- **LIM, the limit object** (A2 §3.2): "W's Route II limit, a tight a.e.-proper six-colouring in D-NF. Here TS's gaps are the whole content".
- **both**: a statement about every band-proper partial six-colouring, or about arguments.

## 0. Definitions (quoted)

- **D-MU** (`data/fs106/claims.md` l. 49): "`µ₆(ε)`: the supremum of the upper density of `C₁ ∪ ⋯ ∪ C₆` over disjoint measurable `C₁, …, C₆ ⊆ ℝ²`, each
  with `(Leb ⊗ Leb){(x, y) ∈ C_j² : 1 − ε ≤ |x − y| ≤ 1 + ε} = 0`."
- **`µ₆⁰`** (`data/fs106/claims.md`, § Corrections at the close): "it is the supremum of the upper density of `C₁ ∪ ⋯ ∪ C₆` over disjoint measurable
  classes whose unit pairs are `Leb ⊗ σ`-null (TQ §3; QB §1.2); `µ_k(ε)`, `µ_k⁰` likewise for `k` classes."
- **`µ₆^per`, `µ₆^tile`** (`plans/FS106-QB-verification.md` §1.2): "**`µ₆^per(ε)`:** the same supremum over `ε`-slack families invariant under `Lℤ²` for
  some `L > 0` (the "periodic grid-square" families; the density exists)." "**`µ₆^tile(ε)`:** the same supremum over `ε`-slack families each of whose
  classes is, up to a null set, a union of cells `hk + [0, h)²`, `k ∈ ℤ²`, for some `h > 0`".
- **Hitting-form argument** (QB §1.2): "an argument whose only use of the uncovered set `H` is that `H` meets every unit circle `T₁(u)` and every
  bicycle `T₁(u) ∪ T₁(v)`, `1 < |u − v| < 2`, in a set of positive length".
- **Effective hole** (TQ §4.4): "an effective hole is one containing a point `≥ ε/2` from the coloured set, since thinner holes fill (HOLE-t)".
- D-CP, D-NF, D-SLACK ("*Tight*: slack for no `ε > 0`"), D-VMC (multicolour, chromaticity): `data/fs106/claims.md` §0, verbatim there. "Tight" here
  is D-SLACK's, never Hoffman's (`CLAUDE.md` G54).

## 1. The two questions, and the theorem they stand on

- **H-EQ (held)** — FS106-EQ (`plans/FS106-derivation.md` §4): "For every k, with no MR and no Voronov: χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺
  lim_{ε→0} µ_k(ε) = 1 ⟺ for every δ > 0 there are ε > 0 and a periodic partial k-colouring by half-open grid squares with no monochromatic pair at
  any distance in [1 − ε, 1 + ε], leaving density ≤ δ uncovered. At k = 6: χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1". **[hand; two minds, one blind]**.
  G21 (QB §3.2): "TQ-EQ is true and is a **compactness restatement**: it moves no value."
- **R — C-Q-STAB, the exact disc form** (A2 §3.3; TQ §4.5 item 2, "The exact disc equivalent is 'for some radius `R`'"): "for some `R` and `δ₀ > 0` and
  every `ε > 0`, every partial six-colouring of `U_R(0)` with no monochromatic pair at distance in `[1 − ε, 1 + ε]` leaves at least `δ₀|U_R|` uncovered."
  Object: both (R-Q on SEQ; R-S on LIM). With H-EQ it is `χ_m⁰(ℝ²) ≥ 7`; given MR (`LEDGER.md` rows 120, 128, 130), `χ(ℝ²) = 7`. Status: **GAP — it is
  the open question** (FS106-STAB).
  - The mechanism asked for (TQ §4.5 item 5): "a mechanism forcing holes of `ε`-independent total measure — a Voronov-type contradiction robust to a free
    colour on any set that is thin at scale `ρ₀`, for every band `ε ≪ ρ₀`." (TQ never defines "thin at a scale `ρ₀`", A2 §0; the disc form is the exact
    question.)
  - R-S's reading (TQ §5.2): "**Hadwiger–Nelson's measurable form is "Voronov's argument on regular colourings, robust to a free colour of vanishing
    density".**"
- **R′ — C-VOID, an intermediate claim for R** (FS107-A's card to the planner, 2026-09-27, verbatim): "some ρ₀, R₀ > 0 such that for every ε every
  band-proper partial six-colouring leaves a fully uncovered ρ₀-disc inside every R₀-disc". Object: both. *This list's note:* C-VOID ⟹ C-Q-STAB, **not
  conversely** (holes of measure bounded below may be many small ones); a W family whose largest uncovered disc has inradius → 0 at coverage bounded
  away from 1 refutes C-VOID and decides nothing. Status: open.
- **R″ — the rung** (A2 §3.7): "improve TQ-EPS2's `ε²` to `ε`, where hitting-form arguments are allowed and TQ-HIT's strips show `ε` is the most they can
  give." Not decisive.
- **W — TQ-EQ (e)** (TQ §3.5, verbatim): "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, with no
  monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered". Object: SEQ. Equivalently (c): "`µ₆⁰ = 1`"; A2 §3.3: "Tight
  polygonal tilings in `[Parts2020c]`'s framework with voids tending to 0 would do, because TQ-SUP equates the tight and slack suprema." Success gives
  `χ_m⁰(ℝ²) ≤ 6` and `χ(ℝ²) ≤ 6` **with no MR** (I-EASY); with five colours, `χ(ℝ²) ≤ 5` — the two are different outcomes (G64). A2 §3.3: "**The
  direction W relies on is the easy one.**"

## 2. Shared constraints (A2 §3.4 verbatim; each row's object; the close's statement and grade)

| id | A2 §3.4, verbatim ("constraint" · "statement and address" · "grade") | object | as FS-106's close left it |
|---|---|---|---|
| K-FLOOR | "floor on holes" · "`1 − µ₆(ε) ≥ ε²/78` for every `ε` (TQ-EPS2, TQ §4.2): a W family with `δ < ε²/78` is wrong, and an R bound below this is already held" · "[hand], one mind; input C-CS-2 at two minds" | both | FS106-EPS2: "Given `[Voronov2023]` Thm 1.3, every partial six-colouring of ℝ² whose monochromatic pairs at distances in [1 − ε, 1 + ε] are Leb ⊗ Leb-null leaves lower density ≥ ε²/(6 + ε)² uncovered (TQ: ε²/78); unconditionally the statement implies V-1.1 at each ε." **[hand; two minds, one blind; conditional on V-1.3]** — W's floor is `ε²/(6+ε)²` |
| K-CEIL | "ceiling on any stability constant" · "`1 − µ₆⁰ ≤ δ₆ = 1.430172·10⁻⁴`, and `1 − µ₆(ε) ≤ δ₆ + O(ε)` (Parts's tiling; TQ-ERODE, §4.3)" · "[external] + [hand], one mind" | both | FS106-LOCAL: "For every δ > δ₆ … there are ε > 0 and a band-proper colouring of a subset of U₃(0) of density ≥ 1 − δ in which every coloured point has chromaticity 1; at δ = δ₆ it is a GAP, likely TRUE" — **[hand; two minds, one blind; over Parts (external)]**; FS106-EPS2: "With `[Parts2020c]`: `ε²/(6+ε)² ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)`" |
| K-DENS | "class density" · "each class `≤ m₁(ℝ²) ≤ 0.2470` (row 129's input)" · "[external]" | both | unchanged; `m₁(ℝ²) ≤ 0.246989 < 0.2470` is re-checked here at [cert + hand] (`BIBLIOGRAPHY.md` `[AmbrusEtAl2023]`) |
| K-INT | "integrality" · "one-class-at-a-time and fractional arguments stop below 4.37 colours; the fractional relaxation of `µ₆⁰` is 1 (row 129, G60; TQ §4.5 item 5)" · "[hand], two minds (row 129)" | R's arguments | unchanged |
| K-THIN | "thin holes are free" · "HOLE-t: a hole whose points all lie within `t < ε/2` of the coloured set fills, at a band loss of `2t` (TQ §4.1)" · "[hand], one mind" | SEQ | unchanged (TQ §4.1; QB's fill Lemma F, §2.8, is a related form) |
| K-PIX | "no multichromatic coloured point, WLOG" · "TQ-ERODE / L1: erosion removes every multichromatic coloured point at cost `O(κ)` (TQ §4.3). R may not start from a trichromatic *coloured* point" · "[hand], one mind" | SEQ | FS106-PIX: "any band-proper partial six-colouring of U₃ becomes, at arbitrarily small cost in slack and coverage, one in which every coloured point has chromaticity 1; so a trichromatic-point method cannot see partial colourings, and a trichromatic-point lemma for partial colourings would already carry C-Q-STAB's full strength." **[hand; two minds, one blind]** |
| K-HIT | "not hitting form" · "TQ-HIT: strips of width `2ε` at spacing `1/2` meet every circle and bicycle, at density `4ε` (TQ §4.4)" · "[hand], one mind" | R's arguments | FS106-HIT: "Strips of width 2ε at spacing 2 (density ε) are effective holes that meet every unit circle and every bicycle in positive length; so an argument that only counts holes hit by circles or bicycles proves at most 1 − µ₆(ε) ≳ ε, which tends to 0 and decides nothing." **[hand; two minds, one blind]** — the cap is `ε` |
| K-TIGHT | "the limit is tight" · "C-AE-SLACK: an a.e.-proper colouring with slack needs seven (V, l. 113)" · "[hand], one mind" | LIM | FS106-AE-SLACK, **[hand; two minds, one blind]**, given `[Voronov2023]` Thm 1.3 |
| K-REG | "the limit is not polygonal, not a nice map" · "C-AE-POLY (except `d = 2`), C-AE-NICE (TS §3; V3)" · "[hand], one mind per route" | LIM | FS106-AE-POLY (except `d = 2`) and FS106-AE-NICE: row 132's grades ("the polygon chain and the convex reduction two, one blind"; "nice maps two readings") |
| K-ISL | "islands" · "band-proper same-colour pieces have diameter `≤ 1 − ε`; two of them are all within `1 − ε` or all beyond `1 + ε` (TQ §5.1; TS-C, TS-C′)" · "[hand], one mind" | both | FS106-TS-C **[two minds, one blind]** (LIM); TS-C′ one mind; the SEQ form TQ §5.1, one mind |
| K-TAN | "the limit's exceptional set" · "wherever W's limit has two points of disjoint three-element multicolours within distance 2, they sit at a tangent interface, a bowtie, a cusp, or a blow-up converging only weak-* (C-T-TAN, TS §4). Whether such pairs must exist is C-T-TRIb / C-T-PIG, a GAP" · "[hand], one mind" | LIM | unchanged |
| K-BAN | "the ban" · "to 2026-10-01: no optimiser, no SAT, no survivor sweep. W's families are given by formula and analysed by hand; exact arithmetic that *checks* a given tiling is allowed" · "owner's rule" | both | beyond 2026-10-01, Kooshi's ruling stands: "search for a finite graph is out. It would be huge, not feasible." (`CLAUDE.md` § Publication) |

**Added by the planner at the advisor's request (FS107-A's record `plans/POROS-2026-09-27-fs107-stability.md`, § Theorems this phase proved, verbatim):**

- **K-C6** (both; checkable on SEQ): "in a six-colour palette two three-element multicolours are disjoint iff they are complementary; so C-T-TAN's "two
  points of disjoint three-element multicolours within distance 2" is "two junctions of complementary type within distance 2", and a colouring avoids it
  iff, in every disc of diameter 2, its junction types lie in one of the families that choose at most one triple from each of the 10 complementary pairs."
  **[hand, one mind, trivial.]**
- **K-BICH** (SEQ; maps): "a map whose face-adjacency graph is connected and in which every vertex meets at most two colours uses at most two colours."
  "So every map in six colours has a vertex where three colours meet." **[hand, one mind]**
- **K-AD, a reading** (R's arguments): "an argument whose only use of the holes is "an effective hole within `Cε` of every anchor of a set `A`" certifies at
  most `≍ N(A ∩ Q, ε)·ε²` of hole area per unit square `Q` (`N` the `ε`-covering number): `ε²` for finitely many anchors per unit area (A8b, TQ-EPS2), `ε`
  for curves of anchors (TQ-HIT), `Θ(1)` only for anchors of positive measure — or for holes of an `ε`-independent size `ρ₀`." **[derived, one mind; credit
  TQ §4.4]** — *this list's grade: a [reading]*, killing test (this list's wording): an argument whose anchors form a null set of dimension `< 2` that
  certifies hole area bounded below uniformly in `ε`.
- **K-KILL** (LIM; TS §5 row C-T-KILL, verbatim): "**split: the disjoint-multicolour half TRUE under C-T-TAN's hypotheses; the same-multicolour half GAP**"
  — "Same multicolour at distance in `(1, 2)`: Lemma 3's transplanted bicycle needs C-T-ANN's curves and C-T-IND's finiteness." [hand, one mind]
- **K-CHR4** (LIM; TS §5 row C-T-CHR4, verbatim): "**GAP** — proved for `|P(x)| ≥ 5` off a null set; `|P(x)| = 4` open". *This list's note:* four-colour
  junctions are **not** excluded on LIM.

## 3. Killing tests (A2 §3.5 verbatim; one added)

**R's** — A2: "Each would kill R's argument, not R's claim."
1. "**Parts calibration.** Apply R's mechanism to `[Parts2020c]`'s tiling, eroded to slack `2κ`. If the argument forces more than `δ₆ + O(ε)` of holes
   there, it is wrong."
2. "**Seven-colour control.** The argument must fail on the slack hexagonal 7-colouring, and must name the step where "six" is spent (TS's K1 rule)."
3. "**Strip test.** Replace the holes by TQ-HIT's strips. If every step still goes through, the argument is in hitting form and capped at `O(ε)`."
   (Cap `ε`, FS106-HIT.)
4. "**Normalization.** R states its bound as uncovered area over plane area, never as pairs over band (stage 2, note)."
5. **Pinhole test** (FS107-A to the planner, 2026-09-27, verbatim): "Replace the holes by one disc of radius ≍ ε at each junction or at each of the
   argument's certificates. If every step survives, the argument is capped at O(ε²)." (A8b's form: `plans/POROS-2026-09-26-fs106-regular-half.md` l. 242,
   "breaking Voronov's proof costs `O(ε²)` per unit area", [hand, one mind].)

**W's**
1. "**Exact check.** Every member of W's family, at given `(ε, δ)`, is a finite periodic tile colouring with rational data. Its falsifier is a
   monochromatic pair of squares whose distance interval `[min, max]` meets `[1 − ε, 1 + ε]`. The check is exact and seconds long, and it checks a given
   object, so it is allowed under the ban." *This list's note (§PA, PA-2):* the interval is each tile pair's exact distance range over the torus's
   periodic images; a corner-circle construction (`[MundingerEtAl2025]` App. B) may be only sufficient.
2. "**Floor.** The family's claimed `δ(ε)` never falls below `ε²/78`." (The close's floor: `ε²/(6+ε)²`, given V-1.3.)
3. "**Class density.** Each class's density is at most 0.2470."
4. "**A driving parameter.** The family has an explicit parameter that drives `δ → 0`. TQ §4.5 item 6 (c): Parts's own family has none; its voids keep
   a fixed size."

**The joint dial, after 2026-10-01** (A2 §3.5): "Trace `1 − µ₆^per(ε)` along eroded Parts tilings and along W's families. Informative both ways: a flat
curve near `10⁻⁴` is R's evidence, a falling one W's." (FS-109, `plans/STUB-hole-dial.md`.)

## 4. The break table (A2 §3.6 verbatim; one annotation)

| the other side's step | how W breaks R | how R breaks W |
|---|---|---|
| R: holes of `ε`-independent measure in some disc of radius `R₀` | holes spread uniformly: a periodic family with density `→ 0` in every `R₀`-disc | show that holes concentrate: some bounded disc keeps `≥ δ₀` |
| R: the argument reads how holes sit relative to the colouring (it must, by TQ-HIT) | put the holes exactly where the multichromatic points would be (Parts's voids "at every vertex", TQ §4.5 item 6 (b)), and shrink them with `ε` | show that a vertex void cannot shrink without a new void appearing elsewhere: C-Q-LOCAL says local repairs cost `O(ε²)`, so the forced quantity must be non-local |
| W: a parameter shrinking the vertex voids | (W's own step) | derive a lower bound on the void at a degree-3 junction of three colours that does not depend on `ε`, from the islands constraint and the six-colour count |
| W: the Route II limit exists as a tight six-colouring | (automatic, by Route II) | R-S: prove that the limit's disjoint-multicolour pairs cannot all sit in C-T-TAN's exceptional set; close C-T-TRIb and C-T-IND without finiteness |
| both | — | the advisor asks each side, before round 1, to name the step of the other's programme it expects to fail. Retractions are counted from there (G51: zero means the disagreement has not started) |

*Annotation (FS107-A, stage 1; the owner's inventory item 2):* row 2's "C-Q-LOCAL says local repairs cost `O(ε²)`" misattributes. The `O(ε²)` is A8b
(`plans/POROS-2026-09-26-fs106-regular-half.md` l. 242); FS106-LOCAL is the Parts-erosion ceiling (chromaticity 1, `δ > δ₆`).

## 5. The limit object's named steps (R-S; LIM only; verbatim from `plans/FS106-derivation.md` §3 unless marked)

- **FS106-AE-Q2**: "S–V's Question 2 almost everywhere and as posed … is a GAP at four named steps, with no counterexample: [G1] S–V Lemma 2 without
  Cond. 5 (configuration C5 refutes its Prop. 5 locally); [G2] Cor. 2's annulus at a bowtie, at a unit-arc boundary through u, at spiralling
  boundaries; [G3] Prop. 17's last step (a cone bounded by a unit arc, consistent with TS-U); [G4] Prop. 12's swap exclusion (FS106-IND-X)." [hand; one
  mind per step]
- **FS106-IND**: "Under reading (A) (a continuous lift agreeing with the trace almost everywhere), Voronov's index of a density trace is well defined
  whenever a lift exists, and complementary curves with no swap satisfy |Ind γ₁ − Ind γ₂| ≤ 1 for any continuous lifts; "an index exists iff the traces
  change colour finitely often" is FALSE under both readings." [hand; the bound two minds, one blind]
- **FS106-IND-X**: "At a unit-arc interface facing a bowtie (or a 4-chromatic point) — configuration C5 with a colour in the side cones at y —
  complementary translate curves swap and |Ind γ₁ − Ind γ₂| = 2". [hand + measured; one mind] — the no-swap lemma is owed.
- **C-T-L1b** (TS §4, verbatim): "GAP in general, at two named steps: (1) the localisation — near `x`, classes outside `P(x)` have density 0 **at** `x`
  but may have density-1 points accumulating at `x`, so `ω(y) ∩ U(x)` need only avoid `S̃_a ∪ S̃_b`, not lie in an interface; (2) the collar — TS-U needs
  an arc of `ω(y)` with a one-sided open neighbourhood in each class, which a class with no regularity (K3's fat edge, or a comb) need not supply".
- **C-T-TRIb** (TS §5, verbatim): "**The named step:** TS-T's hull growth on supports — the outer frontier of a component of `{x : P_supp(x) = {j}}` is
  connected and lies in one `supp S_j ∩ supp S_i`, and the ring of `i` around it must be a connected piece of `supp S_i` to which TS-C′ applies."
- **C-T-BIKE** (TS §4, verbatim): "**GAP — undecided here**; the step named: an explicit proper 3-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (or
  a proof none exists), for each `d = |u − v| ∈ (1, 2)`".
- **C-T-PIG** (TS §5): "**GAP**, inherits C-T-TRIb (a trichromatic point to start from) and C-T-ANN (the circle colourings of Lemmas 5–6)".

## 6. Not claimed; held GAPs (for reference, not assigned)

- **FS106-PDEQ** (`plans/FS106-derivation.md` §4): "PD-EQ (sketch): χ_m⁰(ℝ²) ≥ 7 iff some c > 0 bounds below, for every ε < ε₀, the monochromatic
  fraction of pairs at distances in [1 − ε, 1 + ε] of every measurable six-colouring. [hand, sketch; one mind: A2 — not claimed]". Its open step (A2
  §2.2): "The operator-norm convergence is the step I have not written in full." Object: both (a colouring of the whole plane, no holes).
- **FS106-LOCAL at `δ = δ₆`**: GAP, "the missing step: 1_H ∗ 1_{U₃} is non-constant".
- **FS106-AE-CLOSED**: "The question itself is open." (closed classes are the tight question itself.)
