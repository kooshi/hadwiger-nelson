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
| `DyadicQuadratic.colorable_of_ringHom` (DQ.1) | route to NF4-DYADIC-TWO, -FOUR | **already in the kernel** as `ResidueColouring.colorable_unitDistance_induce_of_residue` — § Stage 2, D-3 |
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
  `ResidueColouring.colorable_unitDistance_induce_of_residue` (`ResidueColouring.lean:561`, Theorem A for a set of points) is the old
  statement with `A := unitRing F`; and the route § Stage 5 gives the two dyadic leaves builds an **additive** map on a lattice
  holding the unit vectors, not a ring homomorphism out of `ℤ[U_F]`. Old: `colorable_of_ringHom {k : Type} [CommRing k] [Finite k]
  [Nontrivial k] (φ : unitRing F →+* k) : Colorable (Nat.card k)`. New: `colorable_planeOver_of_addMonoidHom {Λ : AddSubgroup ℂ}
  {G : Type*} [AddCommGroup G] [Finite G] (ψ : Λ →+ G) (h : ∀ u ∈ unitVectors F, ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) : Colorable (Nat.card G)`
  — `ResidueColouring.colorable_of_residue` (`:235`) read at the plane. The old form is its case `Λ = ℤ[U_F]`.
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
- **L2.5 `colorable_two_iff_fieldBandSet_two_nonempty`** — `⟸` is D-4 with `ResidueColouring.colorable_of_residue` at
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
