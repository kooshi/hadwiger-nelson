# Theorem A in the kernel — the general residue colouring (subplan)

*Opened 2026-09-08 by Opus 5, on Kooshi's go, from `plans/STUB-theorem-A-kernel.md`. Branch
`backlog`. The stub's §3a fork is settled: generality is the objective, and the first action was the
reading it registered. This subplan records what that reading found and the shape it forces.*

## 0. What is to be proved

`plans/FIELD-WALL-THEOREM.md` §5.1, Theorem A:

> Let `F ⊂ ℝ` be a number field, `L = F(i)`, and `𝔭` a nonzero prime of `O_L` fixed by complex
> conjugation. Then the unit-distance graph on `F²` is properly colourable with `N(𝔭)` colours.

The stub's §3a ladder put the interesting rung at 4 — drop `ℂ`, distance and geometry entirely.
**This subplan targets rung 4 and reaches rung 2's mathematics on the way**, by replacing the
number theory with the two properties the proof actually uses.

## 1. What the registered reading found

The stub's first instruction: read `LocalGlobal.addCayleyMap`/`addCayleyColoring`,
`Additive.additiveColoring`, `UnitQuadrance` before writing any statement, and decide whether A1 is
nearly free from them or whether they already are the general theorem with the norm-one condition
missing. Read 2026-09-08. **Neither.** They are three different theorems and none of them is this
one:

| existing | what it says | why it is not A1 |
|---|---|---|
| `Additive.additiveColoring` | a hom `V →+ G` nonzero on every edge difference colours a graph on the group `V` | the hom is **total**; A1's residue map is defined only on a subring `A`, and the whole difficulty is that the plane is not `A` |
| `LocalGlobal.addCayleyMap` / `colorable_of_addCayleyMap` | a hom whose kernel misses the connection set maps one Cayley graph to another | again total, and it is a **quotient** statement (fewer vertices), not a coset-representative statement |
| `LocalGlobal.addCayleyColoring` | a table proper along the connection set colours the Cayley graph | a restatement of properness; no algebra |
| `UnitQuadrance.unitQuadrance.map` | a ring hom applied coordinatewise is a graph hom | M58's functoriality — a **different mechanism** (the finite-plane bound), not the residue colouring |

So the work is not free. But the reading pays anyway, because it names the exact gap:
`additiveColoring` is the case `A = ⊤` of the theorem to be written, and the general theorem is
`additiveColoring` with the homomorphism made **partial**. That single change — a hom out of a
subgroup instead of the whole group — is what forces the coset representatives, and it is the whole
content of B1's §8.

## 2. The theorem, in the shape the proof forces

Stripped to what B1's §8 uses, with no `ℂ`, no distance, no ring, no Cayley structure:

> **A graph drawn in an abelian group, all of whose edge differences lie in a subgroup `A` and are
> nonzero under a homomorphism `ψ : A →+ G`, is `|G|`-colourable.**

Choose one representative per coset of `A`; colour a point by `ψ` of its offset from its own
representative. Adjacent points differ by an element of `A`, so they share a representative, so
their colours differ by `ψ` of the edge difference, which is nonzero.

That is rung 4 and past it: the Cayley structure is gone too — the theorem never asks that the
edge set be translation-invariant.

The arithmetic then enters as a *sufficient condition for the two hypotheses*, in three layers:

1. **The unit layer** (replaces "the residue field is a field, so units are nonzero"): if `A` is a
   subring of a commutative ring `L` stable under `σ : L →+* L`, and `u ∈ A` satisfies
   `u · σu = 1`, then `u` is a **unit of `A`**, so its image under any ring hom to a nontrivial
   ring is nonzero. The norm-one condition's entire role.
2. **The integrality layer** (replaces `v_𝔭(u) = 0`): if `L` is a field, `σ` an involution and `A`
   a **valuation subring** stable under `σ`, then every norm-one element lies in `A` — because
   `u · σu = 1` makes `u` a unit of `L` with `u⁻¹ = σu`, and a valuation subring holds `u` or
   `u⁻¹`; in the second case `σ(σu) = u ∈ A`. Two lines, and it is Theorem A's arithmetic step
   with the Dedekind theory deleted. Mathlib's `ValuationSubring` is exactly this hypothesis
   bundled (`mem_or_inv_mem`).
3. **The plane layer**: `dist z w = 1` in `ℂ` is `(z − w) · conj(z − w) = 1`, so A1 as the stub
   stated it is the specialization at `L = ℂ`, `σ = starRingEnd ℂ`.

**Why this is more general than the write-up's Theorem A, and not less.** The write-up's hypotheses
(number field, `L = F(i)`, prime `𝔭` with `𝔭̄ = 𝔭`) enter only to produce a σ-stable valuation
subring with a finite residue field. Layer 2 takes that object as the hypothesis. Everything the
write-up proves follows; nothing it proves is lost; and the statement now also covers B1's `A`,
which is **not** a valuation ring (it is the intersection of the two, one per prime above `2`) and
so is outside the write-up's own statement.

## 3. Module layout

New module `Proofs/HadwigerNelson/ResidueColouring.lean`, imported by `FieldWall4.lean`.

| § | content |
|---|---|
| 1 | `cosetRep`, `sub_cosetRep_mem`, `cosetRep_eq_of_sub_mem`; `residue ψ`, `residue_sub` |
| 2 | `residueColoring` (a `Γ.Coloring G`), `colorable_of_residue` (the numeral form) |
| 3 | `normOne σ`; `isUnit_of_mem_normOne`; `colorable_of_normOne`; `ValuationSubring` bridge |
| 4 | the plane: `colorable_unitDistance_induce_of_subring` — A1 as the stub stated it |
| 5 | the ring-free corollary at `unitQuadrance R`; `additiveColoring` recovered as `A = ⊤` |
| 6 | spec: a model of the hypotheses, the grid, and the planted reds |

Then `FieldWall4.lean` is **cut back**: its §8 colouring machinery (`mk_surjective`, `base`,
`mk_base`, `sub_base_mem`, `base_eq_of_sub_mem`) is deleted, `psiOf` is replaced by a bundled ring
hom `psiA : oddDenom →+* F4`, `psiOf_ne_zero_of_unit` is replaced by the unit layer (which needs a
new six-line `conj_mem_oddDenom`), and `colorable_four_of_subset_seamPlane` becomes an application
of §4. Every name registered in `scripts/Axioms.lean` survives — none of the deleted ones is there.

## 4. Decisions

| # | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| D1 | the drawn-graph form `f : V → M`, not a Cayley graph on `M` | state it for `addCayley S` only | `induce` (what B1's headline is) has vertex type `↥S`, not a group; `f` covers both and costs nothing | high |
| D2 | hypothesis as `∃ a : A, (a : M) = f v − f w ∧ ψ a ≠ 0` | a dependent pair `∃ h : _ ∈ A, ψ ⟨_, h⟩ ≠ 0`, or two separate hypotheses | one quantifier, no dependent-pair juggling at the call site, and it reads as "the difference lies in `A` with nonzero residue" | medium — if consumers find it awkward, split into `hmem`/`hne` at the ring layer only |
| D3 | `ψ : A →+ G` bundled out of a subgroup | a junk-extended total `ψ : M → G` with an additivity hypothesis (B1's `psiOf`) | the bundled hom composes, carries `map_zero`/`map_add` free, and makes the unit layer one `IsUnit.map` | high |
| D4 | `ValuationSubring` for layer 2 | an explicit `∀ z w, z * w = 1 → z ∈ A ∨ w ∈ A` hypothesis | Mathlib's bundled object is the same hypothesis and brings its own API; the unbundled form is stated too, as the primitive | high |
| D5 | refactor `FieldWall4` rather than leave it | keep both proofs | the stub called the re-derivation the honest test of the abstraction; two copies of one argument is the thing the standard forbids | high |
| D6 | do **not** move `Quad` out of `FieldWall4` | move it, so `R[i]` is available and `unitQuadrance R` becomes an instance | the `unitQuadrance` corollary is available at the **group** level with no ring structure on `R × R`, which is all a consumer needs; moving `Quad` is file surgery that buys a decoration | medium — revisit if a consumer wants the norm-one form over a general ring |

## 5. Registered predictions (scored at the close)

* **P1** — the general theorem plus its three layers lands under 300 lines.
* **P2** — the `FieldWall4` refactor is a net **deletion** (its line count falls).
* **P3** — `additiveColoring` is recoverable as the `A = ⊤` case in under ten lines.
* **P4** — `Subring.toAddSubgroup` coercion friction: `↥A.toAddSubgroup` will *not* be transparently
  `↥A` at the call site, and an explicit `AddMonoidHom` will be needed. (Registered because the
  opposite would save ten lines and I do not know which holds.)
* **P5** — the number-field instantiation (§6, phase 3) will need `IsFractionRing`,
  `IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, an automorphism fixing the prime,
  and finiteness of the residue field; the σ-stability step is where it stalls if it stalls.
* **P6** — no existing proof in the repository breaks except inside `FieldWall4.lean`.

## 6. Phases and the stop rules

* **Phase 1** — `ResidueColouring.lean`, §§1–6. Unconditional.
* **Phase 2** — the `FieldWall4` refactor. Unconditional; it is the test of Phase 1.
* **Phase 3** — the number-field instantiation (rung 2). **Stop rule, carried from the stub and
  hardened: one attempt, ~150 lines. If the σ-stability of `valuationSubringAtPrime` under a ring
  automorphism fixing the prime is not available within that budget, stop and report Phase 3 as
  not landed, naming the exact missing statement.** Phases 1–2 are the milestone either way; Phase
  3 is the literature-facing instantiation and the ladder's own analysis prices it at "nothing new"
  (§3a rung 3).
* Standing rules (`plans/BACKLOG-FOR-OPUS.md`): never `lake build` — `./scripts/build.sh`; one
  heavy job at a time; HALT on any unexplained crash; register every new headline in
  `scripts/Axioms.lean`; results into `plans/STUB-theorem-A-kernel.md` as `## §B. Built`; do not
  touch `CLAUDE.md` § Frontier / § Grokkings or the frontier-set ranking.

## 7. Domain-modeling pass (2026-09-08)

### M1. What the object actually is

The skeleton had `residue ψ x = ψ ⟨x − cosetRep A x, _⟩` with `cosetRep` an arbitrary section of
`M ⧸ A`. Simulating it: what is `residue ψ` characterized by? A function `Ψ : M → G` with
`Ψ x − Ψ y = ψ (x − y)` whenever `x − y ∈ A` is exactly "ψ, translated by an arbitrary constant on
each coset". So `residue ψ` is one witness of an existence statement, and the *property* is what
every consumer travels — which is why the definition must be sealed and the property stated.

### M2. The one change that dissolved the subtypes

Nothing forces the section to be arbitrary. **Normalize it: send the zero coset to `0`**
(`cosetRep A x = if x ∈ A then 0 else surjInv …`; the patched section still satisfies
`cosetRep_eq_of_sub_mem`, because `x − y ∈ A` makes `x ∈ A ↔ y ∈ A` and both branches agree).
Then

* `residue ψ` **restricts to `ψ` on `A`** (`residue_apply_of_mem`), so `residue ψ 0 = 0`; and
* `residue_sub` states with no subtype at all: `residue ψ x − residue ψ y = residue ψ (x − y)`
  whenever `x − y ∈ A` — a conditional `map_sub`.

The consequence is the whole point. The skeleton's hypothesis was
`∃ a : A, (a : M) = f v − f w ∧ ψ a ≠ 0` — one quantifier hiding a membership, an equation and a
value condition, and every use site opening with a `▸` to recover the membership. It is replaced by
**two independent, non-dependent, subtype-free hypotheses**:

```lean
(hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
(hne  : ∀ ⦃v w⦄, Γ.Adj v w → residue ψ (f v - f w) ≠ 0)
```

**D2 is superseded**: the existential shape was incidental structure — an artifact of an
un-normalized section — not the mathematics. The mathematics is "the difference lies in `A`, and its
residue is nonzero", and with the normalization both clauses are statements about `M`, not about
`↥A`.

### M3. The reframes walked, and what each returned

* **Function or relation, data or proof.** `residue ψ : M → G` stays a `def` (sealed) rather than an
  existence statement, because `FieldWall4` needs a *named colour function* to carry its two
  theorems (`residueColouring_ne_of_dist_one`, `_eq_of_dist_two`). The property is `residue_sub`.
* **Subgroup pair instead of a homomorphism?** The statement "`K ≤ A ≤ M`, every edge difference in
  `A \ K`, therefore `[A : K]`-colourable" is strictly sharper (it gives the index, not `card G`).
  Rejected: every consumer here *has* a hom and would have to compute an index and prove
  surjectivity to use it. The hom form is the usable one; the sharper count is noted in the
  docstring and not claimed.
* **`SetLike` + `AddSubgroupClass` instead of `AddSubgroup M`?** It would remove the
  `Subring.toAddSubgroup` conversions at the two ring-layer call sites. Rejected as speculative
  generality — and the probe run during this pass says the conversions are nearly free: `↥A` and
  `↥A.toAddSubgroup` are transparently the same type, `ψ.toAddMonoidHom` feeds `residue` with no
  wrapper, and membership transfers by `rfl`, for `Subring` and `ValuationSubring` alike. The one
  residual friction is that the subgroup cannot be *inferred* from the hom (`↥?A ≡ ↥A` is
  higher-order), so it must be written `residue (A := A.toAddSubgroup) ψ.toAddMonoidHom`. That
  killed a planned `ringResidue` wrapper and its four mirrored lemmas: the ring layer's public
  statements (`colorable_of_normOne`, `colorable_of_valuationSubring`, both plane forms) mention no
  residue map at all, so the annotation is written exactly once, in `FieldWall4`'s own definition of
  its colouring.
* **`normOne σ` as a `Submonoid`?** It is one (closed under multiplication, contains `1`). No
  consumer needs the closure, so it stays a plain `Set L`. It keeps its *name* because it is the
  noun in three statements — "every norm-one element lies in `A`", the valuation bridge, and the
  plane bridge `dist z w = 1 ↔ z − w ∈ normOne (starRingEnd ℂ)`.
* **Which recursor?** None: the theorem has no induction. The only recursion in the whole item is
  `FieldWall4`'s existing descent, which is not touched.

### M4. Seams

* **Model of the hypotheses (non-vacuity).** Needed with a *genuinely partial* `ψ` — one that does
  not extend to `M` — or the theorem is `additiveColoring` in disguise. Spec model: `M = ℤ`,
  `A = range(x ↦ 2x)`, `ψ : A →+ ZMod 2` halving; no extension exists (`2 · φ 1 = 1` is unsolvable
  in `ZMod 2`), and the graph "differ by 2" is 2-coloured by it. `FieldWall4` is the second and
  real model.
* **Unsampled members.** `A = ⊥`: `hmem` forces `f v = f w` on edges and then `residue ψ 0 = 0`
  contradicts `hne` — so the hypotheses are simply unsatisfiable for a graph with an edge, which is
  correct. Empty `V`, edgeless `Γ`: fine, and `Fintype.card G ≥ 1` because `G` holds `0`.
  Non-injective drawings: excluded at exactly the edges, by the same route.
* **Adversarial member.** The conclusion `Colorable (Fintype.card G)` is weaker than the truth
  (`[A : ker ψ]` colours suffice). Deliberate, stated, and irrelevant to every consumer here, all of
  which have a surjective `ψ` onto a field.
* **Reds planted.** `hne` is load-bearing (the triangle drawn at `0, 1, 2` in `ℤ` with the parity
  hom: `residue (0 − 2) = 0`, and a triangle is not 2-colourable); `Nontrivial G` is load-bearing at
  the ring layer (a graph with an edge is not 1-colourable).

### M5. Next-theorem test, run before consulting the model

Named in advance: *"two points differing by an element of `A` with zero residue get the same
colour"* — `FieldWall4`'s distance-2 statement, and the first thing any future consumer will want.
It states in the existing vocabulary and proves in one line
(`residue_eq_of_eq_zero`, from `residue_sub` and `sub_eq_zero`). The model earns it.

## 8. Obligation-modeling pass (2026-09-08)

### O1. The space has no induction in it

Every obligation in the new module is a **case split** or an **equational derivation**; there is no
recursion anywhere. The one induction in the whole item is `FieldWall4`'s existing `oddDenom_aux`
descent (strong induction on the denominator), which this milestone does not touch. So the space is
characterized by writing the case tables, not by choosing a recursor — and the only design question
is *where the case splits live*.

### O2. The one derivation that moved a case split off a two-element lemma

The domain pass's normalization (`cosetRep A x = 0` for `x ∈ A`) buys subtype-freedom, but it
threatens to cost a four-case proof of the agreement lemma
`cosetRep A x = cosetRep A y` (two live cases, two impossible by `x ∈ A ↔ y ∈ A`). Read as a report:
the case split is on `x` and on `y` separately, and the statement is about *one* coset — so the
split is in the wrong place.

**Move the normalization into a section of the quotient, not of the group.**

```lean
private noncomputable def sect (A : AddSubgroup M) (q : M ⧸ A) : M :=
  if q = 0 then 0 else Function.surjInv (mk_surjective A) q
private def cosetRep (A : AddSubgroup M) (x : M) : M := sect A (QuotientAddGroup.mk' A x)
```

Now the case split is a one-element lemma — `sect_spec : mk' A (sect A q) = q`, two cases — and the
agreement lemma is **`congrArg (sect A)`**, one line, because `x − y ∈ A` says exactly that the two
arguments are the same quotient element. Back's corollary: shape the definition around the
statement, and the statement keeps its one-line proof.

### O3. The dependent-rewrite hazard in `residue_sub`, and where it dies

`residue ψ x − residue ψ y = residue ψ (x − y)` is proved by rewriting `cosetRep A y` to
`cosetRep A x` — but that term appears inside a *membership proof* (`⟨y − cosetRep A y, _⟩`), which
is the classic "motive is not type correct". The fix is to never rewrite there: apply
`← map_sub` first, so the goal is an equation between two elements of `↥A`, then `Subtype.ext`
**strips both proofs**, leaving `(x − cosetRep A x) − (y − cosetRep A y) = x − y` in `M`, where the
agreement lemma is an ordinary `rw` and `abel` closes. No `▸`, no `Eq.mpr`, no motive.

### O4. The case tables, and the local obligation of each

| obligation | shape | size |
|---|---|---|
| `mk_surjective` | `Quot.exists_rep` | 1 line |
| `sect_spec` | 2 cases (`q = 0`: `mk 0 = 0`; else `surjInv_eq`) | 4 |
| `sect_zero`, `cosetRep_of_mem` | `if_pos`, `QuotientAddGroup.eq_zero_iff` | 2 each |
| `sub_cosetRep_mem` | `sect_spec` + `QuotientAddGroup.eq` | 3 |
| `cosetRep_eq_of_sub_mem` | `congrArg (sect A)` | 1 |
| `residue_apply_of_mem` | `cosetRep_of_mem` + `sub_zero` under `Subtype.ext` | 3 |
| `residue_sub` | O3 above | 5 |
| `residue_ne` / `residue_eq` | `residue_sub` + `sub_self` / `sub_eq_zero` | 2 each |
| `colorable_of_residue` | `Coloring.mk … |>.colorable` | 1 |
| `colorable_of_additive` | `A = ⊤`, `f = id`, `residue_apply_of_mem` | 8 |
| `isUnit_of_mem_normOne` | `isUnit_of_mul_eq_one _ _ (Subtype.ext h)` | 2 |
| `apply_ne_zero_of_mem_normOne` | route through `isUnit_of_mem_normOne`, then `exists_right_inv` and `0 = 1` | 4 |
| `mem_of_mem_normOne` | 2 cases; the second is `hσ` then `hσσ` | 4 |
| `ValuationSubring.mem_of_mem_normOne` | `mem_or_inv_mem` + `w = z⁻¹` from `z * w = 1` | 6 |
| `colorable_of_normOne` | `colorable_of_residue` + `residue_apply_of_mem` | 5 |
| `colorable_of_valuationSubring` | 1 application | 2 |
| `mem_normOne_conj_iff`, `sub_mem_normOne_conj_iff` | `Complex.mul_conj`, `sq_norm`, `dist_eq` | 8 |
| the two plane forms, `colorable_unitQuadrance_of_residue` | 1–6 lines each | 12 |

Nothing above needs a walkthrough, which is the terminal test met: each statement's proof is its own
transcription.

### O5. A hypothesis deleted before it was written

`apply_ne_zero_of_mem_normOne` can be proved *without* `isUnit_of_mem_normOne` — apply `ψ` to
`u · σu = 1` directly and read `0 = 1`. That would leave `isUnit_of_mem_normOne` unused, which the
ugliness catalog calls dead weight. Resolution: keep the lemma, because it **is** the mechanism
("a norm-one element is a unit of `A`") and a consumer may want it, and route the nonzero-ness
through it so it is load-bearing rather than decorative. The cost is two lines (`exists_right_inv`,
`0 = 1`) instead of one.

### O6. The `FieldWall4` refactor, as obligations

* **new** `conj_mem_oddDenom` (~6 lines): `den (conj x) = starRingEnd (den x)` is `den_conj`, and
  the odd `m` is real, so `map_intCast` carries it.
* **new** `psiAFun` / `psiAFun_eq` / `psiA : oddDenom →+* F4` / `psiA_eq` (~45): `psiAFun_eq` is
  B1's `psiOf_eq` verbatim; each of the four ring-hom fields is one witness through it
  (`m = 1, x = 1`; `m = 1, x = 0`; `mn` with `n·x + m·y`; `mn` with `x·y`), with
  `F4.intCast_odd` killing the `m`s. Defining the function first and bundling second is what avoids
  the circularity of stating `psiA_eq` about a hom whose fields need it.
* **deleted** (~70 lines): `psiOf`, `psiOf_eq`, `psiOf_sub`, `psiOf_ne_zero_of_unit`,
  `mk_surjective`, `base`, `mk_base`, `sub_base_mem`, `base_eq_of_sub_mem`.
* **rewritten**: `residueColouring := residue (A := oddDenom.toAddSubgroup) psiA.toAddMonoidHom`;
  `residueColouring_ne_of_dist_one` from `residue_ne` + `apply_ne_zero_of_mem_normOne` (15 lines →
  6); `residueColouring_eq_of_dist_two` from `residue_eq` + `psiA_eq` (25 → 12);
  `colorable_four_of_subset_seamPlane` as one application of the plane form (9 → 6).
* **survives untouched**: the descent (`oddDenom_aux`, `mem_oddDenom_of_unit`), `psi_comp_conj` and
  `psiZero_conj` (still the descent's engine), `norm_eq_of_den`, and every name in
  `scripts/Axioms.lean` — none of the deleted ones is registered.

### O7. Validation, decorrelated from the generator

* **Mutation audit, registered now and run at the close.** Each of these must break the proof:
  drop `hσσ` from `mem_of_mem_normOne`; drop `hσ` from `apply_ne_zero_of_mem_normOne`; drop
  `Nontrivial G`; drop `h : x − y ∈ A` from `residue_sub`; drop `hmem` from `colorable_of_residue`.
* **Non-vacuity**: the `twoStep` model with a genuinely partial `ψ` (halving on the even integers),
  and `FieldWall4` as the second, real model.
* **The end-to-end test already in the repository**: `FieldWall4`'s spec example
  `residueColouring 0 = residueColouring 2` now runs through the *new* mechanism, and its `#guard`s
  on `psiZero` are untouched — so the refactor is checked by tests written before it.
* **Prove / test / assume**: everything in §§1–5 is proved; the model and the two reds are tests;
  nothing is assumed — no axiom, no `native_decide`, no new trust.

## 9. Experience-modeling pass (2026-09-08)

### E1. Who consumes this, and what they hold

| consumer | what they hold at the moment of use | what they need from the surface |
|---|---|---|
| a future milestone colouring a plane over a field | a set of points and a hunch that "the residue method applies" | the exact triple they must produce, as a numbered recipe |
| a reader auditing the ledger claim | the write-up's Theorem A (number field, prime `𝔭`, `N(𝔭)` colours) | how the formal statement relates to it — **and what is not proved** |
| `FieldWall4` | a subring, a ring hom, and a descent | `residue_apply_of_mem`, `residue_eq_iff`, and the plane entry point |
| `exact?` | statement shapes | *nothing* — the colour count `Fintype.card G` is an input, not determined by the goal, so no search can find these theorems. **Discovery is the module docstring's job**, which is why "Using this file" is a five-step recipe naming a lemma at each step. |

### E2. The honesty clause, written into the module

A stated theorem arrives with total authority, so the docstring says in its own section what is
**not** proved: that a number field with a conjugation-fixed prime *has* the subring layer 2 wants.
Without that sentence, "Theorem A is kernel-checked" is a claim the formal statement does not back.

### E3. Names changed by the pass

| was | now | why |
|---|---|---|
| `residue_ne` + `residue_eq` | **`residue_eq_iff`** | one name for both directions; the implicature of stating one half is that the other is false or hard. Consumers need both (properness one way, the monochromatic distance class the other) |
| `apply_ne_zero_of_mem_normOne` | **`map_ne_zero_of_mem_normOne`** | Mathlib names `f a ≠ 0` as `map_ne_zero`; "apply" named nothing |
| `mem_of_mem_normOne` | **`normOne_subset`** | it is a subset relation, which is how the write-up states it ("unit vectors are integral"); `mem_of_mem` read as noise |
| `ValuationSubring.mem_of_mem_normOne` | **`normOne_subset_valuationSubring`** | a lemma about our `normOne` does not belong in a Mathlib namespace |
| `colorable_of_additive` (a theorem) | *deleted* — a spec **example** instead | see E4 |

### E4. One theorem deleted, and replaced by something stronger

`colorable_of_additive` (the `A = ⊤` corollary) had no customer: users of `Additive.lean` reach for
`additiveColoring` directly. But the subsumption claim still has to be *checkable* rather than
asserted, so the spec section now proves the two colourings are **the same function**:
`additiveColoring Γ φ h x = residue (φ.comp (⊤ : AddSubgroup M).subtype) x`. Stronger evidence,
smaller surface, and it removes a name a reader would otherwise have to place.

Same reasoning kept `colorable_unitQuadrance_of_residue`, which does have a claim to back: "nothing
in §1 needed `ℂ`, a metric or a field" is a docstring assertion until a statement over an arbitrary
commutative ring stands beside it.

### E5. The `simp` budget: exactly one tag

Only `residue_zero` is `@[simp]` — a normal form we own, terminating, no overlap.

`mem_normOne` was a candidate (the house drives goals out of graph/set vocabulary into ring
arithmetic, as `unitQuadrance_adj` and `unitDistance_adj` do). **Rejected**: consumers state
`hnorm` in `normOne` vocabulary and `colorable_of_normOne` consumes it in that form, so a tagged
`mem_normOne` would make any `simp at *` unfold the hypothesis out of the shape the theorem wants —
the "every use site opens with a simp preamble" smell, inverted. `normOne` stays sealed and
`mem_normOne` is the bridge a consumer applies by name. `sub_mem_normOne_conj_iff` is untagged for
the same reason plus an overlap: its left-hand side would match a tagged `mem_normOne` first.

### E6. The breakdown surface

The one failure a consumer will hit that teaches nothing on its own: writing
`residue ψ.toAddMonoidHom` and getting `Application type mismatch … ↥?m.8 →+ G`, because the
subgroup cannot be inferred from the homomorphism (higher-order unification on `↥?A ≡ ↥A`). The
error names no fix, so **the docstring names it**: write `residue (A := A.toAddSubgroup) …`. Every
public statement in §§3–5 was checked to be free of this — none of them mentions a residue map at
all, so the annotation is written exactly once in the whole repository, inside `FieldWall4`'s own
definition of its colouring.

Second breakdown, designed out rather than documented: a consumer holding `ψ : A →+* G` for a
subring should never be routed to `colorable_of_residue` (which wants an `AddSubgroup` and an
`AddMonoidHom`). The docstring's recipe sends them to `colorable_of_normOne` and its plane forms;
the group layer is named as the primitive and is not on the recipe.

### E7. What a reader will confuse this with, said explicitly

The module docstring carries a "What this is not" section naming four neighbours and the one-line
difference in each: `Additive` (total homomorphism — this file *is* that with the hom made partial),
`LocalGlobal` (a quotient construction, also total), `UnitQuadrance` (functoriality — a different
mechanism, and strictly sharper where it applies, since it yields the residue plane's own chromatic
number rather than the size of a residue field), and `ResidueObstruction` (M60 — pair compulsions,
no colouring built). Without it the file's name alone puts it within one letter of a module about
something else.

### E8. Validation planned

* **API-only proof**: the `FieldWall4` refactor is exactly this test — it must be written with no
  `unfold` of `residue`, `sect` or `cosetRep` (the last two are `private`, so the kernel enforces
  it), and every reach for the source is a hole in the surface to be filled by a lemma.
* **New-import test**: the spec section's `twoStep` model is written as a cold consumer would — name
  a subgroup, name a hom, apply the entry point — and it is the first thing to break if the recipe
  is wrong.
* **`#print axioms`** on the six public headlines, registered in `scripts/Axioms.lean`.

## 10. Results (2026-09-08)

**Landed, gate green** — build OK, zero `sorry`, `#print axioms` **682 clean / 5 declared purchases**
(all five pre-existing `native_decide` axioms of M03's certificate routes; nothing new bought), lint
silent, spec examples passing. `Proofs/HadwigerNelson/ResidueColouring.lean`, 534 lines of which 244
are code.

### R1. What is in the kernel

| statement | what it says |
|---|---|
| `colorable_of_residue` | a graph **drawn** in an abelian group, every edge difference in a subgroup `A` and of nonzero residue under `ψ : A →+ G`, is `Fintype.card G`-colourable |
| `cosetResidue`, `cosetResidue_apply_of_mem`, `cosetResidue_sub`, `cosetResidue_eq_iff` | the colouring map: `ψ` extended to the whole group, restricting to `ψ` on `A`, additive within each coset |
| `isUnit_of_mem_normOne`, `map_ne_zero_of_mem_normOne` | a norm-one element of a σ-stable subring is a **unit** of it, so its residue is nonzero — the norm-one condition's entire role |
| `normOne_subset`, `normOne_subset_valuationSubring` | a σ-stable subring holding one of every pair of reciprocals contains every norm-one element — Theorem A's `v_𝔭(u) = 0` step, two lines |
| `conj_mem_valuationSubringAtPrime` | the localization of a Dedekind domain at a height-one prime **fixed by an automorphism** is stable under it — the Galois-equivariance the stub named as load-bearing |
| `colorable_of_normOne`, `colorable_of_valuationSubring` | the ring and valuation forms |
| `colorable_unitDistance_of_residue`, `colorable_unitDistance_induce_of_residue` | the plane, for a drawing and for a set of points — the stub's A1 |
| **`colorable_unitDistance_induce_of_valuationSubring`** | **Theorem A in the write-up's own shape**: a conjugation-stable subfield of `ℂ`, a conjugation-stable valuation subring of it, a hom to a finite nontrivial ring |
| `colorable_unitQuadrance_of_residue` | the same theorem over the coordinate group of an arbitrary commutative ring |

`FieldWall4`'s Theorem B is now an instance: `colorable_four_of_subset_seamPlane` is one application
of the plane form, and the file is a **net deletion** (1403 → 1386 lines) despite gaining a
`Nontrivial F4` instance, `conj_mem_oddDenom`, and a bundled ring hom `psiA` in place of the
junk-extended `psiOf`.

### R2. What is *not* in the kernel, stated exactly

That a number field with a conjugation-fixed prime `𝔭` supplies the valuation subring **with a
residue field of size `N(𝔭)`**. The stability half is now proved
(`conj_mem_valuationSubringAtPrime`); what remains is the finiteness and the count (`Ideal.absNorm`
and the `NumberField` instances) and the typing that places an abstract number field inside `ℂ`.
Both are classical arithmetic and Mathlib plumbing with no new content. The module docstring says so
in its own section, so the file does not claim more than it proves.

### R3. Phase 3 was re-aimed, and the re-aim is a deviation from the registration

Registered: "the number-field instantiation (rung 2), one attempt, ~150 lines, stop if the
σ-stability of `valuationSubringAtPrime` resists". What was done instead: **Theorem A in the
write-up's own shape** (§R1's headline) plus the σ-stability lemma alone. The reason, and it is the
stub's own §3a analysis: rung 3 — an abstract number field with a chosen complex embedding — "buys
*nothing*, the same proof re-typed", and the marginal content of the full instantiation over the
valuation form is exactly the two classical facts named in R2. Landing the *shape* a reader compares
against §5.1, plus the one arithmetic step the stub flagged as the risk, is where the content is.

The σ-stability probe, when it ran, took **four lines** — far inside the registered budget — and the
reason is worth recording: it is not a statement about valuations at all. Mathlib's
`valuationSubringAtPrime` has elements `a / s` with `s` outside `𝔭`, so stability is
`σa / σs` with `σs` outside `𝔭`. The stub had priced this as the place the milestone could balloon.

### R4. Predictions, scored

| # | registered | outcome |
|---|---|---|
| P1 | the theorem and its three layers land under 300 lines | **met** — 244 code lines (534 with docstrings) |
| P2 | the `FieldWall4` refactor is a net deletion | **met** — 1403 → 1386, with a new instance and a new theorem added |
| P3 | `additiveColoring` recoverable as `A = ⊤` in under ten lines | **met, and in a stronger form** — three lines, and as an *equation between the two colourings* rather than a colourability corollary, so the subsumption is checkable rather than asserted |
| P4 | `Subring.toAddSubgroup` friction: an explicit `AddMonoidHom` will be needed | **refuted in its main clause** — `↥A` and `↥A.toAddSubgroup` are transparently the same type, `ψ.toAddMonoidHom` feeds `cosetResidue` with no wrapper, and membership transfers by `rfl`; **met in a weaker residual form** — the subgroup cannot be *inferred* from the hom (`↥?A ≡ ↥A` is higher-order), so `(A := A.toAddSubgroup)` must be written, exactly once in the repository. The refutation deleted a planned `ringResidue` wrapper and its four mirrored lemmas |
| P5 | the number-field instantiation needs `IsFractionRing`, `valuationSubringAtPrime`, an automorphism fixing the prime, residue-field finiteness; σ-stability is where it stalls | **half-tested, and the tested half is refuted.** The first three names were needed and are in `conj_mem_valuationSubringAtPrime`; σ-stability did **not** stall — four lines. Residue-field finiteness was not attempted (R3), so that clause is untested and is reported as untested |
| P6 | no existing proof breaks except inside `FieldWall4` | **met in substance, with a correction I did not predict**: no proof broke, but `Proofs.lean` refused the import outright — `HadwigerNelson.residue` already exists in `Lift.lean` (M59's reduction of a point of `(ℤ/p²)²` to `𝔽_p²`). The map is renamed `cosetResidue`. The experience pass had flagged `residue` as a generic name and let it stand; the environment settled it, which is the cheaper way to be told |

### R5. Mutation audit (registered in §8 O7)

Deleting `hσσ` from `normOne_subset`, `Nontrivial G` from `map_ne_zero_of_mem_normOne`, `x − y ∈ A`
from `cosetResidue_sub`, and `hmem` from `colorable_of_residue` each breaks the file (2, 1, 4 and 5
errors). The control — an unused hypothesis added to a lemma with no call sites — stays green at 0,
so the audit's instrument is calibrated rather than merely red.

### R6. One vacuity finding, recorded because it fixes the shape

`colorable_of_valuationSubring` cannot be widened to `A : ValuationSubring ℂ`: a homomorphism from a
valuation ring to a finite nontrivial ring has a prime kernel whose quotient is a finite domain,
hence a field, hence the kernel is the maximal ideal — and the residue field of a valuation subring
of an algebraically closed field is algebraically closed, hence infinite. So the hypotheses would be
unsatisfiable over `ℂ`, and the subfield in `colorable_unitDistance_induce_of_valuationSubring` is
load-bearing rather than decorative. The argument is in the module docstring, **marked as an
argument and not a theorem**, because it is not formalized.

### R7. What a future milestone gets

The recipe, in the module docstring: name a conjugation-stable subring of `ℂ`, a ring hom to a
finite nontrivial ring, and a proof that unit-distance differences land in the subring — and if the
subring is a valuation subring of a subfield, the third step is free. `FieldWall4` now names its own
three inputs (`conj_mem_oddDenom`, `psiA`, `mem_oddDenom_of_unit`) and says not to copy the file.

## 11. Literature check (2026-09-08, after the close)

*Kooshi asked whether the close's item 6 — "the plane over a field is a disjoint union of translates
of one countable graph, so all the chromatic content lives in the subgroup generated by the unit
vectors" — is known. It is, twice over, and the check turned up a paper that bears on far more than
that.*

### L1. Item 6 is known, and it is the first structural lemma of a paper we hold and have read

**[Fischer1990]**, *Additive k-colorable extensions of the rational plane*, which is the framework
this project adopted at M56. His introduction: "The connected component containing the origin will
be denoted by `Σ₀(F^d)`. Hence, this is the subgroup in `F^d` generated by all the unit vectors."
His Theorem 1's proof opens: "**Since the connected components of `F^d` are translates of
`Σ₀(F^d)`, to k-color `F^d` it suffices to k-color `Σ₀(F^d)`.**" And his **Example 1** (p. 186) is
the rational case verbatim: `Σ₀(ℚ²) = ℤ_S + ℤ_S·i` with `S` the multiplicative set generated by the
primes `≡ 1 (mod 4)` — the same Pythagorean-triple argument, crediting **[Chilakamarri1988]**, whose
Theorem 2 is "the graphs `U₁, U₂, U₃, U₄` are all disconnected" and Theorem 3 "`U_n` is connected for
`n ≥ 5`".

Our own bibliography already recorded it: the `[Chilakamarri1988]` row says "Fischer's Example 1
gives `Σ₀(ℚ²) = ℤ_S[i]`". So the derivation was independent and the fact was on the shelf.

### L2. Two more of the close's items are also Fischer's

* **The unit argument** (layer 1 of §2's "arithmetic in two facts" — a norm-one element is a *unit*
  of the ring, so its residue is nonzero) is Fischer's Theorem 1(iii) proof, p. 183: "given any
  non-zero homomorphism on the ring `Σ₀(F²)` … if `‖ξ‖ = 1`, then `ξ` has an inverse in `Σ₀(F²)` and
  therefore `v(ξ) = 1`."
* **The impossibility over `ℝ²`** (the close's item 1, offered as a limitation theorem worth
  formalising) is Fischer's own argument at p. 187, applied to a case he did not write down: "since
  `Σ₀(ℚ^d) = ℚ^d` for `d ≥ 5`, it follows that `ℚ^d` can have no additive `k`-coloring for any
  `k ≥ 1`. For if `v : ℚ^d → G` … then `k·v(1/k, 0, …, 0) = v(1) ≠ 0` and yet `k·G = 0`." The same
  one line kills `ℝ²`, because `Σ₀(ℝ²) = ℂ` is divisible. **The offer to formalise it is withdrawn**
  — it is an instance of a named 1990 argument, not structure nobody had named.

**What survives of §2's reduction:** layer 2, the valuation-ring step. Fischer never needs it,
because he takes `A = Σ₀` and the unit vectors are in it by construction; the field-wall note takes
`A` to be a localization and spends valuation theory proving them integral there. That step is real
and its two-line replacement is not in Fischer.

**And a precise statement of what the general theorem is worth:** on a *full plane* it is exactly
Fischer's Theorem 1(i), because any admissible `(A, ψ)` has `A ⊇ Σ₀` and restricts to a hom on `Σ₀`,
while Fischer's data is ours at `A = Σ₀`. The generality is only for graphs that are not full planes.

### L3. The find: Moorhouse 2010, and what it costs the record

**[Moorhouse2010]**, *On the Chromatic Numbers of Planes* (preliminary draft, 3 March 2010,
unpublished and little cited), read in full and now held at
`library/papers/moorhouse-2010-chromatic-numbers-of-planes.pdf`. It is the same programme as this
project's M58–M61 arc, twenty-six years earlier in the sequence and sixteen years earlier in time.

**What it already contains, with our name for it beside it:**

| Moorhouse 2010 | ours |
|---|---|
| §1: `K²` as a graph over *any field or commutative ring with unity*, `(a−c)²+(b−d)² = 1` | `unitQuadrance R` (M58, ledger row 53) |
| §3.1, §4.2(i): `χ(K²) = χ(K₀²)` | the close's item 6 |
| §4.2(ii): an additive map preserving neighbours of `0` gives `χ(A) ≤ χ(B)` | `addCayleyMap`, `colorable_of_addCayleyMap` (M61, row 56) |
| Lemma 2.3: every solution of `ξ²+η² = 1` is `(α/γ, β/γ)` with at most one of `α, β, γ` in `𝔭` | the `𝔭`-integrality of unit vectors — the hand step M58 left unformalized |
| **§8.2 Lemma, §10.3 Theorem: "there exists a graph homomorphism `K² → 𝔽_q²` so that `χ(K²) ≤ χ(𝔽_q²)`"** for a number field `K` and a prime with `\|O/𝔭\| ≡ 3 (mod 4)` | **the finite-plane bound — the pivot of 2026-09-06, ledger row 52** |
| **§6 Table 6.1: `χ(𝔽₁₁²) = 5`**, with 3, 7, 9, 13, 17 | **`χ(UD(𝔽₁₁,2)) = 5`, rows 52–53** |
| §6: the guess `χ(𝔽_q²) → ∞` | settled by [Vinh2005] in 2005 — which Moorhouse does not cite, and which does not cite him |
| §7.1: odd-degree number fields have `χ(K²) = 2`, by a residue colouring at a prime above `2` through the trace of `𝔽_{2^f}` | the same 2-adic mechanism as Theorem B |
| §9: a composite ideal cannot beat the minimum over primes **without refuting Hedetniemi's Conjecture** | the close's item 3, with a far better tie-in than I gave it |

**What it explicitly leaves open, and what that means for Theorem B.** §1, after Proposition 1.4(b)
(`K²` contains a Moser spindle iff `K` holds `1/66`, `√3` and `√11`): "The smallest number field `K`
for which `K²` contains a Moser spindle of edge length one, is the field `K = ℚ(√3, √11)`. In this
case `χ(K²) ≥ 4`. **We have not determined the exact value of `χ(K²)` in this case.**" His machinery
cannot reach it — §7.1 needs odd degree, §8 is quadratic, and the wall stands at `2` for this field.
**So Theorem B answers a stated open question of this draft**, and searches surface no later answer.
That is a strengthening of Theorem B's standing, not a weakening.

### L4. Corrections owed to `CLAUDE.md` § Frontier — for Kooshi, since the backlog rules bar me

1. **Ledger row 52 (the pivot).** "the finite-plane bound" is Moorhouse 2010 §8.2/§10.3. The
   novelty claim there ("Novelty is provisional (Vinh and the library's number-field papers do not
   contain the bound)") is now **refuted**: a number-field paper does contain it. What remains ours
   is the verification, the certificate form over an arbitrary ring, the kernel proof, and the
   instances.
2. **Rows 52–53: `χ(UD(𝔽₁₁,2)) = 5`** is in his Table 6.1. The kernel certificate (M58) appears to
   be the first; the value is not new. The frontier's "Vinh 2005 computed only p = 7" was true of
   Vinh and is misleading as a claim about the literature.
3. **Row 53's `unitQuadrance R` over any commutative ring** and **row 56's `addCayleyMap`** have
   prior art (§1, §4.2). Both were always folklore-adjacent; now they have an address.
4. **Row 47 / the field-wall theorem** should record that Theorem B answers Moorhouse's stated open
   question, and that his §7.1 uses the same 2-adic residue mechanism at other primes.
5. **G43** should record §9's Hedetniemi tie: improving on the minimum over primes is at least as
   hard as refuting Hedetniemi's Conjecture.
6. **A methodological entry for G30/G46**: this project reconstructed, independently, a 2010 draft's
   §1, §3, §4, §6, §8 and §10 — and the reconstruction took four milestones. The draft was one web
   search away, and the search that found it was run only because a *side* claim of a closed item was
   questioned. **The literature check belongs at the milestone's OPENING, not at its close**, and
   the check must be run against the mechanism's own vocabulary ("chromatic number of planes over
   fields", "finite field plane") rather than against the project's ("finite-plane bound", "field
   wall") — the earlier searches used our words and found nothing.

### L5. What is untouched

Theorem B itself; the 2-adic wall criterion and the multiquadratic classification; the field sieve
(M58: which fields are 6-open, `11` the only sealing prime over `K`); the lift theory (M59); the
compulsion transfer (M60); the tightness mechanism (M61); and every kernel certificate in the
repository. None of that is in Moorhouse or Fischer.

## 12. The workflow change this argues for: a prior-art gate at a milestone's OPENING

*Written 2026-09-08 at Kooshi's direction, from §11. This is a proposal for `WORKFLOW.md`; the edit
itself is his, not mine (the backlog ground rules keep me out of the standards files).*

### W1. The failure, stated as a mechanism rather than a lesson

Four milestones (M58–M61) rest on a bound that a 2010 draft states twice (`[Moorhouse2010]` §8.2,
§10.3), and on a value that its Table 6.1 contains. The draft is public, on the author's university
page, indexed, and **one web search away**. It was found on 2026-09-08 — after all four milestones
had closed — and only because a *side* claim of an already-closed item was questioned.

Three things went wrong, and only the third is about diligence:

1. **The check ran at the close, not the opening.** Every milestone here ends with a literature
   note; by then the derivation is done, the instruments are built, and the check can only assign
   credit. Run at the opening it would have changed what M58 was *for*.
2. **The check searched in this project's vocabulary.** "Finite-plane bound", "field wall",
   "residue obstruction", "5-sealed" — all coined here, none in any paper. The search that worked
   used the field's own words: *chromatic number of planes over fields*. **A private vocabulary is
   an excellent instrument for thinking and a perfect filter against finding out you are not first.**
3. **The check searched the wrong literature.** The bibliography's §B and §C hold thirty-odd
   arXiv items about unit-distance graphs and colourings. Moorhouse is not on arXiv, is not
   published, and is not cited by the papers we hold — he sits in the finite-geometry community, and
   Vinh (2005), whose objects we also use, does not cite him either, nor he Vinh. **The two
   literatures this project's pivot connected had never met, which is exactly why searching either
   one alone found nothing.**

### W2. The proposed step

**`WORKFLOW.md` step 3a — the prior-art gate. Between subplanning and the modeling passes, before
any derivation.** Its output is a section of the subplan; a milestone whose subplan has no §PA is
not subplanned.

The gate is four questions, and it is cheap — thirty minutes, not a day:

1. **Name the object in the vocabulary of the discipline it belongs to**, not this project's. G46
   already demands this recognition step for *deriving*; the same sentence is the search query.
   ("The finite planes are Cayley graphs of an abelian group" → search *Cayley graph chromatic
   number abelian group*, not *finite-plane bound*.)
2. **Search under at least two disciplines' names for the same object.** The M58 arc's object is
   simultaneously a number-field colouring question and a finite-geometry question; searching one
   found Vinh, searching the other would have found Moorhouse. Kooshi's ladder of disciplines
   (under G30) already names which two rooms any given wall sits between — use it as the search
   plan.
3. **Search for the QUESTION, not only the method.** "Has anyone computed χ of the plane over this
   field?" would have surfaced Moorhouse §1 immediately, and with it the fact that Theorem B answers
   a stated open question — worth knowing *before* the milestone, not after.
4. **Look outside arXiv.** Personal pages, unpublished drafts, theses, and the pre-2000 journal
   literature. Two of the three works that mattered most here (Fischer 1990, Moorhouse 2010) are in
   neither arXiv nor our search history.

### W3. What the gate is *for*, which is not credit

The instinct is to read this as a novelty-protection measure. It is not, and framing it that way
would make it get skipped:

* **It aims the milestone.** Had M58 opened knowing §10.3, its subplan would have been "formalize a
  known bound and push past it" — which is what it in fact did, and the field sieve, the lift theory
  and the tightness mechanism would have been the headline from the first day.
* **It hands over free theorems.** §9's Hedetniemi tie, Lemma 2.3, and Table 6.1 are all results we
  re-derived at cost.
* **It finds the open questions.** The single most valuable line in the draft — "We have not
  determined the exact value of χ(K²) in this case" — is a stated open problem this project has now
  answered, and it went unnoticed for the entire arc.
* **The negative result is worth the thirty minutes too.** Knowing that Moorhouse and Vinh do not
  cite each other is itself a finding: it says where the unworked ground is.

### W4. Registered prediction, to be scored the next time the gate runs

The gate will change at least one milestone's *scope* (not merely its attribution) within the next
three milestones — because the pattern here was not "we duplicated a result" but "we spent four
milestones re-deriving the entrance to a room, and the interesting work started after it."

## 13. The poros session's papers, verified (2026-09-08)

*Kooshi pointed at the last messages of the `../poros` session (`~/.claude/projects/-home-kooshi-source-poros`),
with the warning that the conversation tripped a cyber-safety false positive and was downgraded to a
weaker model, so its reasoning is not to be trusted but its paper finds should be. Read: the final
14 k-character assistant message (model `claude-opus-4-8`). Its three citations are **real and
correctly given** — checked one by one, which is exactly the check a downgraded model's citations
need.*

### P1. The three papers

| work | what it is | why it matters here | status |
|---|---|---|---|
| `[Krebs2022]` M. Krebs, *Clique numbers of finite unit-quadrance graphs*, J. Algebraic Combin. 57 (2023) | determines `ω(UD(F, n))` **completely for every finite field and every `n`**; also computes bipartiteness and connectedness, and **bounds the chromatic numbers**, with conditions under which `χ > ω` | M59 `decide`s `ω = 3` at 11 and `ω = 2` at 19 one prime at a time; a closed form replaces that. G24/G40/G44's `ω`-versus-`χ` readings — the programme's own account of where the integrality gap lives — have a paper about them | abstract read; **not held** (paywalled) |
| `[SchneiderSilva2013]` C. Schneider, A. Silva, arXiv:1306.6050, J. Algebra Appl. | generalized Paley graphs with `ω = χ`, tied to synchronization in primitive affine permutation groups | **`UD(𝔽_q, 2)` is a generalized Paley graph** for `q ≡ 3 (mod 4)`: the quadrance is the norm of `𝔽_{q²}/𝔽_q`, so the connection set is the norm-one subgroup of order `q + 1` — `GP(q², q − 1)`. Our planes are the `ω ≠ χ` case, so their criterion is about our family, and it names a discipline (synchronization) absent from the ladder under G30 | abstract read; **not held** |
| `[CervantesKrebs2023]` J. Cervantes, M. Krebs, *Chromatic numbers of Cayley graphs of abelian groups: a matrix method*, Lin. Alg. Appl. (2023), arXiv:2303.06262 / 06272 | an abelian Cayley graph is an integer matrix; row operations give graph homomorphisms to smaller Cayley graphs, hence `χ` upper bounds | **this is M61's periodic quotient, systematized.** `addCayleyMap` / `unitQuadrance_colorable_of_quotient` is one row operation done by hand, per prime. **It was already in our bibliography §B/§C, unread, since 2026-09-06** — promoted to §A now. Follow-up arXiv:2511.03028 (rank two, 2025) | **listed and unread for two days**; now promoted |

Same Mike Krebs in two of the three: there is a live, coherent line of work on exactly our objects,
and none of it was in the record.

### P2. The convergence that matters more than the papers

The poros session's card 3 — *"the discipline was named (generalized Paley graph) and one of its
theorems used (Lovász ϑ), but its chromatic literature past Vinh was not read"* — is the **same
diagnosis** §11 reached from a completely different direction (Moorhouse 2010, found by searching for
a side claim of a closed item). Two independent routes, one downgraded model and one literature
check, to the same finding on the same day. That is as strong an argument for §12's prior-art gate
as the record is going to produce, and it should be scored that way rather than as two anecdotes.

### P3. One checkable thing the session did not have, and it is a cheaper target than the backlog's

Searching for a published exact value of `χ(UD(𝔽₂₃, 2))` — FS-17's first digit, and backlog item
**B3, budgeted at twenty-four hours of compute** — found none. **So B3 is not answered in the
literature and its budget is not wasted.** But `[Moorhouse2010]` Table 6.1 (§11) stops at `q = 17`
and leaves two entries **open**:

* `χ(𝔽₁₃²) ∈ {5, 6}` — which our own record already settles at **5** (frontier row 52, from the
  2026-09-06 pivot session), apparently without knowing it was an open entry;
* **`χ(𝔽₁₇²) ∈ {5, 6, 7}` — open in the literature, and never touched here.** `data/fplane/` holds
  records at 3, 7, 11, 19, 23, 27, 31, 43, 47, 131; there is nothing at 13 or 17.

**`𝔽₁₇²` has 289 vertices against `𝔽₂₃²`'s 529**, and *if it is 6 the first digit is answered* — the
question FS-17 and B3 exist for. The caveat is real and belongs in the same sentence: `17 ≡ 1
(mod 4)`, so it is never a usable prime for the sieve, and a 6-chromatic plane there answers the
**range** half of the local–global conjecture (is the answer ever exactly 6) and contributes nothing
to the **sieve** half. That is precisely the fork the poros session put to Kooshi as its rank-1 card,
now with a concrete cheap instance attached.

### P4. What of the session I did *not* adopt

Its diagnosis (the arithmetic frame bounds, locates and explains but cannot compute; the first digit
sits at the frame's own edge; it is off the path to a 6-object by G45 and FS-17 D3) reads as
coherent and is consistent with the record I can check — but it is a *reading* produced by a
downgraded model, its rank-1 card is explicitly Kooshi's to rule on, and its card 2 ("search the
fibre of the mod-11 reduction with M59's idle mod-`p²` machinery") is offered by its own author in
the hypothetical mood. None of it is recorded here as a finding. The papers are.
