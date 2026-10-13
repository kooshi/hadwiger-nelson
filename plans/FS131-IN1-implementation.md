# FS131-IN1 — the implementation of `Arith/ThreeColourCriterion`: thirteen leaves

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wrc` (cut at the skeleton's commit `34d9113b2`). Brief:
`data/fs131/briefs/FS131-IN1-leaves.md` (on `main`). The skeleton and its plans: `plans/FS131-KN4-three-four-colours-plan.md`
§ 4.3 and its dated last section, `plans/FS131-KN5-three-four-colours-passes.md` §§ Stage 3, 5, 7 (both on `fs131-wr2`).
Working files: `data/fs131/in1/`.*

## Theorems this phase proved

All in `Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean`, namespace `HadwigerNelson.ThreeColourCriterion`; the thirteen
leaves of the skeleton, each proved (stages 2–4), the axioms printed from the built module (stage 5). "Standard three" is
`[propext, Classical.choice, Quot.sound]`; "Weil" is the declared outside theorem `HadwigerNelson.StandingFive.kloosterman_bound`
(`[Weil1948]` p. 207). **Two of the thirteen also print `sorryAx` in this tree, from upstream leaves that are other jobs'
and from nothing of this module** — those two are [kernel] only when their upstream is; the other eleven are [kernel] as
they stand. Three statements are wider than the skeleton's, by the coordinator's rulings (stage 2).

| declaration | the informal statement it was read against | axioms |
|---|---|---|
| `targetFloor_four_weil` | `χ(Γ_Q) ≥ 4` for `Q ≡ 3 (mod 4)`, `Q ≥ 14` (every field of `Q²` elements with a non-trivial involution) | standard three + Weil |
| `exists_mul_conj_inv_eq_of_mul_conj_eq_one` | Hilbert 90 for a quadratic extension: `t·σ t = 1 ⟹ t = y/σ y` — **every field** (widened: `[Finite k]` dropped) | standard three |
| `exists_normOne_zero_of_card_ne_nine` | FS91-J02-L4(a): in `𝔽_{Q²}`, characteristic 3, `i` moved by `σ`, `Q ≠ 3`, every `𝔽₃`-functional vanishes on the norm-one group | standard three + Weil |
| `eq_zero_of_forall_normOne_eq` | FS91-J02-L4(b): characteristic 2, a functional constant on `{y/σ y}` is `0` there — **every endomorphism `σ ≠ id`** (widened: `hσσ` dropped) | standard three |
| `exists_maximal_card_nine` | FS91-J02-L3, L4(a), T1 step 4: a finite ring of characteristic 3 with such a functional has a residue field of nine elements | standard three + Weil |
| `exists_maximal_conj_trivial` | FS91-J02-L4(b), T1 step 5: characteristic 2, functional `≡ 1` on `{x/c x}` ⟹ `c` is the identity modulo a maximal ideal — **every endomorphism `c`** (widened: `hcc` dropped) | standard three |
| `conj_mem_unitRing` | `ℤ[U_F]` is closed under complex conjugation | standard three |
| `exists_unitSet_mul_conjR_eq` | every non-zero `a ∈ ℤ[U_F]` is `u·ā` with `u` a unit vector | standard three |
| `comap_conjR_eq` | FS91-J02-L2(b), for every ideal: conjugation fixes each ideal of `ℤ[U_F]` | standard three |
| `finite_quotient_span_natCast` | FS91-J02-L2(a): `ℤ[U_F]/N` is finite for a number field `F`, `N ≠ 0` | standard three |
| `exists_maximal_of_torsion` | FS91-J02-T1 ⟹, in the ring: a point of `Θ₃ ∩ T₆` gives a maximal ideal of dyadic type or one with nine elements in its quotient | standard three + Weil **+ `sorryAx` from `TorsionExtraction.exists_zmod_hom_of_mem_torsionBy`** (upstream leaf) |
| `fieldBandSet_two_nonempty_of_conj_trivial` | a maximal ideal with trivial conjugation is a two-colouring's character | standard three |
| `exists_maximal_conj_trivial_of_colorable_two` | the two-colour end, every subfield of `ℝ`: a two-colourable plane gives such an ideal | standard three **+ `sorryAx` from `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty`** (upstream leaf) |

The headline `exists_maximal_card_nine_of_colorable_three` (NF4-THEOREM (b), toward the prime, as far as the ring; the planner's
composition, not a leaf) prints standard three + Weil + `sorryAx` from four upstream leaves
(`ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`, `TorsionExtraction.exists_torsion_mem_fieldBandSet`,
`colorable_two_iff_fieldBandSet_two_nonempty`, `exists_zmod_hom_of_mem_torsionBy`). Twenty private helpers: nineteen on the
standard three, one (`exists_maximal_card_nine_of_quotient`) on Weil's bound too.

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/in1/check_quotes.py` (the planner's checker, pointed at this brief): the brief's five quoted
blocks — Kooshi's W2 and the claim list's theorem and three dated lines — against their sources in the coordinator's checkout,
byte for byte: **5 MATCH**, exit 0 (`data/fs131/in1/logs/check_quotes.out`). Control `--plant` alters one token of each in
memory: 5 of 5 then mismatch (`check_quotes.plant.out`).

**The tree as found, and what was done about it.** The launch note said the tree's build is an older job's and "iteration on
your file works as it stands". It does not: this worktree's `.lake/build` is of 2026-10-07 (1,867 `.olean`s) and holds no
`.olean` of `Arith/TorsionExtraction` or `Arith/ThreeColourCharacter`, so `lake env lean` on the module stops at its first
import (`object file … TorsionExtraction.olean … does not exist`). Worked around with no build: `data/fs131/in1/farm.sh` makes
a scratch farm under this tree's gitignored `build/in1-farm/` — real copies of the 44 `.olean`s of the module's import closure
inside `Proofs`, taken from the planners' tree `fs131-wr2` (whose library was built from the skeleton), with
`Arith/TorsionExtraction` — the one upstream module whose source differs there (another implementer's proofs) — recompiled
into the farm **from this tree's skeleton source**, so the farm holds what this tree's build will hold, every upstream leaf
`sorry`. The script checks that every other copied module's source is the same file in the two trees (`logs/farm.out`: yes).
`data/fs131/in1/lean1.sh` runs `lean` on one file against the farm under the slot, with the lakefile's two options. On the
untouched skeleton: exit 0, the 13 `declaration uses sorry` warnings and nothing else, 2.4 s, 3.9 GB. The farm is an
iteration device and no evidence; the one build at the end compiles this tree's own library.

**The statement check, armed before the first edit** (the pattern of `data/fs131/iu1/`, FS131-IU1's, with its tool defect
read: a statement printed from two paths differs in an instance binder's stored name, so both prints are made at one path).
- `data/fs131/in1/statements.sh`: the skeleton (`git show 34d9113b2:…`) and the working module, each with
  `lean/StatementFooter.lean` appended, elaborated at one path in turn; the two prints compared by `statement_diff.py` — every
  named constant's kind, stored type and (a definition's) stored value, character for character — then its control. On the
  untouched file: `PASS`, 17 named constants (16 theorems, 1 definition), 3 `example`s compared whole as text; control
  `4 of 4` (`logs/statements-stage1.out`).
- Two checks added to the pattern: **a name outside the module's namespace** declared by the module fails (the launch note's
  point 1: a `simp [f]` that unfolds another module's definition can generate `f.eq_1` here under that definition's name) —
  the control's fourth plant is such a name; and the `example`s are compared as text, not counted.
- `data/fs131/in1/dump.sh` prints the constants of the **compiled** module from a named library
  (`lean/StatementDump.lean`). Made now from `fs131-wr2`'s compiled skeleton (its source there is the skeleton's, checked by
  `git diff`; its `.olean` is of 14:28 today): `data/fs131/in1/statements-before-wr2.txt`, the "before" the build at the end
  is compared with. Against the footer's print it differs in the eight statements that have an anonymous instance binder and
  in nothing else — the binder's stored name carries the module's path, as FS131-IU1 found — and **Lean's own hash of every
  stored type agrees across the two prints** (20 of 20; the hash does not read binder names).

**The leaves, each read in the source** (`Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean` at `34d9113b2`), restated in
one line, with the plan's route. `R = ℤ[U_F] = unitRing F`; `c̄` is the map an involution induces on a quotient.

| leaf | statement, in one line | the plan's route | agree |
|---|---|---|---|
| L3.1 `targetFloor_four_weil` | `Q % 4 = 3`, `14 ≤ Q` ⟹ `TargetFloor 4 Q` (every field of `Q²` elements with a non-trivial involution has `χ(normOneCayley) ≥ 4`) | `targetFloor_six_of_kloosterman`'s proof with `6 → 4`: `4√Q < Q + 1` from `14 ≤ Q`; `targetFloor_of_charSum 4 Q (m := 2√Q)`, `normOne_charSum_ge`, `kloostermanBound_of_ringChar_ne_two` | yes |
| H90 `exists_mul_conj_inv_eq_of_mul_conj_eq_one` | finite field `k`, involution `σ ≠ id`, `t·σ t = 1` ⟹ `∃ y : kˣ, y·σ(y⁻¹) = t` | plan: cyclic `kˣ`. Taken instead: `y = a + t·σ a` satisfies `t·σ y = y`; if every such `y` were `0` then `t = −1` and `σ = id` | yes — **and `[Finite k]` is not read by this proof** (see below) |
| FC3 `exists_normOne_zero_of_card_ne_nine` | finite field of characteristic 3, involution `σ`, `ι² = −1`, `σ ι = −ι`, not nine elements, `lam : k →+ ZMod 3` ⟹ `lam` vanishes at some `y·σ(y⁻¹)` | else `lam` properly three-colours `normOneCayley k σ` (H90); `card_fixed_of_involution` gives `|k| = Q²`, `Q ≡ 3 (mod 4)`; `Q ≥ 14`: L3.1; `Q < 14`: `Q ∈ {3, 7, 11}` and `Q² = 3ⁿ` leaves `Q = 3` | yes |
| FC2 `eq_zero_of_forall_normOne_eq` | finite field of characteristic 2, involution `σ ≠ id`, `lam : k →+ ZMod 2` constant `= e` on `{y·σ(y⁻¹)}` ⟹ `e = 0` | the range of `y ↦ y·σ(y)⁻¹` is a subgroup of `kˣ`, not trivial, of odd order, summing to `0` (`FiniteField.sum_subgroup_units_eq_zero`) | yes |
| L3.2 `exists_maximal_card_nine` | finite ring of characteristic 3, involution `c` with `𝔪.comap c = 𝔪` for every maximal `𝔪`, `ι² = −1`, `c ι = −ι`, `l : A →+ ZMod 3` never `0` on `{x·c(x⁻¹)}` ⟹ some maximal ideal has a quotient of nine elements | the shared reduction R (below), FC3 at every factor | yes |
| L3.3 `exists_maximal_conj_trivial` | finite ring of characteristic 2, such a `c`, `l : A →+ ZMod 2` equal to `1` on `{x·c(x⁻¹)}` ⟹ `∃ 𝔪` maximal, `∀ x, c x − x ∈ 𝔪` | R; varying one coordinate each factor's functional is constant on its norm-one elements; FC2 | yes |
| L3.4 `conj_mem_unitRing` | `x ∈ R ⟹ x̄ ∈ R` | `Subring.closure_le`: generators go to generators | yes |
| L3.5 `exists_unitSet_mul_conjR_eq` | `a ∈ R`, `a ≠ 0` ⟹ `∃ u ∈ unitSet F, u·ā = a` | `u = a/ā` | yes |
| L3.6 `comap_conjR_eq` | every ideal `I` of `R`: `I.comap conjR = I` | `ā = ū·a` | yes |
| L3.7 `finite_quotient_span_natCast` | `F` a number field, `N ≠ 0` ⟹ `R ⧸ (N)` finite | plan: `N^d + 1` elements and a free group of rank `≤ d`. Taken: at a prime `p`, `R/pR` is an `𝔽_p`-space of dimension `≤ [F(i):ℚ]` (a relation over `ℤ` descends: its coefficients are all divisible by `p`); a product by `Submodule.finite_quotient_smul` | yes |
| L3.8 `exists_maximal_of_torsion` | `F` a number field, `τ ∈ Θ₃ ∩ T₆` ⟹ a maximal ideal of `R` with conjugation trivial modulo it, or one with nine elements in its quotient | `§ Stage 3`: `P(x₂)`, `Q(x₃)` on units of `R/2`, `R/3`, exactly one for every pair; L3.3 or L3.2; pull the ideal back | yes |
| L3.9 `fieldBandSet_two_nonempty_of_conj_trivial` | `𝔪` maximal in `R` with `∀ x, x̄ − x ∈ 𝔪` ⟹ `Θ₂(R_F) ≠ ∅` | `2 ∈ 𝔪`; every unit vector is `1` modulo `𝔪`; an `𝔽₂`-functional with value 1 at 1 | yes |
| L3.10 `exists_maximal_conj_trivial_of_colorable_two` | every subfield `F ⊆ ℝ`: `F²` two-colourable ⟹ such an `𝔪` | D-2: `J = (u − 1 : u a unit vector)`; every element is `0` or `1` modulo `J`; the two-colouring's character kills `J` and not `1` | yes |

**R, the shared reduction** (the plan's § Stage 3, to be stated by the implementer; private): for a finite commutative ring `A` of
prime characteristic `p`, a ring endomorphism `c` fixing each maximal ideal and `l : A →+ ZMod p`, there are
`lam I : A ⧸ I →+ ZMod p`, one per maximal ideal `I`, such that for every family of units `y I ∈ (A ⧸ I)ˣ` some unit `x ∈ Aˣ` has
`l (x·c(x⁻¹)) = Σ_I lam I (y I·c̄(y I)⁻¹)`.

No leaf's statement disagrees with its plan; none reads false or vacuous on reading. **One finding at the readback, for the
coordinator**: H90 as typed carries `[Finite k]`, and the proof above does not read it — the statement holds for every field
with an involution that is not the identity (it is Hilbert's Theorem 90 for a quadratic extension, by the usual one-line
resolvent). The skeleton's form is kept; the route's consequence for the environment linters is in § Stage 2.

Order taken: the plan's — L3.1, H90, FC3, FC2, R, L3.2, L3.3, L3.4, L3.5, L3.6, L3.7, L3.8, L3.9, L3.10.

## Stage 2 — SAVED: L3.1, Hilbert 90, the two field cases, the shared reduction, L3.2, L3.3 proved; three statements widened by ruling

`targetFloor_four_weil`, `exists_mul_conj_inv_eq_of_mul_conj_eq_one`, `exists_normOne_zero_of_card_ne_nine`,
`eq_zero_of_forall_normOne_eq`, `exists_maximal_card_nine`, `exists_maximal_conj_trivial` — each by the route of stage 1's
table, each elaborating at its first writing but for two names (`Pi.ringHom` is deprecated at the pin for `RingHom.pi`; the
sum minus one term is `Finset.sum_eq_sum_sdiff_singleton_add`). `lean1.sh`: exit 0, seven `sorry` left, no other message; 4.7 s,
3.9 GB. **Price, from these seven**: the plan's 250–400 lines for L3.2 came to 75 for the shared reduction and 20 for each
part; the remaining seven leaves are priced at about 250 lines together, L3.7 and L3.8 the long ones.

**Three private helpers** (none named by the plan beyond R):
- `exists_factor_functionals` — the plan's R, as stated in stage 1. `A ⧸ nilradical A ≃ₐ[A] Π_I A ⧸ I`
  (`IsArtinianRing.quotNilradicalEquivPi`) gives the surjection `π : A → Π_I A ⧸ I` with nilpotent kernel;
  `IsArtinianRing.isNilpotent_nilradical` gives one exponent; `l ∘ iterateFrobenius` descends along `π` by
  `AddMonoidHom.liftOfRightInverse`; the factor functionals are its composites with `AddMonoidHom.single`
  (`Finset.univ_sum_single`); a family of units lifts to an element outside every maximal ideal, a unit
  (`exists_max_ideal_of_mem_nonunits`).
- `quotientMap_involutive` — an involution's induced map on a quotient is an involution (read by L3.2, and by L3.8).
- `charP_quotient_of_isMaximal` — a residue field of a ring of prime characteristic `p` has characteristic `p`.

**What differed from the plan's text.**
- Hilbert 90 is not the cyclic-group argument: `w = a + t·σ a` satisfies `t·σ w = w`, and `w = 0` for every `a` forces
  `t = −1`, `σ = id`. Seventeen lines, no finiteness.
- FC3 takes `|k| = Q²`, `Q ≡ 3 (mod 4)` from `StandingFive.card_fixed_of_involution` (the lemma the plan asked to look for
  near `Arith/StandingFive.lean:1164`; it is at line 409), not from `involution_eq_pow`.
- FC2 reads no Hilbert 90: the group is the range of the homomorphism `y ↦ y / σ y` of `kˣ`.
- L3.3's "varying one coordinate" is `Function.apply_update` with `Finset.sum_update_of_mem`.

**Findings, and the coordinator's rulings.** Three statements of the skeleton carried a hypothesis their proofs never read.
I kept the skeleton's form, said so to the coordinator (two messages), and it ruled both times — the brief's Amendment 1
(2026-10-13 20:28 UTC) and Amendment 2 (20:32 UTC), on `main` at `4f3a5af87` and `d0f364a3f` — to drop them:

| statement | dropped | why the proof does not read it | consumer in this file |
|---|---|---|---|
| `exists_mul_conj_inv_eq_of_mul_conj_eq_one` | `[Finite k]` | the resolvent argument is for every field | FC3: an instance argument, the call is unchanged |
| `eq_zero_of_forall_normOne_eq` | `hσσ : ∀ x, σ (σ x) = x` | `{y / σ y}` is a non-trivial subgroup of `kˣ` for every endomorphism `σ ≠ id` | L3.3: one argument fewer |
| `exists_maximal_conj_trivial` | `hcc : ∀ x, c (c x) = x` | it read the involution only to pass it to the field case at 2; the shared reduction never reads it | L3.8 (not yet written): one argument fewer |

The three docstrings say what the statements now say ("every field: no finiteness is read"; "an endomorphism `σ ≠ id` … `σ` need
not be an involution"; "an endomorphism `c`"). `exists_maximal_card_nine` keeps `hcc`: Hilbert 90 and the count of the fixed field
both read it. Nothing else of the skeleton's statements moved. **The joining module**: its text
(`data/fs131/kn4/lean/ThreeFourColours.lean` on `fs131-wr2`) holds no call of any of the three yet — only the plan's J.2 cites
the first; a call `exists_mul_conj_inv_eq_of_mul_conj_eq_one σ hσσ hσ ht` at a finite residue field elaborates unchanged, the
dropped binder having been an instance argument. **It needs no change.**

**The statement check after the rulings** (`data/fs131/in1/statements.sh stage2`; `logs/statements-stage2.out`).
`statement_diff.py` now holds the three names in `WIDENED`: each **must** differ from the skeleton in its stored type — a
widened name that does not differ fails — and every other constant must be identical as before. Result: `PASS`, 17 named
constants compared, **3 of 3 widened, no other difference**, three new private theorems, no name outside the module's
namespace, 3 `example`s identical as text; control `4 of 4` (its first plant is one more statement changed: reported).
That each difference is a dropped hypothesis and nothing else is shown from the kernel's side by `widenings.py`: the
skeleton's form of each of the three — binders and conclusion copied by script from `git show 34d9113b2`, never retyped — is
an `example` proved by one application of the working module's theorem, appended to the candidate's copy: 0 errors. Its
control (one argument too few): 1 error, as it must.

## Stage 3 — SAVED: L3.4, L3.5, L3.6, L3.7, L3.9, L3.10 proved; one `sorry` left (L3.8)

`conj_mem_unitRing`, `exists_unitSet_mul_conjR_eq`, `comap_conjR_eq`, `finite_quotient_span_natCast`,
`fieldBandSet_two_nonempty_of_conj_trivial`, `exists_maximal_conj_trivial_of_colorable_two` — `lean1.sh`: exit 0, one `sorry`
(L3.8), no other message; 10.5 s, 3.9 GB. Statement check (`logs/statements-stage3.out`): `PASS`, the three widened by ruling
and nothing else; control `4 of 4`.

**Private helpers added** (ten): on unit vectors — `conjR_mem_unitSet`, `mul_conjR_of_mem_unitSet` (`u·ū = 1`),
`mul_mem_unitSet`, `one_mem_unitSet`, `neg_one_mem_unitSet`; `unitRing_induction` (the ring is the additive span of the unit
vectors, as an induction principle over `UnitRing.exists_sum_eq_of_mem_unitRingOver`); `half_ne_zero`, `toAddCircle_one_two`
(`1 ↦ 1/2`); `finite_quotient_span_prime` (L3.7 at a prime).

**What differed from the plan's text.**
- **L3.7 is not the plan's count of `N^d + 1` elements.** At a prime `p` the quotient `R/pR` is an `𝔽_p`-space
  (`AddCommGroup.zmodModule`) of dimension at most `[F(i) : ℚ]`: by `rank_le` it is enough that lifts `v` of an
  `𝔽_p`-independent finite family are independent over `ℤ` (then over `ℚ` by `LinearIndependent.iff_fractionRing ℤ ℚ`, and
  `LinearIndependent.fintype_card_le_finrank` counts them in `fieldI F`). An integer relation among the lifts reduces to an
  `𝔽_p`-relation, so `p` divides every coefficient; dividing, `pⁿ` divides every coefficient for every `n`
  (`Int.eq_zero_of_abs_lt_dvd`). Then `Module.rank_lt_aleph0_iff` and `Module.finite_of_finite`. A composite `N`:
  `Nat.recOnMul` with `Submodule.finite_quotient_smul` (`(ab) = (a)·(b)`). 60 lines for the prime, 17 for the rest.
- **L3.10** takes `2 ∈ J` from the unit vector `−1` (`(−1) − 1 = −2`), not from `i`.
- **L3.9**'s functional is `LinearMap.exists_leftInverse_of_injective` on `LinearMap.toSpanSingleton (ZMod 2) _ 1`, as the plan
  says; the module structure is `AddCommGroup.zmodModule`.

**One thing measured, for `LEAN.md`** (`data/fs131/in1/probes/rank.lean`): with a module structure introduced by
`letI : Module (ZMod p) M := AddCommGroup.zmodModule h`, `inferInstance : Module.Free (ZMod p) M` (and `Module.Finite`, and so
`Module.rank_lt_aleph0_iff.mp`) fails with "typeclass instance problem is stuck, it is often due to metavariables", the printed
problem holding no metavariable; with `haveI` in place of `letI` the same line elaborates. (My reading, not checked against the
elaborator's source: a candidate instance whose module structure does not match is unified against the `let`'s value, and
that unification is reported stuck where against an opaque hypothesis it would fail and the search go on.) A lemma that takes
its instances by unification (`LinearMap.exists_leftInverse_of_injective f`, `IsNoetherian.iff_rank_lt_aleph0.mpr h`) is not
affected.

## Stage 4 — SAVED: L3.8 proved; the file has no `sorry`; every declaration prints its axioms

`exists_maximal_of_torsion` — by the plan's "one fact about two predicates". `lean1.sh` on the module: exit 0, **no message at
all** (no `sorry`, no warning); 14.3 s, 4.0 GB. The file is 878 lines (the skeleton was 192).

**Eight private helpers** carry it, so that the theorem itself is fifteen lines and no `set`/`let` abbreviates a term a rewrite
must find:
- `two_part_eq_one_iff_three_part_eq_zero` — for `6τ = 0` and `τ u ∈ band 3`: with `3τ = toAddCircle ∘ m₂`, `2τ = toAddCircle ∘ m₃`,
  `m₂ u = 1 ↔ m₃ u = 0`. (`6x = n ∈ {2, 3, 4}`; `m₂ u = 0 ↔ 3x ∈ ℤ`, `m₃ u = 0 ↔ 2x ∈ ℤ`; `omega`.) The 3-part is taken as
  `2τ`, not the plan's `4τ`: either is killed by 3 and vanishes exactly where `τ u = 1/2`.
- `exists_quotient_hom` — an additive map into `ZMod p` descends to `R ⧸ (p)` (`AddMonoidHom.liftOfRightInverse`).
- `comap_quotientMap_conjR` — conjugation on a quotient of `ℤ[U_F]` fixes every ideal of it (L3.6 on the pull-back).
- `mk_eq_unit_mul_conj_inv` — `u·ā = a` and `a ↦ x` a unit give `u ↦ x / c̄ x`.
- `card_quotient_comap_mk` — pulling an ideal back along `R → R ⧸ I` keeps the quotient (`DoubleQuot.quotQuotEquivQuotOfLE`).
- `forall_unit_eq_one_or_forall_unit_ne_zero` — the fact: for ideals `I₂ ∋ 2`, `I₃ ∋ 3`, the lift `a = 3a₂ − 2a₃` and L3.5
  give `l₂ (x₂ / c̄ x₂) = 1 ↔ l₃ (x₃ / c̄ x₃) = 0` for every pair of units, so one predicate holds throughout. The case
  `a = 0` (both quotients trivial) is excluded inside it by the unit vector `1` — no separate "`τ 1 = 6·τ(1/6)`" step.
- `exists_maximal_conj_trivial_of_quotient`, `exists_maximal_card_nine_of_quotient` — the two ends: L3.3, L3.2 on a finite
  quotient by an ideal holding `2`, resp. `3` (non-trivial because the functional is not `0`; `ι` the class of `i`), and the
  ideal pulled back.

**The axioms, between builds** (`data/fs131/in1/axioms.sh source stage4`; the print `logs/axioms-stage4.txt`, the verdict
`logs/axioms-stage4.out`). `lean/AxiomsCore.lean` prints every declaration's axioms and, where `sorryAx` is among them, **the
leaves it comes from** (the library's constants reachable from the declaration whose own stored type or proof holds `sorryAx`);
`read_axioms.py` checks each record. 37 declarations (17 public, 20 private):
- 30 on the standard three alone;
- 6 rest on `HadwigerNelson.StandingFive.kloosterman_bound` and are exactly the listed ones — the plan's five
  (`targetFloor_four_weil`, `exists_normOne_zero_of_card_ne_nine`, `exists_maximal_card_nine`, `exists_maximal_of_torsion`,
  `exists_maximal_card_nine_of_colorable_three`) and the private `exists_maximal_card_nine_of_quotient`;
- 3 hold `sorryAx`, **each from upstream leaves that are `sorry` in this tree and from nothing of this module**:
  `exists_maximal_of_torsion` ← `TorsionExtraction.exists_zmod_hom_of_mem_torsionBy`;
  `exists_maximal_conj_trivial_of_colorable_two` ← `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty`;
  `exists_maximal_card_nine_of_colorable_three` ← those two, `TorsionExtraction.exists_torsion_mem_fieldBandSet` and
  `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable`.
Verdict `PASS`; control (four planted records: an undeclared axiom, Weil's bound under an unlisted name, a `sorry` sourced
inside this module, a `sorryAx` with no source) `4 of 4`. The check went red in earnest once before it passed: the first
version read a theorem's proof through `ConstantInfo.value?`, which is `none` for a theorem at the pin, so every source list
was empty and all three records failed as `SORRY UNSOURCED` — the stored proof is read by its constructor.

**Statement check** (`logs/statements-stage4.out`): `PASS` — 17 named constants, the three widened by ruling and no other
difference, 20 new private theorems, no name outside the module's namespace, the 3 `example`s identical; control `4 of 4`;
the widenings' control 1 error.

## Stage 5 — SAVED: the build, the statements and the axioms from the kernel's side, the models, the linters

**The one build** (`data/fs131/in1/build_sampled.sh logs/build1 8`, i.e. `scripts/build.sh` under `scripts/slot.py --mem 10
--cpus 4` with `MEMMAX=10G BATCH=8`; `data/fs131/in1/logs/build1.{out,err,peak}`; the gate's own copy
`build/gate/build/20261013T205359Z-890092.log`): **exit 0 — `OK — 248 of 248 batches, 37 module(s) rebuilt, 3 module(s) with
warnings, 9m54s`**. The three modules with warnings are the line's other three, still skeletons in this tree
(`Arith/ThreeColourCharacter` 8, `Arith/TorsionExtraction` 10, `Arith/DyadicQuadratic` 10 `declaration uses sorry`, and nothing
else). **`Arith/ThreeColourCriterion`: `✔ Built … (11s)`, no message of any kind** — the full log holds no line naming the file.
The other 33 rebuilt modules are what this tree's build of 2026-10-07 was behind by (`Plane/…`, `Outside/OAI158…`, `Proofs`).
Peak, summed over the build's process tree every 2 s: 12.3 GB — an upper estimate (pages of one `.olean` mapped by several
processes are counted once each), above the planner's 5.2 GB because here whole batches compiled at once; the 10 GB cap did
not fire. The build is Lake's: killed at any instant, the same command redoes only the modules not yet written.

**No statement changed but the three ruled, from the kernel's side.** `data/fs131/in1/dump.sh` prints every constant the
compiled module stores (kind, name, stored type, a definition's stored value). Before: `statements-before-wr2.txt`, from
`fs131-wr2`'s compiled skeleton, made in stage 1 (this tree never held a compiled skeleton). After:
`statements-after.txt`, from this tree's library after the build. `statement_diff.py` (`logs/statements-stage5.out`):
**`PASS` — 17 named constants compared (16 theorems, 1 definition); 3 of 3 widened by ruling differ, as they must; the other
14 identical character for character, `conjR`'s stored value included; 20 new private theorems; no new public name; names
outside `HadwigerNelson.ThreeColourCriterion`: 0** (so no equation lemma under another module's definition's name — the launch
note's point 1); the 3 `example`s identical as text. Control: four planted faults — one more statement changed, the
definition's value changed, a declaration removed, a generated lemma under `SpectralChain.unitRing`'s name added — `4 of 4`
reported. That each ruled difference is a dropped hypothesis and nothing else: stage 4's `widenings.py` examples (the
skeleton's own text, proved in one application), 0 errors, control 1 error.

**The axioms, from the built module** (`data/fs131/in1/axioms.sh compiled stage5`; print `logs/axioms-stage5.txt`, verdict
`logs/axioms-stage5.out`): the same 37 records as stage 4's print from the source, line for line — 30 on the standard three;
6 on Weil's bound, exactly the listed ones; 3 with `sorryAx`, each sourced to upstream leaves only (the table above). `PASS`;
control `4 of 4`.

**The models** (`data/fs131/in1/models.sh compiled stage5`; `logs/models-stage5.{txt,out}`): exit 0, no error, no `sorry` —
Hilbert 90 at `ℂ` with conjugation and `t = i`; the two-part at `𝔽₂`; the field case at 2 at `GaloisField 2 2` with its
Frobenius (`frobenius_ne_id`); `finite_quotient_span_natCast` at the standing field with `N = 2`. The two auxiliary theorems
print the standard three.

**The environment linters** (`lake lint --no-build -- --no-build --trace` under the slot; `logs/lint.out`): exit 0,
`-- Linting passed for Proofs.`, fourteen linters `Passed`, no line naming this module — `unusedArguments` among them, which
is the linter the three widenings would otherwise have met. I planted no fault in the house's linters (their controls are the
gate's); the build's own `linter.unusedVariables` did fire once on this file during the work (`hσσ` in the field case at 2,
stage 2), which is how the second finding was seen.

**Not run by this job**: `scripts/axioms.sh`, `scripts/dupnames.sh`, `scripts/vacuity.sh`, `scripts/assumptions.sh` — the
landing's, on the joined tree; this tree cannot pass them (three modules of the line are `sorry` here).

**What is left in this tree, to clean or keep**: the scratch farm `build/in1-farm/` (55 MB, gitignored, regenerable by
`data/fs131/in1/farm.sh`; no longer needed — `IN1_NOFARM=1` makes `lean1.sh` read the tree's own library). No process of
this job is running or queued.

## Drafts for the landing (saved with stage 5)

*This job ran no gate: no audit, no vacuity scan, no assumptions step, no `dupnames`. What follows is for the landing of the
three-and-four-colours line (`Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`, `Arith/ThreeColourCriterion`,
`Arith/DyadicQuadratic`).*

### 1. The audit block — `scripts/Axioms.lean`

`data/fs131/in1/audit-block.txt`: 17 records, one `#print axioms` line per public declaration a person typed (16 theorems,
the definition `conjR`), in the file's order, generated by `data/fs131/in1/make_audit.py` from the source, the kernel's list
of named constants and the axioms print — it fails if the source writes a public declaration the dump does not hold, or the
dump holds a named constant the source does not write.
- **CLEAN (12)**: `exists_mul_conj_inv_eq_of_mul_conj_eq_one`, `eq_zero_of_forall_normOne_eq`, `exists_maximal_conj_trivial`,
  `conj_mem_unitRing`, `conjR`, `coe_conjR`, `conjR_conjR`, `exists_unitSet_mul_conjR_eq`, `comap_conjR_eq`,
  `finite_quotient_span_natCast`, `fieldBandSet_two_nonempty_of_conj_trivial`, `exists_maximal_conj_trivial_of_colorable_two`.
- **IMPORTED (5)**, under `declareImport ``HadwigerNelson.StandingFive.kloosterman_bound`: `targetFloor_four_weil`,
  `exists_normOne_zero_of_card_ne_nine`, `exists_maximal_card_nine`, `exists_maximal_of_torsion`,
  `exists_maximal_card_nine_of_colorable_three` — the plan's list (`plans/FS131-KN5-three-four-colours-passes.md` § Stage 7),
  unchanged. `ARCHITECTURE.md` § Trust's consumer list for the import gains these five.
- **In this tree three of the seventeen also print `sorryAx`**, from upstream leaves only (stage 4's table; stage 5's print from
  the built module). On the joined tree, with the upstream modules proved, `exists_maximal_conj_trivial_of_colorable_two`
  reads CLEAN and the other two IMPORTED; `data/fs131/in1/axioms.sh compiled <tag> --no-sorry` is the check that then
  admits no `sorryAx` at all.
- The 20 private helpers cannot be named from `scripts/Axioms.lean`; each is read by a public record, and their own prints
  (by `collectAxioms` on the private names) are in the same print: 19 on the standard three, one
  (`exists_maximal_card_nine_of_quotient`, the `𝔽₃` end of `exists_maximal_of_torsion`) on Weil's bound.

### 2. A model for each hypothesis of the headlines

`data/fs131/in1/lean/ModelsBody.lean` (never part of the library) applies the module's theorems at named objects; its print
from the built module is `data/fs131/in1/logs/models-stage5.txt`. "Kernel" below means: an `example` there, or a declaration
of the library, exhibits every hypothesis at once.

| statement | hypotheses | model | does the kernel hold it? |
|---|---|---|---|
| `targetFloor_four_weil` | `Q % 4 = 3`, `14 ≤ Q` | `Q = 27` (the module's spec `example`: `27 % 4 = 3`; 14 is the least `Q` with `4√Q < Q + 1`) | yes. The conclusion's own binder — a field of `27²` elements with a non-trivial involution — is exhibited by no declaration (`GaloisField 3 6` with `x ↦ x²⁷`) |
| `exists_mul_conj_inv_eq_of_mul_conj_eq_one` | a field, an involution `σ ≠ id`, `t·σ t = 1` | `ℂ`, conjugation, `t = i` — a field that is not finite, which the widened statement now covers | yes (`ModelsBody`, with `conj_ne_id`) |
| `eq_zero_of_forall_normOne_eq` | a finite field of characteristic 2, an endomorphism `σ ≠ id`, `lam` constant `= e` on `{y/σ y}` | `𝔽₄ = GaloisField 2 2`, its Frobenius, `lam = 0`, `e = 0` (a non-zero `lam` is impossible there: `l(1) + l(ω) + l(ω²) = l(0)`) | yes (`ModelsBody`, with `frobenius_ne_id`) |
| `exists_normOne_zero_of_card_ne_nine` | a finite field of characteristic 3, an involution, `ι² = −1`, `σ ι = −ι`, not nine elements | the field of `27²` elements, `σ = (·)²⁷`, `ι` a square root of `−1` (`27 ≡ 3 (mod 4)`); `𝔽₈₁` is **not** a model (`ι ∈ 𝔽₉` is fixed by `x ↦ x⁹`) — the module docstring says both | **no**: named, exhibited by no declaration |
| `exists_maximal_card_nine` | a finite ring of characteristic 3, an involution fixing each maximal ideal, `ι`, `l` never `0` on `{x/c x}` | `𝔽₉ = 𝔽₃[i]`, conjugation, `l(x + yi) = x + y` (non-zero on `{±1, ±i}`); the conclusion holds there with `𝔪 = 0` | **no**: named in the module docstring, exhibited by no declaration |
| `exists_maximal_conj_trivial` | a finite ring of characteristic 2, an endomorphism fixing each maximal ideal, `l = 1` on `{x/c x}` | `𝔽₂`, the identity, `l = id` | yes (`ModelsBody`; the module's first spec `example` is its last hypothesis) |
| `conj_mem_unitRing`, `conjR`, `coe_conjR`, `conjR_conjR`, `comap_conjR_eq` | every `F : Subfield ℝ` | `F = ⊥` (the module's third spec `example`) | yes |
| `exists_unitSet_mul_conjR_eq` | `a ≠ 0` in `ℤ[U_F]` | `a = 1` at any `F` | yes (a condition on the parameter) |
| `finite_quotient_span_natCast` | `[NumberField F]`, `N ≠ 0` | the standing field `ℚ(√3, √11, η)` (`StandingFive.instNumberFieldStanding`), `N = 2`; `fieldOfRadicands {d}` once `fs131-wnf`'s instance is on the tree | yes, at the standing field (`ModelsBody`) |
| `exists_maximal_of_torsion` | `[NumberField F]`, `τ ∈ Θ₃(R_F) ∩ T₆` | first alternative: `F = ℚ(√2)`, `τ` the character of a two-colouring (`1/2` on unit vectors: in the band at 3, killed by 2); second: `F = ℚ(√3)`, `τ` from a three-colouring through L1.7 and L2.4 | **not in this tree**: at `ℚ(√2)` once `DyadicQuadratic.colorable_two_planeOver_sqrt` and `TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty` are proved; at `ℚ(√3)` once the joining module has its row at 3. At the standing field no such `τ` should exist (a point of `Θ₃` three-colours the plane, and `χ ≥ 5` there on Weil's bound) — said, not checked by a declaration here |
| `fieldBandSet_two_nonempty_of_conj_trivial` | a maximal ideal of `ℤ[U_F]` modulo which conjugation is the identity | the ideal `exists_maximal_conj_trivial_of_colorable_two` produces at `F = ℚ(√2)` | **not in this tree** (the same two upstream leaves) |
| `exists_maximal_conj_trivial_of_colorable_two` | `F²` two-colourable | `F = ℚ(√2)` (`DyadicQuadratic.colorable_two_planeOver_sqrt`, downstream of this module) | **not in this tree** |
| `exists_maximal_card_nine_of_colorable_three` | `[NumberField F]`, `F²` three-colourable and not two-colourable | `F = ℚ(√3)`: `χ = 3` (`[Fischer1990]` Thm 9) | **not in this tree**: "not two-colourable" is `TorsionExtraction.not_colorable_two_of_sqrt_mem` at `d = 3` (a leaf); "three-colourable" is on `fs131-wnf` (the prime above 3 of residue field `𝔽₃`, `UpperHalf.colorable_planeOver_of_finitePlane`). The landing of the joined tree names the declaration |

By the planner's reading (`plans/FS131-KN4-three-four-colours-plan.md` § 4.6) the vacuity scan tracks none of these hypotheses
(sets and maps under predicates it does not read); this job did not run the scan. The table is then the evidence, and six of
its rows are "named, not held": two for want of a declaration exhibiting a finite field or ring, four until the join.

### 3. What a reader of the statements should be told that the docstrings do not say

1. **Whose each value is.** The direction proved here — a three-colouring of the plane over a real number field gives a prime
   with residue field `𝔽₃`, as far as a maximal ideal of `ℤ[U_F]` with nine elements in its quotient — is this project's
   (FS91-J02-T2, `[hand; three derivations]` before this module; not found in print; `[Fischer1990]` §1 poses the question),
   and it rests on **one declared outside theorem**, Weil's bound for Kloosterman sums (`[Weil1948]` p. 207), read at exactly
   one place: `targetFloor_four_weil`, through the field case at 3. The two-colour end
   (`exists_maximal_conj_trivial_of_colorable_two` with its converse `fieldBandSet_two_nonempty_of_conj_trivial`) is an
   elementary restatement of "no odd closed walk" in the ring's words, at every subfield of `ℝ`; read at a real number field
   through the joining module's dictionary it is the ⟹ of the two-colour classification, **an outside model's theorem**
   (GPT Astra's Thm 2.1; second derivation FS91-J02-A21p): not claimed as this project's. The values 2 and 3 of the quadratic
   table and every upper bound are Fischer's and Johnson's (`[Fischer1990]`, `[Johnson2000]`) and are not in this module at
   all. Hilbert's Theorem 90 for a quadratic extension is classical; the proof here is the textbook resolvent.
2. **Three statements are wider than the skeleton's**, by the coordinator's rulings of 2026-10-13 (the brief's Amendments 1
   and 2; `data/fs131/claims-NF4.md`'s two dated lines): Hilbert 90 for every field; the field case at 2 and the two-part for
   an endomorphism that need not be an involution. The three-part keeps "involution": its proof reads it twice.
3. **"As far as the ring."** `exists_maximal_card_nine_of_colorable_three` ends at a maximal ideal of `ℤ[U_F]`, which is not
   the ring of integers of anything and need not be Noetherian. That the ideal is cut out by a conjugation-stable prime of
   `F(i)` with `𝓞/𝔓 = 𝔽₉`, so that `𝔓 ∩ F` has residue field `𝔽₃`, is the joining module's (its J.1, J.3) and is not in this
   file.
4. **The two alternatives of `exists_maximal_of_torsion` are decided by `τ`, and the statement does not say which.** The proof
   shows more than the disjunction: the 2-part of `τ` is `1` on every `x/c̄ x` of `R/2`, or the 3-part is non-zero on every
   `x/c̄ x` of `R/3` (`forall_unit_eq_one_or_forall_unit_ne_zero`, private). A field may have ideals of both kinds; a given
   `τ` selects one.
5. **`finite_quotient_span_natCast` is not a statement about `𝓞_F`.** `ℤ[U_F]` holds `1/5` (and `1/n` for many `n`), so some
   quotients are the zero ring — still finite. The proof's bound, `dim_{𝔽_p} R/pR ≤ [F(i) : ℚ]`, is not stated.
6. **`targetFloor_four_weil`'s `14 ≤ Q` is where `4√Q < Q + 1` begins, not where four colours begin.** The statement says
   nothing about `Q = 3, 7, 11`; the criterion needs `Q = 3ᶠ ≥ 27`, `f` odd.
7. **`exists_unitSet_mul_conjR_eq` is the easy direction** (`a/ā` has norm one); the planner renamed it for that reason. Its
   name's `unitSet` is the set of unit vectors, not the group of units.

### 4. For the join

- **The joining module's call site needs no change** (the brief's Amendment 1 asks): its text
  (`data/fs131/kn4/lean/ThreeFourColours.lean` on `fs131-wr2`) holds no call of any of the three widened leaves; the plan's
  J.2 cites `exists_mul_conj_inv_eq_of_mul_conj_eq_one`, and a call `… σ hσσ hσ ht` at a finite residue field elaborates
  unchanged, the dropped binder having been an instance argument. J.2's own statement may keep its finiteness.
- **Names.** No public name was added, removed or renamed; the 20 helpers are private (`_private.…` names, which cannot meet
  another module's); the module declares no constant outside `HadwigerNelson.ThreeColourCriterion` (stage 5, from the built
  module) — in particular no equation lemma under another module's definition's name: no `simp [f]` unfolds an upstream
  definition anywhere in the file (`Subring.closure_le.mpr` as a term unifies through `unitRing F` with no unfolding tactic).
- **The statement check on the joined tree**: `data/fs131/in1/dump.sh <library> <out>` then
  `statement_diff.py data/fs131/in1/statements-before-wr2.txt <out>` — expected: the three `WIDENED`, nothing else.
- **`ARCHITECTURE.md` § 3, the row `Arith/ThreeColourCriterion`** — replace the words "(FS131-KN4, passes FS131-KN5; a
  skeleton: thirteen leaves are `sorry`)" by "(statements FS131-KN4's and FS131-KN5's, three of them widened by ruling; the
  thirteen leaves' proofs FS131-IN1's)". Nothing else in the row changes: no import was added, no public declaration added
  or removed.

### 5. Lines for `LEAN.md` § Searching — Lean

- A module structure introduced by `letI : Module (ZMod p) M := AddCommGroup.zmodModule h` makes instance search for
  `Module.Free (ZMod p) M` and `Module.Finite (ZMod p) M` fail as "typeclass instance problem is stuck, it is often due to
  metavariables" (the printed problem holds none); with `haveI` the same line elaborates. Use `haveI` unless a proof must
  unfold the action; a lemma that takes its instances by unification is not affected (`data/fs131/in1/probes/rank.lean`;
  FS131-IN1).
- `ConstantInfo.value?` is `none` for a theorem at the pin: a tool that walks proofs reads `.thmInfo v => v.value`
  (`data/fs131/in1/lean/AxiomsCore.lean`, which names the leaf each `sorryAx` comes from; its first version found no source
  for any, and the check was red until it did) (FS131-IN1).
- A worktree cut for one module of a line may hold no `.olean` of the line's upstream modules: `lake env lean` then stops at
  the first import. Without a build: real copies of the import closure's `.olean`s from the tree that built the skeleton,
  the modules whose source differs recompiled into the copy from this tree's source with `lean -o`, and `lean` run with that
  directory in front of Lake's path with the tree's own library taken out (`data/fs131/in1/farm.sh`, `lean1.sh`) (FS131-IN1).
- At the pin: `Pi.ringHom` is deprecated for `RingHom.pi`; a sum minus one term is `Finset.sum_eq_sum_sdiff_singleton_add`;
  `AddSubmonoidClass.coe_finset_sum` is deprecated for `AddSubmonoidClass.coe_finsetSum`; `Cardinal.nat_lt_aleph0` for
  `Cardinal.natCast_lt_aleph0`. A finite ring's residue fields: `IsArtinianRing.quotNilradicalEquivPi` is an `A`-algebra
  equivalence, so `e (mk a) = fun I => mk a` is `e.commutes a`. "Finite rank over `ℤ`, so `M/NM` is finite" has no single
  lemma: at a prime `rank_le` over `ZMod p` with `LinearIndependent.iff_fractionRing ℤ ℚ`, and
  `Submodule.finite_quotient_smul` for a product (FS131-IN1).

## Drafts for the front page

This job filed no ledger row and ran no gate; the counts for `CLAUDE.md` § The gate and § Trust ledger are the landing's.
What this module changes when the line lands, for whoever drafts those lines:
- **Trust ledger** — the import `StandingFive.kloosterman_bound` gains five imported records from this module (§ 1 above);
  no new axiom, no native evaluation, no hypothesis former.
- **`LEDGER.md` row 99** (the planner's draft, `plans/FS131-KN4-three-four-colours-plan.md` § 4.8, stands): its ⟹ — a
  three-colouring gives a prime of residue field `𝔽₃` — is, as far as the ring `ℤ[U_F]`, the declaration
  `ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three`, kernel-checked in this tree on the standard three,
  Weil's bound and four upstream leaves that are `sorry` here; it is [kernel] on one declared outside theorem only when those
  leaves and the joining module's J.1, J.3 are. Until then its grade does not move.
- **Frontier, Proof Atlas** — nothing from this job alone.
