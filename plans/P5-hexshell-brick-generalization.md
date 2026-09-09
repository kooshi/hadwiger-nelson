# P5 — FS-24 items G4 and G7b: statements moved to the level their proofs occupy

*Subplan, 2026-09-09, de Bruijn (package P5 of the six-way consolidation batch). Parent stub:
`plans/STUB-generalize-the-kernel.md` §G4 (lines 113–130) and §G7 second bullet (lines 161–164).
Shared context: `/home/kooshi/source/CONSOLIDATION-BRIEFING.md`.*

---

## 0. What this is, for a reader with no memory of the project

This repository asks how many colours are needed to paint the plane so that no two points exactly
one unit apart get the same colour — the **Hadwiger–Nelson problem**. The answer is 5, 6, or 7.
Everything here is checked by Lean's kernel.

Three theorems in this repository are **written more narrowly than the arguments that prove them**.
Nothing below is new mathematics. Each item takes a statement that mentions a specific number, and
replaces the number by a variable that the proof never looked at — keeping the original statement as
a one-line consequence, so nothing that cites it by name breaks.

The payoff is that three sentences which **currently cannot be typed in this repository at all**
become typeable.

## 1. The three items

### G4a — the six-colour target is pinned at five colours

`Instances/HexShell.lean:259` and `:271` are the repository's statement of what the hunt needs:
*if some finite gadget forces every pair at distance `√3` apart to differ in every proper
5-colouring of the plane, **and** some gadget does the same at distance `2`, then the plane needs
at least 6 colours.* Both are hard-wired to five colours.

The lemma they consume (`hexShell_plane`, `:162`) is **already** stated for every colour count below
seven, and the numeral `5` appears nowhere in its four-line proof. So the five is decoration.

**What it buys:** the `k = 6` instance — *two six-colour gadgets at `√3` and `2` give
`χ(ℝ²) ≥ 7`* — which is the affirmative side of the project's own local–global conjecture in its
bold form (`CLAUDE.md` § Grokkings G48), and which today cannot be written down.

**The caution, carried forward verbatim from the task brief.** `:271` is a **conjunction**: it needs
a gadget at `√3` **and** one at `2`, never one at either. An earlier era of the record misread that
as a disjunction, and the module now carries two explicit 5-colourings of the seven-point carrier —
one separating every `√3`-pair, one separating every diameter — as the proof that neither half
suffices alone. **That structure is preserved exactly, and the two witnesses are duplicated at
`k = 6`** so the new instance is as honest as the old one.

### G4b — the theorems are about the unit-distance graph; the proof needs less

Both theorems quantify over colourings of `unitDistance ℂ` — the graph joining points exactly one
unit apart. The proof uses **only** that the colouring separates points at distance `1`. So the
right hypothesis is a colouring of `distanceGraph ℂ D` for any set of forbidden distances `D`
containing `1` — the graph that joins two distinct points whenever their distance is in `D`
(`DistanceGraph.lean:51`, M49).

**Why that is the valuable half.** Over `distanceGraph ℂ {1, 2}` the three diameters of the shell
are *already edges*, so the distance-`2` hypothesis is discharged by the colouring's own validity —
and then **a `√3` gadget alone gives `χ(ℝ²; {1,2}) ≥ 6`**. That is the exact target of the
measurement programme of milestones M49 and M50 (the *μ-dial*), which today has no kernel statement
connecting it to the hexagonal shell at all. The mirror statement holds over `distanceGraph ℂ
{1, √3}`.

### G7b — one theorem where the record currently has two facts

`Brick.colorable` and `Brick.avoids` (`Brick.lean:467, :479`) say, separately, that a passing
periodic-tiling certificate (i) properly colours the plane and (ii) never repeats a colour at any
guarded distance. **Together they are a colouring of `distanceGraph ℂ D`** — a notion the module
predates by a milestone.

The record's *"a certified 9-colouring avoiding `√(3/2)`"* (`CLAUDE.md` ledger row 32) becomes one
theorem: **the plane with both distance `1` and distance `√(3/2)` forbidden needs at most nine
colours.** Ledger row 32 says in as many words that the module exists so a future avoider can be
instantiated the day it is found; a two-distance chromatic bound is the form such a find is quoted
in.

## 2. §PA — the prior-art gate (WORKFLOW step 3a), run 2026-09-09 before any derivation

Searched in the disciplines' vocabulary, not this project's: *"chromatic number of the plane with
two forbidden distances"*, *"distance graphs on the plane"*, *"forbidden distance set"*,
*"periodic colouring upper bound"*, *"triangular lattice shell clique {1,√3,2}"*. Two disciplines:
combinatorial geometry / Euclidean Ramsey theory, and graph colouring of Cayley/distance graphs.
Searched for the **question** (is there a catalogue of `χ(ℝ²; {1,d})` upper bounds?) as well as the
method. Looked outside arXiv (Springer, ScienceDirect, ResearchGate, the Polymath wiki).

**Result: a negative on everything this package claims, plus one bibliography addition.**

* **`χ(ℝ²; {1,d})` is a studied quantity and the literature is lower-bound-heavy.** The reference
  paper is **G. Exoo, D. Ismailescu, *The Hadwiger–Nelson problem with two forbidden distances*,
  arXiv:1805.06055 (2018)** — *"We find several values of `d`, for which the answer … is at least
  5"* — **lower bounds only**, no periodic upper-bound construction, no mention of the triangular
  lattice shell or the set `{1,√3,2}`. **This paper is NOT in `BIBLIOGRAPHY.md`** (checked: the
  three Exoo–Ismailescu entries there are arXiv:1805.00157, arXiv:1909.13177 and the 2020
  Geombinatorics note). It is the right citation for the two-distance landscape and goes in the
  handoff for P1.
* Naslund, *The chromatic number of `ℝⁿ` with multiple forbidden distances*, arXiv:2205.12312 —
  lower bounds by the partition-rank method; no colourings, no upper bounds.
* `[DeNeve2025]` (Amer. Math. Monthly 132(10), already in `BIBLIOGRAPHY.md` line 67) is the other
  two-distance entry, again lower bounds (`{1,3}` in 33 vertices, `{1, 2+√6}` in 117).
* Nothing found states `χ(ℝ²; {1,√3,2}) ≥ 7` or the seven-point shell clique; the module already
  attributes that as presumably folklore and this package does not change the attribution.
* **No upper bound of the form `χ(ℝ²; {1,d}) ≤ k` was found stated as a theorem anywhere.** That is
  a genuine negative and it is recorded as one — but the honest reading is that such a bound from an
  explicit 3×3 tiling is *easy*, not *unknown*, and no novelty is claimed for it. Its value is that
  this repository can now state one, kernel-checked, in the form a find would be quoted in.

**What the gate did not change:** nothing. No result below was rescoped by it. Recorded as required.

## 3. The design decisions

### D1 — the shape of the relaxed hypothesis (G4b). **Chosen: one master over an arbitrary `D`.**

*Alternative weighed:* hard-code the two cases `{1,2}` and `{1,√3}`, since those are the ones the
μ-dial wants. *Why the master won:* it is the level the four-line proof actually occupies, it costs
no extra work, and — the deciding evidence — **it contains the module's own existing
`seven_le_chromaticNumber_hexShell_distances` (`:222`) as the case `D = {1,√3,2}`, where both
hypotheses are free.** A generalization that re-derives a theorem the file already proves by a
different route is a generalization that found the right level. That cross-check ships as an
`example`. *Confidence: high.*

### D2 — where the small helper lemma lives. **Chosen: local to `HexShell.lean`, stated generally.**

The relaxation needs one four-line fact: *a proper colouring of `distanceGraph V D` gives different
colours to any two points at a distance in `D`, provided that distance is not zero.* Its natural
home is `DistanceGraph.lean`.

*Alternative weighed:* put it there. *Why local won:* `DistanceGraph.lean` is imported by
`Homogeneous.lean`, which package P3 owns and is editing in this same batch, and by `Copy.lean` and
`Mascot.lean`; a declaration added upstream rebuilds every dependent forever after
(briefing §4 rule 4) and a structural edit to a file another live package builds on is a collision
that costs more than it saves. It is stated at full generality (`[MetricSpace V]`, arbitrary colour
type) with a `--` comment naming its proper home, so moving it later is a cut-and-paste.
*Confidence: high — and it is a deliberate debt, recorded in the handoff.*

### D3 — G7b: a new module, not an edit to `Brick.lean`. **Chosen: new leaf `BrickDistance.lean`.**

*Alternative weighed:* add the theorem to `Brick.lean`, which needs a new import of
`DistanceGraph`. *Why the new module won:* either change rewrites `Brick.lean`'s compiled artifact
and rebuilds `Instances/Seven.lean`, `Instances/Nine.lean` and `Instances/Interval.lean` — the last
being the module that carries `5 ≤ χ(ℝ²) ≤ 7`. A new leaf that imports both and is imported only by
`Instances/Nine.lean` rebuilds one file. It is also the right home: the bridge is a general fact
about `Brick`, and the nine-colour instance is an instance. *Confidence: high.*

### D4 — the `k = 6` independence witnesses. **Chosen: duplicate both, at `Fin 6`.**

*Alternative weighed:* rely on the `Fin 5` pair, since a 5-colouring is a 6-colouring after
relabelling. *Why duplicating won:* the record's whole point about `:271` is that the conjunction is
irreducible **from both sides**, and it proves that with adversaries rather than with prose. A new
instance of the theorem with no adversary at that instance silently degrades exactly the property
the module was corrected to carry. Two three-line `example`s. *Confidence: high.*

### D5 — vacuity (briefing §8). **Finding, not a decision, and it is recorded in the module.**

The master `hexShell_planeIn` takes a *structure* as its hypothesis — a colouring — so the §8 rule
bites. Three cases, and they are not the same:

* At `D = {1}` (the unit-distance plane) and `k ∈ {5, 6}`, whether a colouring exists **is the open
  problem itself**; `plane_colorable_seven` (`Instances/Seven.lean`) supplies one at `k = 7`, which
  is the named inhabitant the rule asks for, quoted as a `--` note rather than an import.
* At the finite level the pigeonhole is non-vacuous outright: the module's existing `example` at
  `:141` exhibits a proper 3-colouring of the seven-point carrier.
* **At `D ⊇ {1, √3, 2}` and `k = 6` the master is provably vacuous** — that is exactly
  `hexShellAug_not_colorable_six` (`:214`). This is not a defect: it is
  `seven_le_chromaticNumber_hexShell_distances` seen from the other side, and a `--` comment says
  so at the declaration. Reported in the handoff for FS-26's ledger.

## 4. The skeleton

Every signature below elaborates with `sorry` at each leaf before any proof effort is spent
(WORKFLOW step 3). `<OLD>` marks a name the record cites, kept at its old statement.

### `Proofs/HadwigerNelson/Instances/HexShell.lean`

```lean
theorem coloring_ne_of_dist_mem {V α : Type*} [MetricSpace V] {D : Set ℝ}
    (C : (distanceGraph V D).Coloring α) {d : ℝ} (hd : d ∈ D) (hd0 : d ≠ 0)
    {x y : V} (hxy : dist x y = d) : C x ≠ C y

theorem hexShell_planeIn {k : ℕ} (hk : k < 7) {D : Set ℝ} (h1 : (1 : ℝ) ∈ D)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y

theorem hexShell_plane {k : ℕ} (hk : k < 7) (C : (unitDistance ℂ).Coloring (Fin k)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y            -- <OLD>

theorem not_colorable_distanceGraph_of_forced_pairs {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D)
    (h3 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ),
            dist x y = 2 → C x ≠ C y) :
    ¬ (distanceGraph ℂ D).Colorable k

theorem add_one_le_chromaticNumber_distanceGraph_of_forced_pairs
    {k : ℕ} (hk : k < 7) {D : Set ℝ} (h1 : (1 : ℝ) ∈ D) (h3 …) (h2 …) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ D).chromaticNumber

-- one class free because it is already an edge
theorem not_colorable_distanceGraph_of_forced_sqrt3 {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) (h2mem : (2 : ℝ) ∈ D) (h3 …) :
    ¬ (distanceGraph ℂ D).Colorable k

theorem not_colorable_distanceGraph_of_forced_two {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) (h3mem : Real.sqrt 3 ∈ D) (h2 …) :
    ¬ (distanceGraph ℂ D).Colorable k

-- the μ-dial headlines, at the two shapes M49/M50 measure
theorem add_one_le_chromaticNumber_oneTwo_of_forced_sqrt3 {k : ℕ} (hk : k < 7) (h3 …) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ {1, 2}).chromaticNumber

theorem add_one_le_chromaticNumber_oneSqrt3_of_forced_two {k : ℕ} (hk : k < 7) (h2 …) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ {1, Real.sqrt 3}).chromaticNumber

-- unit-distance, colour-generic
theorem not_colorable_of_forced_pairs {k : ℕ} (hk : k < 7) (h3 …) (h2 …) :
    ¬ (unitDistance ℂ).Colorable k

theorem add_one_le_chromaticNumber_plane_of_forced_pairs {k : ℕ} (hk : k < 7) (h3 …) (h2 …) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber

theorem not_colorable_five_of_forced_pairs (h3 …) (h2 …) :
    ¬ (unitDistance ℂ).Colorable 5                                            -- <OLD>
theorem six_le_chromaticNumber_plane_of_forced_pairs (h3 …) (h2 …) :
    6 ≤ (unitDistance ℂ).chromaticNumber                                      -- <OLD>

theorem not_colorable_six_of_forced_pairs (h3 …) (h2 …) :
    ¬ (unitDistance ℂ).Colorable 6                                            -- NEW
theorem seven_le_chromaticNumber_plane_of_forced_pairs (h3 …) (h2 …) :
    7 ≤ (unitDistance ℂ).chromaticNumber                                      -- NEW
```

plus the two `Fin 6` independence `example`s and the `example` cross-checking that the master
reproduces `seven_le_chromaticNumber_hexShell_distances`.

### `Proofs/HadwigerNelson/BrickDistance.lean` (new leaf)

```lean
namespace HadwigerNelson
namespace Brick
variable {k : ℕ} (B : Brick k)

theorem colorable_distanceGraph {guards : List ℚ} {D : Set ℝ}
    (hchk : B.check guards = true)
    (hD : ∀ r ∈ D, ∃ q ∈ guards, r = Real.sqrt (q : ℝ)) :
    (distanceGraph ℂ D).Colorable k

theorem chromaticNumber_distanceGraph_le {guards : List ℚ} {D : Set ℝ}
    (hchk : B.check guards = true) (hD : …) :
    (distanceGraph ℂ D).chromaticNumber ≤ k

theorem colorable_two_distance {guards : List ℚ} {q : ℚ}
    (h1 : (1 : ℚ) ∈ guards) (hq : q ∈ guards) (hchk : B.check guards = true) :
    (distanceGraph ℂ {1, Real.sqrt (q : ℝ)}).Colorable k
```

### `Proofs/HadwigerNelson/Instances/Nine.lean`

```lean
theorem chromaticNumber_oneSqrtThreeHalves_le_nine :
    (distanceGraph ℂ {1, Real.sqrt ((3/2 : ℚ) : ℝ)}).chromaticNumber ≤ 9      -- NEW
```
`nine_avoids_sqrt_three_halves` and `plane_colorable_nine` keep their statements unchanged.

## 5. The gate, and what would make me stop

`flock … ./scripts/build.sh` prints `build: OK`; zero `sorry` in `Proofs/`; `./scripts/axioms.sh`
reports 725+ clean and **exactly 5 declared purchases** — if that 5 moves, stop and report; every
`<OLD>` name resolves with its old statement (checked by `#check` pins, compiled every build).

**The one real risk, named in the parent stub and tested first, not last:** whether
`hexShell.valid_sound` composes without friction at a non-singleton `D`. If it does not, the shape
of the friction is the finding and is reported as such rather than worked around.

---

## 6. Domain-modeling pass (WORKFLOW step 5, first pass) — two findings that change the claims

### F1 — the relaxation of `hexShell_plane` is a **repackaging, not a strengthening**, and the record must say so

The pass asked whether `hexShell_planeIn` (over `distanceGraph ℂ D`) is stronger than `hexShell_plane`
(over `unitDistance ℂ`). **It is not — they are interderivable, each in one line.** Downward is the
obvious direction (a unit-distance colouring is a `{1}`-colouring). Upward is the one that matters and
it also holds: given a colouring `C` of `distanceGraph ℂ D` with `1 ∈ D`, the *same function* is a
proper colouring of `unitDistance ℂ`, because a unit pair is a pair of distinct points at a distance
in `D`. So `hexShell_plane` already implies `hexShell_planeIn`.

**So G4b at the level of the pigeonhole buys usability, not mathematics, and this subplan will not
claim otherwise.** The master is still stated over `D` — deriving the special case downward is cleaner
than converting sideways at every call site — but the honest word is "restated", not "generalized".

### F2 — the mathematics moves one level up, at the conditional refutation, and there it moves in both directions

`not_colorable_five_of_forced_pairs` concludes `¬ (unitDistance ℂ).Colorable 5` from hypotheses about
*every proper 5-colouring of the unit-distance plane*. Its `D`-form concludes
`¬ (distanceGraph ℂ D).Colorable k` from hypotheses about every proper `k`-colouring of **that** graph.
Both halves move, and they move the same way:

* **the hypothesis weakens** — every `{1,2}`-colouring is a unit-distance colouring but not conversely,
  so "all of the smaller set separate `√3`-pairs" is a strictly easier thing to establish;
* **the conclusion weakens** — a bound on a two-distance graph is weaker than the same bound on the
  plane (`chromaticNumber_unitDistance_le_distanceGraph`, `DistanceGraph.lean:82`).

Neither statement implies the other. **That is the whole point**, and it is why this is worth doing:
the objects the μ-dial programme actually holds are `{1,2}`-graphs (Exoo–Ismailescu's 214-point seed is
one), so the weaker hypothesis is the one a real gadget could discharge, and the weaker conclusion —
`χ(ℝ²; {1,2}) ≥ 6` — is a quantity the literature already tracks (§PA).

### F3 — there is exactly ONE conditional theorem, and the helper is what makes that true

The pass looked for a cleaner factoring and found one. In each of the wanted statements the requirement
per distance is *either* "it lies in `D`, so the colouring's own validity separates it" *or* "some
gadget separates it". But the first **implies** the second, through
`coloring_ne_of_dist_mem`. So the disjunction collapses: there is a single theorem with two separation
hypotheses, and the `{1,2}` and `{1,√3}` headline forms are **instances obtained by discharging one
hypothesis from a membership** — not copies of an argument.

That reclassifies D2's helper: `coloring_ne_of_dist_mem` is not a convenience, it is **the discharge
map**, and it is why the count of conditional theorems is one rather than three.

### F4 — three shapes considered and declined, with the reason

* **A bare function `f : ℂ → Fin k` with a hand-rolled hypothesis `∀ x y, dist x y = 1 → f x ≠ f y`.**
  This is the weakest possible hypothesis and it is the level the four-line proof literally occupies.
  **Declined:** it is the same theorem in a *third* costume — `Coloring.mk` converts in one line — and
  the repository already has two names for that concept (`Coloring` and `Separated`). Minting an
  anonymous third spelling is drifting vocabulary, which the ugliness catalog lists as a smell in its
  own right.
* **Making the shell `V`-generic over a metric space.** **Declined:** the seven points are a *drawing*,
  and the drawing is `ℂ`-valued by construction (`hexShell.point`); a `V`-generic form would have to
  take the drawing as a parameter, which is what
  `add_one_le_chromaticNumber_distanceGraph_edgeList` already is. The helper `coloring_ne_of_dist_mem`
  IS stated `V`-generically, because there the generality is free.
* **A `Brick.guardedDists` definition naming the square-roots of a guard list.** **Declined:** the
  membership hypothesis `∀ r ∈ D, ∃ q ∈ guards, r = √q` is weaker, needs no new name, and asks the
  caller for exactly the same work. A definition whose only job is to be unfolded is not subtraction.

### F5 — a seam that came out right on its own, recorded as evidence rather than as luck

`distanceGraph` needs `0 ∉ D` wherever a listed distance must give *distinct* points. In the G7b
bridge that side condition is **never assumed and never needed**: a distance in `D` is `√q` for a
guard `q`, and `Brick.check_pos` proves every certified guard positive, so `0 ∈ D` is impossible. A
side condition that the certificate discharges rather than the caller is the sign that the hypothesis
was cut in the right place.

---

## 7. Obligation-modeling pass (WORKFLOW step 5, second pass) — the decomposition, probed rather than predicted

Every shape below was compiled before being written down here
(`/tmp/…/scratchpad/Probe{1,2,3}.lean`, three files, all green). The pass asked two questions.

### Q1 — how does each of the twelve declarations become a one- or two-line consequence?

**Answer: the unit-distance case is a literal instance of the distance-graph case, through the bridge
the `DistanceGraph` module was built to provide.** `unitDistance_eq_distanceGraph_singleton`
(`DistanceGraph.lean:64`) is an equality of graphs whose own docstring says it exists "to make every
`unitDistance` theorem a `D = {1}` instance", and nobody had used it that way. Two idioms, and which
one applies is decided by whether the goal mentions the graph:

* **the goal mentions the graph** (`¬ (unitDistance ℂ).Colorable k`) → `rw [unitDistance_eq_
  distanceGraph_singleton] at h3 h2 ⊢`, then apply. **Two lines, no argument repeated.**
* **the goal mentions only the colouring** (`∃ x y, … ∧ C x = C y`) → the rewrite does not reach the
  goal, so transport the colouring inline with one `Coloring.mk`. Probed: the conclusion is
  definitionally the same because the underlying function is literally the same. **Three lines.**

The two one-hypothesis-free corollaries are then `master … (fun C _ _ h => coloring_ne_of_dist_mem C
hm _ h)` — **one line each**, which is F3 of the domain pass cashed out.

### Q2 — where does the `ℕ∞` numeral arithmetic belong so it happens once?

**Answer: nowhere new. It already has a home and the home is documented.**
`add_one_le_chromaticNumber_iff_not_colorable` (`UnitDistance.lean:69`) is exactly this, and its
docstring reads *"Derived once here so that the `ℕ∞` arithmetic does not recur at every call site"*.
Every chromatic-number form in this package is `add_one_le_chromaticNumber_iff_not_colorable.mpr
(not_colorable_… )` — one line, zero arithmetic.

The **only** arithmetic is at the two headline names that carry a bare numeral (`6 ≤ χ`, `7 ≤ χ`),
where `((5 + 1 : ℕ) : ℕ∞)` must meet the literal `6`. One `exact_mod_cast` each; probed. Note this
*replaces* the existing proof of `six_le_chromaticNumber_plane_of_forced_pairs`, which hand-rolled
`rw [show ((5 : ℕ) : ℕ∞) = 5 from rfl, ← ENat.add_one_le_iff (by simp)]` — the statement is unchanged
and the proof gets shorter. A declined generalization is recorded with it: a bespoke numeral-bridge
lemma was considered and rejected, because minting one would have put the arithmetic in a *second*
place, which is the opposite of the answer to Q2.

### The mutation audit (validate-adversarially), and what it produced

Each hypothesis was deleted in thought and the failure sought concretely.

* `hk : k < 7` — already red-tested in the module (the seven-colour rainbow, `:148`).
* `h1 : (1 : ℝ) ∈ D` — **a new red, and it is worth having.** The map `![0,0,1,2,3,4,5] : Fin 7 →
  Fin 6` has **no** monochromatic pair among the six `√3`-pairs and three diameters, and its one
  repeat sits on the listed unit edge `(0,1)`. So without properness at distance `1` the conclusion
  is false at the carrier, and the hypothesis is load-bearing rather than inherited. Compiles; ships
  as an `example` with the repeat pinned by a `#guard`.
* `hm : (2 : ℝ) ∈ D` in the one-free corollary — it is the sole input to the discharge; deleting it
  leaves `h2` unprovable.
* **The consistency cross-check passes**: the master with *both* hypotheses discharged from
  membership proves `¬ (distanceGraph ℂ {1, √3, 2}).Colorable 6`, which the module already proves by
  the independent edge-list route at `:222`. Two proofs of one fact, by different arguments, is the
  evidence D1 was chosen on — it ships as an `example`.

### What the pass declined

* **A pair of named colouring-transport definitions** (`{1}`-colouring ↔ unit colouring, both ways).
  Declined: `rw` plus one inline `Coloring.mk` covers both call sites, and the module already owns
  the bridge these would duplicate.
* **Forcing the unit conditional through the `D` conditional by hand-transporting hypotheses.**
  Superseded — the `rw` idiom does it for free, which is strictly better than either the transport or
  the five-line duplicate the pass started out expecting to accept.
