## Stage 6 — SAVED (FS131-LC1): read aloud — each headline against its claim line and the dated line, the lemma against the page, the definition against the paper's

*The statements are read as the kernel holds them: `#check @…` and `#print` of `data/fs131/lc1/checks.lean`, elaborated
with the lakefile's two options (`probes/checks-before.log` before any edit; again in the gate's pass,
`gate/checks-final.out`). The page is `[Davies2026]` as rendered: p. 2, p. 44, p. 46. A sentence in quotation marks is
the paper's or the claim list's; a line in code is the kernel's.*

### The definition: `Plane.chiLebesgue` against the paper's measurable chromatic number (p. 2)

The paper, p. 2: "The Hadwiger-Nelson problem asks for the chromatic number of the plane: the minimum number of colours
needed to colour ℝ² so that points at distance 1 receive different colours." And: "Requiring the colour classes to be
Lebesgue measurable gives the measurable chromatic number χ^(m)(ℝ^d)."

```
def HadwigerNelson.Plane.chiLebesgue : ℕ∞ :=
⨅ k, ⨅ (_ : ∃ f, NullMeasurable f volume ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y), ↑k
```

| the paper's clause | the kernel's | read |
|---|---|---|
| "the minimum number of colours" | the infimum in `ℕ∞`, over `k : ℕ`, of `k` such that a colouring `f : ℂ → Fin k` with the two properties exists; `⊤` if none | the same: an infimum of a set of naturals that is not empty (nine: the module's `example`; seven: `FS131LC1.chiLebesgue_le_seven`, a term) is attained. A map into `Fin k` uses at most `k` colours |
| "ℝ²" | `ℂ`, with its distance `dist x y = ‖x − y‖` and its measure `volume` | the Euclidean plane as this library holds it everywhere (`Plane/`); `volume` on `ℂ` is the Lebesgue measure of the plane (an additive Haar measure: `inferInstance : volume.IsAddHaarMeasure`, printed). **The number is defined over `ℂ` only**: no `EuclideanSpace ℝ (Fin 2)` form of it is stated — the headline in row 33's form has `EuclideanSpace` on its left side and this number on its right |
| "so that points at distance 1 receive different colours" | `∀ (x y : ℂ), dist x y = 1 → f x ≠ f y` | **every** pair at distance one, no exception |
| "the colour classes … Lebesgue measurable" | `NullMeasurable f volume`: the preimage of every set of colours is a `NullMeasurableSet` for `volume` — a set equal, off a null set, to a Borel set; that is the Lebesgue σ-algebra of the plane, the completion of the Borel sets under Lebesgue measure | **Lebesgue, not Borel.** In the paper's own words by a kernel theorem: `nullMeasurable_iff_forall_fibre : NullMeasurable f volume ↔ ∀ (j : Fin k), NullMeasurableSet (f ⁻¹' {j}) volume` — each colour class a Lebesgue-measurable set |

**Which measurability, which pairs:** Lebesgue-measurable classes; every unit pair. It is the paper's `χ^(m)(ℝ²)` and
Falconer's number. It is not `Plane.chiM` (`⨅ k, ⨅ (_ : ∃ f, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), ↑k`:
`Measurable` on `ℂ` is Borel) and not `Plane.chiM0` (an `AeColouring k`: a Borel map, each class with
`UnitPairsNull` — proper at almost every unit pair). Sanity of the definition, as terms and `example`s, none a claim:
`5 ≤ chiLebesgue` and `chiLebesgue ≤ 9` (the module's `example`s, the standard three), `chiLebesgue ≤ 7`
(`FS131LC1.chiLebesgue_le_seven`, the standard three), `6 ≤ chiLebesgue` given the *other* declared outside theorem
(`FS131LC1.six_le_chiLebesgue`; its axioms print `no_proper_five_coloring`).

### The lemma against the page (p. 44), clause by clause, with its standing hypotheses

The page. Standing: "Throughout, D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty, d ⩾ 2, and k ⩾ 2." Before the lemma:
"We first show that a measurable proper colouring of a conull set can, after changes on a null set, be extended to a
measurable proper colouring of ℝ^d. We suspect that this is a folklore result, but have not found it in the
literature." **Lemma B.1.** "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then
ℝ^d admits a measurable proper k-colouring of its D-distance graph." (p. 2: "A set is D-avoiding if it contains no pair
of points at a distance in D"; "the graph whose edges join points at distances in D".)

```
@davies_lemma_B1_euclidean : ∀ {d : ℕ} (D : Set ℝ) {k : ℕ} {A : Fin k → Set (EuclideanSpace ℝ (Fin d))},
  (∀ (i : Fin k), NullMeasurableSet (A i) volume) →
    (∀ (i : Fin k), ∀ x ∈ A i, ∀ y ∈ A i, dist x y ∉ D) →
      volume (⋃ i, A i)ᶜ = 0 →
        ∃ f, NullMeasurable f volume ∧ (∀ᵐ (x : EuclideanSpace ℝ (Fin d)), x ∈ A (f x)) ∧
              ∀ (x y : EuclideanSpace ℝ (Fin d)), dist x y ∈ D → f x ≠ f y
```

| the page's clause | the kernel's | read |
|---|---|---|
| "A₁, …, A_k ⊆ ℝ^d" | `A : Fin k → Set (EuclideanSpace ℝ (Fin d))` | `k` sets, indexed `0 … k − 1`, in `ℝ^d` with its Euclidean distance and Lebesgue measure |
| "are measurable" | `∀ i, NullMeasurableSet (A i) volume` | Lebesgue measurable — the paper's sense (p. 2; its proof ends "so the colouring is Lebesgue measurable"), and the weaker reading of the hypothesis: a Borel set is one, so the theorem covers both |
| "D-avoiding" | `∀ i, ∀ x ∈ A i, ∀ y ∈ A i, dist x y ∉ D` | no two points of one set at a distance in `D` (with `x = y`: `0 ∉ D` wherever a set is not empty — automatic for the paper's `D ⊆ (0, ∞)`) |
| "whose union is conull" | `volume (⋃ i, A i)ᶜ = 0` | the same |
| "Then ℝ^d admits a measurable proper k-colouring of its D-distance graph" | `∃ f : EuclideanSpace ℝ (Fin d) → Fin k, NullMeasurable f volume ∧ … ∧ ∀ x y, dist x y ∈ D → f x ≠ f y` | a Lebesgue-measurable map into `k` colours, proper at every pair at a distance in `D` |
| — (the proof's last line: "Each colour class differs from A_i only within the null set ℝ^d ∖ A") | the middle conjunct, `∀ᵐ x, x ∈ A (f x)` | **more than the printed statement**, and what its proof gives: almost every point lies in a given set of its own colour |
| standing: "D = {d₁, …, d_t} ⊆ (0, ∞) is finite and nonempty" | `(D : Set ℝ)`, nothing asked | **not asked**: any set of reals. With `0 ∈ D` or with no avoiding cover the hypotheses cannot be met and the theorem says nothing; it is never false |
| standing: "d ⩾ 2" | `{d : ℕ}`, nothing asked | **not asked** |
| standing: "k ⩾ 2" | `{k : ℕ}`, nothing asked | **not asked**; at `k = 0` the hypotheses are contradictory (a Haar measure of the whole space is not zero), which the proof of `exists_proper_nullMeasurable_of_avoiding_cover` derives |

**So the kernel's lemma says more than the page's, in two ways the claim list's dated line accepts** ("the general form
the planner found comes free"): fewer hypotheses, and one more conclusion. The printed proof's six steps are FS131-KC1's
table (its record, § Stage 3); read here against the module: step 3's sentence is the docstring of
`exists_translate_mem`, word for word from the page, and step 5 is `Finset.rado_selection`, which Mathlib proves from
Tychonoff's theorem (its module header: "The proof uses the fact that the product of finite discrete spaces is compact
(by Tychonoff's theorem)").

The sentence before the lemma, against the core:

```
@exists_proper_ae_eq_of_proper_on_conull : ∀ {E : Type u_1} [inst : NormedAddCommGroup E] [inst_1 : NormedSpace ℝ E]
  [FiniteDimensional ℝ E] [inst_3 : MeasurableSpace E] [BorelSpace E] (μ : Measure E) [μ.IsAddHaarMeasure]
  {R : E → E → Prop}, (∀ (ξ x y : E), R x y → R (x + ξ) (y + ξ)) →
    ∀ {k : ℕ} {c : E → Fin k}, NullMeasurable c μ → ∀ {S : Set E}, μ Sᶜ = 0 →
      (∀ x ∈ S, ∀ y ∈ S, R x y → c x ≠ c y) → ∃ f, NullMeasurable f μ ∧ f =ᵐ[μ] c ∧ ∀ (x y : E), R x y → f x ≠ f y
```

"a measurable proper colouring of a conull set" — `c`, Lebesgue measurable, proper for `R` on `S`, `μ Sᶜ = 0` (`c` is
total and read for properness only on `S`; its values off `S` cannot spoil measurability, the complement being null);
"can, after changes on a null set" — `f =ᵐ[μ] c`; "be extended to a measurable proper colouring of ℝ^d" —
`NullMeasurable f μ ∧ ∀ x y, R x y → f x ≠ f y`. In place of `ℝ^d` and "at a distance in `D`": any finite-dimensional
real normed space with its Borel σ-algebra and an additive Haar measure, and any relation carried to itself by every
translation — neither symmetry nor irreflexivity is asked. The plane's form, `Plane.davies_lemma_B1`, is the
Euclidean one at `ℂ` and `dist x y = 1`.

### NF3-PRINTED

The claim line is the page's statement with its standing hypotheses and the sentence before it; the table above is
its reading. **Kernel theorems**: `exists_proper_ae_eq_of_proper_on_conull`,
`exists_proper_nullMeasurable_of_avoiding_cover`, `davies_lemma_B1_euclidean`, `Plane.davies_lemma_B1`, each on
`[propext, Classical.choice, Quot.sound]`. Formalized with the printed proof, not imported: no `axiom` enters with
the module.

### NF3-WEAK-TO-PROPER — **the claim's first clause says more than the kernel holds**

The claim: "a weak measurable `k`-colouring of `ℝ^d` (Lebesgue measurable, proper at almost every pair at a distance in
a finite `D`) gives a Lebesgue-measurable `k`-colouring proper at every such pair; so `χ_m⁰(ℝ²) = χ_m(ℝ²)`."

```
@exists_proper_of_nullMeasurable_weak : ∀ {k : ℕ} {c : ℂ → Fin k}, NullMeasurable c volume →
    (∀ (j : Fin k), UnitPairsNull (c ⁻¹' {j})) →
      ∃ f, NullMeasurable f volume ∧ f =ᵐ[volume] c ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y
chiM0_eq_chiLebesgue : chiM0 = chiLebesgue
```

- **Less than the first clause**: the plane and the unit distance, not `ℝ^d` and a finite `D`. The step that does not
  come free is the density-point step (the library's `UnitPairsNull` is a set of pairs `(x, θ)` in `ℂ × ℝ`); the lemma
  itself is in every dimension. The planner's report says so, NF3-NC allows it ("anything in dimension other than two
  or for distance sets other than the unit distance beyond what a planner finds comes free" is not claimed), and the
  coordinator was sent the difference before the gate ran. **The `ℝ^d` clause stays [hand]**; what is regraded is the
  plane's clause and the equality.
- "Lebesgue measurable" — `NullMeasurable c volume`. "proper at almost every pair" — `∀ j, UnitPairsNull (c ⁻¹' {j})`:
  `UnitPairsNull A` is `(volume.prod arcLength) (unitPairSet A) = 0`, the pairs `(x, x + e θ)` of one class null for
  plane measure times arc length. "proper at every such pair" — the last conjunct. **More than the claim**: the new
  colouring equals the old one almost everywhere.
- "so `χ_m⁰(ℝ²) = χ_m(ℝ²)`" — `chiM0 = chiLebesgue`. `chiM0` is the least `k` with an `AeColouring k`, a **Borel** map;
  the claim's `χ_m⁰` is the least `k` with a measurable colouring proper at almost every unit pair. They are one
  number: with `k` colours a Lebesgue-measurable such colouring exists exactly when a Borel one does
  (`FS131LC1.lebesgue_weak_iff_nonempty_aeColouring`, a term over `exists_proper_of_nullMeasurable_weak` and
  `exists_aeColouring_of_nullMeasurable_proper`, the standard three). On the standard three, no outside theorem.

### NF3-PLANE

The claim: "`χ(ℝ²) = χ_m(ℝ²)`, Falconer's number. **[derived]** from ER1-WEAK-TO-PROPER and the declared outside
theorem `Outside.OAI158.proper_to_borel_weak`; one mind; in neither paper as far as each was read."

```
chromaticNumber_plane_eq_chiLebesgue : (unitDistance ℂ).chromaticNumber = chiLebesgue
chromaticNumber_euclidean_plane_eq_chiLebesgue : (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = chiLebesgue
@colorable_iff_exists_nullMeasurable_proper : ∀ {k : ℕ},
  (unitDistance ℂ).Colorable k ↔ ∃ f, NullMeasurable f volume ∧ ∀ (x y : ℂ), dist x y = 1 → f x ≠ f y
```

Read against Mathlib's `SimpleGraph.chromaticNumber : SimpleGraph V → ℕ∞` (the infimum over `n` of `G.Colorable n`) and
`unitDistance_adj : (unitDistance V).Adj x y ↔ dist x y = 1`: the left side is the least number of colours in a
colouring of the plane with no two points at distance one alike, over all maps; the right side is the same least
number over Lebesgue-measurable maps. **Aloud**: the plane can be coloured with `k` colours so that no two points one
unit apart share a colour exactly when it can be so coloured with every colour class a Lebesgue-measurable set.
Axioms, as printed: `[propext, Classical.choice, Quot.sound, Outside.OAI158.proper_to_borel_weak]` on each of the
three — the one declared outside theorem and no other; `no_proper_five_coloring` is not among them. The equality gives
no value, and none is stated.

### The dated line (2026-10-13 16:51 UTC)

"typed over a new definition of the Lebesgue number (the least k with a map `ℂ → Fin k` that is null-measurable for
Lebesgue measure and proper at every unit pair)" — `chiLebesgue`, read above. "with the inequality 'Lebesgue number ≤
`Plane.chiM`' beside them" — `chiLebesgue_le_chiM : chiLebesgue ≤ chiM`, the standard three. "`Plane.chiM` is
untouched" — its stored type and value are the ones dumped before any edit (`gate/statements-final.txt`); only its
docstring moved, to say what it is. "The core lemma is typed in the general form …, the plane and the unit distance as
its instance" — read above; the relation need not even be a graph.

### NF3-NC, against every docstring of the module

"that either statement is this project's theorem" — the module header opens "None of it is this project's beyond the
composing", and the headline's docstring says "A composition of two outside results". "any value" — none; the two
`example`s bound the definition for sanity. "anything about Borel classes where the statements say Lebesgue" — the
header's "What is not said", and `chiLebesgue_le_chiM`'s "Nothing is claimed in the other direction". "anything in
dimension other than two or for distance sets other than the unit distance beyond what … comes free" — the lemma in
every dimension is what came free; the weak-to-proper step and both equalities are the plane's. "that the printed
lemma is new" — the header quotes the paper's "We suspect that this is a folklore result".

### What the read-aloud changed in the module's docstrings (no statement; stage 2 lists the lines)

1. `davies_lemma_B1_euclidean`: its list of the paper's standing hypotheses dropped "⊆ (0, ∞)"; it now reads "`D ⊆
   (0, ∞)` finite and nonempty, `d ⩾ 2`, `k ⩾ 2` — are not used by its proof and are not asked: `D` is any set of reals".
2. The density-point step's attribution, in the header and at `AeColouring.core_dist_ne_one`: "printed in
   `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6)" said more than the source — there the argument is for the
   density points of a support on a compact group ("Let I be the set of density points in the support of f … Claim: I
   is independent", printed p. 22), and `[Davies2026]` p. 46 says "We now follow the density-point argument in [24,
   proof of Lemma 5.6]". The docstrings now say: the argument of that proof, as `[Davies2026]` p. 46 follows it in `ℝ^d`.
3. "`Finset.rado_selection`, which is Tychonoff's theorem" → "which Mathlib proves from Tychonoff's theorem".
4. `exists_proper_of_aeColouring`: "whether one exists with six is Hadwiger–Nelson" is true given the two declared
   outside theorems, and now says so and names `Outside.OAI158.colorable_iff_nonempty_aeColouring`.

**One docstring's fact the library does not hold as a theorem**: the module's second `example` is headed "The step run
on a colouring that is not proper". That `r7Col` gives one colour to two points at distance one is true and
kernel-checked as a term — `FS131LC1.r7Col_not_proper`: the lattice point `0` and `3/7 + (5/7)ω`, at distance one
because `(3/7)² + (3/7)(5/7) + (5/7)² = 1`, both of colour `0` — and so is its consequence that the conull set handed
to the lemma there is not the plane (`FS131LC1.model_core_ne_univ`). Open gate item 2.
