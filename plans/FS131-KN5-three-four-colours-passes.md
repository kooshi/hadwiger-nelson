# FS131-KN5 — three and four colours: the modeling passes, the first build, the dyadic leaves' plan

*The kernel lane's planner (de Bruijn), successor of FS131-KN4, 2026-10-13, branch `fs131-wr2`. Brief:
`data/fs131/briefs/FS131-KN5-passes-and-build.md`. The skeleton and its plan per leaf: `plans/FS131-KN4-three-four-colours-plan.md`
(this record amends it; where the two differ, this one is later). Working files: `data/fs131/kn5/`.*

## Theorems this phase proved

None in the kernel: a planning job; every leaf is `sorry`. What this job **found** is listed in each stage under "Findings", at
[hand, one mind, the planner] unless a computation is named.

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/kn5/check_quotes.py`: the brief's five quoted blocks (Kooshi's W2 and the claim list's theorem and three
dated lines) against their sources in the coordinator's checkout, byte for byte — **5 MATCH** (exit 0;
`data/fs131/kn5/logs/check_quotes.out`). Control `--plant` alters one token of each quotation in memory: 5 of 5 then mismatch
(`check_quotes.plant.out`). **One thing for the coordinator**: this tree's own copy of `data/fs131/claims-NF4.md` ends at NF4-NC — the
three dated lines are on `main` only (the branch was cut before them). Nothing here reads the stale copy; the join brings main's.

**Definitions of the four modules** (two; everything else is the library's `band`, `bandSet`, `fieldBandSet`, `torsionBy`, `unitSet`,
`unitRing`, `planeOver`, `Winding`, `ProperAlong`, `TargetFloor`, `normOneCayley`, read where they stand):

| definition | what it is | read by |
|---|---|---|
| `TorsionExtraction.inv5 F : unitRing F` | `1/5` as an element of `ℤ[U_F]` (`coe_inv5` its simp form) | L2.3, L2.4 |
| `ThreeColourCriterion.conjR F : unitRing F →+* unitRing F` | complex conjugation on `ℤ[U_F]` (`coe_conjR`) | L3.5–L3.10, the joining text |

**Headlines, each with the claim it answers** (leaves are the plan's § Stage 2 list; I re-derived each leaf's statement by hand before
the passes — every one is true as typed; the notes are what the re-derivation saw):

| statement | claim | note from the re-derivation |
|---|---|---|
| `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` (L1.7, over L1.1–L1.6) | NF4-S6 | the box point is Hahn–Banach for the support function of the box; true |
| `TorsionExtraction.exists_torsion_mem_fieldBandSet` (L2.4, over L2.1–L2.3) | NF4-S7 | `(2 − i)w = 2 + i`, `1/5 = w + w̄ − 1`; a rotation from a corner has a coordinate `7/30 > 1/6`; the corner layer alternates along `5⁻ᵏ`, hence `25⁻ⁿ` |
| `colorable_two_of_inv_three_mem`, `four_le_…_of_inv_three_mem`, `…_ne_three_…` | NF4-THEOREM (c), with G-2 | compositions, proved over L2.4–L2.6 and L1.7 |
| `four_le_…_of_sqrt_mem`, `four_le_…_fieldOfRadicands`, `three_le_…_of_sqrt_mem` | NF4-THEOREM (a), lower bound, with G-1 | `|v|² = ((2n−1)² + d)/4n² = 1` exactly when `d + 1 = 4n` |
| `ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three` (over L3.1–L3.9) | NF4-THEOREM (b) ⟹, as far as the ring | proved over leaves |
| `exists_maximal_conj_trivial_of_colorable_two` (L3.10) | row 99's form only (the outside model's two-colour theorem, ⟹) | **true for every subfield, with a short proof** — § Stage 2, D-2 |
| `comap_conjR_eq` (L3.6) | FS91-J02-L2(b) | **true of every ideal** — § Stage 2, D-1 |
| `DyadicQuadratic.colorable_of_ringHom` (DQ.1) | route to NF4-DYADIC-TWO, -FOUR | **already in the kernel** as `HadwigerNelson.colorable_unitDistance_induce_of_residue` — § Stage 2, D-3 |
| `colorable_two_planeOver_sqrt` (DQ.2), `colorable_four_planeOver_sqrt` (DQ.3) | NF4-DYADIC-TWO, NF4-DYADIC-FOUR (kernel form) | § Stage 5 |
| joining text: `chromaticNumber_planeOver_eq_three_iff`, `colorable_three_iff`, the four rows, `localBound_le_chromaticNumber_of_le_four`, the two primes | NF4-THEOREM (b), (a)'s table, row 99, the dated lines' wording | elaborated against both lines by the first planner; re-elaborated after the passes (§ Stage 4) |

## Stage 2 — SAVED: the domain pass (`debruijn-domain-modeling`, a fresh invocation)

**What was weighed.** The pass's one cut — what belongs to the problem against what the present proof route happens to carry — was
put to every statement by asking which hypotheses its proof uses, and to both definitions by asking who inspects them. The two
definitions stand (`inv5` is read by two statements and has its coercion lemma; `conjR` by nine and the joining text). `Θ₂` stays
`fieldBandSet F (band 2)`: it is the criterion's own vocabulary at `k = 2`, and every consumer on this line holds a character. The
finite rings stay `{A : Type}` (forced by `TargetFloor`'s `k : Type`). `layer_dichotomy` needs its two-sided index (the corner layer is
read at `m ± 1` at every depth). No cast, no index threaded and unread, no `Bool`/`Prop` pair. Four findings, three of which change a
statement; each was re-elaborated in § Stage 4.

- **D-1 — `ThreeColourCriterion.comap_conjR_eq`: every ideal, not every prime ideal.**
  Old: `(𝔮 : Ideal (unitRing F)) [𝔮.IsPrime] : 𝔮.comap (conjR F) = 𝔮`. New: `(I : Ideal (unitRing F)) : I.comap (conjR F) = I`.
  Reason: for `a ∈ I`, `a ≠ 0`, the unit vector `u = a/ā` gives `ā = ū·a ∈ I` because `I` is an ideal; primality is never used, and
  the instance would be reported unused the day the leaf is proved. Consumers (L3.8's `hmax`) read the wider form unchanged.
- **D-2 — `ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two`: every subfield of `ℝ`, by five lines; no number
  field, no finite quotient, no L3.3.** Old: `(F : Subfield ℝ) [NumberField F] (h2 : Colorable 2) : ∃ 𝔪, 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪`.
  New: the same with `[NumberField F]` dropped. Reason, the proof: let `J = Ideal.span {u − 1 | u ∈ unitSet F}`. Every unit vector
  is `1` modulo `J`, and `ℤ[U_F]` is the additive span of the unit vectors, so every element is an integer modulo `J`; `i ≡ 1` gives
  `2 ∈ J`; so the quotient has at most two elements. A two-colouring's character `τ` (L2.5 ⟹) kills `J` — `J` is the additive span
  of the `u'u − u'`, and `τ(u'u) − τ(u') = 1/2 − 1/2` — while `τ(1) = 1/2`, so `1 ∉ J`. Hence `J` is maximal with quotient `𝔽₂`,
  and conjugation, which fixes `J` (D-1), is the identity modulo it. With L3.9 (its converse, already every subfield) the two-colour
  end is an equivalence at every subfield of `ℝ`: **`F²` is two-colourable iff `ℤ[U_F]` has `𝔽₂` as a quotient.** [hand, one
  mind; a restatement of "no odd closed walk" in the ring's words — elementary, and the outside model's theorem (GPT Astra Thm 2.1)
  is its number-field reading through the dictionary J.1/J.4; not claimed.] L3.3 keeps its one consumer, L3.8.
- **D-3 — `DyadicQuadratic.colorable_of_ringHom` is already in the kernel, and the dyadic leaves want its additive form.**
  `HadwigerNelson.colorable_unitDistance_induce_of_residue` (`ResidueColouring.lean:561`, Theorem A for a set of points) is the old
  statement with `A := unitRing F`; and the route § Stage 5 gives the two dyadic leaves builds an **additive** map on a lattice
  holding the unit vectors, not a ring homomorphism out of `ℤ[U_F]`. Old: `colorable_of_ringHom {k : Type} [CommRing k] [Finite k]
  [Nontrivial k] (φ : unitRing F →+* k) : Colorable (Nat.card k)`. New: `colorable_planeOver_of_addMonoidHom {Λ : AddSubgroup ℂ}
  {G : Type*} [AddCommGroup G] [Finite G] (ψ : Λ →+ G) (h : ∀ u ∈ unitVectors F, ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) : Colorable (Nat.card G)`
  — `HadwigerNelson.colorable_of_residue` (`ResidueColouring.lean:235`) read at the plane. The old form is its case `Λ = ℤ[U_F]`.
- **D-4 — one helper stated once: a character killed by `N` is a `ZMod N`-valued functional** (`ZMod.toAddCircle` after it). Four
  leaves were each going to build it privately (L2.5 both ways, L3.8 at 2 and 3, L3.9). New leaf in `TorsionExtraction` § 3:
  `exists_addMonoidHom_zmod`. No statement changes.

**Seams.** Models of the hypotheses: unchanged from the first planner's (§ Stage 3 of its plan); D-2's new form has the model
`F = ℚ(√2)` once DQ.2 is proved, and until then names `ℚ` in words as before. Adversarial members tried: `d` a perfect square in
clause (a) (none: squares are `0, 1 (mod 4)`); `n = 0` in L2.7 (excluded by `d + 1 = 4n`); `A` trivial in L3.2/L3.3 (excluded by
`CharP A p`); `𝔽₄` with Frobenius in L3.3 (hypothesis unsatisfiable there: `l(1) + l(ω) + l(ω²) = l(0)`), `𝔽₂[ε]` (holds).

## Stage 3 — SAVED: the obligation pass (`debruijn-obligation-modeling`, a fresh invocation)

For each leaf the plan calls long: the statement checked for strength, and the named children from which each case is local. A
child marked **typed** is a new leaf in the module (statement fixed, `sorry`); the others are for the implementer to state.

- **L1.1 `exists_box_point`** — statement right (its only hypothesis, `minRise_le`, is the whole content). The first plan's step
  (v), "it suffices on the `2^m` vertices … keep `c`, `q`, `N` as explicit functions", is where the walk-through was; it localizes as:
  **C1** for `r` in the lattice, a vertex `v ∈ {1/3, 2/3}^m` with `W r ≤ r·v` (`v_j = 2/3` iff `0 ≤ r_j`; `minRise_le` at `−r`);
  **C2** if no point of the box solves the `n` generator equations, some `c : Fin n → ℝ` has `Σ_i c_i (r_i·x − W r_i) < 0` on the box
  (`geometric_hahn_banach_closed_point`, the image of the box compact and convex); **C3**, the only analysis: finitely many linear
  functionals negative at a real vector are negative at an integer vector — `∀ k, ℓ k c < 0 → ∃ N : ι → ℤ, ∀ k, ℓ k (N ·) < 0`
  (the set is open, a finite intersection of open half-spaces; the rational vectors are dense; scale by a common denominator) — it
  is read **only at the `2^m` vertices**, so no convexity and no tube lemma is needed; **C4** a solution on generators is one on the
  lattice. Contradiction: C3's integer vector is a relation `r` with `r·v < W r` at every vertex, against C1.
  A second route, not chosen: `exists_extension_of_le_sublinear` with the box's support function `N(v) = Σ_j max(v_j/3, 2v_j/3)`
  needs no compactness but needs the winding extended to the real span first — the same passage `ℤ → ℚ → ℝ`, harder to localize.
- **L2.3 `tendsto_layer`** — two invariants, each an induction on the depth `k` **with the layer index `m` quantified inside**
  (the step reads `m ± 1`): rotation layer, `∀ m, θ(5⁻ᵏ g_m) = ↑(1/2 + a_m/5ᵏ)` (from `a_{m+1} + a_{m−1} = (6/5) a_m`, by `linarith`
  from the rotation equations at `m` and `m − 1`); corner layer, `∀ m, 3 • θ(5⁻ᵏ g_m) = 0`. Before them: `w` as a **unit** of
  `ℤ[U_F]` (so `g_m = w^m b` is a `zpow`), a lift `a ∈ [−1/6, 1/6]` for every unit vector, and the two relation hypotheses of
  `layer_dichotomy` from `(2 − i)w = 2 + i`. Statement unchanged.
- **L2.5 `colorable_two_iff_fieldBandSet_two_nonempty`** — `⟸` is D-4 with `HadwigerNelson.colorable_of_residue` at
  `G = ZMod 2` (fifteen lines, not the coset construction the first plan re-derives). `⟹`: with `f x = C x − C 0`, the invariant is
  `Q(y) := ∀ x, f (x + y) = f x + f y`; it holds at a unit vector (properness with two colours) and is closed under `+` and `−`, so
  it holds on the additive span. Statement unchanged.
- **L3.2 `exists_maximal_card_nine`, L3.3 `exists_maximal_conj_trivial`** — one shared reduction and two field cases; each
  theorem is then fifteen lines.
  **R (shared, to be stated by the implementer):** for a finite commutative ring `A` of prime characteristic `p`, an involution `c`
  fixing each maximal ideal, and `l : A →+ ZMod p`, there are `λ_𝔪 : A ⧸ 𝔪 →+ ZMod p`, one per maximal ideal, such that for every
  family of units `y_𝔪 ∈ (A ⧸ 𝔪)ˣ` some unit `x ∈ Aˣ` has `l (x · c x⁻¹) = Σ_𝔪 λ_𝔪 (y_𝔪 · c̄ y_𝔪⁻¹)`. (Proof: `x ↦ x^(p^M)` is a
  ring endomorphism killing the nilradical, so `l ∘ (·)^(p^M)` descends along the surjection `A → Π_𝔪 A ⧸ 𝔪`
  (`IsArtinianRing.quotNilradicalEquivPi`, or the Chinese remainder theorem with kernel the nilradical); `λ_𝔪` is its restriction
  to the factor; a family of units lifts to a unit; and `(x · c x⁻¹)^(p^M)` is again of that form.)
  **FC3 (typed, `exists_unit_div_conj_eq_zero`):** a finite field of characteristic 3 with an involution `σ`, `ι² = −1`, `σ ι = −ι`,
  not of nine elements: every additive `λ : k →+ ZMod 3` vanishes at some `y · σ y⁻¹`. (Weil: `targetFloor_four_weil`; this is
  where the import is read.) **FC2 (typed, `eq_zero_of_forall_unit_div_conj_eq`):** a finite field of characteristic 2 with an
  involution `σ ≠ id`: an additive `λ` constant on `{y · σ y⁻¹}` is `0` there.
  **H90 (typed, `exists_unit_div_conj_eq_of_mul_conj_eq_one`):** in a finite field with an involution `σ ≠ id`, `t · σ t = 1` gives
  `t = y · σ y⁻¹`. It was step (d) inside L3.2's sketch and is **also what J.2 reads** — a step inside another implementer's proof
  cannot be cited, so it is a statement.
  Then L3.2: were no quotient of nine elements, FC3 gives a zero of every `λ_𝔪` and R a unit with `l = 0`. L3.3: were conjugation
  non-trivial in every factor, varying one coordinate in R makes each `λ_𝔪` constant on its norm-one group, FC2 makes the constants
  `0`, and the family of ones gives `l = 0 ≠ 1`.
- **L3.7 `finite_quotient_span_natCast`** — unchanged; no shorter statement found. (It is no longer read by L3.10 after D-2: its
  one consumer is L3.8.)
- **L3.8 `exists_maximal_of_torsion`** — the case analysis is one fact about two predicates: with `P(x₂) := l₂(x₂ · c x₂⁻¹) = 1` on
  units of `R/2` and `Q(x₃) := l₃(x₃ · c x₃⁻¹) ≠ 0` on units of `R/3`, the unit vector `a/ā` of a common lift gives **exactly one
  of `P(x₂)`, `Q(x₃)` for every pair**; so `P` and `Q` are constant and opposite. `P ≡ true` is L3.3's hypothesis, `Q ≡ true` is
  L3.2's. (A trivial quotient has `l = 0`, which makes its predicate constantly false with no separate case; both trivial is
  `τ 1 = 6·τ(1/6) = 0`.) Children: the lift (`a = 3a₂ − 2a₃`, with `exists_unit_mul_conj_eq`), D-4 at 2 and 3, and the pull-back of a
  maximal ideal along `R → R/p` keeping the quotient's size and conjugation's triviality. Statement unchanged.
- **DQ.2, DQ.3** — § Stage 5: each class is one parity statement about integers, checked exactly.

## Stage 4 — SAVED: the experience pass (`debruijn-experience-modeling`, a fresh invocation), and every change re-elaborated

**Who reads these files.** Three implementers who take an upstream leaf as stated and cannot open its proof; the reader of the
published statements, who meets a theorem by its name and docstring alone; `simp`, which knows two lemmas here (`coe_inv5`,
`coe_conjR`, each a coercion to its value — a third, `conjR_conjR`, is added); and the gate's scripts, which read docstrings for the
words "external", "named hypothesis", "outside the backlog" on hypothesis formers (there is none in these modules).

- **E-1 — a name that said the wrong thing.** `exists_unit_mul_conj_eq`, docstring "Hilbert 90 inside the ring": the statement is the
  *easy* direction (`a/ā` has norm one), and "unit" meant unit vector. Renamed `exists_unitSet_mul_conjR_eq`; the docstring says what
  it is and points at the real Hilbert 90 (`exists_mul_conj_inv_eq_of_mul_conj_eq_one`, § Stage 3).
- **E-2 — the module's docstring already called it `Winding.exists_box_point`**; the declaration was
  `ThreeColourCharacter.exists_box_point`. It is now `ThreeColour.Winding.exists_box_point`, so `W.exists_box_point` reads.
- **E-3 — the lemma a definition owes**: `conjR_conjR` (`@[simp]`, proved, one line). L3.6 and L3.8 both need the involution.
- **E-4 — whose result, on the statement itself.** A reader who hovers a headline sees its docstring, not the module's. The three
  headlines of `TorsionExtraction` now each carry one sentence of attribution in the claim list's words (the lower bound this
  project's, not found in print; the vector and `1/3 ∈ ℤ[U]` `[Fischer1990]`; the family posed by `[Johnson2000]`; upper bounds prior
  art). L3.10's docstring says the ring statement is elementary and that its number-field reading is an outside model's theorem.
- **E-5 — joining text**: `colorable_three_iff` did not say of what; now `colorable_three_planeOver_iff`.
- **Weighed, unchanged.** Explicit `(F : Subfield ℝ)` on headlines whose hypothesis already fixes `F`: the house's pattern
  (`exists_torsion_mem_fieldBandSet F h`), and every proved composition calls them so. `targetFloor_four_weil` matches
  `targetFloor_six_weil`, `targetFloor_seven_weil`. `exists_character_of_box_point` has no box in its hypothesis; it is read once,
  inside its own module, and stays. Both directions of the two-colour end are stated (`fieldBandSet_two_nonempty_of_conj_trivial`,
  `exists_maximal_conj_trivial_of_colorable_two`): no reader has to infer that the converse is missing.

**Every change of the three passes, as applied** (commit `558952c3e`; the stored statements are the files'):

| declaration | change | pass |
|---|---|---|
| `ThreeColourCriterion.comap_conjR_eq` | statement widened: every ideal | D-1 |
| `ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two` | statement widened: `[NumberField F]` dropped | D-2 |
| `DyadicQuadratic.colorable_of_ringHom` | replaced by `colorable_planeOver_of_addMonoidHom` | D-3 |
| `ThreeColourCharacter.exists_box_point` | renamed `ThreeColour.Winding.exists_box_point` | E-2 |
| `ThreeColourCriterion.exists_unit_mul_conj_eq` | renamed `exists_unitSet_mul_conjR_eq` | E-1 |
| joining text `colorable_three_iff` | renamed `colorable_three_planeOver_iff` | E-5 |
| new leaves (typed children) | `ThreeColourCharacter.exists_int_vector_of_forall_neg` (C3); `TorsionExtraction.exists_zmod_hom_of_mem_torsionBy` (D-4); `ThreeColourCriterion.exists_mul_conj_inv_eq_of_mul_conj_eq_one` (H90), `exists_normOne_zero_of_card_ne_nine` (FC3), `eq_zero_of_forall_normOne_eq` (FC2); in `DyadicQuadratic`: `exists_rat_add_mul_sqrt_eq`, `exists_int_solution_of_mem_unitVectors`, `dyadic_shape_one_mod_four`, `dyadic_shape_two_mod_four`, `dyadic_shape_three_mod_eight`, `exists_addMonoidHom_one_mod_four`, `exists_addMonoidHom_two_mod_four`, `exists_addMonoidHom_three_mod_eight` | obligation |
| proved | `ThreeColourCriterion.conjR_conjR`; `DyadicQuadratic.colorable_four_planeOver_sqrt` (a composition over its leaves) | E-3; obligation |
| docstrings | three headlines of `TorsionExtraction`; L3.10; the modules' "Inhabitants" | E-4 |

No headline of the claim list changed: clauses (a), (b), (c), NF4-S6, NF4-S7 and the two dyadic rows read as they did.

**Re-elaboration.** `data/fs131/kn5/elab4.sh` (the first planner's `lean1.sh`, with `-DautoImplicit=false
-DrelaxedAutoImplicit=false`, in dependency order): each module exit 0 with no message but its `declaration uses sorry` lines
(`data/fs131/kn5/logs/<Module>.out`). The joining text against both lines' libraries (`data/fs131/kn4/join_check.sh`, its farm in this
job's scratch): exit 0, ten `sorry`, no other message (`logs/join_check.out`). Leaf counts are in § Stage 7 with the final build.

## Stage 5 — SAVED: the two dyadic leaves — a plan an implementer can follow; no question for the derive lane

**The finding.** The first plan built an order of `ℚ(√m, i)`, a prime at which `1 + i` is a uniformizer, and its localization, and
called the class `m ≡ 2 (mod 4)` "sketched only". None of that is needed. **Each class is one statement about integers**, and the
colouring is an additive map written in coordinates. [hand, one mind, the planner; the integer statements checked exactly, below.]

**The objects.** For `m` not a square, a unit vector of `ℚ(√m)²` is `u = (a + b√m + c·i + d·i√m)/N` with integers, and `|u| = 1` is
`Q1: a² + c² + m(b² + d²) = N²`, `Q2: ab + cd = 0` (the rational part and the `√m` part of `u·ū = 1`). Take the solution not all
even. Then, by class (`dyadic_shape_*`):

| class | `N` odd | `N` even | the map `ψ` (on `(a, b, c, d)/(2N)`, `N` odd) |
|---|---|---|---|
| `m ≡ 1 (mod 4)` | `a + b + c + d` odd | `N ≡ 2 (mod 4)`, `a ≡ b`, `c ≡ d (mod 2)`, `(a − b + c − d)/2` odd | `(a − b + c − d)/2 mod 2` on `{a ≡ b, c ≡ d}` |
| `m ≡ 2 (mod 4)` | `a + c` odd | `N ≡ 2 (mod 4)`, `a, c` even, `b, d` odd, `a/2 + c/2 + d` odd | `a/2 + c/2 + d mod 2` on `{a, c even, b ≡ d}` |
| `m ≡ 3 (mod 8)` | `a + b + c + d` odd | `N ≡ 2 (mod 4)`, `a ≡ d`, `b ≡ c (mod 2)`, `b + d` odd | `((a − d + b + c)/2, b + d) mod 2` on `{a ≡ d, b ≡ c}` |

In each row the last clause of both alternatives says `ψ(u) ≠ 0`. (`ψ` is reduction at the dyadic prime: `i ↦ 1`, and
`ω = (1 + √m)/2`, `η = √m(1 + i)/2`, `ρ = (1 + i√m)/2` to their residues. The proof never says so.)

**Checked exactly** (`data/fs131/kn5/dyadic_check.py`, `dyadic_modulus.py`; logs beside them):
- every integer solution with `|a|, |b|, |c|, |d| ≤ 9` for every non-square `m ≤ 45` of the class: 836, 836 and 528 solutions, both
  alternatives met in each class (96, 176, 272 with `N` even), **0 failures**;
- every residue class: the statement with `Q1`, `Q2` read modulo 16 holds at all 20480 + 12288 + 8192 residue tuples satisfying them
  — since the conclusion reads residues modulo 4 only, **this is a proof of the three statements by exhaustion** [tools, exact];
- the least modulus (`dyadic_modulus.py`): classes A and B are already finite statements **modulo 8** (1280 and 768 tuples; modulo 4
  each fails 8 times); class C needs 16 only to exclude the all-odd quadruples (**no** tuple modulo 16 satisfies `Q1`, `Q2` with
  `a, b, c, d` all odd), and with those left out it is a statement modulo 8 (512 tuples). Control: class C modulo 8 with nothing left
  out fails 128 times, as it must;
- three planted faults, each watched firing (exit 1): class A's claim at `m ≡ 3 (mod 4)` (first failure `−(1 + i√3)/2`), class B's
  at `m ≡ 0 (mod 4)`, class C's at `m ≡ 7 (mod 8)` (`logs/dyadic_check.plant{A,B,C}.out`).

**The leaves of `Arith/DyadicQuadratic`, in order, each with its route.** Names marked ✓ are in
`data/fs131/kn5/lean/NameCheck.lean` (checked under this module's imports; § Stage 7 has the log's verdict).

1. **`colorable_planeOver_of_addMonoidHom`** (≈ 20 lines). `haveI := Fintype.ofFinite G`; `rw [Nat.card_eq_fintype_card]`;
   `HadwigerNelson.colorable_of_residue _ (fun v : planeOver F => (v : ℂ)) ψ hmem hne`. For adjacent `v, w` the difference is a
   unit vector (`unitDistance_adj`, `Complex.dist_eq`; coordinates by `Complex.sub_re`, `Subfield.sub_mem`); `hmem` is the first
   component of `h`, `hne` the second after `HadwigerNelson.cosetResidue_apply_of_mem`.
2. **`exists_rat_add_mul_sqrt_eq`** (≈ 35 lines). `Subfield.closure_induction` on `fieldOfRadicands {m}` with the predicate
   `∃ p q : ℚ, x = p + q√m`. Product by `Real.mul_self_sqrt`. Inverse of `x = p + q√m ≠ 0`: if `p − q√m ≠ 0` it is
   `(p − q√m)/(p² − mq²)`; if `p − q√m = 0` then `x = 2p` and the inverse is rational. **No irrationality is used**, so the lemma
   holds for every `m`.
3. **`exists_int_solution_of_mem_unitVectors`** (≈ 70 lines; the glue all three classes share). From (2), `u.re = p₁ + p₂√m`,
   `u.im = p₃ + p₄√m`; `‖u‖ = 1` gives `(p₁² + p₃² + m(p₂² + p₄²) − 1) + 2(p₁p₂ + p₃p₄)√m = 0`, and `√m` irrational
   (`irrational_sqrt_natCast_iff`, from `¬ IsSquare m`) makes both rational parts `0`. Clear denominators; among the representations
   `N·u = a + b√m + (c + d√m)i` with `N > 0` take one with `N` least (`Nat.find`): it is not all even, or halving would give a
   smaller one.
4. **`dyadic_shape_one_mod_four`, `dyadic_shape_two_mod_four`** (≈ 40 lines each). Cast `h1`, `h2` to `ZMod 8`
   (`congrArg (Int.cast : ℤ → ZMod 8)`, `push_cast`; `(m : ZMod 8)` is `1` or `5`, resp. `2` or `6`, by `ZMod.natCast_mod`). The
   finite statement — for all `a b c d N : ZMod 8`, `Q1 → Q2 →` not all of even value `→` the conclusion on `.val` modulo 4 — is
   `decide` over `8⁵ = 32768` tuples per value of `m`; if it is slow, split first on the five parities (32 cases) and use
   `decide +kernel` (`LEAN.md` § The kernel's cost model; state the check as a `Bool` through `List.all` if a `∀` is slow). Read the
   conclusion back with `ZMod.val_intCast` and `omega` (`Int.odd_iff`; `/ 2` and `% 4` by literals are linear for `omega`).
5. **`dyadic_shape_three_mod_eight`** (≈ 60 lines). The same with one more step: first the all-odd quadruples are impossible —
   cast to `ZMod 16` (`m ≡ 3` or `11`), `8⁴·16` tuples; by hand: odd squares are `1` or `9 (mod 16)`, `ab = −cd` forces
   `a²b² = c²d²`, so `a² + c² + m(b² + d²) ≡ 2 + 2m ≡ 8 (mod 16)`, never a square. Then the rest modulo 8 as in (4).
6. **The odd-denominator rationals** (≈ 40 lines, private to the module): `oddDen : AddSubgroup ℚ := {q | Odd q.den}`
   (`Rat.add_den_dvd`) and `red : oddDen →+ ZMod 2`, `q ↦ ((q : ℚ) : ZMod 2)` — `Rat.cast` into the field `ZMod 2` is additive on
   rationals whose denominators are not `0` there (`Rat.cast_add_of_ne_zero`); for an integer `a` and odd `N`, `a/N ∈ oddDen` and
   `red (a/N) = (a : ZMod 2)`.
7. **`exists_addMonoidHom_one_mod_four`, `…_two_mod_four`, `…_three_mod_eight`** (≈ 70 lines each). `e : ℚ × ℚ × ℚ × ℚ →+ ℂ`,
   `e p = p₁ + p₂√m + (p₃ + p₄√m)·i`, injective because `√m` is irrational (classes 2 and 3 are never squares: squares are `0, 1
   (mod 4)`). `Γ ≤ ℚ⁴`: the `p` whose four forms `t₁ … t₄` lie in `oddDen`; `ψ₀ : Γ →+ G` a sum of `red ∘ t_j`; then
   `Λ := Γ.map e` and `ψ := ψ₀ ∘ (Γ.equivMapOfInjective e he).symm` (`AddSubgroup.equivMapOfInjective`), so no coordinate has to be
   chosen. The forms, by class:
   - `m ≡ 1 (mod 4)`: `t = (p₁ − p₂, 2p₂, p₃ − p₄, 2p₄)`; `ψ₀ = red t₁ + red t₃`.
   - `m ≡ 2 (mod 4)`: `t = (p₁, p₃, p₂ − p₄, 2p₄)`; `ψ₀ = red t₁ + red t₂ + red t₄`.
   - `m ≡ 3 (mod 8)`: `t = (p₁ − p₄, p₃ + p₂, 2p₄, −2p₂)`; `ψ₀ = (red t₁ + red t₂, red t₃ + red t₄)`.
   For a unit vector: (3) gives `(a, b, c, d, N)`, the shape lemma gives the alternative, and in each the four `t_j` are an integer
   over an odd number (`N`, or `N/2` when `N ≡ 2 (mod 4)`) and `ψ₀` is the odd quantity of the table.
8. **`colorable_two_planeOver_sqrt`** (≈ 25 lines; a composition). `m % 4 = 0` contradicts `Squarefree m` (`2 * 2 ∣ m`,
   `Nat.isUnit_iff`). `m = 1`: `fieldOfRadicands {1} ≤ fieldOfRadicands {2}` (`Subfield.closure_le`, `Real.sqrt_one`), then
   `SimpleGraph.Colorable.of_hom` along `SimpleGraph.induceHomOfLE` from the case `m = 2`. `m % 4 = 1`, `m ≠ 1`: not a square (a
   square root would be a unit by `Squarefree`); (7) and (1). `m % 4 = 2`: (7) and (1). `Nat.card (ZMod 2) = 2`.
9. `colorable_four_planeOver_sqrt` — **proved** over (7) and (1).

**What is hard.** Nothing is deep; the length is in (3) and (7). The one place a plan's table could mislead is the cost of the
`decide` in (4)–(5): price it from the first of them.

**What the joining text reads from these leaves.** J.10 (`exists_stablePrime_card_four_sqrt`) needed "`1/2 ∉ ℤ[U_F]`" from "the ring
homomorphism of DQ.3"; with the additive map it is: `ℤ[U_F]` is the additive span of the unit vectors
(`UnitRing.exists_sum_eq_of_mem_unitRingOver`), so it lies in `Λ`; were `1/2` in it, `ψ 1 = 2 • ψ (1/2) = 0` in `𝔽₂ × 𝔽₂`, but `1`
is a unit vector. The rest of J.10 is as the first plan has it.
