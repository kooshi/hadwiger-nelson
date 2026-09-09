# FS-24 — Generalize the kernel: seven theorems narrower than their own proofs

*Minted 2026-09-09 by de Bruijn on Kooshi's direction — **"let's not focus on pushing to 6 right now, I want to
secure our current position. Explain the unexplained with proofs, generalize our specific proofs, general
bookkeeping."*** *The survey behind this stub read all twenty-two theory modules plus twelve more; every item
below rests on the **proof body**, not on the statement, and the two highest-value ones were spot-checked by
hand before this file was written.*

---

## 0. Why this exists — for a reader with no memory of the project

This repository proves things about the **Hadwiger–Nelson problem**: how many colours are needed to paint the
plane so that no two points exactly one unit apart share a colour. Over sixty milestones it has built a theory
of that question **over number fields** — `ℚ(√3,√11)` rather than `ℝ` — and a machine-checked library of about
725 declarations.

A library written milestone by milestone accumulates a characteristic debt: **each theorem is stated at the
instance that needed it.** The proof is general; the statement is not. That is invisible while you keep working
in the same instance, and it becomes expensive the moment a new milestone needs the same argument one field
over — which is exactly what happened on 2026-09-09, when the open item of
`plans/STUB-four-colour-valuation-law.md` turned out to need a homogeneity theorem this repository has, in a
form it does not have.

**This milestone pays that debt.** Nothing here is new mathematics. Everything here is a statement moved to the
level its proof already occupies.

## 1. The headline finding, which is good news

**The library is already unusually well generalized.** `ResidueColouring`, `Absorb`, `Arity`, `CriticalSet`,
`DistanceGraph`, `Additive`, `AdditiveRigid`, `Limit`, `SpareColour` and `Fractional` were examined and have
**nothing to relax** — they are stated at the right level. The debt is concentrated in seven places, and two of
them are on a critical path.

Also worth stating plainly: **no unused `Fintype`/`DecidableEq` binders were found.** `Mascot.lean` uses `omit`
correctly, `Fan.lean` documents choosing `List` over `Finset` precisely to avoid a `DecidableEq`, and
finiteness appears only where a degree is counted. That is a clean bill on the cheapest failure mode.

## 2. The work, ranked

### G1 — `transport_pair` is stated over `ℂ`; its proof needs only "an isometry exists"

`Homogeneous.lean:80`, with consumers at `:54, :90, :100, :108, :118`.

**Verified by hand 2026-09-09.** The entire body is four lines, and the only appeal to `ℂ` is the sub-lemma
`exists_isometry_map_pair`, which *constructs* the map `z ↦ az + b`. The transport itself goes through
`Isometry.distanceGraphHom`, which is already `[MetricSpace V]`-generic (`DistanceGraph.lean:92`). The colour
type is already arbitrary — half of this generalization was done and the geometry half was not.

```lean
theorem transport_pair_of_isometry {V : Type*} [MetricSpace V] {α : Type*} {D : Set ℝ}
    {R : α → α → Prop} {x₀ y₀ x y : V}
    (hg : ∃ g : V → V, Isometry g ∧ g x₀ = x ∧ g y₀ = y)
    (h : ∀ C : (distanceGraph V D).Coloring α, R (C x₀) (C y₀))
    (C : (distanceGraph V D).Coloring α) : R (C x) (C y)
```

with `transport_pair := transport_pair_of_isometry (exists_isometry_map_pair hd)` and
`exists_isometry_map_pair` kept as the `ℂ`-witness.

**Why this is first, and it is the sharpest observation in the survey.** The retracted duality's replacement
(`plans/STUB-four-colour-valuation-law.md`) needs to *"transport by a norm-one element of `K(i)`"*. **Over `K²`
the isometry group is not transitive on equidistant pairs**, so the `ℂ`-shaped theorem is not merely
inconvenient there — it is unusable, and a `K`-caller cannot state its hypothesis. The
hypothesis-taking form is exactly what such a caller *can* discharge, for the pairs a `K`-rotation reaches.
The same split serves `EuclideanSpace ℝ (Fin n)` and the finite planes, where `addCayleyTranslate`
(`ResidueObstruction.lean:70`) is the isometry.

**Cost:** under an hour. **Confidence: high.** **Blocking**: the `√3`-carrier-over-`K` work waits on it.

### G2 — the 2-adic law lives at one field, one prime, four colours

`ValuationLaw.lean` §1–§3: `:104, :139, :147, :163, :180, :228, :235, :243, :249, :262, :274`.

Every one is pinned to `seamPlane`, `oddDenom`, `psiA : oddDenom →+* F4` and the literal `4`. The mathematics
is: a conjugation-stable subring `A` of a field `L` containing every unit vector, and a ring hom into a finite
nontrivial ring with no zero divisors.

**The evidence is that the proof already calls the general theorem.** `sub_mem_oddDenom_of_dist` uses six
facts, and at `:126–127` it invokes `ResidueColouring.map_ne_zero_of_mem_normOne` — the general lemma — by
name. The specialization is in the statement, not the argument. The `normSq` half is the same one level up:
`psiA_conj` says `ψ (σ z) = ψ z * ψ z`, whose general form is `ψ ∘ σ = F ∘ ψ` for a ring endomorphism `F` with
trivial kernel, and the cube-cancellation becomes "in a domain, `x · F x = 0` with `F` injective gives `x = 0`".

The general statement belongs in `ResidueColouring.lean` beside `colorable_of_normOne`, with
`normOne_subset_valuationSubring` (`:300`) discharging the unit-vector hypothesis outright for a
conjugation-stable valuation subring.

**What it buys.** Today the law exists at one prime of one field at one colour count. Generalized it is the
compulsion-level statement **at every prime the field sieve names** — which is the vocabulary M58–M61 already
speak and the current statement cannot be spoken in.

**Cost:** a real but mechanical re-proof, about a day, most of it re-instantiating the seven-row table in §4.
`FieldWall4.lean` should get *smaller*, the way it did when Theorem A absorbed it — that is the honest test.

### G3 — the spindle-kills-its-prime theorems are at `ZMod p`; the proof needs a field where `−1` is not a square

`LocalGlobal.lean:218, :230, :247, :265, :275`.

**Verified by hand 2026-09-09, and this is the cleanest evidence in the survey: the general lemma is already
written, and the very next declaration narrows it.** `isSquare_neg_one_of_spindle_radicand` (`:238`) is stated
over `{R K : Type*} [CommRing R] [Field K]` with no congruence anywhere; `no_ringHom_of_spindle_radicand`
(`:247`) is a three-line wrapper whose only use of `p % 4 = 3` is to supply `¬ IsSquare (-1 : ZMod p)`.

**Why it matters.** `unitQuadrance` is already ring-generic (`UnitQuadrance.lean:51`), so the plane over
`GaloisField 3 3` exists in the kernel today — and **no theorem in `LocalGlobal.lean` can say anything about
it**, because they are all `ZMod`-shaped. The odd-degree face of the sieve (M61's measurement that
`UD(𝔽₂₇,2)` refuses four colours, i.e. Haugland's field) is currently unstateable, and `[Krebs2022]` gives the
clique number of `UD(𝔽_q,2)` in closed form for **every** prime power.

**Cost:** an hour or two. **Confidence: high.**

### G4 — the `χ ≥ 6` target is pinned at five colours where its own lemma is `k`-generic

`Instances/HexShell.lean:259, :271`.

The consumed lemma `hexShell_plane` (`:162`) is already `{k : ℕ} (hk : k < 7)`; the numeral `5` never appears
in the four-line proof body. Relaxing gives the `k`-generic form in minutes — and **the `k = 6` instance is a
statement nobody in this repository can currently write**: two six-colour gadgets at `√3` and `2` give
`χ(ℝ²) ≥ 7`, the affirmative side of M61's local–global conjecture in its bold form.

**A second, larger relaxation in the same place, priced separately.** Both theorems quantify over colourings of
`unitDistance ℂ`, but the proof needs only properness at the listed distances — i.e. `distanceGraph ℂ D` for
any `D ∋ 1`. Over `distanceGraph ℂ {1,2}` the three diameters are edges, so one hypothesis is discharged by
`C.valid`, and **a `√3` virtual edge at five colours alone gives `χ(ℝ²; {1,2}) ≥ 6`** — exactly the μ-dial
target of M49/M50, which today has no kernel statement connecting it to the hex shell. Machinery present
(`add_one_le_chromaticNumber_distanceGraph_edgeList`, `Separated.planeIn`); half a day; **confidence
medium-high** — whether `hexShell.valid_sound` composes without friction at a non-singleton `D` is not checked,
though `seven_le_chromaticNumber_hexShell_distances` (`:222`) already does the analogous thing.

### G5 — `Coset.lean` proves one theorem five times

`:932/:951, :996/:1014, :1061/:1080, :1240/:1270, :1299/:1327`.

Ten theorems that are five copies of one argument: *`N` addresses whose pairwise norms are all realizable as
unit pairs at scale `p` ⟹ `N` labels*. The five wrappers are byte-for-byte identical modulo the shell name and
`N`. One predicate (`Constrained p rnd d`) plus two lemmas replaces them; adding a band drops from ~40 lines to
~10, and the census has more bands.

**Bearing on χ ≥ 6: none** — the Frontier has struck this family as a source of novelty. **Value:** ~200 lines
becoming ~60, and it is precisely "generalize our specific proofs". Half a day.

### G6 — the 2-adic independence engine is hard-coded at `√5`, and the record says so

`Quadrature.lean:238`, with `:56, :75, :155`, and the consumer `quadrature_rho15` at `:372`.

This is the one item the project itself has flagged: ledger row 28 says *"the √7 analogue is a numeral
change"*, and G12 says *"the ρ₆₃ instance remains measured-only, a numeral change away"*. Landing it closes a
named open item — the quadrature law at `√7`. **Cost:** a real re-proof. **Confidence: medium** — the `√7`
`linear_combination` witnesses were not verified to fall out identically; the module claims they do, and this
project's own discipline says derive the witnesses in sympy first.

### G7 — three small ones, minutes each

* **`Glue.eq_gluePoint_of_unit_pair`** (`PartnerLattice.lean:29`) is at radii `(1,1)`; `Glue.sphere_inter_sphere`
  (`Glue.lean:247`) is already radii-generic and the two triangle-inequality lines give the annulus bounds for
  arbitrary `r₁, r₂`. Generalizing extends `CriticalSet.eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces`
  from unit-edge drawings to `distanceGraph` drawings — which is what M49's `{1,d}` objects are.
* **`Brick.colorable` + `Brick.avoids`** (`:467, :479`) together *are* a colouring of `distanceGraph ℂ {√q}`,
  which `DistanceGraph.lean` (M49) can state and `Brick` (M35) predates. The Frontier's "certified 9-colouring
  avoiding `√(3/2)`" becomes one theorem: `χ(ℝ²; {1, √(3/2)}) ≤ 9`, which a future `k ≤ 6` avoider instantiates
  same-day — which is what ledger row 32 says the module exists for.
* **`Forces.of_equiv` / `Separated.of_equiv`.** `Forces`, `Separated`, `Fan`, `Realizes` and `Extends` all
  quantify over `Fin k` — the right choice, and `Forcer.lean`'s docstring argues for it — but the boundary cost
  is now paid by hand twice (`Additive.lean:56` builds `Fintype.equivFinOfCardEq`; `ValuationLaw.lean:200`
  mints `F4.equivFin` with a comment explaining why). Two helper lemmas remove the boilerplate, and they are a
  prerequisite for a clean G2.

## 2b. Considered and DECLINED, with the reason — so nobody re-opens these

Recorded because a survey's negatives are as useful as its positives, and each of these looks generalizable
until you check.

* **`Pigeonhole.lean`'s bridge at `edgeGraph n E` / `Fin n`** (`mono_pair_of_not_colorable_append` `:82`,
  `mono_pair_of_clique` `:112`). `mono_pair_of_clique` is pure counting over an arbitrary graph and an arbitrary
  augmentation, so it *looks* like a free generalization — but the `Fin n` + `List` shape **is** the interface
  the LRAT certificate chain consumes. Generalizing it would put a translation layer between the kernel and
  every certificate. **Declined.**
* **`Mascot.no_four_unit_points` over `ℂ`** (`:166`). The Gram-determinant argument is 2-dimensional; the
  natural general form is *no `d+2` points of `ℝ^d` are pairwise unit-distant*, which would make
  `not_forces_of_unit_drawing` (`:229`) dimension-generic. That is a genuine re-proof needing affine-independence
  machinery, and **nothing in the mission wants higher dimensions**. Low.
* **`UDCert` hard-wired to the four-radical tower `Q4`** (`Certificate.lean:71`, and every `{S : Subring Q4}` in
  `UnitQuadrance`, `Lift`, `ResidueObstruction`). Generalizing the coefficient ring is a redesign of the
  certificate layer and of every module under `Instances/`; and the case that would motivate it — Haugland's
  heptagonal witness — needs cubic-field machinery this repository does not have. **Declined outright**, not
  merely deferred.
* **`Coset.lean` to a general planar lattice.** The whole file runs on `hexQ = a² + ab + b²`. The Frontier
  already prices this: the crude Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice, and closing
  `k = 6` needs a near-equality rigidity argument from reduction theory — **mathematics we do not have.** Lowest.

## 3. Consolidation — the same thing proved twice

Not over-specific statements; duplicates. **Read the build caveat in §4 before touching any of these.**

* **`Copy.rotAbout` subsumes three earlier rotation families.** `ClassGeometry.rot3` (`:205`),
  `Compulsion.seamImage` (`:80`) and `Compulsion.hexStep` (`:184`) are all `c + ρ·(z − c)`, and their distance
  lemmas are the same two-step proof (`Complex.dist_eq` → `norm_mul` → `‖ρ‖ = 1`) written four times —
  `Homogeneous.exists_isometry_map_pair` (`:70`) proves `Isometry` by hand for the fourth. The shared primitive
  is one line: `Isometry (fun z => a * z + b)` whenever `‖a‖ = 1`.
* **Two quadratic-extension constructions.** `Adjoin d K` (`Field/Quadratic.lean:47`) **is** `Quad 0 d K`
  (`FieldWall4.lean:218`), and both have a universal-property lift with the same obligation shape. **Do not
  merge the data types** — `Adjoin`'s `NatScalar`/`FastSq` machinery is a measured 23.1 s → 13.8 s kernel win
  and the certificate modules depend on it — but state the universal property once and make `Adjoin.lift` a
  corollary.
* **Two `omega3`s.** `ClassGeometry.omega3` (`:199`) and `FieldWall4.omega3` (`:449`) are the same complex
  number in two namespaces, each with its own algebra.
* **Fourteen copies of `Real.sqrt 3 * Real.sqrt 3 = 3`**, plus `√5`, `√11`, `√33`, `√15` copies alongside —
  `FieldWall`, `Coupled`, `Glue`, `Quadrature`, `Triangle`, `Coset`, `Hexagram`, `MetaLadder`, `ClassGeometry`,
  `TwoCircle`, `Compulsion`, `Ladder`, `FieldWall4`, `Mascot`. **The build rule explains this and also solves
  it**, and the observation is worth more than the duplication: a *declaration* added to an existing upstream
  module rebuilds every dependent, which is why each file minted its own private copy — but a **new leaf
  module** (`Field/Radicals.lean`), imported by all and never edited afterwards, costs **one** rebuild and
  nothing thereafter.

## 4. Method, cost, and the one real risk

**The risk is the build, not the mathematics.** `CLAUDE.md` records that changing a *declaration or a
docstring* in an upstream module invalidates every dependent, that certificate modules peak at 3.4 GB + 0.81 GB
per chunk, and that an unrestricted `lake build` has taken the desktop down twice. So:

* **Order the work leaf-first**, and put every new shared lemma in a **new** module rather than an existing
  upstream one. §3's fourteen-copy item is the model.
* **`--` line comments are free downstream** (they leave the `.olean` byte-identical); docstrings are not.
* **Always `./scripts/build.sh`, never `lake build`, bare or named.** Then `./scripts/axioms.sh`.
* Do G1, G3 and G7 first: they are leaf-adjacent, hours not days, and G1 unblocks stubbed work.

**Acceptance.** Every generalized theorem keeps its old form as a one-line corollary, so no caller changes and
no ledger row's cited name disappears; the axiom audit stays at exactly the standard three plus the five
declared purchases; `FieldWall4.lean` is no larger after G2 than before.

**Cost:** G1+G3+G7 in a day; G2 a day; G4 half a day plus half a day for its second half; G5 half a day; G6 a
day. Call it a week for the lot, and it splits cleanly — none of these depend on each other except G7's
`of_equiv` helpers before G2.

**Bearing on χ(ℝ²) ≥ 6: indirect, and the stub says so plainly.** G1 unblocks a stubbed proof; G3 makes the
odd-degree half of the field sieve expressible; G4 makes the `k = 6` and μ-dial targets *statable*, which they
currently are not. The rest is debt service. **M62 (FS-6) remains the ranked rank-1 milestone for the hunt.**
