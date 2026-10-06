# FS131-E8 — the bridge under REG-J′: the frozen words, with saturation, give the fan with end tangents

*Job FS131-E8, Ephodos (Opus 5.5), launched 2026-10-06 on `main`. Brief `data/fs131/briefs/FS131-E8-regj-bridge.md`, with
`plans/STANDING-RULES.md`. Working files `data/fs131/e8/`. One mind throughout; no search was run and none was wanted.*

## Theorems this phase proved

Each **[hand], one mind, kernel pending**; entries and arguments in § Stage 3. No value of any chromatic number moves.

- **FS131-E8-LOCAL** — off Σ the interface set of a saturated colouring is the whole closure of the essential boundary, locally one `C^{1,1}` graph
  whose tangent is 1-Lipschitz in arclength, with one colour on each side: § 3.1. (FS121-V5-LOC and V5-OFF at the class their argument carries.)
- **FS131-E8-GAMMA** — clause (γ): near an isolated point `z` of Σ, in a disc of radius at most `1/2`, every interface component is an open arc
  of length at most `π/2` with ends at `z` or on the disc's boundary and a limit tangent at each end: § 3.2.
- **FS131-E8-BETA** — clause (β): a component with an end at `z` has increasing distance from `z`, so it is a polar graph with a limit direction: § 3.3.
- **FS131-E8-ALPHA** — clause (α): finitely many components meet the half disc, and a smaller disc holds only those that end at `z`: § 3.4.
- **FS131-E8-DELTA** — clause (δ): a connected open set meeting no essential boundary and no cusp is almost everywhere of one colour: § 3.5.
- **FS131-E8-FAN** — the class: a fan with end tangents at every singular point isolated in Σ, with saturation read in a punctured disc only;
  at least two branches, neighbouring regions of different colours: § 3.6.
- **FS131-E8-BRIDGE** — the instance: saturated with Σ locally finite gives the fan at every point of Σ; `RegJBridge k` holds for every `k`, the
  frozen words' second clause unread: § 3.6.
- **FS131-E8-CLAUSE2** — under saturation the frozen words' second clause follows from the first, and every bounded set meets finitely many
  interface arcs: § 3.7.
- **FS131-E8-BRANCH** — the contacts at a branch of any fan under saturation (the planner's `Fan.branch_contacts`): a common contact at one
  branch point puts the whole branch on one unit circle about it; otherwise the two contacts at `z ± i e(d)`: § 6.1.
- **FS131-E8-TWOSIDES** — at any fan, no saturation: the two sides of a branch differ in colour, no fan has one branch, and a singular point
  has at least two (the planner's `Fan.col_ne`, `Fan.two_le_n`): § 6.2.
- **FS131-E8-OUTSIDE** — a curve of curvature at most 1 and length at most `π/2` stays outside the two unit discs tangent at its start (the
  planner's `IsUnitCurve.one_le_dist`, checked): § 6.3.
- **FS131-E8-SI5C** — the brief's second question: J45-SI-5's step (c) holds by majority decoding — Chebyshev's inequality and a closed subspace
  of `L²` — with no pointwise ergodic theorem: § 5.1.

## Stage 1 — SAVED: the readback, the question restated, the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

By script, exact substring match of each `>`-block against the file its `— source:` line names (`data/fs131/e8/quotes.py`; output
`data/fs131/e8/quotes.out`, exit 0; with one character of the first quotation altered, `--plant`, it reports 1 mismatch and exits 1):

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "481. **FS131-K6, by message mid-job (`fs131-w6` at `c3ffb4e7`, build OK by its word): five rows of wave 6 hold at a wider class than filed;" | `plans/FS131-close-inventory.md` l. 4812 | exact |
| 2 | "def RegJLiteral (c : AeColouring k) : Prop :=" | `.claude/worktrees/fs131-w6/data/fs131/k6/FanDesign.lean` l. 22 | exact |
| 3 | "def RegJFan (c : AeColouring k) : Prop :=" | the same, l. 65 | exact |
| 4 | "def RegJBridge (k : ℕ) : Prop :=" | the same, l. 70 | exact |
| 5 | "## Stage 6 — SAVED: REG-J′, both forms, and the bridge (for the deriver's job; ruled, inventory item 481)" | `.claude/worktrees/fs131-w6/plans/FS131-w6-kernel-plan.md` l. 212 | exact |

Kooshi's sentence in § Why this job is `plans/STANDING-RULES.md` rule 4's, read there: exact. No mismatch; no finding about the brief.

### 1.2 Files read, in order

The brief; `plans/STANDING-RULES.md`; inventory items 481–484 (`plans/FS131-close-inventory.md` ll. 4812–4874); the planner's design
`FanDesign.lean` whole and its record §§ 1–7 (`plans/FS131-w6-kernel-plan.md` on `fs131-w6` at `714a972b`, ll. 1–330), § 6 twice; the foundation
`Proofs/HadwigerNelson/Plane/Saturated/Basic.lean` on that branch (the definitions `essBdry`, `IsCuspAt`, `H1`, `H2`, `TwoColourAt`, `singularSet`,
`interfaceSet`, `HasTwoDiscsAt`), and on `main` `Plane/Cover.lean` ll. 60–120 (`essClosure`, `essBoundary`, `IsContactFor`, `Saturated`) and
`Plane/UnitPairs.lean` ll. 28–42 (`densitySet`, `upperDensityAt`, `essSupport`); `data/fs121/claims.md` whole (REG-J′'s words, § 0; the close's
notes, ll. 210–221); `plans/FS111-M-regularity.md` §§ 2.1, 3–3.6, 4.1 (M-PINCH, M-C11, M-HALF, REG-J′'s minting); `plans/FS111-M2-regularity.md` § 4.1
(Σ, M2-INTRAD); the entries FS111-M-PINCH, -M-C11, -W-NOBEND, -W-NOREP, -M-REDUCE-I, -W-KB-DIR, -M2-INTRAD (`plans/FS111-derivation.md`) and the
nineteen FS-121 entries the planner's § 2 marks "fan" (`plans/FS121-derivation.md`: statement, uses only, not claimed); and three FS-121 job records
the planner did not open: `plans/FS121-V2-verification.md` §§ 1.4, 2.1–2.3, `plans/FS121-V3-verification.md` §§ 2.3, 3.2, 3.5, 3.6,
`plans/FS121-V5-verification.md` § 3.1.

### 1.3 The question, restated

REG-J′'s frozen words (`data/fs111/claims.md` § 6, quoted by `data/fs121/claims.md` § 0, verbatim): "**REG-J′_k**: a saturated colouring whose
singular set Σ is locally finite, **each point of Σ meeting finitely many interface arcs** (the clause two briefs dropped)". The planner reads them
as `RegJLiteral`: Σ locally finite, and at each `z ∈ Σ` finitely many connected components of `𝓘 = ∂_e ∖ Σ` have `z` in their closure. The
consumers read a *fan* at each `z ∈ Σ` (`data/fs121/claims.md`, the close's note to § 0, verbatim): "a disc `B(z, r)` whose only point of Σ is `z`,
in which the essential boundary is the finitely many interface arcs at `z`; every region of the fan is an open set a.e. of one colour; a region of
positive angle has an open arc of directions, a zero-angle region none and one tangent direction."

**Q** (the brief's, verbatim): "For a saturated honest colouring of the plane with `k` colours satisfying REG-J′ in its frozen words, does every
singular point have a fan with end tangents — the four clauses (α)–(δ) by which the planner's § 6 says the fan exceeds the words?" The clauses
(the planner's § 6, verbatim): "(α) **no arc passes near `z` without meeting it** (`bdry`'s equality: the literal form counts only the arcs with
`z` in their closure, and infinitely many other components of `𝓘` could accumulate at `z` while the singular set stays locally finite — unless
each has an endpoint in Σ, which is itself unproved); (β) **each arc is a polar graph near `z`**; (γ) **each arc has an end tangent** (`tendsto`);
(δ) **each region is one colour** (`region`)."

In my words, for the record only: is `RegJBridge k` — `∀ c : AeColouring k, Saturated c.cls → c.RegJLiteral → c.RegJFan` — true, with `Fan` the
structure of `FanDesign.lean` ll. 29–49 field by field?

**The planner's reading of the frozen words** is the natural one and I keep it: an *interface arc* is a connected component of `𝓘`, and it
*meets* `z` when `z` is in its closure. The verdict below does not depend on it (§ The second clause is a consequence).

### 1.4 What the readback found before any derivation was written

Three FS-121 job records, not read by the planner (its § 6 says so), already hold parts of the bridge:

- **(γ), given an arc at `z`** — `plans/FS121-V2-verification.md` § 2.1, Lemma T (i), verbatim: "Points of `γ` near `z` are off Σ, so (M-C11, held
  through M-PINCH) `γ` is locally `C^{1,1}` with `|κ| ≤ 1`: its unit tangent is 1-Lipschitz in arclength. A sub-arc of length `ℓ ≤ π/2` has chord at
  least `sin ℓ` along its initial tangent, so inside `B(z, r)`, `r < 1/2`, every sub-arc has length `< π/2`: the arc has finite length up to `z`, and
  the tangent converges." The same step is `plans/FS121-V3-verification.md` § 2.3 (F-a). The planner's worry — C11's discs hold only in a
  neighbourhood `N(x′)` that shrinks toward `z` — does not touch this argument: the curvature bound is pointwise, and a pointwise bound on a
  connected arc makes the tangent 1-Lipschitz in arclength along the whole arc.
- **(δ), given the fan** — V3 § 2.3 (F-b), by "Federer's criterion … or the relayed definition".
- **The local structure off Σ** — `plans/FS121-V5-verification.md` § 3.1, V5-OFF and V5-LOC (entry FS121-V5-LOC, [hand], one mind): `cl 𝓘 ∖ Σ ⊆ 𝓘`,
  and each such point has a ball missing Σ in which `cl 𝓘` is one `C^{1,1}` graph.

Not found anywhere: (α) and (β). V3 § 3.5 states (α) as a caution — "REG-J′'s words … do not by themselves exclude arcs that pass arbitrarily
near `z` without meeting it" — and the close filed it as a reading (`data/fs121/claims.md` l. 214), with no example and no derivation.

### 1.5 The registered expectations

**A note on timing.** While reading § 6 and V5-LOC I saw an argument for (α): every component near `z` crosses the circle `∂B(z, R/2)`, the
interface set meets that circle in a compact set, and V5-LOC makes each of its points own a neighbourhood lying in one component — so finitely
many components cross. The predictions below were written after that sketch and are informed by it; none was written blind.

| clause | predicted verdict | probability | the likeliest break |
|---|---|---|---|
| (α) no arc near `z` without meeting it | derived | 0.88 | M-PINCH read at a point that is not the centre of its two-colour ball (the Lean `pinch` is centred; the hand proof reads `N` only as a neighbourhood); or a component of `𝓘 ∩ B(z, R)` that is not an arc with two ends |
| (β) polar graph | derived | 0.92 | the distance to `z` failing to be monotone on an arc longer than I can bound |
| (γ) end tangent | derived — found in the record (V2 Lemma T (i), V3 (F-a)) | 0.95 | the 1-Lipschitz tangent taken across a point where the arc is not `C^{1,1}` |
| (δ) one colour per region | derived, without Federer | 0.93 | a region point that is a density point of no class |
| the frozen words' second clause is consumed by the bridge | **no** — the first clause and saturation suffice | 0.8 | infinitely many arcs ending at `z` in directions that accumulate: I expect the same compactness to exclude them |

The decision each prediction carries: a "refuted" at any clause goes to "main" at once (the planner of wave 6's second pass states its rows over
this hypothesis); "derived" at all four means the rows can be stated over the frozen words — or over the first clause alone — with the bridge as
one lemma.

### 1.6 The target, written as a conjecture before any argument

At stage 1's commit (`39d7b431`) this section held the entry FS131-E8-BRIDGE with `verdict: gap: the argument is not written`, `grade: measured`.
Its statement was fixed there and is quoted verbatim by the derived entry of § 3.6, which replaces it; the conjecture's text is in git.

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh)

### 2.1 The stall, read

The planner's stall has two shapes at once. **A known theorem that almost applies**: FS111-M-C11 gives the tangent, but its unit discs are stated
inside a neighbourhood that shrinks toward `z`. **A wall that describes a counterexample**: "infinitely many other components of `𝓘` could accumulate
at `z` while the singular set stays locally finite" says what a counterexample would carry. The cue is to ask what every actual arc near `z`
carries. It carries two things: it lies in a set that is one sheet near each of its own points, and its curvature is at most 1 — so it cannot
close up or turn back inside a small disc, and must cross every small circle about `z`.

### 2.2 The problem, for a stranger (a differential geometer; no word of this project)

*Let `Σ ⊂ ℝ²` be a closed discrete set and `G ⊂ ℝ² ∖ Σ` a relatively closed subset such that every point of `G` has a neighbourhood in which `G`
is a single `C^{1,1}` graph whose unit tangent is 1-Lipschitz in arclength (curvature at most 1). Let `z ∈ Σ`. Show that there is `r > 0` such
that `G ∩ B(z, r)` is finitely many pairwise disjoint arcs, each with one end at `z`, each a polar graph about `z` with a tangent at `z`; and that
the complementary regions are the open sectors between consecutive arcs.*

Words the reader would stop at: none. Words of this project that the translation struck: *saturated*, *contact*, *interface*, *essential
boundary*, *colour* — each is consumed only through the one-sheet graph with curvature at most 1 (the first three) or enters clause (δ) alone
(the last two). **This is a** properly embedded system of curves of bounded curvature in a punctured disc.

### 2.3 The features, sorted

| feature | sort | receipt |
|---|---|---|
| saturation | **splits**: its consequence "off Σ the interface set is locally one `C^{1,1}` graph of curvature at most 1" determines; the rest accompanies | consumed only through FS111-M-PINCH's two tangent unit discs (§ 3.1); nothing else of it is read |
| the curvature bound | determines (α), (β), (γ) | without it: circles of radii `2^{−n}` about points `z + 3·2^{−n}e₁` are closed, one-sheeted, accumulate at `z` and never end there (α fails); a logarithmic spiral into `z` has no end tangent (β, γ fail). The control `e8-chord` fires when the bound is doubled |
| one sheet near each point (the interface set is all of the essential boundary's closure off Σ, and locally one graph) | determines (α) | without it: the rays from `z` at angles `1/n` and `0` are closed in the punctured disc, each of curvature 0, infinitely many |
| Σ locally finite | determines; consumed as "Σ is closed and `z` is isolated in it" | the same rays: in a colouring they make every point of the limit ray singular (FS121-V5-RAY's mechanism), which is the failure of this hypothesis |
| **the frozen words' second clause** (finitely many interface arcs meet `z`) | **accompanies** | the argument of §§ 3.1–3.6 runs without it, and § 3.7 derives it |
| the number of colours `k` | accompanies | no step reads it (finitely many, for § 3.1 (0) and § 3.5) |
| honest (one colour per point) | determines, inside FS111-M-PINCH | (H1)'s "the ball is a.e. the two classes, which are disjoint"; on covers the (out, out) case changes (`plans/FS111-M2-regularity.md` § 2.2) |
| D-NF | accompanies | every notion is invariant under a null change (the planner's § 3.1) |
| that `z` itself is saturated | accompanies | never read (so too V2 § 2.2 and V3 § 2.3) |
| saturation away from `z` | accompanies beyond a punctured disc | read at essential boundary points of `B(z, R) ∖ {z}` and nowhere else |
| the radius bound `R ≤ 1/2` | determines the stated lengths | a unit circle fits in a disc of radius above 1; the fan's `r` is existential, so the bound costs nothing |

### 2.4 The homes

1. **Curves of bounded curvature** (differential geometry; Schur's comparison theorem, recalled, not read): a curve of curvature at most 1 and
   length `ℓ ≤ π` has chord at least that of the unit-circle arc of length `ℓ`. *Dictionary:* interface arc ↔ curve with 1-Lipschitz tangent;
   end tangent ↔ the Lipschitz tangent extended to the closed parameter interval; polar graph ↔ monotone distance from the endpoint. *Test:* the
   proofs apply with nothing changed; it predicts a neighbour (no interface component closes up inside a disc of radius `1/2`; an arc that ends at
   `z` crosses each small circle once). **Kept** for (β), (γ); the three inequalities used are proved in § 3.2–3.3 in the form needed, which is
   shorter than the search.
2. **Closed embedded submanifolds** (general topology): the components of a closed embedded submanifold of an open set `Ω` are a locally finite
   family in `Ω` — a compact subset of `Ω` meets finitely many, because each point's chart lies in one component. *Dictionary:* `Ω = ℝ² ∖ Σ`, the
   submanifold `𝓘`, the compact set a circle about `z`. *Test:* the wall's counterexample (components accumulating at `z` without ending there)
   becomes a statement about a compact circle; the clause-per-case question "does each have an endpoint in Σ" vanishes. **Kept** for (α), once home 1
   shows every component near `z` crosses the circle.
3. **One-dimensional varifolds of bounded first variation** (geometric measure theory; Allard–Almgren's structure of stationary one-dimensional
   varifolds, recalled, not read): finitely many rays in the tangent cone at a point of finite density. **Killed**: its hypothesis is finite mass
   near `z`, and finite mass near `z` is clause (α) — the remaining step would be the problem renamed.
4. **Sets of positive reach, the two-sided rolling ball** (convex geometry; `[Walther1999]`, listing seen, unread; `[RatajZajicek2017]`): gives
   the local `C^{1,1}` graph. Already FS111-M-C11's home; it says nothing at an isolated singular point. **Kept** for § 3.1 only.

### 2.5 The class, and what the new description predicts

The determiners are local to a punctured disc, so the statement belongs at **one isolated point of Σ** (FS131-E8-FAN, § 3.6), with saturation
read only in the punctured disc; the bridge over a locally finite Σ is its instance. Predicted neighbours, each checked in stage 3: the frozen
words' second clause is free (§ 3.7); every bounded set meets finitely many interface arcs (§ 3.7 — FS111-M-REDUCE-I and FS121-D2-PERFIN read this
from REG-J′); every singular point has at least two branches, and consecutive regions differ in colour (§ 3.6); in a saturated colouring,
infinitely many interface arcs in a bounded set make Σ not locally finite (the contrapositive; on grid colourings with genuine breakpoints it
decides the "Σ clause" FS121-D4-GRID's not-claimed line leaves open).

**Recognition against the plan's picture.** The planner pictured the bridge as possibly false at (α) and as needing a winding argument at
(β)–(γ). The recognition differs: (α) is compactness on a circle once the curvature bound is read as "every component crosses", and the bridge
does not consume the clause the frozen words were corrected to carry. That difference is this job's finding.

## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge

*Setting, throughout.* A **colouring** is a measurable `f : ℝ² → [k]` whose classes `S_j = f⁻¹(j)` have null unit pairs (the Lean type
`AeColouring k`). `S̃_j`, `d̄_j`, `supp S_j`, `∂_e S_j = {d̄_j > 0} ∖ S̃_j`, the essential boundary `∂_e = ⋃_j ∂_e S_j`, cusps, (H1), (H2), `Σ` and
`𝓘 = ∂_e ∖ Σ` are `data/fs121/claims.md` § 0's, in the planner's Lean readings (`Plane/Saturated/Basic.lean` on `fs131-w6`: `essBdry`,
`IsCuspAt`, `TwoColourAt`, `singularSet`, `interfaceSet`). A point `x` is **saturated** when every class with `x ∈ ∂_e S_j` has a point of
`supp S_j` at distance exactly 1 from `x`; the colouring is saturated when every point is (`Saturated c.cls`). For an open set `U`, **hypothesis
(U)**: `U ∩ Σ = ∅`, and every point of `∂_e ∩ U` is saturated.

### 3.1 The local structure off Σ

**(0) The closure of the essential boundary lies in `∂_e ∪ Σ`** (V5-OFF, `plans/FS121-V5-verification.md` § 3.1; no saturation). Let `x_n → x`,
`x_n ∈ ∂_e S_j` (one `j` along a subsequence). As `x_n ∉ S̃_j` and the density ratios of the `k` classes sum to 1, some `b ≠ j` has
`d̄_b(x_n) > 0` (one `b` along a subsequence). So `x ∈ supp S_j ∩ supp S_b`. If `d̄_j(x) = 0` or `d̄_b(x) = 0`, `x` is a cusp, in Σ. Otherwise
neither is a density class at `x` and `x ∈ ∂_e S_j`. ∎ So under (U): `cl(∂_e) ∩ U = ∂_e ∩ U = 𝓘 ∩ U`, and `𝓘 ∩ U` is relatively closed in `U`.

**(1) The two-colour ball.** Let `y ∈ 𝓘 ∩ U`. There are `ρ > 0` and colours `a ≠ b` with (H1), (H2) in `N = B(y, ρ)`: every other class is null
in `N`, and `S_a ∩ N`, `S_b ∩ N` are a.e. connected open sets `P_a ⊆ S̃_a`, `P_b ⊆ S̃_b`. Put `O_a = N ∖ supp S_b`, `O_b = N ∖ supp S_a` (open,
disjoint; `O_a` is a.e. in `S_a`, and an open subset of `N` that is a.e. in `S_a` lies in `O_a`) and `Z = N ∩ supp S_a ∩ supp S_b`, so
`N = O_a ⊔ O_b ⊔ Z`. Take `ρ₀ ≤ ρ` with `B(y, ρ₀) ⊆ U` and put `Z₀ = Z ∩ B(y, ρ₀)`. A point `x′ ∈ Z₀` is no cusp (it is off Σ), so
`d̄_a(x′) > 0` and `d̄_b(x′) > 0`: `x′ ∈ ∂_e S_a ∩ ∂_e S_b`, and `x′ ∈ cl P_a ∩ cl P_b`. Conversely `∂_e ∩ B(y, ρ₀) ⊆ Z₀` (a point of `∂_e S_a`
in `N` has `d̄_b > 0` too, by the sum of ratios). So `Z₀ = ∂_e ∩ B(y, ρ₀) = 𝓘 ∩ B(y, ρ₀)`, and every point of `Z₀` is saturated for `a` and for `b`.

**(2) Two discs at every point of `Z₀`, in the one ball `N`.** FS111-M-PINCH (held; `plans/FS111-M-regularity.md` § 3.1) at `x′ ∈ Z₀`, with *this*
`N`, `P_a`, `P_b`: its Step 1 reads the connected `P_a`, `P_b` and the contacts of `x′`, and its Step 2 compares open subsets of `N` near `x′`, so
the proof reads `N` as an open neighbourhood of `x′`, never as a ball centred there (FS111-M-C11's statement uses it so: "with the same `N`,
`P_a`, `P_b`"). Both of its cases give a unit vector `ν(x′)` with

  `B(x′ + ν(x′), 1) ∩ N ⊆ O_b` and `B(x′ − ν(x′), 1) ∩ N ⊆ O_a`.

From here on replace `ρ` by `ρ₁ = min(ρ, 1)`: the inclusions hold in the smaller ball.

**(3) Two inequalities.** Let `x′, x″ ∈ Z₀`, `w = x′ − x″`, `δ = |w|`.
(b) `x″ ∈ Z` lies in neither open disc at `x′`, so `|x″ − x′ ∓ ν(x′)|² ≥ 1`: **`|⟨x″ − x′, ν(x′)⟩| ≤ δ²/2`**.
(c) If `x′, x″ ∈ B(y, ρ₁/2)` and `δ ≤ ρ₁/8`, then **`|ν(x′) − ν(x″)| ≤ 6δ`**. Suppose `L = |ν′ − ν″| > 6δ` (`ν′ = ν(x′)`, `ν″ = ν(x″)`). Put
`d = (ν″ − ν′)/L`, `t = min(L/2, ρ₁/4)`, `p = x′ + td`. Since `⟨d, ν′⟩ = −L/2` and `⟨d, ν″⟩ = L/2`: `|p − (x′ − ν′)|² = 1 − tL + t² < 1`, and by
(b) at `x″`, `|p − (x″ + ν″)|² = |w − ν″|² + 2t⟨d, w⟩ − tL + t² ≤ 1 + 2δ² + 2tδ − t(L − t)`, which is below 1 because `t(L − t) ≥ tL/2 > 3tδ ≥
2tδ + 2δ²` (`t ≥ 2δ`: `L/2 > 3δ`, and `ρ₁/4 ≥ 2δ`). So `p` lies in the `a`-disc at `x′` and in the `b`-disc at `x″`, and `|p − y| < ρ₁/2 + ρ₁/4`:
a point of `O_a ∩ O_b = ∅`. ∎ (Control `e8-lens`: exact, on 308 rational normals by 70 rational offsets, 18,890 admissible pairs, with `t` rounded down
to a multiple of `L/64`; it fires when 6 is replaced by 1.)

**(4) The graph.** Coordinates `(u, v)` centred at `y` with `ν(y) = e₂`; `h = min(ρ₀, ρ₁)/24`; `Q = (−h, h)²`, inside `B(y, ρ₀) ∩ B(y, ρ₁/12)`.
*Existence.* For `|u₀| < h` the segment `{u₀} × [−h, h]` has its top end in `B(y + e₂, 1) ∩ N ⊆ O_b` (`u₀² + (h − 1)² < 1` as `h < 1`) and its
bottom end in `O_a`; a segment is not the union of two disjoint non-empty relatively open sets, so it holds a point of `Z₀`.
*Uniqueness.* For `x′ = (u₀, v₁)`, `x″ = (u₀, v₂)` in `Z₀`: by (c) against `y`, `|ν(x′) − e₂| ≤ 6√2·h < 0.36`, so `⟨e₂, ν(x′)⟩ > 0.93`; by (b),
`0.93|v₂ − v₁| ≤ |v₂ − v₁|²/2`, so `v₁ = v₂` or `|v₂ − v₁| > 1.8 > 2h`. So `Z ∩ ((−h, h) × [−h, h])` is the graph of a function `g`, and (b) at `y`
gives `|g(u)| ≤ u²`: the graph lies in `Q`, and `𝓘 ∩ Q = Z ∩ Q = graph(g)`.
*Regularity.* (b) at `x′ = (u₁, g(u₁))` with the bound on `ν(x′)` gives `|g(u₂) − g(u₁)| ≤ 0.46|u₂ − u₁|` and then
`g(u₂) − g(u₁) = −(ν₁/ν₂)(x′)·(u₂ − u₁) + O(|u₂ − u₁|²)`: `g` is differentiable with `g′ = −ν₁/ν₂`, which is Lipschitz by (c). So `g ∈ C^{1,1}`. At
a point where `g″` exists the graph stays outside two open unit discs tangent to it there, so its curvature is at most 1 in absolute value; the
tangent angle `ψ = arctan g′` is absolutely continuous with `dψ/ds = κ`, so **`ψ` is 1-Lipschitz in arclength**.
*Sides.* `{v > g(u)} ∩ Q` and `{v < g(u)} ∩ Q` are connected open sets missing `Z`, so each lies in `O_a` or in `O_b`; the upper one meets
`B(y + e₂, 1)`, so it lies in `O_b`, and the lower one in `O_a`. ∎

derivation: FS131-E8-LOCAL
  statement: in a measurable k-colouring of the plane whose classes have null unit pairs, let U be an open set that holds no point of the singular
    set Σ and each of whose essential boundary points has, for every class with that point on its essential boundary, a point of that class's
    support at distance 1; then the closure of the essential boundary meets U in the interface set, and every point y of the interface set in U
    is the centre of an open square inside U in which the interface set is the graph, over the tangent line at y, of a C^{1,1} function whose
    unit tangent is 1-Lipschitz in arclength, the two sides of the graph in the square being connected open sets, each almost everywhere of one
    colour, of two different colours
  uses only: the definitions of the essential boundary, of cusps and of Σ; finitely many colours; (H1), (H2) at y in one ball N; FS111-M-PINCH
    (held, three minds) at each essential boundary point near y, read in that one ball N — its proof reads N as an open neighbourhood of the
    point; that an open set is not almost everywhere of two colours
  not claimed: anything at a point of Σ or at an accumulation point of Σ; that the square's size is bounded below along the interface set (it
    shrinks toward Σ); the graph without the hypothesis that no cusp lies near y — FS111-M-C11 as filed assumes M-PINCH's hypotheses at essential
    boundary points only, and its step "each normal line meets the boundary once" needs the point found on the line to be no cusp
  argument: § 3.1 The local structure off Σ
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at the edge point (1/2, 1/4), U the open disc of radius 1/8 about it — the graph is the segment u = 1/2, the sides the two squares'
    colours (in the kernel on fs131-w6 as sq9_twoColourAt and sq9_hasTwoDiscsAt)
  prior art: partly: FS121-V5-LOC with V5-OFF (held, hand, one mind) is this statement under REG-J′; the graph step is FS111-M-C11's, there over
    [Walther1999] (listing seen, unread), here written out with constants
  handoff: none — a relay-result that FS131-E8-FAN subsumes; it is the form of FS111-M-C11 (ii) the kernel needs (one ball, off-centre points)

control: e8-lens
  of: FS131-E8-LOCAL — step (3)(c), the normal is 6-Lipschitz: the lens point lies in both discs on every admissible rational sample
  run: python3 ../data/fs131/e8/e8_lens.py
  expect: 0
  fault: python3 ../data/fs131/e8/e8_lens.py --C 1

**Erratum, 2026-10-06** (under FS131-E8-LOCAL; § 6.4; source: FS131-K6b, `plans/FS131-w6-kernel-plan.md` § 11.5 (1) on `fs131-w6` at `32f2ab4c`,
its `norm_sub_le_of_discs` kernel-checked). § 3.1 (4), *Regularity*, last sentence — "At a point where `g″` exists … the tangent angle
`ψ = arctan g′` is absolutely continuous with `dψ/ds = κ`, so `ψ` is 1-Lipschitz in arclength" — is true, and rests on two theorems the argument
does not need (a Lipschitz function is differentiable almost everywhere; the fundamental theorem for absolutely continuous functions). Read in
its place: for `x′, x″ ∈ Z₀ ∩ B(y, ρ₁/2)` with `δ = |x′ − x″| ≤ ρ₁/8`, the open unit disc of `b` at `x′` and that of `a` at `x″` do not overlap —
if they did, the midpoint of their centres, `x′ + (x″ − x′)/2 + (ν′ − ν″)/2`, would lie in both and within `δ/2 + 6δ/2 = 3.5δ` of `x′` by
(3)(c), hence in `N`, in `O_a ∩ O_b = ∅` — and the same with `a`, `b` exchanged; so the centres are at least 2 apart both ways, and the
parallelogram law gives **`|ν(x′) − ν(x″)| ≤ |x′ − x″|`**. The unit normal, hence the unit tangent, is 1-Lipschitz in the chord, so in
arclength; a continuous tangent angle with that property is 1-Lipschitz. No second derivative is taken. The entry's statement, its `uses only`
and its verdict are unchanged; (3)(c)'s constant 6 is now read only to place that midpoint in `N`.

### 3.2 Finite length, the ends and the end tangent

*Setting for §§ 3.2–3.4.* `z ∈ Σ`, `0 < R ≤ 1/2`, and `U = B(z, R) ∖ {z}` satisfies (U). By § 3.1, `𝓘 ∩ U = ∂_e ∩ U` is relatively closed in `U`
and locally one `C^{1,1}` graph: an embedded one-dimensional manifold whose unit tangent is locally, hence along each connected curve in it,
1-Lipschitz in arclength.

**(1) The chord.** Let `γ : [0, ℓ] → ℝ²` have unit speed and tangent angle `ψ` with `|ψ(s) − ψ(u)| ≤ |s − u|`, `ℓ ≤ π/2`. Then
`⟨γ(ℓ) − γ(0), T(0)⟩ = ∫₀^ℓ cos(ψ(s) − ψ(0)) ds ≥ ∫₀^ℓ cos s ds = sin ℓ`. (Control `e8-chord`, C1.)

**(2) Length.** Let `C` be a connected component of `𝓘 ∩ U` and `γ` a unit-speed parametrization of it. A sub-arc of length `π/2` would have
chord at least 1, but its ends lie in `B(z, R)`, less than `2R ≤ 1` apart. So `C` has length `L ≤ π/2`. It is not a closed curve: a closed curve of
length `ℓ ≤ π/2` has `0 = ⟨γ(ℓ) − γ(0), T(0)⟩ ≥ sin ℓ > 0`. So `C = γ((0, L))`, `γ` injective; `γ` and `T` are 1-Lipschitz and extend continuously
to `[0, L]`: **`C` has two ends, and its unit tangent has a limit at each** — clause (γ).
*(For the kernel: the classification of one-manifolds is not needed. From a point of `𝓘 ∩ U`, follow the graph charts in each direction; (1)
makes the curve injective and of length at most `π/2`, and (3) says where it stops.)*

**(3) Where an end lies.** Let `p = γ(0) ∈ cl B(z, R)`. Suppose `p ∈ U`. Then `p ∈ cl(∂_e) ∩ U = 𝓘 ∩ U` (§ 3.1 (0)); take its square `Q ⊆ U`.
`𝓘 ∩ Q` is one connected graph arc through `p`, so it lies in one component of `𝓘 ∩ U`, and that component is `C` (the points `γ(s)`, `s` small,
are in it). So `p = γ(s₀)` for some `s₀ ∈ (0, L)`, and the points `γ(s)`, `s → 0`, on the graph arc near `p`, would be `γ(s′)` with `s′` near
`s₀`, against injectivity. So **each end is `z` or a point of the circle `∂B(z, R)`**.

derivation: FS131-E8-GAMMA
  statement: in a measurable k-colouring of the plane whose classes have null unit pairs, let z be a point of the singular set Σ and 0 < R ≤ 1/2
    such that B(z, R) holds no other point of Σ and every essential boundary point of B(z, R) other than z has, for every class with that point
    on its essential boundary, a point of that class's support at distance 1; then every connected component of the interface set in B(z, R) is
    an open arc of length at most π/2, not closed, each of whose two ends converges to z or to a point of the circle ∂B(z, R), and whose unit
    tangent has a limit at each end
  uses only: FS131-E8-LOCAL on the punctured disc; the chord bound for a curve with 1-Lipschitz tangent angle; R ≤ 1/2
  not claimed: a tangent at z for a curve of the essential boundary when z is an accumulation point of Σ; any bound on the number of components
    (FS131-E8-ALPHA); that the two ends differ in kind (FS131-E8-BETA)
  argument: § 3.2 Finite length, the ends and the end tangent
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at the vertex z = (1/2, 1/2), R = 1/2 — four components, the open segments from z along the axes, each of length 1/2 with one end
    at z and one on the circle; R7 at a lattice point — six unit arcs ending there
  prior art: partly: FS121-V2-verification.md § 2.1 Lemma T (i) and FS121-V3-verification.md § 2.3 (F-a) hold the length and tangent step for an
    arc already known to end at z; the chord bound is a weak form of Schur's comparison theorem (recalled, not read; proved here in the form used)
  handoff: none — a relay-result that FS131-E8-FAN subsumes

control: e8-chord
  of: FS131-E8-GAMMA — the chord bound (C1), with FS131-E8-BETA's two inequalities (C2, C3), on all 65,534 bang-bang prefixes of curvature ±1
  run: python3 ../data/fs131/e8/e8_chord.py
  expect: 0
  fault: python3 ../data/fs131/e8/e8_chord.py --kappa 2

### 3.3 The polar graph

Let a component `C = γ((0, L))` have `γ(0) = z`. For `0 < s < L`:

  `(d/ds)|γ(s) − z|² = 2⟨γ(s) − z, T(s)⟩ = 2∫₀^s cos(ψ(s) − ψ(u)) du ≥ 2∫₀^s cos(s − u) du = 2 sin s > 0`.

So `t(s) = |γ(s) − z|` is `C¹` and strictly increasing, with `t′(s) ≥ (sin s)/s > 0`. Hence `γ(L) ≠ z`: **no component has both ends at `z`**, the
other end is on `∂B(z, R)`, and `s ↦ t` is a `C¹` bijection of `(0, L)` onto `(0, R)`. So `C = {z + t e(φ(t)) : 0 < t < R}` with `e(φ(t))` the
direction of `γ(s(t)) − z`, continuous in `t` — a polar graph, clause (β). And `|γ(s) − z − sT(0)| ≤ ∫₀^s |T(u) − T(0)| du ≤ s²/2`, so the direction of
`γ(s) − z` tends to `T(0)`: a continuous real lift `φ` on `(0, R)` converges as `t → 0`, to an angle of the end tangent. (Control `e8-chord`: C2 is
the displayed inequality; C3 is the stronger "the chord's direction is within `s/2` of `T(0)`" for `s ≤ π/3`.)

derivation: FS131-E8-BETA
  statement: in the setting of FS131-E8-GAMMA, along a component of the interface set in B(z, R) that has an end at z the distance from z is
    strictly increasing, its other end lies on the circle ∂B(z, R), and it is a polar graph {z + t e(φ(t)) : 0 < t < R} with φ continuous on
    (0, R) and convergent, as t → 0, to an angle of the component's limit tangent at z
  uses only: FS131-E8-GAMMA (finite length, the Lipschitz tangent up to the end); the inequality ⟨γ(s) − γ(0), T(s)⟩ ≥ sin s for arclength
    s ≤ π/2
  not claimed: that φ is monotone or of bounded variation as a function of t beyond its convergence; a rate better than |φ(t) − φ(0+)| = O(t)
  argument: § 3.3 The polar graph
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point z — each of the six unit arcs through z is {z + t e(φ(t))} with cos(φ(t) − φ(0+)) = √(1 − t²/4), the distance
    from z increasing along it up to the antipode
  prior art: partly: a textbook property of curves of curvature at most 1 (recalled, not read; proved here); not found in this project's records
  handoff: none — a relay-result that FS131-E8-FAN subsumes

### 3.4 No arc passes near z without ending there

By §§ 3.2–3.3 a component of `𝓘 ∩ U` is of **type E** (one end at `z`, the other on `∂B(z, R)`; a polar graph over `(0, R)`) or of **type X**
(both ends on `∂B(z, R)`). Let `S = ∂B(z, R/2)`.
(a) *Every component that meets `cl B(z, R/2)` meets `S`*: type E by the polar graph; type X because the distance to `z` is continuous along it,
at most `R/2` somewhere and tending to `R` at the ends.
(b) *`𝓘 ∩ S` is compact*: `𝓘 ∩ U` is relatively closed in `U` (§ 3.1 (0)) and `S ⊂ U` is compact.
(c) *Each `q ∈ 𝓘 ∩ S` has a square `Q_q ⊆ U` in which `𝓘` is one connected arc* (§ 3.1 (4)), so `𝓘 ∩ Q_q` lies in one component.
(d) Finitely many squares cover `𝓘 ∩ S`. So **finitely many components of `𝓘 ∩ U` meet `cl B(z, R/2)`**.
(e) Each type-X component among them has compact closure `γ([0, L])` missing `z`. Let `r` be the least of `R/2` and their distances from `z`.
Then every point of `∂_e ∩ B(z, r)` other than `z` lies on a type-E component, and there are finitely many of those, say `n`; the part of each in
`B(z, r)` is its polar graph over `(0, r)` (the distance is increasing). ∎ Clause (α).

derivation: FS131-E8-ALPHA
  statement: in the setting of FS131-E8-GAMMA, finitely many connected components of the interface set in B(z, R) meet the closed disc of radius
    R/2 about z, and there is r with 0 < r ≤ R/2 such that every point of the essential boundary in B(z, r) other than z lies on a component that
    has an end at z
  uses only: FS131-E8-LOCAL (the interface set is relatively closed in the punctured disc, and near each of its points lies in one component);
    FS131-E8-GAMMA and FS131-E8-BETA (a component that comes within R/2 of z crosses the circle of radius R/2); compactness of that circle
  not claimed: any bound on the number n of components ending at z in terms of k or R; that r is bounded below over the points of Σ
  argument: § 3.4 No arc passes near z without ending there
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at z = (1/2, 1/2), R = 1/2 — the circle of radius 1/4 meets the interface set in four points, four components, all with an end
    at z; r = 1/4
  prior art: partly: filed as a reading by the close's note to data/fs121/claims.md § 0 and as a caution by FS121-V3-verification.md § 3.5;
    FS121-V5-RAY holds the same mechanism for arcs of radii tending to infinity; not found derived in this project's records; no literature
    search run — the objects are this project's
  handoff: none — a relay-result that FS131-E8-FAN subsumes

### 3.5 Regions are of one colour

Let `W` be a connected open set that meets no `∂_e S_j` and holds no cusp, and `x ∈ W`. For each `j`: `d̄_j(x) = 0`, and then `x ∉ supp S_j` (no
cusp), so `S_j` is null near `x`; or `d̄_j(x) > 0`, and then `x ∈ S̃_j` (no essential boundary). Not every class is null near `x`, so some `j(x)`
has `x ∈ S̃_{j(x)}`; every other class then has upper density 0 at `x`, so is null near `x`. So a ball about `x` is a.e. in `S_{j(x)}`: `j(·)` is
locally constant on `W`, hence constant. ∎ Clause (δ), with no appeal to Federer's criterion (V3 § 2.3 (F-b) took it from there).

derivation: FS131-E8-DELTA
  statement: in a measurable colouring of the plane with finitely many colours, a connected open set that meets the essential boundary of no
    class and holds no cusp of any class is almost everywhere of one colour
  uses only: that the classes partition the plane; the definitions of the density set, the essential boundary and a cusp; connectedness
  not claimed: the statement for a set that holds a cusp (a density point of one class in the support of another); anything about unit pairs
    or saturation, which the argument does not read
  argument: § 3.5 Regions are of one colour
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9's open cell (0, 1/2) × (0, 1/2), of one colour
  prior art: partly: FS121-V3-verification.md § 2.3 (F-b) takes it from Federer's criterion for a set of zero measure-theoretic boundary in a
    connected open set (recalled there, not read); here from the definitions
  handoff: none — a relay-result that FS131-E8-FAN subsumes

### 3.6 The fan at an isolated singular point

Let `z`, `R` be as in § 3.2 and `r`, `n` as in § 3.4 (e). The `n` branches in `B(z, r)` are pairwise disjoint polar graphs, so for each
`t ∈ (0, r)` their `n` directions are distinct. Take a continuous lift `φ₀` of one branch's angle; each other branch has a unique continuous lift
with values in `(φ₀(t), φ₀(t) + 2π)`; these lifts are continuous and pairwise different at every `t`, so their order is the same for all `t`:
index them `φ₀ < φ₁ < … < φ_{n−1} < φ₀ + 2π`. Each converges as `t → 0` (§ 3.3). The set `W_i` between branch `i` and the next is open and
connected, and misses the branches and `z`, so it meets neither `∂_e` nor Σ: by § 3.5 it is a.e. of one colour.
*At least two branches, and neighbours differ.* If `n = 0`, the punctured disc is a.e. of one colour `j`, so `z ∈ S̃_j` and every other class is
null near `z`: `z` is no essential boundary point and no cusp, against `z ∈ Σ`. Each branch point has a square in which the two sides have
different colours (§ 3.1 (4)); the sides lie in the regions on either side of the branch, so those regions differ in colour, and `n = 1`, where
they are one region, is impossible.

**Against the planner's structure, field by field** (`FanDesign.lean` ll. 29–49): `r`, `r_pos`, `n` — § 3.4 (e); `φ`, `cont`, `mono`, `wrap` — the
ordered lifts; `dir`, `tendsto` — their limits (so `dir` is non-decreasing in `i` and `dir (n−1) ≤ dir 0 + 2π`, the planner's `HasSector` and
`HasHorn` being the strict and the equal case); `singular` — `B(z, R) ∩ Σ ⊆ {z}`; `bdry` — § 3.4 (e), an equality because each branch lies in
`∂_e`; `col`, `region` — § 3.5 on `W_i`, whose description in polar coordinates is the field's set. So a `Fan` at `z` exists.

derivation: FS131-E8-FAN
  statement: in a measurable k-colouring of the plane whose classes have null unit pairs, let z be a point of the singular set Σ with a radius
    R > 0 such that B(z, R) holds no other point of Σ and every essential boundary point of B(z, R) other than z has, for every class with that
    point on its essential boundary, a point of that class's support at distance 1; then there is r > 0 such that the essential boundary in
    B(z, r) off z is the union of finitely many pairwise disjoint curves, at least two, each a polar graph t ↦ z + t e(φ(t)) over 0 < t < r with
    φ continuous and convergent as t → 0, and each open region between two angularly consecutive curves is almost everywhere of one colour,
    regions on the two sides of a curve being of different colours
  uses only: FS131-E8-ALPHA, -BETA, -GAMMA, -DELTA; FS131-E8-LOCAL's two colours at a branch point; z ∈ Σ, for the lower bound on the number
    of curves. Not read: any second clause about arcs meeting z; saturation at z; saturation outside the punctured disc; the number of colours
  not claimed: that Σ is locally finite or that z is isolated in Σ in any saturated colouring (C121-REGJ's first clause, open: FS-127); the
    fan at an accumulation point of Σ; that two curves have different limit directions (R7's lattice points have three tangent pairs); any
    bound on the number of curves; that any colouring with fewer than seven colours meets the hypotheses
  argument: § 3.6 The fan at an isolated singular point
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at z = (1/2, 1/2), R = 1/2, r = 1/4 — four curves along the axes with constant angles 0, π/2, π, 3π/2 and four regions of four
    colours; R7 at a lattice point — six curves, tangent in three pairs, three regions of positive angle and three of zero angle
  prior art: partly: its parts as the four clause entries say; the statement not found in this project's records (FS111-derivation.md,
    FS121-derivation.md, the job records FS121-V2, -V3, -V5); no literature search run — the objects are this project's
  handoff: de Bruijn — the statement as a lemma producing the planner's Fan at z from Σ ∩ ball z R ⊆ {z} and saturation at the essential boundary
    points of the punctured ball; § 3.6's field-by-field reading; the kernel route notes of §§ 3.1 (2) and 3.2 (2)

**Note, 2026-10-06** (under FS131-E8-FAN; § 6.2, § 6.3; source: FS131-K6b, § 11.5 (3), (4)). Two of the statement's clauses and one of its
hypotheses are wider than filed. (i) "at least two" and "regions on the two sides of a curve being of different colours" read no saturation and
none of FS131-E8-LOCAL: they hold for every fan (FS131-E8-TWOSIDES, § 6.2), the first with `z ∈ Σ`. The `uses only` line's "FS131-E8-LOCAL's two
colours at a branch point" is one route, not a need. (ii) "let z be a point of the singular set" is read for "at least two" alone: a point `z`
off Σ with the other hypotheses has a fan too — with no curve if `z` is off the essential boundary's closure, with two if `z` is an interface
point. (iii) `R` needs no bound: pass to `min(R, 1/2)`. The entry's text stands; these are the planner's `fan_of_isolated`, `Fan.two_le_n`,
`Fan.col_ne`, each confirmed in stage 6.

derivation: FS131-E8-BRIDGE
  statement: for every k, in a measurable k-colouring of the plane whose classes have null unit pairs, saturated, with locally finite singular set Σ,
    every point z of Σ has a radius r > 0 such that B(z, r) holds no other point of Σ, the essential boundary in B(z, r) off z is the union of
    finitely many pairwise disjoint curves, each a polar graph t ↦ z + t e(φ(t)) over 0 < t < r with φ continuous and convergent as t → 0, and
    each open region between two angularly consecutive curves is almost everywhere of one colour
  uses only: FS131-E8-FAN at each z ∈ Σ — a locally finite Σ is closed and each of its points has a ball holding no other; saturation of the
    colouring gives the punctured ball's saturation. The frozen words' second clause is not read
  not claimed: that any colouring with fewer than seven colours meets the hypotheses; that Σ is locally finite in any saturated colouring
    (C121-REGJ's first clause, open); anything at a point of Σ that is an accumulation point of Σ
  argument: § 3.6 The fan at an isolated singular point
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 (saturated, Σ the vertices (½ℤ)², locally finite) — at every vertex four branches along the axes, constant angles, four colours
  prior art: partly: as FS131-E8-FAN; the planner's RegJBridge (plans/FS131-w6-kernel-plan.md § 6 on fs131-w6) poses it with the second clause
    as a hypothesis and reports no derivation found
  handoff: de Bruijn — ∀ c : AeColouring k, Saturated c.cls → (∀ x, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) → c.RegJFan, which gives
    RegJBridge k with c.RegJLiteral's second conjunct unused; a corollary of FS131-E8-FAN

### 3.7 The second clause is a consequence

Let the colouring be saturated with Σ locally finite, `z ∈ Σ`, and `r`, `n` its fan's. A connected component `A` of `𝓘` with `z ∈ cl A` has a point
in `B(z, r)`, which lies on one of the `n` branches; a branch is a connected subset of `𝓘`, so it lies in one component, which is `A`. So **at most
`n` components of `𝓘` have `z` in their closure** — the frozen words' second clause, in the planner's reading `(c.arcsAt z).Finite`; and since the
branches are all of `∂_e` near `z`, in any reading of "interface arc" as a connected piece of the essential boundary.
*A bounded set meets finitely many components.* Let `K` be compact. `Σ ∩ K = {z₁, …, z_m}` is finite, with fans of radii `r_i`. The set
`K′ = K ∖ ⋃ B(z_i, r_i)` is compact in the open set `ℝ² ∖ Σ`, in which `𝓘` is relatively closed and each point of `𝓘` has a square lying in one
component (§ 3.1); finitely many squares cover `𝓘 ∩ K′`. With the at most `n_i` components at each `z_i`: finitely many meet `K`. ∎

derivation: FS131-E8-CLAUSE2
  statement: in a measurable k-colouring of the plane whose classes have null unit pairs, saturated, with locally finite singular set Σ, every
    point of Σ lies in the closure of finitely many connected components of the interface set, and every bounded set meets finitely many
    connected components of the interface set
  uses only: FS131-E8-BRIDGE (the fan at each point of Σ); FS131-E8-LOCAL (off Σ each interface point has a neighbourhood in one component);
    compactness
  not claimed: a bound on the number of components per unit area; the statement when Σ is not locally finite — its contrapositive says that in
    a saturated colouring infinitely many interface arcs in a bounded set make Σ not locally finite
  argument: § 3.7 The second clause is a consequence
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 — each vertex lies in the closure of four components (the open edges at it), and a disc of radius 2 meets finitely many edges
  prior art: partly: FS111-M-REDUCE-I and FS121-D2-PERFIN read "finitely many interface arcs meet a compact set" from REG-J′'s two clauses;
    here from the first alone; not found in this project's records
  handoff: de Bruijn — c.RegJLiteral follows from Saturated c.cls and local finiteness of c.singularSet; a corollary of FS131-E8-BRIDGE, wanted
    where a row reads finitely many arcs in a bounded set

### 3.8 The verdict on Q, clause by clause

| clause | verdict | entry | found in the record, or derived here |
|---|---|---|---|
| (α) no arc passes near `z` without meeting it | **derived** | FS131-E8-ALPHA | derived here; the record held it as a reading |
| (β) each arc is a polar graph near `z` | **derived** | FS131-E8-BETA | derived here |
| (γ) each arc has an end tangent | **derived** | FS131-E8-GAMMA | in the record for an arc at `z` (V2 § 2.1 Lemma T (i); V3 § 2.3 (F-a)); here with the ends located |
| (δ) each region is one colour | **derived** | FS131-E8-DELTA | in the record over Federer's criterion (V3 § 2.3 (F-b)); here from the definitions |

`RegJBridge k` is **true for every `k`** (FS131-E8-BRIDGE), and it does not read `RegJLiteral`'s second conjunct, which is itself a consequence
(FS131-E8-CLAUSE2). Under saturation the three forms — Σ locally finite; the frozen words; the fan with end tangents — are one hypothesis.
[hand], one mind, kernel pending.

## Stage 4 — SAVED: the attack, the trace of the consumers, the drafts, the predictions scored

### 4.1 The attack: where it succeeds, and where it does not

On the statement, smallest cases first. **SQ9 at a vertex** and **R7 at a lattice point** are the two held singular points; both have fans (four
branches in four directions; six branches tangent in three pairs — so "the branches have different limit directions" is false, and is not
claimed). The nearest false statements, each located:

| the statement, altered | fails at | where the argument breaks |
|---|---|---|
| without saturation | (α), (β), (γ): circles of radii `2^{−n}` accumulating at `z`; a spiral into `z` — both drawable in a slack sixteen-colouring by squares of side `0.4`, whose edges may be redrawn freely | § 3.1 (2): no contacts, no tangent discs, no curvature bound |
| at an accumulation point of Σ | the fan's own `singular` field | § 3.2's setting has no `R` |
| on a cover in place of a colouring | not decided here | FS111-M-PINCH's (out, out) case changes with overlaps (`plans/FS111-M2-regularity.md` § 2.2) |
| in a disc of radius above `1/2` | "not closed", "length at most `π/2`" (a unit circle of interface fits in a disc of radius above 1) | § 3.2 (2)'s chord below 1 |
| "the fan has a region of positive angle" | not decided: branches all tangent to one line are not excluded here | nothing in §§ 3.1–3.6 reads an angle |

On the steps. (i) *FS111-M-PINCH off-centre* — the one place the argument reads a held proof in a form its Lean statement does not have. I re-read
`plans/FS111-M-regularity.md` § 3.1 for it: Step 1 reads `P_a`, the contact, and M-HULL1; Step 2 reads `S_a ∪ S_b ⊇ N` a.e. and open cones at the
point. Neither reads the centre of `N`. FS111-M-C11's statement already applies it "with the same `N`, `P_a`, `P_b`". (ii) *A cusp inside the
two-colour ball* — excluded in § 3.1 (1) by `U ∩ Σ = ∅`; FS111-M-C11 as filed has no such hypothesis, and its line "each normal line near `x`
meet the boundary once" finds a point of `supp S_a ∩ supp S_b`, which is an essential boundary point only if it is no cusp. Every consumer
applies C11 off a closed Σ, so nothing filed is at risk; the formal C11 (ii) should carry the hypothesis. (iii) *A neighbour that could have
refuted it*: FS121-V5-GRID-CANTOR's colouring has a non-locally-finite breakpoint set and SQ9's locally finite Σ — against FS131-E8-CLAUSE2 only
if its extra breakpoints carried essential boundary; they are redundant (the colour is the same on both sides), so they carry none. Consistent.
(iv) *R7's numbers*: a unit arc from a lattice point `z` has length `2 arcsin(1/4) ≈ 0.505 < π/2` inside `B(z, 1/2)`, and its distance from `z`
increases up to the antipode. Consistent with §§ 3.2–3.3.

**What the attack could not supply:** a second mind. This derivation is one mind's, sighted of V2, V3 and V5; the kernel is the second check.

### 4.2 The trace: which filed results read which clause, and what each becomes

Read from the entries' `uses only` lines (`plans/FS111-derivation.md`, `plans/FS121-derivation.md`) and from three arguments (V2 §§ 2.1–2.3, V3
§ 2.3, V5 § 3.1). The other arguments were not re-read: a row that reads something of REG-J′ beyond the two clauses and the fan would not be caught
here, and no `uses only` line names such a thing.

| rows | what of REG-J′ each reads | clauses | under the verdict |
|---|---|---|---|
| FS121-DB1-L3 (carrying FS111-W-NOREP), FS121-V2-SECTOR, FS121-V3-CPI, FS111-W-KB-DIR | the fan at one point: the essential boundary near `z` is the arcs at `z`; each has a tangent there; each region is a.e. one colour | (α), (γ), (δ); (β) only as the Lean structure's way of writing a branch | **unchanged**; true at every singular point isolated in Σ, with FS131-E8-FAN as the lemma |
| FS111-M2-INTRAD (iii), FS111-M-REDUCE-I, FS121-D2-PERFIN | the second clause, or "finitely many interface arcs meet a compact set" | — (the words' second clause) | **unchanged**; the clause is FS131-E8-CLAUSE2 |
| FS121-O1-ENDS, -DB1-L6, -O1-OUT, -O1-LRA-LINE, FS121-D1-VT, -V2-VT-W, -D1-EROSION, -D1-PENCILWIN, FS121-D2-EXT, -D2-THIN, -D2-SYM | Σ locally finite; the fan and end tangents where an arc ends at a point of Σ; the rows above | (α), (γ), (δ) through the rows above | **unchanged**; each needs the bridge as a lemma |
| FS121-V5-LOC, -V5-RAY | Σ closed only | none | **unchanged**; FS131-E8-LOCAL is V5-LOC's statement with its hypothesis read |
| FS121-DB1-L7, FS121-D4-HOLE | nothing (no REG-J′) | none | unchanged |

**No filed result becomes "true under the stronger hypothesis only".** The weakest hypothesis the consumers share, which is what the kernel should
carry: globally, `Saturated c.cls` and `∀ x, ∃ r > 0, (c.singularSet ∩ ball x r).Finite`; at one point, `c.singularSet ∩ ball z R ⊆ {z}` with
saturation at the essential boundary points of the punctured ball. The fan is then a theorem (FS131-E8-FAN), not a hypothesis; a row may still
take a `Fan` as an argument, with the lemma supplying it.

**Bearing on inventory item 481's ruling (b)** — "REG-J′'s fan form with end tangents stays in the hypothesis, named, each consumer's docstring
saying it is stronger than the frozen words": under FS131-E8-BRIDGE the fan form is not stronger, given saturation. The docstring sentence is
true of the two definitions as bare predicates and false of every saturated colouring. Held for the coordinator.

### 4.3 What it implies (the look-back)

- **C121-REGJ is its first clause.** "Σ is locally finite and each point of Σ meets finitely many interface arcs" follows, in a saturated
  colouring, from "Σ is locally finite" (FS131-E8-CLAUSE2). FS-127's question — "can infinitely many singular points, or infinitely many boundary
  arcs, crowd into a bounded set?" (`plans/STUB-lateral-extent.md` l. 9) — is the singular points alone: infinitely many interface arcs in a
  bounded set make Σ not locally finite.
- **Route M's regularity hypothesis is local finiteness of Σ.** FS111-M2-REDUCE-A's three conditions at six are honest saturation, REG-J′₆, ¬LRA;
  the second is now "Σ locally finite" with nothing beside it.
- **Grid colourings.** In an honest saturated grid colouring, breakpoints that carry essential boundary and accumulate put Σ on the limit line;
  so FS121-D4-GRID's open "Σ clause" at uncountable breakpoint sets is the question whether its genuine breakpoints are locally finite. Not
  decided here.
- **Could it have been foreseen?** Yes: FS121-V5-RAY is the same compactness, run for arcs of radii tending to infinity; the record held the reading
  (the close's note) and the lemma that proves it (V5-RAY) in two files. An instance of G92 (a held result reaches as far as its argument).
- **Is it known?** Its parts are textbook (the chord bound; local finiteness of the components of a closed embedded submanifold). The statement
  about saturated colourings is about this project's objects; no literature search was run, and nothing is claimed new beyond "not found in this
  project's records".

### 4.4 Drafts for the coordinator's files (I edit none of them)

Each names its slot.

- **`plans/STUB-lateral-extent.md`, § Provisional bearings, a line after "G84, G85; …":** "Since FS131-E8 (`plans/FS131-E8-derivation.md`; [hand],
  one mind, kernel pending): in a saturated colouring a locally finite Σ gives a fan with end tangents at each of its points and finitely many
  interface arcs in every bounded set (FS131-E8-BRIDGE, -CLAUSE2), so C121-REGJ is its first clause — the question is the singular points alone, and
  infinitely many boundary arcs in a bounded set are a wild Σ, never a second kind of crowding."
- **`plans/STUB-curved-pencils.md`, § Provisional bearings, a line after "G84, G85 (contact, integer radii; …":** "Since FS131-E8: REG-J′'s fan
  reading is derived from its first clause (FS131-E8-BRIDGE; [hand], one mind, kernel pending), so this stub's class is the honest saturated
  colourings with locally finite Σ; the failure clause on quoting REG-J′ stays as a quotation rule."
- **`data/fs121/claims.md`, Notes at the close, a note after "§ 0, add (V3 § 3.6)":** "*2026-10-06, FS131-E8:* the fan reading of REG-J′ is derived
  from its words, and from their first clause alone (FS131-E8-BRIDGE, -CLAUSE2, `plans/FS131-E8-derivation.md`; [hand], one mind, kernel pending).
  C121-REGJ's second clause follows from its first."
- **`.claude/skills/grokkings/SKILL.md`, G85, the words "Off a singular set that is locally finite with finitely many arcs at each point,":**
  replace by "Off a locally finite singular set (finitely many arcs then meet each of its points, FS131-E8-CLAUSE2),". And `CLAUDE.md` § Grokkings,
  the theory paragraph's "off a locally finite singular set its interfaces are segments and arcs of integer radius, that finiteness open": no
  change — it already names the first clause alone.
- **`plans/GROKKING-INSTANCES.md` § G92, an instance:** "FS131-E8 (2026-10-06): FS121-V5-RAY's compactness — arcs accumulating off Σ are one arc —
  was filed for arcs of radii tending to infinity; its argument reads no radius, and run on a circle about a singular point it gives the fan the
  close had filed as a reading of REG-J′ (FS131-E8-ALPHA). Source: `plans/FS131-E8-derivation.md` § 3.4."
- **`LEDGER.md`:** no row drafted — FS-131 files by its inventory; the result is a lemma under rows 140–144, [hand], one mind, kernel pending.
- **`BIBLIOGRAPHY.md`:** no row. Schur's comparison theorem and Allard–Almgren's structure theorem are named as recalled, not read, and nothing
  rests on either: the chord bound is proved in § 3.2 (1), and home 3 was killed.

### 4.5 The predictions, scored

Registered at stage 1 after a sketch (§ 1.5's note): (α) derived at 0.88 — met; (β) derived at 0.92 — met; (γ) derived, found in the record, at
0.95 — met; (δ) derived without Federer at 0.93 — met; "the second clause is not consumed" at 0.8 — met. Brier 0.014 over five, all informed.
Neither registered break occurred as a failure; the first (M-PINCH off-centre) is the note of § 4.1 (i), and a break not registered — the cusp
inside C11's ball — is § 4.1 (ii).

### 4.6 Row by row, for wave 6's second planner (added on the coordinator's word, inventory item 490; §§ 3.1–3.7 unchanged)

*Basis, as § 4.2: each row's `uses only` line, and the arguments of V2 §§ 2.1–2.3, V3 § 2.3, V5 § 3.1 and `plans/FS111-M2-regularity.md` § 4.1.
A row marked † was read from its entry only.* Columns: **F** — a fan at named points (FS131-E8-FAN: the point isolated in Σ, saturation in a
punctured ball); **Σ** — Σ locally finite on a bounded set; **C2** — finitely many interface arcs in a bounded set (FS131-E8-CLAUSE2); **L** — the
local graph off Σ (FS131-E8-LOCAL, the form of C11 (ii)).

| row | F | Σ | C2 | L | what it reads, in its own words |
|---|---|---|---|---|---|
| FS111-W-KB-DIR † | at the arc's centre | — | — | — | "the inner colour's sector points toward the arc" |
| FS121-DB1-L3 (with FS111-W-NOREP) | at `z` | — | — | on `W₁`'s two edges | V2 § 2.1's fan; Lemma T at the edges |
| FS121-V2-SECTOR | at `z` | — | — | on the edges and on `γ₃` | the same; the comparison of `γ₃` with a unit circle |
| FS121-V3-CPI | at `z` | — | — | on a region's two edges | V3 § 2.3's Lemmas A, C |
| FS121-D1-VT †, FS121-V2-VT-W † | at `Y` | near `Y` | — | along `I`, `L_Y` | "REG-J′'s local finiteness and FS111-M-C11's end tangents; FS121-V2-SECTOR at Y" |
| FS121-D1-EROSION † | at the crossing point, through D1-VT | as D1-VT | — | — | "FS121-D1-VT on the straight branch" |
| FS121-D1-PENCILWIN † | through D1-VT, V2-SECTOR | through O1-OUT | — | — | "one sector per colour (FS121-V2-SECTOR)" |
| FS121-O1-ENDS † | at the last arc's centre (FS121-DB1-L3 there) | along the chain (a null set of normals) | — | — | "the chain toward the centre stops at radius 1 or at Σ" |
| FS121-DB1-L6 † | — | along the chain (finitely many normals) | — | — | "REG-J′'s local finiteness (each point of Σ but the centre on one normal)" |
| FS121-O1-OUT † | — | over the window | — | yes | the parallel is an interface "off Σ" |
| FS111-M2-INTRAD | — | step (2): the normals that meet Σ | step (3), per-radius finiteness: "REG-J′'s second clause bounds the gaps" | steps (1)–(2) | § 4.1 there |
| FS121-O1-LRA-LINE †, FS121-D2-THIN † | — | yes | through INTRAD (iii) | — | "its per-radius finiteness (iii)" |
| FS121-D2-EXT † | — | "REG-J′", named whole | — | "two distinct circles … tangent at a point meet only there near it" | — |
| FS121-D2-SYM † | — | — | the in-particular clause, through INTRAD (iii) | through FS121-V5-RAY | — |
| FS121-D2-PERFIN † | — | — | by name: "finitely many interface arcs meet a compact set" | — | — |
| FS111-M-REDUCE-I † | at each point of Σ (S–V's Condition 3) | yes | "the finitely-many-arcs clause" | off Σ | — |
| FS121-V5-LOC, FS121-V5-RAY | — | Σ closed | — | it is this | V5 § 3.1 |
| FS111-W-NOBEND † | — | — | — | it is C11 | — |
| FS121-DB1-L7 †, FS121-D4-HOLE † | — | — | — | L7: yes | "REG-J′ is not used"; "REG-J′ (unused)" |

**Rows that need a fan at one point and no local finiteness:** FS111-W-KB-DIR, FS121-DB1-L3, FS121-V2-SECTOR, FS121-V3-CPI — FS131-E8-FAN's
hypotheses are theirs (`Σ ∩ ball z R ⊆ {z}`; saturation at the essential boundary points of the punctured ball, never at `z`).

**No row reads more than FS131-E8 gives; four read more than the planner's `Fan` has fields for.** FS121-DB1-L3, -V2-SECTOR, -V3-CPI and, through
them, D1-VT read two facts about a branch that `Fan` does not carry: (1) **the curvature bound along it** — V2-SECTOR compares `γ₃` with a unit
circle, V3's (F-c) puts two tangent branches between the two unit circles tangent to their direction; (2) **the branch's unit tangent, hence its
normal, converges to the direction `dir i`** — Lemma T (ii) and Lemma A take limits of contacts `x_n ± ν(x_n)` along the branch. `Fan.tendsto` is
the convergence of the polar angle only. Both facts are in this record: (1) is FS131-E8-LOCAL at the branch points, which are interface points
(`bdry` puts them on the essential boundary, `singular` off Σ); (2) is FS131-E8-GAMMA with FS131-E8-BETA's last clause ("convergent, as t → 0, to
an angle of the component's limit tangent at z"). So the kernel lemma for FS131-E8-FAN should export, beside the `Fan`: each branch is a
`C^{1,1}` curve with tangent 1-Lipschitz in arclength, and its unit tangent at `z + t e(φ i t)` tends to `±e(dir i)` as `t → 0`. Proved here, in
addition, and offered: the chord of a branch from `z` makes an angle at most `s/2` with the end tangent for arclength `s ≤ π/3` (control
`e8-chord`, C3; proof: `∫₀^s sin(ψ(u) − s/2) du ≤ ∫₀^s sin(u − s/2) du = 0`, the sine increasing on `[−π/2, π/2]`), which with `t ≥ sin s`
gives `|φ i t − dir i| ≤ arcsin(t)/2`. V3's sharper lens bound `arcsin(t/2)` is its own comparison argument, not re-derived here.

**Errata drafts for `plans/FS111-derivation.md`** (Keryx files; each a dated line under its entry, after the entry's "Rests on it" line, the
entry's text left standing):

- *Under FS111-M-C11:* "**Erratum, 2026-10-06** (FS131-E8, `plans/FS131-E8-derivation.md` §§ 3.1 (1), 4.1 (ii); one mind): the hypothesis
  "M-PINCH's hypotheses hold at every essential boundary point in N" does not speak of a cusp of `a` or `b` inside `N` — a point of
  `supp S_a ∩ supp S_b` where one of the two has density 0, which is no essential boundary point. The argument's step "each normal line near `x`
  meet the boundary once" (`plans/FS111-M-regularity.md` § 3.2 (ii)) finds on each normal line a point of `supp S_a ∩ supp S_b`; it is an
  essential boundary point only if it is no cusp. Read the statement with the added hypothesis "and neither colour has a cusp in N". Every
  consumer applies it off a closed Σ, where the hypothesis holds, so nothing resting on it changes. Whether the added hypothesis follows from the
  filed one is not derived (a sketch over Federer's criterion, recalled, not read, suggests it does)."
- *Under FS111-M-PINCH:* "**Note, 2026-10-06** (FS131-E8, `plans/FS131-E8-derivation.md` §§ 3.1 (2), 4.1 (i); one mind): "a neighbourhood N" is
  an open ball containing `x`, not a ball centred at `x`. The argument (`plans/FS111-M-regularity.md` § 3.1) reads `N` through `P_a`, `P_b` and
  through open cones at `x`, never through its centre; FS111-M-C11 applies it at every boundary point of one ball ("with the same `N`, `P_a`,
  `P_b`"), and FS131-E8-LOCAL does the same. A formal statement centred at `x` (`pinch` over `TwoColourAt x ρ a b`, `fs131-w6`) is the special
  case and does not serve those two."

## Stage 5 — SAVED: the second question — J45-SI-5's step (c) without a pointwise ergodic theorem

**The step** (`plans/FS84-SI-D-derivation.md` § 2.2, SI-5 (c), verbatim): "`γ_Φ ∘ π_𝔓` is `c`-measurable (on each residue class its colour has
frequency `≥ 2/3`, any other `≤ 1/3`: ergodic averages along a tempered Følner sequence)". Its setting, SI-5 (b), verbatim: "Independently: `Φ` a
uniform translate `a ∈ O/𝔓` …; `c₂`; `ε` i.i.d. with `P(ε = 1) = 1/3`. Put `c(x) = m` if `x ∈ W_Φ`, `c₂(x) = j₀`, `ε(x) = 1`, and
`c(x) = γ_Φ(π_𝔓 x)` otherwise."

**Answer: yes — Chebyshev's inequality and the closedness of `L²(σ(c))` suffice; no ergodic theorem, no Følner sequence, and no independence of
`ε` from `(Φ, c₂)`.**

### 5.1 Majority decoding

Fix a residue class `ρ ∈ O/𝔓` and put `G = γ_Φ(ρ) = γ(ρ + a)`, a random colour. The class `{x ∈ R : π_𝔓 x = ρ}` is infinite (a coset of a
subgroup of finite index in the infinite group `R`); enumerate distinct points `x₁, x₂, …` of it. By the construction, `c(x_i) ≠ G` only if
`ε(x_i) = 1`. Let `Maj_n` be the most frequent colour among `c(x₁), …, c(x_n)` (least index on a tie): a function of `c`. If fewer than `n/2` of
`ε(x₁), …, ε(x_n)` are 1, then `G` is the strict majority and `Maj_n = G`. The `ε(x_i)` are pairwise independent with mean `1/3` and variance
`2/9`, so by Chebyshev

  `P(Maj_n ≠ G) ≤ P(Σ_{i ≤ n} ε(x_i) ≥ n/2) ≤ (2n/9)/(n/6)² = 8/n`.

Hence `‖1[Maj_n = j] − 1[G = j]‖₂² ≤ 8/n → 0` for each colour `j`. Each `1[Maj_n = j]` lies in `L²(σ(c))`, a closed subspace; so `1[G = j]` does,
that is `1[G = j] = E[1[G = j] | σ(c)]` a.s.: `G` is a.s. a function of `c`. This holds for each of the finitely many `ρ`, so
`γ_Φ ∘ π_𝔓` is `c`-measurable. ∎ (Along `n = N²` the bound is summable, so `Maj_{N²} → G` almost surely by Borel–Cantelli, if a pointwise
selector is wanted. The strong law for the i.i.d. `ε(x_i)` does the same in one line where the library has it.)

The rest of step (c) — that a finite-valued `c`-measurable process permuted through `O/𝔓` is `𝒜_S(c)`-measurable — does not read the ergodic
averages and is not touched.

derivation: FS131-E8-SI5C
  statement: let I be a countably infinite set, G a random variable with values in a finite set, c = (c(x)) for x in I random variables with
    values in the same finite set, and ε = (ε(x)) for x in I indicator variables, pairwise independent, each of probability p < 1/2, such that
    almost surely c(x) ≠ G implies ε(x) = 1 for every x in I; then G is almost surely equal to a function of c, measurable for the σ-algebra c
    generates
  uses only: Chebyshev's inequality for a sum of n pairwise independent indicators, P(sum ≥ n/2) ≤ p(1 − p)/(n(1/2 − p)²); that a strict
    majority among c(x₁), …, c(x_n) is a function of c; that L² of a sub-σ-algebra is closed. Not read: any group structure on I, a Følner
    sequence, an ergodic theorem, independence of ε from (G, c)
  not claimed: the statement at p ≥ 1/2 (at p = 2/3 the recoloured value can be the majority); the remainder of J45-SI-5 (c) (measurability for
    the E_S-factor), J45-SI-J, or SI-5 as a whole, none of which was re-derived here
  argument: § 5.1 Majority decoding
  verdict: derived
  grade: hand
  minds: 1
  model: I = ℕ, G uniform on {0, 1}, ε i.i.d. of probability 1/3, c(x) = 2 where ε(x) = 1 and c(x) = G elsewhere — the majority of
    c(1), …, c(n) is G once fewer than half of the ε are 1; SI-5 (b)'s construction on one residue class is the instance the step needs
  prior art: known: the weak law of large numbers by Chebyshev, and majority decoding of a repetition code (textbook; recalled, not read)
  handoff: de Bruijn — it replaces "ergodic averages along a tempered Følner sequence" in J45-SI-5 (c) for wave 10's second planning pass:
    Chebyshev and a closed subspace of L², or the strong law for i.i.d. indicators where Mathlib has it (not checked at the pin)

control: e8-majority
  of: FS131-E8-SI5C — the Chebyshev bound P(Bin(n, 1/3) ≥ n/2) ≤ 8/n, exactly, for n = 1 … 300
  run: python3 ../data/fs131/e8/e8_majority.py
  expect: 0
  fault: python3 ../data/fs131/e8/e8_majority.py --p 2/3

## Stage 6 — SAVED: the planner's statements of the bridge, checked (the brief's amendment of 2026-10-06)

*Resumed for this stage only. Read: the amendment; `plans/FS131-w6-kernel-plan.md` §§ 10.2, 11.1–11.5 on `fs131-w6` at `32f2ab4c`;
`Plane/Saturated/Curve.lean`, `FanBridge.lean` whole; `Fan.lean` ll. 30–215; `LocalGraph.lean` ll. 63–105; `Pinch.lean`'s statements of `pinch`,
`pinch_interface`, `c11_discs`, `c11_split`. The amendment's ten quotations against their sources: exact, each (`data/fs131/e8/quotes.py`, now
reading a section name after a path; output `data/fs131/e8/quotes-amendment.out`, 15 of 15 over the whole brief; `--plant` exits 1).*

**A fan**, in this stage, is the planner's structure (`Plane/Saturated/Fan.lean` ll. 159–185), for a measurable colouring with finitely many
colours and a point `z`: a radius `r > 0` with `Σ ∩ B(z, r) ⊆ {z}`; `n` **branches**, branch `i` the polar graph `{z + t e(φ_i(t)) : 0 < t < r}`
of a continuous `φ_i` with a limit `d_i` at 0 (its **limit direction** `e(d_i)`), in counter-clockwise order within one turn at every `t`; the
essential boundary in `B(z, r) ∖ {z}` the union of the branches; the open region counter-clockwise of branch `i` almost everywhere of a colour
`col i`. No saturation and no curvature bound is part of it.

### 6.1 The contacts at a branch

**Registered after a sketch made while reading the statement** (informed, as § 1.5's were): `branch_contacts` true at 0.8; the planner's
"split along its whole length or tangent along it" true as worded at 0.5 — the likeliest break a point that is of both types at once.
*Scored:* the first met; the second half-met — true as an inclusive alternative, false as an exclusive one (below).

Let `F` be a fan at `z`, the colouring's classes with null unit pairs, and every essential boundary point of `B(z, r) ∖ {z}` saturated. Fix a
branch, `e(d)` its limit direction, `a` the colour of the region clockwise of it and `b` of the region counter-clockwise; `a ≠ b` (§ 6.2). Its
points `x(t) = z + t e(φ(t))` are interface points (on the essential boundary, off Σ), and in every small ball about one only `a` and `b` have
positive measure, so its two-colour ball has the colours `a`, `b`.

**Case A: some branch point `x(t₀)` has a common contact** — a point `y ∈ supp S_a ∩ supp S_b` with `|x(t₀) − y| = 1`. Let
`T = {t ∈ (0, r) : |x(t) − y| = 1}`. It is closed in `(0, r)` (continuity). It is open: at `t₁ ∈ T`, FS111-M-PINCH at `x(t₁)` with the pair of
contacts `(y, y)` cannot be its tangent case (that needs antipodal contacts), so `x(t₁)` is of split type about `y`, and in its two-colour ball
the essential boundary is the unit circle about `y` (FS111-M-C11 (iii)); the branch points near `x(t₁)` are essential boundary points in that
ball. `T ∋ t₀` and `(0, r)` is connected: **the whole branch lies on the unit circle about `y`**. Letting `t → 0`: `|z − y| = 1`, and the
branch's limit direction is the circle's tangent at `z`, so `y − z = ± i e(d)`. (No saturation is read in this case beyond the one common
contact, and no bound `1/2`.)

**Case B: no branch point has a common contact.** At each branch point `x` take a contact `y_a` of `a` and `y_b` of `b` (saturation). They
differ, so FS111-M-PINCH gives its tangent case: `y_b − x = −(y_a − x)`, the open unit disc about `y_a` a.e. of `b` near `x`, the one about
`y_b` a.e. of `a`. So `y_a − x` is a unit normal of the branch at `x` pointing into `b`'s side, the counter-clockwise side. Within `B(z, 1/2)`
the branch is the component of FS131-E8-GAMMA through its points (it is connected, lies in one component, and both meet each small circle about
`z` once — FS131-E8-BETA), so it has a unit tangent `T`, pointing away from `z`, which tends at `z` to `e(d)` (BETA's last clause with the fan's
`tendsto`). The normal into the counter-clockwise side is `iT` (the tangent has a positive radial component, so `iT` has a positive component
along increasing angle). Hence `y_a(x(t)) = x(t) + iT → z + i e(d)` and `y_b(x(t)) = x(t) − iT → z − i e(d)`; supports are closed:
**`z + i e(d) ∈ supp S_a` and `z − i e(d) ∈ supp S_b`**. ∎

One of the two cases holds, so the planner's disjunction holds: `branch_contacts` is **derived at its exact hypotheses** (`F` any fan;
saturation in `B(z, F.r) ∖ {z}`; `j` the region clockwise of `i`).

**The planner's sentence, corrected in one word.** "A branch is of split type along its whole length or of tangent type along it" is true as
*some branch point has a common contact of both colours — then every branch point is of split type about that one centre — or none has, and
then every branch point is of tangent type*. It is false as an exclusive alternative of the two types: a unit arc about `y` with `b` inside,
whose colour `b` also has a contact at `2x − y` for the arc's points `x`, is of split type and of tangent type at once (FS111-M-PINCH's "exactly
one of" is per pair of contacts). The Lean disjunction is inclusive, so the statement is unaffected; a consumer that case-splits on it must not
assume the second alternative excludes a unit arc.

derivation: FS131-E8-BRANCH
  statement: in a measurable k-colouring of the plane whose classes have null unit pairs, let z have a fan of radius r, and let every essential
    boundary point of B(z, r) other than z have, for every class with that point on its essential boundary, a point of that class's support at
    distance 1; then for each branch of the fan, with limit direction e(d), a the colour of the region clockwise of it and b the colour of the
    region counter-clockwise: either one of the two points z + i e(d), z − i e(d) lies in the supports of both a and b and every point of the
    branch is at distance 1 from it, or z + i e(d) lies in the support of a and z − i e(d) in the support of b
  uses only: FS111-M-PINCH at a branch point for a given pair of contacts (a common contact excludes its tangent case, distinct contacts its
    split case); FS111-M-C11 (iii) in a split point's two-colour ball; connectedness of (0, r); FS131-E8-TWOSIDES (a ≠ b); in the second
    alternative also saturation at branch points near z, FS131-E8-GAMMA and -BETA for the branch's tangent at z, and closed supports
  not claimed: that the two alternatives exclude each other (a unit arc with a further contact at the antipode has both); which colour is
    inside the circle in the first; that the branch is not a unit arc in the second; anything about a branch of a fan in a colouring that is
    not saturated near z
  argument: § 6.1 The contacts at a branch
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point — each of the six branches is a unit arc about the opposite corner of its Reuleaux triangle, which carries both
    colours (the first alternative); SQ9 at the vertex (1/2, 1/2) — each branch along an axis has its two contacts at z ± i e(d) (the second;
    control e8-sq9-contacts)
  prior art: partly: FS121-V2-verification.md § 2.1 Lemma T (ii) holds the contacts' limit for an arc of one type; the propagation of a common
    contact along the branch and the statement over any fan are the planner's (FS131-w6-kernel-plan.md § 11.5 (4) on fs131-w6), derived here
  handoff: de Bruijn — Fan.branch_contacts as stated; the first alternative holds for every t in (0, F.r), not only below 1/2, and its
    proof reads no saturation beyond the common contact

control: e8-sq9-contacts
  of: FS131-E8-BRANCH — the second alternative on its model: SQ9's four branches at a vertex, both contacts of each, exactly
  run: python3 ../data/fs131/e8/e8_sq9_contacts.py
  expect: 0
  fault: python3 ../data/fs131/e8/e8_sq9_contacts.py --swap

### 6.2 Two sides, two colours — with no saturation

Let `F` be a fan at `z` in a measurable colouring with finitely many colours; no unit pairs, no contacts.
(1) *A branch is a null set.* It is relatively closed in the punctured disc, and each circle about `z` meets it in one point; integrate in
polar coordinates. (Or: the image of the graph of `φ_i`, a null set of the `(t, θ)`-plane, under the smooth polar map.)
(2) *Near a branch point `x = x_i(t₀)` every point is on branch `i` or in one of the two regions beside it.* The other branches' angles differ
from `φ_i(t₀)` modulo `2π` at `t₀` (the order within one turn) and are continuous, so a small ball about `x` misses them; its points have
angle just above `φ_i(t)` (the region counter-clockwise of `i`), just below (the region clockwise of it), or equal.
(3) *The two regions differ in colour.* If both were a.e. of one colour `a`, a ball about `x` would be a.e. of `a` by (1) and (2), `x` a density
point of `S_a`, hence on no class's essential boundary — but the branches lie in the essential boundary. With one branch the two regions are
one region, so **no fan has one branch**.
(4) *At a singular point, at least two.* With no branch, the punctured disc is a connected open set meeting no essential boundary and no cusp
(cusps are in Σ), so it is a.e. of one colour (FS131-E8-DELTA); then `z` is a density point of that class and outside every other class's
support: on no essential boundary and no cusp, so `z ∉ Σ`. ∎

The planner's `Fan.col_ne` and `Fan.two_le_n` are **derived, with no saturation**. FS131-E8-FAN's entry is not wrong — its two clauses are true
— but its `uses only` names a route through FS131-E8-LOCAL that is not needed; the dated note under the entry (§ 3.6) says so.

derivation: FS131-E8-TWOSIDES
  statement: in a measurable colouring of the plane with finitely many colours, at a point z that has a fan, the regions on the two sides of
    each branch have different colours, the fan does not have one branch, and if z is a singular point the fan has at least two branches
  uses only: that a continuous polar graph is a null set; continuity and the angular order of the branches; that a density point of one class
    is on no class's essential boundary; FS131-E8-DELTA on the punctured disc, for a fan with no branch; the definition of Σ. Not read: unit
    pairs, saturation, contacts, curvature
  not claimed: that two regions not beside one branch differ in colour (without saturation one colour can occupy two regions of a fan, as at
    the centre of a bow-tie); that a fan exists
  argument: § 6.2 Two sides, two colours — with no saturation
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at the vertex (1/2, 1/2) — four branches, four regions, the colours on the two sides of each branch different
  prior art: partly: the planner's argument (FS131-w6-kernel-plan.md §§ 11.4, 11.5 (3) on fs131-w6), checked here step by step; FS131-E8-FAN
    held the two clauses under saturation
  handoff: de Bruijn — Fan.two_le_n and Fan.col_ne as stated

### 6.3 The lens bound, and the fan at every point

**`IsUnitCurve.one_le_dist`.** For a unit-speed curve with 1-Lipschitz tangent angle `ψ` on `[0, ℓ]`, `ℓ ≤ π/2`, put
`f_±(s) = |γ(s) − γ(0) ∓ i T(0)|²`. Then `f_±(0) = 1` and, with `⟨i e(α), e(β)⟩ = sin(β − α)`,

  `f_±′(s) = 2⟨γ(s) − γ(0), T(s)⟩ ∓ 2 sin(ψ(s) − ψ(0)) ≥ 2 sin s − 2 sin s = 0`,

by § 3.3's inequality (C2) and `|ψ(s) − ψ(0)| ≤ s ≤ π/2`. So `f_± ≥ 1`: **confirmed** (control `e8-outside`, exact, both signs). **It is the
statement the sector rows need**: V2 § 2.3's "it lies on or below that arc, outside `B(y, 1)`" and V3 § 2.3 (F-c) are this, at `γ(0) = z`,
`T(0) = e(d)`. In polar form it is `|φ_i(t) − d_i| ≤ arcsin(t/2)`, V3's lens; my § 4.6 offered `arcsin(t)/2`, which is weaker
(`arcsin(t/2) ≤ arcsin(t)/2`) and does not put the branch outside the discs. § 4.6's offer is withdrawn in favour of this.

derivation: FS131-E8-OUTSIDE
  statement: a unit-speed plane curve whose tangent angle is 1-Lipschitz in arclength, of length at most π/2, stays outside the two open unit
    discs tangent to it at its starting point
  uses only: the inequality ⟨γ(s) − γ(0), T(s)⟩ ≥ sin s of § 3.3; that the sine is increasing on [0, π/2]
  not claimed: the same beyond arclength π/2; strict inequality (a unit arc stays on one of the two circles)
  argument: § 6.3 The lens bound, and the fan at every point
  verdict: derived
  grade: hand
  minds: 1
  model: the unit arc γ(s) = (sin s, 1 − cos s) — on the circle about (0, 1), at distance √(5 − 4 cos s) ≥ 1 from (0, −1); the segment
  prior art: partly: the derivation is the planner's (FS131-w6-kernel-plan.md § 11.4, one_le_dist, on fs131-w6), redone by the coordinator and
    checked here; a classical comparison for curves of curvature at most 1 (recalled, not read)
  handoff: de Bruijn — IsUnitCurve.one_le_dist as stated; Fan.branch_outside_discs follows on the branch's arclength parametrization

control: e8-outside
  of: FS131-E8-OUTSIDE — both distances, exactly, on all 65,534 bang-bang prefixes of curvature ±1
  run: python3 ../data/fs131/e8/e8_outside.py
  expect: 0
  fault: python3 ../data/fs131/e8/e8_outside.py --kappa 2

**`fan_of_isolated` at every `z`, without `R ≤ 1/2`: confirmed.** §§ 3.1–3.5 read `z ∈ Σ` nowhere (hypothesis (U) is about the punctured disc),
and § 3.6 reads it for "at least two" alone. For `z` off Σ under the same hypotheses: if `z` is not in the closure of the essential boundary, a
small punctured disc has no essential boundary and the fan has no branch; otherwise `z` is an interface point (§ 3.1 (0)), and §§ 3.2–3.4 give
finitely many branches (two: the halves of the curve through `z`), § 3.5 the regions. `R` enters only through `min(R, 1/2)`.

### 6.4 The erratum under FS131-E8-LOCAL, and the planner's `3.5δ`

The dated erratum is under the entry in § 3.1. Checked: the midpoint of the centres `x′ + ν′` and `x″ − ν″` is
`x′ + (x″ − x′)/2 + (ν′ − ν″)/2`, within `δ/2 + |ν′ − ν″|/2 ≤ 3.5δ` of `x′` by (3)(c); with `|x′ − y| < ρ₁/2` and `δ ≤ ρ₁/8` it is within
`0.9375ρ₁` of `y`, in `N`; two open unit discs whose centres are less than 2 apart both contain that midpoint. `3.5δ` is right. The planner's
`norm_sub_le_of_discs` then gives the sharp bound, and its item 2 is right too: the fan's existence needs only the crude constant (lengths
bounded in a smaller disc), the sharp one is read by FS131-E8-OUTSIDE's consumers.

### 6.5 The planner's read-backs (its § 11.3), entry by entry

Beyond what § 11.3 itself names as wider:
- **FS131-E8-GAMMA** — `gamma` says `InjOn γ (Icc 0 L)`, injective on the *closed* interval, which is more than the entry's "not closed": the two
  ends are different points and no end is a point of the arc. True, by the same chord bound (`⟨γ(s₂) − γ(s₁), T(s₁)⟩ ≥ sin(s₂ − s₁) > 0`).
- **FS131-E8-BETA** — `beta` exports a limit `d` of the polar angle and drops "to an angle of the component's limit tangent at z";
  `exists_polarGraph` keeps it (its limit is `ψ 0`). `Fan.branch_contacts` and `Fan.branch_outside_discs` need the dropped clause (§ 6.1 Case B:
  the tangent at `z` is `e(d)`), so their proofs go through `gamma` and `exists_polarGraph`, not through `beta` alone — as § 11.4's row for
  `branch_outside_discs` plans.
- **FS131-E8-LOCAL** — `local_graph` is the entry's clause (ii) at a wider class (two sets); the entry's clause (i) is `closure_essBdry_subset`.
  The chart's `bdry` is about `essBoundary A`; for a colouring, `c.essBdry ∩ Q` is the same set (every other class is null in `Q ⊆ N`), a line the
  colouring form owes.
- **FS131-E8-DELTA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2** — as meant; nothing to add to § 11.3.
