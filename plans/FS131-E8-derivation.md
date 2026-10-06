# FS131-E8 — the bridge under REG-J′: the frozen words, with saturation, give the fan with end tangents

*Job FS131-E8, Ephodos (Opus 5.5), launched 2026-10-06 on `main`. Brief `data/fs131/briefs/FS131-E8-regj-bridge.md`, with
`plans/STANDING-RULES.md`. Working files `data/fs131/e8/`. One mind throughout; no search was run and none was wanted.*

## Theorems this phase proved

Each [hand], one mind, kernel pending; arguments in § Stage 3.

- **FS131-E8-LOCAL** — off a closed singular set a saturated colouring's interface set is a properly embedded `C^{1,1}` curve system of curvature at
  most 1: § The local structure off Σ. (A restatement of FS121-V5-LOC and V5-OFF at the class their arguments carry: Σ closed near the point.)
- **FS131-E8-ENDS** — clauses (β) and (γ): near an isolated point `z` of Σ every component of the interface set in a disc of radius at most `1/2`
  has length at most `π/2`, ends on the disc's boundary or at `z`, and one that ends at `z` is a polar graph about `z` with a limit direction:
  § Finite length, the end tangent and the polar graph.
- **FS131-E8-FINITE** — clause (α): finitely many components meet the half disc, so a smaller disc holds only the branches that end at `z`:
  § No arc passes near z without ending there.
- **FS131-E8-REGION** — clause (δ): a connected open set that misses the essential boundary and Σ is almost everywhere of one colour:
  § Regions are of one colour.
- **FS131-E8-BRIDGE** — a saturated colouring whose singular set is locally finite has a fan with end tangents at every singular point; so
  `RegJBridge k` holds for every `k`: § The bridge.
- **FS131-E8-CLAUSE2** — under saturation the frozen words' second clause follows from the first: § The second clause is a consequence.

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

derivation: FS131-E8-BRIDGE
  statement: for every k, in a measurable k-colouring of the plane whose classes have null unit pairs, saturated, with locally finite singular set Σ,
    every point z of Σ has a radius r > 0 such that B(z, r) holds no other point of Σ, the essential boundary in B(z, r) off z is the union of
    finitely many pairwise disjoint curves, each a polar graph t ↦ z + t e(φ(t)) over 0 < t < r with φ continuous and convergent as t → 0, and
    each open region between two angularly consecutive curves is almost everywhere of one colour
  uses only: owed — the argument is not written
  not claimed: that any colouring with fewer than seven colours meets the hypotheses; that Σ is locally finite in any saturated colouring
    (C121-REGJ's first clause, open); anything at a point of Σ that is an accumulation point of Σ
  argument: § 1.5 The registered expectations
  verdict: gap: the argument is not written; § 1.5's sketch is a prediction, not a derivation
  grade: measured
  minds: 1
  model: SQ9 at a grid vertex — four branches along the axes, constant angles, four colours
  prior art: owed
  handoff: none — a conjecture at this stage
