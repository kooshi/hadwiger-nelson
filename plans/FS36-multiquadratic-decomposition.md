# FS-36 — The multiquadratic handoff folded in: two colours from inertia, and the 2-adic splitting

> **Approved by the main session on 2026-09-11, with all 22 decisions standing.**

*Opened 2026-09-11. WORKFLOW steps 3, 3a and 4 by the planning agent; step 5's modeling passes are §M1–§M3 at
the end, and **§1–§11 already describe the shape after them**. Steps 7–10 belong to the implementer, who starts
from this file and remembers nothing of the conversation that produced it. The source and its verification are in
`reference/ChatGPT-multiquadratic/` (`handoff.md`, `VERIFICATION.md`, two check scripts). After this milestone the
project returns to M63.*

**Kooshi's framing, which sizes this milestone.** He brought a handoff from his conversation with ChatGPT (OpenAI)
about colouring the plane over multiquadratic fields. He had told ChatGPT he would credit it with one result, the
decomposition theorem, if the project did not already hold it; the project does not. His verdict on the whole:
*"less insightful than I hoped, but worth formalizing."* So this is a modest milestone: fold the material in
properly, formalize what earns formalizing, and stub the rest.

---

## 0. For the implementer — read this first

**What you are building.** Two new leaf modules. Both skeletons are committed, and every statement in them
elaborates.

1. `Proofs/HadwigerNelson/TwoColourResidue.lean` — **Theorem A's two-colour case.** If complex conjugation leaves
   every residue unchanged, every unit vector reduces to a square root of `1`. In a reduced ring of characteristic
   two that root is `1`, so an additive functional to `ZMod 2` that is `1` at `1` two-colours the plane.
2. `Proofs/HadwigerNelson/SquareClass.lean` — **the 2-adic splitting.** It holds:
   - the positive rational square classes as an `𝔽₂`-vector space, and localization at 2;
   - a Galois connection between square-class groups and real fields, so the field of a sum is the compositum;
   - the splitting of any square-class group containing `[2]` into two pieces whose 2-adic images avoid `[−1]`;
   - the field-level consequence: every real multiquadratic field, once `√2` is adjoined, lies in the compositum of
     the two pieces' fields, each passing the four-colour test;
   - when the field contains `ℚ(√3, √11)`, each piece's plane needs four colours.

**What you must not do.** Each rule has cost this project before; `CLAUDE.md` gives the history.
- **Build only with `./scripts/build.sh`, never `lake build`**, bare or named. `lake env lean <file>` is fine for
  iterating but does not apply `autoImplicit := false`; pass `-DautoImplicit=false` or wait for `build.sh`.
- **Do not add or change a declaration or a `/-- docstring -/` in `ResidueColouring.lean`, `FieldWall4.lean` or
  `UnitQuadrance.lean`.** Every module downstream of them would rebuild. Both new modules are leaves on purpose.
- **No `native_decide`.** The standard three axioms only.
- **One heavy job at a time. Any unexplained process crash: stop and report**, do not retry.
- **Commit on `backlog`, never push**, and end every commit message with the two attribution lines the session gives
  you.
- **Do not write `χ ≤ 4` for the pieces anywhere as if the kernel proved it.** It does not; see §7.

**The acceptance test is §9. What the close must record is §10.**

---

## 1. Purpose

### 1.1 What came in, and what of it is new

The handoff (`reference/ChatGPT-multiquadratic/handoff.md`) is short and careful about its own scope. Every claim in it
was re-derived before this plan was written (`VERIFICATION.md`). Sorted against the repository:

| the handoff's item | already here? |
|---|---|
| `χ(ℚ(√3,√11)²) = 4` | yes — Theorem B, ledger row 57 (a reproduction; Kooshi said so in the conversation) |
| the 2-adic four-colour test `[−1] ∉ V₂(F)` | yes — `plans/FIELD-WALL-THEOREM.md` §6.2, grokking G35 |
| the odd-prime reduction to `UD(𝔽_p, 2)` | yes — ledger row 52 (prior art Moorhouse, Manturov, Madore) |
| the example field values `K(√35) = 4`, `K(√5) = K(√247) = 5`, … | yes — `plans/M58-field-sieve.md`, ledger rows 47, 52 |
| de Grey's field "open to six" | yes — G43 |
| the six-colour cutoff at `p = 83` | yes, sharper — `plans/M61-local-global-tightness.md` §S2's exact Hoffman floors exclude 71 too |
| **the decomposition theorem** (§5) | **new** — credit ChatGPT (§3 D8) |
| **`K(√14)`, `K(√70)` pass the four-colour test; their compositum holds `√5` and is 5-chromatic** (§4) | **new** |
| **the screening rule for several added roots at once** (§4) | **new**; proved by exhaustion over local classes in `independent_check.py` |
| **the two-colour criterion `[−1], [3] ∉ V₂(F) ⟹ χ(F²) = 2`** (§3), made an iff by the main session's converse | **new**; corrects `plans/FIELD-WALL-THEOREM.md` Proposition 6.4, recorded there as §10.2 |

### 1.2 What the decomposition is worth, stated so it cannot be oversold

It colours nothing: a point of the compositum's plane generally lies in neither piece's plane. Its content is a
statement about what a *combining rule* would have to do.

Every multiquadratic unit-distance graph lives in some real multiquadratic field. The decomposition puts that field,
once `√2` is adjoined, inside a compositum of two fields that pass the four-colour test. So a rule of the form
"`χ(A²), χ(B²) ≤ 4 ⟹ χ((AB)²) ≤ c`", for test-passing `A` and `B`, would give `χ ≤ c` for every multiquadratic field
plane. The `K(√14) · K(√70)` example forces `c ≥ 5`, and `c = 5` would mean that no 6-chromatic unit-distance graph
has multiquadratic coordinates. This makes exact the remark in `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 that "their
colourings do not glue".

**Bearing on χ(ℝ²) ≥ 6: none directly.** Its natural home is the Theorem B paper (FS-20,
`plans/STUB-theorem-B-writeup.md`).

### 1.3 What the two-colour criterion is worth

- **It corrects this project's own note.** Proposition 6.4 granted two colours only when the residue field at 2 is
  `𝔽₂`. That leaves out `ℚ(√5)`, `ℚ(√13)`, `ℚ(√2, √5)`, and every field whose 2-adic image contains `[5]`.
- **It settles which real multiquadratic planes are 2-colourable**, as a hand theorem: exactly those whose
  square-class group has no odd element `≡ 3 (mod 4)`.
- **It bears on two questions posed in print** (§PA(c)).
- **Its kernel part is small and honest.** It is the mechanism, in the valuation-subring language Theorem A already
  speaks. Which multiquadratic fields supply such a valuation subring is the same gap as Theorem A's own (FS-37).

---

## §PA — The prior-art gate (WORKFLOW step 3a)

Run 2026-09-11, before any derivation in this plan, in the disciplines' own vocabulary and never in this
project's. The disciplines: Kummer theory and square classes of multiquadratic fields; chromatic numbers of planes
over `ℚ(√d)` and number fields; unit-distance graphs over fields; additive colourings.

### (a) The two-colour mechanism is classical and spread across four sources; the multiquadratic iff was not found

| source | what it has | what it does not |
|---|---|---|
| `[Woodall1973]` (second-hand) | `χ(ℚ²) = 2` | fields |
| `[Fischer1990]` Theorem 8 (**read in full**) | `ℚ(√N)²` is 2-colourable iff `N ≢ 3 (mod 4)`, both directions: an explicit odd cycle for `N ≡ 3 (mod 4)`, and explicit parity evaluations on `Σ₀` otherwise | residues, valuations, any field of degree above 2 |
| `[Moorhouse2010]` Theorem 7.1 (**read**) | odd-degree number fields have `χ(K²) = 2`: at a prime above 2 with `e` and `f` odd, colour by the trace of `ξ + η mod 𝔭` | even degree; such a prime ramifies in `K(i)`, so this is a special case of (b) |
| `[Madore2015]` Prop. 3.9 (**read**) and Remark 2.5 | `χ(ℚ(√2)²) = χ(ℚ₂(√2)²) = 2`, by hand over `ℚ₂(√2)` with a coordinate-wise valuation (his *"slight difficulty"*); in characteristic 2, two colours through a functional | the general statement; he does not cite Fischer, whose Theorem 8 already covers `N = 2` |
| `[Johnson1987]` (zbMATH review known) | the "if" half of Fischer's Theorem 8, with many distances forbidden | fields beyond quadratic |
| `[Johnson2010]` (**read in full**) | nothing on fields beyond connectivity; points to `[Johnson2006]` for `ℚ(√m)²` | — |

**Not read, and blocking any novelty claim for the multiquadratic iff — not the formalization:**
- `[AxenovichEtAl2014]`: its abstract names "extensions of the rational plane". It is not held — the preprint host's
  certificate chain is broken, the journal copy is closed, and it needs a browser save.
- `[Johnson2006]`: it discusses `ℚ(√m)²`. It is not held.

`[Fischer1990b]`, on multiquadratic planes specifically, is about connected components according to its zbMATH
review. No colouring criterion is mentioned there, but the paper itself is unread.

**Consequence for the shape.** The kernel statement is the valuation-subring form of the mechanism, which none of the
four sources states and all four instantiate. The multiquadratic iff stays a hand theorem, recorded with its
prior-art caveat.

### (b) The decomposition — nothing found, and nothing expected

- **Searched:** *"multiquadratic field compositum of two subfields square class group 2-adic localization"*,
  *"Kummer theory multiquadratic subgroup preimage local square classes"*, *"chromatic number of the plane over
  multiquadratic field"*, and *"two-colorable plane real multiquadratic extension"*.
- **Found:** Kummer-theory papers on degrees of Kummer extensions (`BIBLIOGRAPHY.md` § C, negative), and the
  colouring literature above; neither has a splitting statement.
- **ChatGPT's own targeted search** also found nothing (handoff §1).

The statement is short linear algebra once the 2-adic test is in hand, so its absence from print is not surprising.
**Credit line** (D8): *a corollary of the 2-adic four-colour criterion (`plans/FIELD-WALL-THEOREM.md` §6.2), stated
and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11; no prior statement found.*

### (c) The questions this work bears on, searched for as questions

- **`[BendaPerles2000]` Open Problem 11.6**, via `[Soifer2024]` ch. 11: *"Find the chromatic number of `ℚ²(√2)` and,
  in general, of any algebraic extension of `ℚ²`."* It is restated in `[GrahamTressler2010]` §3. The first half was
  answered in 1990 (`[Fischer1990]` Theorem 8; again `[Madore2015]` Prop. 3.9). The two-colour criterion answers the
  second half at the value 2, for real multiquadratic fields, as a hand theorem.
- **`[Fischer1990]` §1**: *"This still begs the general question, however, whether some algebraic criterion can be
  found to determine the chromatic number of F² where F is a subfield of R, of finite degree over Q."*
- **`[Krebs2022]` Remark 2.3**: *"It might be interesting, however, to try to find necessary and sufficient conditions
  for UD(F,n) to be bipartite for such fields"* (characteristic zero). The same remark misquotes Fischer's Theorem 8
  as *"N is not congruent to 2 (mod 3)"*, which is Theorem 9's hypothesis.
- **Citation walks of the works that posed them.**
  - `[Fischer1990]`: 13 citers on OpenAlex, 11 on Semantic Scholar; the lists agree apart from duplicate records.
    The citers in the neighbourhood were opened: `[AxenovichEtAl2014]` (not obtainable, above), `[Johnson2010]`
    (read), `[Reid1996]` (connectivity; named). The rest are expository, `ℚⁿ`-only, or held and read
    (`[Payne2009]`, `[CranstonRabern2015]`, `[CurrieEggleton2016]`, `[Krebs2022]`).
  - `[Krebs2022]`: 1 citer on OpenAlex and 2 on Semantic Scholar, all `[LorenzZimmermann2023]`'s two papers (held;
    finite local rings). **Nobody citing Krebs has answered his remark.**
- **Recommendation for the close** (§10): a `CLOSED-QUESTIONS.md` §2 row, "answered for a class of fields", with the
  hand-theorem status and the two unread works in its prior-art column.

### (d) The spectral citation in the handoff

`[BrittenhamPakianathan2024]` (scanned) gives the eigenvalues of every finite Euclidean distance graph as twisted
Kloosterman sums (Theorem 3.1). It quotes the Weil bound (`[Weil1948]`) and says nothing about colourings. The
repository's `tools/fplane.py spectral --all-below 100` gives exact Hoffman floors 6, 6, 7, 6, 6 at
`p = 59, 67, 71, 79, 83`. So `p = 71` refuses six colours by its exact spectrum, which the handoff's Weil estimate
cannot see.

### (e) What the gate changed in this repository the same day

`BIBLIOGRAPHY.md`:
- **new rows:** `[AxenovichEtAl2014]`, `[BrittenhamPakianathan2024]`, `[BannaiShimabukuroTanaka2009]`, `[Kwok1992]`,
  `[Johnson2010]` / `[GrahamTressler2010]`, `[Reid1996]`, `[JungreisReidWitte1990]`;
- **corrected rows:** `[Krebs2022]`, `[Fischer1990]`, `[Fischer1990b]`, `[Madore2015]`, `[Moorhouse2010]`,
  `[Johnson2006]`;
- **replaced § C verdict:** it had dismissed `[AxenovichEtAl2014]` unread as having "no field content", which its
  own abstract contradicts.

---

## 2. What the kernel already holds — read these before writing a line

| where | names you will use |
|---|---|
| `ResidueColouring.lean` | `colorable_of_residue` (a graph drawn in an abelian group, edge differences in a subgroup `A`, nonzero under `ψ : A →+ G`, is `\|G\|`-colourable); `normOne`, `mem_normOne`; `isUnit_of_mem_normOne`; `normOne_subset_valuationSubring`; `colorable_of_valuationSubring`; `conjOn`, `conjOn_conjOn`; `colorable_unitDistance_induce_of_valuationSubring` (Theorem A, the plane form to mirror); `sub_mem_normOne_conj_iff`; `map_mul_conj_eq_zero_iff` (its `hker` binder is the rung below our `hψσ`) |
| `FieldWall4.lean` | `seamField : Subfield ℝ`, `seamPlane`, `mem_seamPlane_iff` (`Iff.rfl`), `mem_seamField_iff` (`x = a + b√3 + c√11 + d√33`, rational `a b c d`), `sqrt3_mem`, `sqrt11_mem`, `four_le_chromaticNumber_seamPlane`, `FieldWall4.F4`, `FieldWall4.F4.sq` (Frobenius, a ring hom) |
| `Instances/FinitePlane11.lean`, `UnitQuadrance.lean` | Phase C only: `chromaticNumber_heule510`, `heule510_coordsIn_sevenFree`, `Q4.sevenFree`, `Q4.sevenFree.toQ3` |
| Mathlib, **measured** by the planning probe or the domain pass | `Submodule.mem_sup`, `Submodule.mem_map_of_mem`, `Submodule.map_le_iff_le_comap`, `Submodule.mem_span_pair`, `Submodule.subset_span`, `Submodule.map_span`, `Finsupp.linearCombination`, `Finsupp.comapDomain`, `Nat.factorization_mul`, `Nat.Prime.factorization`, `Nat.sq_mul_squarefree`, `GaloisConnection.l_sup`, `Module.forall_dual_apply_eq_zero_iff` (needs `Module.Projective`), `ZMod.algebra k 2` (needs `CharP k 2`), `frobenius_inj` (`Mathlib/Algebra/CharP/Reduced.lean`), `Subfield.closure_le`, `Real.sqrt_mul`, `Real.sqrt_mul_self`, `SimpleGraph.chromaticNumber_mono_of_hom`, `SimpleGraph.induceHomOfLE`, `SimpleGraph.cycleGraph` (import `Mathlib.Combinatorics.SimpleGraph.CycleGraph`), `StarRing (ℤ√d)` (so `starRingEnd GaussianInt`) |
| Mathlib, **not found** | "even factorization ⟹ `IsSquare`" in that shape (`exact?` failed): go through `Nat.sq_mul_squarefree` |
| Mathlib, **friction found** | `IsReduced (ZMod 2)` needs the import `Mathlib.Algebra.Field.ZMod`, where `Field (ZMod p)` is declared and which `FieldWall4`'s closure lacks: without it the trace shows `NormedField.toField` as the only candidate. `Fact (Nat.Prime 2)` is a global instance. Found by tracing the instance search after a first guess (a local `Fact`) failed; the experience pass confirmed that the named model needs no local instance |
| Mathlib, **names found by the obligation pass** (§M2, probed) | `Squarefree.natFactorization_le_one`, `ZMod.natCast_eq_zero_iff`, `Nat.eq_of_factorization_eq`, `Nat.factorization_pow`, `Finsupp.induction` (cases `zero` and `single_add`), `Finsupp.linearCombination_single`, `ZModModule.add_self`, `Real.sqrt_ne_zero'`, `natCast_mem`, `SubfieldClass.ratCast_mem`, `frobenius_def`, `ZMod.algebra` (in `Mathlib.Algebra.Algebra.ZMod`, now imported), `CharP.nontrivial_of_char_ne_one` (its argument is `v`), `not_forall` (in place of the deprecated `push_neg`) |

---

## 3. The shape, and every decision in it

**Two leaf modules**, each importing `FieldWall4` and nothing downstream of it:
- `TwoColourResidue` needs `FieldWall4` only for its red (D14).
- `SquareClass` needs it for `seamField` and the Moser spindle.

| # | the choice | the alternative weighed | why this one | confidence |
|---|---|---|---|---|
| D1 | Formalize the decomposition **at the field level**: `ℚ(√D) ≤ A ⊔ B` as subfields of `ℝ`, through the Galois connection of D9; the four-colour test's hypothesis on each piece; `χ ≥ 4` for each piece's plane when `ℚ(√3,√11) ⊆ ℚ(√D)` | the class-level linear algebra alone | The handoff's claim is about fields, and a class-level statement alone is the failure mode the main session named — a vector-space lemma that reads like a chromatic result. The field level leaves the kernel statement equal to the claim minus exactly one named step (`χ ≤ 4`), which the docstring names | medium: if Phase B2 passes its stop rule (§8), land B1 + B3 and report B2 not landed |
| D2 | The two-colour theorem **in Theorem A's three forms** (ring, valuation subring, plane) | (i) the plane form only; (ii) "Theorem A′" — colour through `G/H` for an additive `H` avoiding the reduced norm-one set | (i) breaks the symmetry with Theorem A's API, which consumers already know. (ii) is `colorable_of_residue` composed with a quotient: no content and no second consumer. The content is the mechanism (D11) | high |
| D3 | **No field-level instance** (`χ(K(√2,√35)²) = 4` in the kernel); stub it as FS-37 | (c) a `FieldWall4`-style order for `K(√2,√35)(i)`; (d) closing `plans/A1-theorem-A-kernel.md` §R2 | **(c) is priced at a week or more.** `FieldWall4` is 1,392 lines for a rank-8 order with ramification index 2 at the prime above 2, where one parity step suffices. `ℚ(√2,√3,√11,√35,i)` has rank 32 and ramification index 4, since `√2` and `i` both ramify. So the descent becomes a four-step valuation argument and every kernel product is sixteen times larger; the residue field's fourth element comes from `ζ₃`, so a residue map defined on the generators alone only reaches `𝔽₂`. **(d) closes only the generic half:** each field still needs its prime's residue degree computed, and Mathlib's decomposition-group API does not deliver that for multiquadratic fields | medium-high: if Mathlib has since grown a residue-degree computation for Kummer extensions, (d) gets cheaper — FS-37 says to check first |
| D4 | **Square classes as `Nat.Primes →₀ ZMod 2`**; the 2-adic group as `ZMod 2 × ZMod 2 × ZMod 2` in coordinates `(−1, 5, 2)`; localization defined on primes by `p mod 8` | (i) `ℚˣ` modulo squares with 2-adic squares through Hensel's lemma in `ℚ₂`; (ii) `ℕ →₀ ZMod 2`; (iii) `ℕ+` as the carrier of radicands | The prime basis is the classical basis. The mod-8 table is the classical fact (Hensel), which no consumer needs proved; the docstring says the table is a table. (ii) has directions no natural number populates, which breaks `exists_sqClass_eq`. (iii) is D12 | medium-high after the domain pass |
| D5 | **Two new leaves; no edit to `ResidueColouring`** | put the two-colour theorems in `ResidueColouring.lean` beside Theorem A | a declaration added there rebuilds `FieldWall4`, `SeamCert`, `ValuationLaw` and everything that imports them | high |
| D6 | The milestone runs as **FS-36**; its carry-forward is **FS-37** | number it M65 | small consolidation-sized items run under their FS number (FS-24 landed ledger row 61); M63 is open with M62 behind it, so an M-number would misstate the queue | high |
| D7 | **The splitting needs `[2] ∈ W` and nothing else**, through two lemmas: "a splitting of the image lifts" (`inf_comap_sup_inf_comap_eq`) and "every subgroup of `ℚ₂^×/(ℚ₂^×)²` holding `[2]` splits along the two blocks" (`le_inf_spanThreeTwo_sup_inf_spanThreeTen`) | (i) the handoff's two-case proof; (ii) the planning skeleton's hypotheses, `U₁ ≤ W.map f` plus `[3] ∈ W` | The planning skeleton's hypotheses were stronger than the truth. Outside both blocks lie only `[5]` and `[−1]`, and `[2]` carries each into `spanThreeTen`. `[3]` and `[11]` are needed only for "each piece contains `ℚ(√3,√11)`". `independent_check.py` §5 checks the local lemma on all 16 subgroups, and finds the ones that do not split to be exactly `{1,5}`, `{1,7}` and `{1,3,5,7}` | high |
| D8 | The credit line of §PA(b), in `SquareClass.lean`'s docstring and in any ledger row | the main session's *"a corollary of the project's 2-adic criterion, stated and proved by ChatGPT…"* | "the project's" claims a criterion whose mechanism is `[Fischer1990]`'s and `[Madore2015]`'s; naming it by where it is written avoids that, and the line carries the search's negative | high |
| D9 | **`fieldOfClasses ⊣ classesOfField`, a Galois connection** between square-class groups and real subfields | ad-hoc lemmas `fieldOfClasses_mono`, `fieldOfClasses_sup`, `fieldOfRadicands_le_fieldOfClasses_span` (the planning skeleton) | One structure gives monotonicity, sums and `⊥` for free. The skeleton's `fieldOfClasses_sup` is already `gc.l_sup` in one line, and `fieldOfClasses_eq_sup` is one `rw` after it. It needs no independence of square roots, and it costs the same two leaves (`exists_sqClass_eq`, `isSquare_of_sqClass_eq_zero`). `classesOfField F` is also the object the handoff's `V₂(F)` is: `(classesOfField F).map twoAdic` | high |
| D10 | The two-colour theorem's carrier is **an additive functional `k →+ ZMod 2`** | (i) a quotient `k ⧸ H` by an index-2 subgroup; (ii) a ring hom `A →+* ZMod 2` (Theorem A at `G = ZMod 2`); (iii) Fischer's route — restrict `ψ` to the subring generated by unit vectors, whose image is `𝔽₂` | (i) needs `Fintype (k ⧸ H)` and a cardinality computation where `ZMod 2` has `ZMod.card`. (ii) cannot reach `ℚ(√5)`: its residue field `𝔽₄` has no ring hom to `𝔽₂`, so the functional being *additive* is the content. (iii) needs a codomain restriction to the prime subfield, heavier in Lean than the dual-space lemma | high |
| D11 | The hypothesis is **pointwise `ψ (σ z) = ψ z`** — conjugation in the inertia group — split from characteristic two: first `ψ u · ψ u = 1` with no hypothesis on the residue ring (`map_mul_self_eq_one_of_mem_normOne_of_conj_eq`), then `ψ u = 1` in a reduced ring of characteristic two | (i) Mathlib's `AddSubgroup.inertia`, which needs a group action for a single involution; (ii) `ψ.comp (σ.restrict …) = ψ` as an equation of ring homs; (iii) one lemma straight to `ψ u = 1` | The pointwise form matches `ResidueColouring` §4's `hker`, which puts the three hypotheses on a visible ladder: none gives `\|k\|` colours; kernel-stable gives the valuation law; inertia gives two colours. The split names the step a residue-`𝔽₃` argument, with square roots `±1`, would reuse | high |
| D12 | **No `0 ∉ D` hypothesis anywhere**: `sqClass 0 = 0` is a junk value made harmless by `√0 = 0`; radicands stay in `ℕ` | `ℕ+` as the carrier | Mathlib's factorization API lives on `ℕ` with `≠ 0` side conditions. `ℕ+` would cast twice in every field statement. And the planning skeleton's `hD : 0 ∉ D` was never used | medium-high |
| D13 | **No `pieceTwo` / `pieceTen` definitions**: a piece is written `W ⊓ U.comap twoAdic`, with its lemmas parametrized by the plane `U` | two named definitions with mirrored lemmas (the planning skeleton: six near-duplicates) | The duplication was a role left unnamed — "the classes localizing into a plane" — and Mathlib's `⊓`/`comap` vocabulary is that role with its API attached. A reader-facing abbreviation is the experience pass's decision | medium |
| D14 | `TwoColourResidue` imports `FieldWall4` for its red | a red in Mathlib's `GaloisField 2 2` | `F4`'s facts are `decide`s. The nontrivial cube roots of one in `GaloisField 2 2` need cardinality arguments. And `F4` with Frobenius *is* Theorem B's residue field — the red says exactly why the hypothesis matters | medium |
| D15 | **`classesOfField`'s carrier requires `n ≠ 0`** | the domain pass's carrier without it | its closure proofs then use the witnesses `1` and `a · b` and never the junk value `sqClass 0 = 0`; the connection's forward direction gets `n ≠ 0` for free from `exists_sqClass_eq` | high — probed |
| D16 | **The arithmetic under the connection is one symmetric lemma with no side condition**, `sqrt_mem_iff_of_sqClass_eq : sqClass n = sqClass m → (√n ∈ F ↔ √m ∈ F)` | the one-directional form with `m ≠ 0`, which the probe compiled | equal classes decide membership for every pair, zero included: class `0` means a square or zero, whose root is rational. The side condition was the proof's convenience, not the truth, and dropping it costs the cases `n = 0` and `m = 0` | medium-high — the core case is probed; the two zero cases are not |
| D17 | **A parallel naming family that reads aloud**: `fieldOfRadicands`, `fieldOfClasses`, `classesOfField`, `classesOfRadicands`; `twoAdic : SqClass →ₗ TwoAdicSqClass` with the named classes `TwoAdicSqClass.two`, `.three`, `.five`, `.ten`, `.minusOne`; `spanThreeTwo`, `spanThreeTen`; `planeOver` | the planning names `mqField`, `sqrtField`, `kummerClasses`, `classGroup`, `loc2`, `LocTwo`, `locPrime`, `minusOne`, `blockTwo`, `blockTen`, `fieldPlane` | The read-aloud gate's reader holds only the statement text, and the old names told them nothing without a docstring. "block" was coined vocabulary, which G49 says hides prior art. `classGroup` collides with Mathlib's `ClassGroup`, the ideal class group FS-37 will meet. The "X of Y" family predicts its own names: `fieldOfRadicands_eq_fieldOfClasses` reads as its statement | medium-high |
| D18 | **The simp set is `sqClass_zero`, `sqClass_one`, `sqClass_sq`, `mem_planeOver`**; `sqClass_apply` stays by name | tagging `sqClass_apply` as well, which Mathlib does for many `_apply` lemmas | With both `sqClass_apply` and `sqClass_sq` tagged, the critical pair `sqClass (b²) p` is not joinable: one side reduces to `0`, the other sticks at `2 * ↑(b.factorization p)`, since no default simp lemma knows `(2 : ZMod 2) = 0`. The class-level lemmas keep consumers at the class level | high |
| D19 | **The two-colouring is exposed as data**, `normOneColoringTwo` with `normOneColoringTwo_apply` (`@[simp]`), taking the functional `l` explicitly; the `Colorable 2` forms derive from it | only the `Colorable 2` theorems | FS-19 (the 𝔭-adic distance classification) must evaluate the colouring to ask which pairs share a colour. `ResidueColouring` exposes `normOneColoring` for exactly that reason, so the parallel is predictable. The functional is not canonical, which is why it is an argument | medium |
| D20 | **`multiquadratic_decomposition` is kept, docstring-marked as the read-aloud form**, with proofs to use its parts | deleting the five-way conjunction as an API smell | its only consumer is the paper's read-aloud gate, for which one theorem matching the handoff's sentence is the point. It costs nothing (it is assembled from its parts), and the docstring routes proof consumers away | medium-high |
| D21 | **`planeOver` and its three lemmas sit in the root `HadwigerNelson` namespace**; the square-class vocabulary sits in `HadwigerNelson.SquareClass` | everything in `SquareClass` | the plane over a subfield is not about square classes. FS-37 will want `planeOver F` for arbitrary fields, and `FieldWall4` exports `seamPlane` to the root for the same reason | medium-high |
| D22 | **No reader-facing abbreviation for a piece**: it stays `W ⊓ U.comap twoAdic` | an abbreviation such as `piece U W` | the Mathlib expression reads aloud as "the classes of `W` landing in `U`" and carries its API; a new name is one more thing a reader must decompress. The one-line eight-case lemma and the frobenius wrapper become `private` for the same reason (no consumer outside their file) | medium |

---

## 4. Prices

**Measured** (desktop, 32 cores; CPU seconds as user + sys):
- The planning probe `build/probe-sqclass/Probe.lean` imports all of Mathlib plus `FieldWall4` and elaborates in
  **60 s**, including one `exact?` that timed out.
- Each skeleton module elaborates in **1.4–1.9 s** with cached `.olean`s.

| item | measurement |
|---|---|
| the planning skeleton's splitting lemma, by hand | **8 lines, compiled** (probe Q1b) — superseded by D7, whose lifting lemma is the same argument with a weaker hypothesis |
| `x * x = 1 → x = 1` in a reduced ring of characteristic 2 | **7 lines, compiled** (probe Q5) |
| `√2 · √10 = 2 · √5` | **3 lines, compiled** (probe Q7) |
| `exact?` on "even factorization ⟹ square" | **not found** |
| `Algebra (ZMod 2) k` from `CharP k 2` | `exact ZMod.algebra k 2` |
| the reshaped skeleton's one- and two-line proofs | **compile**: the 2-adic splitting from its two lemmas; the four-colour test on any piece; `fieldOfClasses_sup` from the Galois connection; `fieldOfClasses_eq_sup` by one `rw`; `planeOver seamField = seamPlane` by `rfl`; the bundled headline from its parts |

**Estimates**, each against its phase in §8:

| phase | content | code lines, probed where marked | time |
|---|---|---|---|
| A | `TwoColourResidue.lean`: the two char-2 lemmas, the square-root-of-one step, the three forms, the model's two facts, two reds | about 45 (everything but the valuation and plane forms probed, §M2) | two to three hours |
| B1 | `SquareClass.lean` §1–§4: the lifting lemma, the `sqClass` API, `twoAdic` on primes, the block facts, the pointwise and local splittings, the class-group image lemma | about 80 (all probed but the image lemma) | half a day |
| B2 | §5–§7: the generator lemma, `fieldOfRadicands_mono`, the membership iff, the radical identity, `classesOfField`, the connection, `fieldOfRadicands_eq_fieldOfClasses`, the planes, `seamField_le_fieldOfRadicands`, the headline | about 90 (the connection, the iff's core case, the radical identity, the planes and `seamField_le_fieldOfRadicands` probed) | half a day |
| B3 | §8 de Grey's field, and the spec | about 50 | two hours |
| C (optional) | `K(√14) · K(√70)` holds Heule-510 in the kernel (§8) | ≤ 150 | half a day |

**Total for A + B: about a day**, down from the planning estimate of 1.5–2 days. The obligation pass probed every
risky leaf against the committed definitions (§M2), and the lemmas it moved into the skeleton make each remaining
leaf local.

---

## 5. The skeleton

Both files are the specification: every signature and every full statement, with `sorry` at every leaf. The table says
what each statement is; the file says it exactly. Names are provisional until the experience pass (§M3).

### 5.1 `TwoColourResidue.lean`

| name | the statement, in words | proof, at leaf size |
|---|---|---|
| `eq_one_of_mul_self_eq_one_of_charTwo` (**private**) | in a reduced ring of characteristic 2, `x · x = 1` forces `x = 1` | `frobenius_inj`, or `(x + 1)² = 0` then reducedness (probe Q5) |
| `exists_addMonoidHom_zmod_two_apply_one_ne_zero` | a ring of characteristic 2 has an additive map to `ZMod 2` nonzero at `1` | `letI := ZMod.algebra k 2`; vector spaces are projective; `Module.forall_dual_apply_eq_zero_iff` at `v = 1 ≠ 0` |
| `map_mul_self_eq_one_of_mem_normOne_of_conj_eq` | if conjugation fixes every residue, a norm-one element's residue squares to `1` — no hypothesis on the residue ring | `← map_mul`, rewrite `ψ (σ u) = ψ u` backwards, `u · σ u = 1` |
| `map_eq_one_of_mem_normOne_of_conj_eq` | …and in a reduced ring of characteristic 2 it is `1` | **written**: the two lemmas above |
| `normOneColoringTwo`, `normOneColoringTwo_apply` | **the two-colouring as data** (D19), through an explicit functional `l`; its value is `l` of the coset residue (`@[simp]`, `rfl`) | the colouring function is **written**; its properness is the leaf: `cosetResidue_eq_iff`, then `map_eq_one_of_mem_normOne_of_conj_eq` and `hl` |
| `colorable_two_of_normOne_of_conj_eq` | ring form: a graph drawn in `L` with integral norm-one edge differences is 2-colourable | **written**: `exists_addMonoidHom_zmod_two_apply_one_ne_zero`, then `normOneColoringTwo`'s `.colorable` |
| `colorable_two_of_valuationSubring_of_conj_eq` | valuation form: integrality is free | the ring form plus `normOne_subset_valuationSubring` |
| `colorable_two_unitDistance_induce_of_valuationSubring` | **the headline**: plane form, mirroring Theorem A | copy `colorable_unitDistance_induce_of_valuationSubring`'s proof |

### 5.2 `SquareClass.lean`

| § | name | the statement, in words |
|---|---|---|
| 1 | `inf_comap_sup_inf_comap_eq` | if `f(W) ≤ (f(W) ⊓ U₁) ⊔ (f(W) ⊓ U₂)`, then `W` is the sum of its preimages of `U₁` and `U₂` |
| 2 | `SqClass`, `sqClass` | `Nat.Primes →₀ ZMod 2`; a natural number's prime exponents mod 2 (junk `0` at `0`) |
| 2 | `sqClass_zero`, `sqClass_one`, `sqClass_mul`, `sqClass_prime` | the junk value stated; multiplicative on nonzero naturals; a prime's class is its basis vector |
| 2 | `isSquare_of_sqClass_eq_zero` | a nonzero natural with trivial class is a perfect square |
| 2 | `exists_sqClass_eq` | every class is a nonzero natural's class |
| 2 | `classesOfRadicands` | the span of the classes of a set of radicands |
| 2 | `sqClass_apply`, `sqClass_sq` | the coordinate formula, **written** as `rfl`; a square's class is 0 |
| 3 | `TwoAdicSqClass`, `twoAdicOfPrime`, `twoAdic`, `twoAdic_sqClass_prime` | `(ZMod 2)³` in coordinates `(−1, 5, 2)`; the table on primes; its linear extension; agreement on primes |
| 3 | `TwoAdicSqClass.two`, `.three`, `.five`, `.ten`, `.minusOne`; `spanThreeTwo`, `spanThreeTen` | the named 2-adic classes; the subgroups `{1,3,2,6}` and `{1,3,10,14}` |
| 3 | `minusOne_not_mem_spanThreeTwo`, `…_blockTen` | neither plane holds `[−1]` |
| 3 | `mem_spanThreeTwo_or_mem_spanThreeTen_or_add_two_mem` (**private**) | every class is in one of the spans, or in `spanThreeTen` after adding `[2]` — the eight cases, by `decide` |
| 3 | `le_inf_spanThreeTwo_sup_inf_spanThreeTen` | every local subgroup holding `[2]` splits along the two blocks |
| 3 | `twoAdic_sqClass_three`, `twoAdic_sqClass_eleven` | both localize to `[3]` |
| 4 | `inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen` | **the 2-adic splitting**: a square-class group holding `[2]` is the sum of its two pieces — **written** from the two lemmas |
| 4 | `minusOne_not_mem_map_inf_comap` | a piece cut by a plane avoiding `[−1]` passes the test — **written** |
| 4 | `sqClass_mem_inf_comap` | a class in `W` localizing into `U` lies in the piece — **written** |
| 4 | `map_twoAdic_classesOfRadicands_le_iff` | a class group's image lies in a plane iff every radicand's class does |
| 5 | `fieldOfRadicands`, `fieldOfClasses`, `classesOfField` | `ℚ(√d : d ∈ D)`; `fieldOfRadicands` of the naturals whose class lies in `W`; the classes of the **nonzero** naturals whose roots lie in `F` (D15) |
| 5 | `sqrt_mem_fieldOfRadicands`, `fieldOfRadicands_mono` | the generators, **written**; monotonicity in the radicand set |
| 5 | `sqrt_mem_iff_of_sqClass_eq` | equal classes carry membership of the root, both ways, with no side condition (D16) |
| 5 | `sqrt_mul_sqrt_eq` | `a · b = s² · c` gives `√a · √b = s · √c` |
| 5 | `gc_fieldOfClasses_classesOfField` | **the Galois connection** |
| 5 | `fieldOfClasses_sup` | the field of a sum is the compositum — **written** as `gc.l_sup` |
| 5 | `fieldOfRadicands_eq_fieldOfClasses` | `ℚ(√D)` is the field of its square-class group |
| 5 | `fieldOfClasses_eq_sup` | the decomposition for a group holding `[2]` — **written** |
| 6 | `planeOver`, `planeOver_seamField` | `{z : ℂ \| z.re ∈ F ∧ z.im ∈ F}`; at `seamField` it *is* `seamPlane` — **written**, `rfl` |
| 6 | `mem_planeOver`, `seamField_le_fieldOfRadicands` | membership, **written** as `Iff.rfl`; `seamField` lies in `fieldOfRadicands {3, 11}`, the field generated by `√3` and `√11` |
| 6 | `four_le_chromaticNumber_planeOver`, `seamField_le_fieldOfClasses` | a plane over a field containing `ℚ(√3,√11)` needs four colours; `[3], [11] ∈ W` puts `ℚ(√3,√11)` in `fieldOfClasses W` |
| 7 | `fieldOfRadicands_le_sup` | **every real multiquadratic field lies in the compositum of the fields of `classesOfRadicands (insert 2 D)`'s two pieces** — no hypothesis |
| 7 | `four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap` | with `3, 11 ∈ D`, each piece cut by a plane through `[3]` has a plane needing four colours |
| 7 | `multiquadratic_decomposition` | **the handoff's statement, bundled for reading aloud** — **written** from its parts |
| 8 | `fieldOfRadicands_deGrey_le_sup`, `map_twoAdic_deGreyTwo_le`, `map_twoAdic_deGreyTen_le` | de Grey's field in `ℚ(√2,√3,√11,√35) · ℚ(√3,√10,√11,√35)`; each factor's 2-adic classes lie in a subgroup avoiding `[−1]`, and an `example` draws the four-colour test from each |

*After the experience pass (§M3), `planeOver`, `mem_planeOver`, `planeOver_seamField` and `four_le_chromaticNumber_planeOver` sit in §0 of the file, in the root `HadwigerNelson` namespace (D21).*

**Elaboration status.**
- **Planning skeleton (committed at `ab300bd`):** `./scripts/build.sh` OK on 170 batches, rebuilding
  `TwoColourResidue` in 1.4 s, `SquareClass` in 1.7 s and `Proofs` in 1.3 s (3 min 21 s wall on the desktop; log
  `build/gate/build/20260911T165548Z-2264217.log`); `tools/check_architecture.py` passes.
- **Reshaped skeleton (§M1):** `./scripts/build.sh` OK on 170 batches, rebuilding `TwoColourResidue` in 1.5 s,
  `SquareClass` in 1.8 s and `Proofs` in 1.3 s (3 min 20 s wall; log `build/gate/build/20260911T172221Z-2301410.log`);
  `tools/check_architecture.py` PASS (138 of 138 module rows, 0 import mismatches).
- **After the obligation pass (§M2):** `./scripts/build.sh` OK on 170 batches, rebuilding `TwoColourResidue` in 1.5 s,
  `SquareClass` in 1.9 s and `Proofs` in 1.4 s (3 min 20 s wall; log `build/gate/build/20260911T174316Z-2333696.log`);
  `tools/check_architecture.py` PASS.
- **After the experience pass (§M3), the shape handed to the implementer:** `./scripts/build.sh` OK on 170 batches,
  rebuilding `TwoColourResidue` in 1.6 s, `SquareClass` in 1.9 s and `Proofs` in 1.4 s (3 min 21 s wall; log
  `build/gate/build/20260911T175812Z-2359781.log`); `tools/check_architecture.py` PASS (138 of 138 rows).

---

## 6. Sanity examples and models of every hypothesis

| declaration | the check that would fail if it drifted | where |
|---|---|---|
| `twoAdicOfPrime` | `#guard`s at 2, 3, 5, 7, 11, 17 | `SquareClass` §9 |
| `sqClass` | `sqClass 12 = sqClass 3` | §9 |
| `twoAdic` | `twoAdic (sqClass 35) = (1, 1, 0)` — `[5] + [−1] = [3]` | §9 |
| `spanThreeTwo` | `[6] ∈ spanThreeTwo`, `[10] ∉ spanThreeTwo` | §9 |
| `fieldOfRadicands` | `√5 ∈ fieldOfRadicands {2, 10}` | §9 |
| `planeOver` | `(√3, 1) ∈ planeOver seamField` | §9 |
| `inf_comap_sup_inf_comap_eq`'s hypothesis | **red**: in `𝔽₂²` the diagonal meets both axes in `0` | §9 |
| the splitting's `[2] ∈ W` | **red**: `classesOfRadicands {7}` does not split — `[7] = [−1]` lies in neither block. **Model**: de Grey's field (§8 of the file, and the `example` applying `fieldOfRadicands_le_sup` at `{3, 5, 7, 11}`) | §8, §9 |
| the two-colour theorems, all forms | **model**: the named theorem `colorable_two_cycleGraph_four_of_gaussResidue` applies the ring form to `ℤ[i]`, with its nontrivial conjugation `starRingEnd GaussianInt`, the residue `a + bi ↦ a + b (mod 2)`, and the 4-cycle drawn at `0, 1, 1+i, i`. Its two leaves are the model's facts: the residue ignores conjugation, and the square's edges are unit vectors. It carries no local instance | `TwoColourResidue` §4 |
| `hψσ` | **red**: in `F4` with Frobenius, `Ω · Ω² = 1` and `Ω ≠ 1` — Theorem B's own residue field | §4 |
| `CharP k 2` | **red**: in `ZMod 3`, `2 · 2 = 1` and `2 ≠ 1` | §4 |

**The vacuity gate.** Each headline whose hypothesis is a structure needs a named inhabitant in its own file, or a
one-line note naming the theorem that supplies one.
- **Two-colour theorems.** The applied `ℤ[i]` model inhabits the ring form. The valuation and plane forms take a
  `ValuationSubring` binder, and the gate did not treat that binder as a site for Theorem A's own valuation form
  (its latest log has no row for `colorable_of_valuationSubring`).
  - Their non-vacuity is Woodall's case, `ℚ(i)` at `1 + i`, which only FS-37's machinery could construct. Say so in
    a one-line note, as `ResidueColouring.lean` does.
  - Say also that over `L = ℂ` the hypotheses cannot be met, which is why the subfield is load-bearing (§M1,
    adversary).
- **Square-class theorems.** They are generic over submodules; de Grey's instance is their model.

---

## 7. The headlines, read aloud against the informal claims

### `colorable_two_unitDistance_induce_of_valuationSubring`

*Let `L` be a subfield of `ℂ` closed under complex conjugation, `A` a valuation subring of `L` that conjugation maps
into itself, and `ψ` a ring homomorphism from `A` to a reduced ring of characteristic two that takes the same value
on `z` and on its conjugate. Then every unit-distance graph drawn in `L` is 2-colourable.*

- **Against the informal claim** "if `[−1], [3] ∉ V₂(F)` then `χ(F²) = 2`": the arithmetic hypothesis is replaced by
  the two properties its proof uses. The prime above 2 is fixed by conjugation (`A` is conjugation-stable), and
  conjugation lies in its inertia group (`ψ` does not see conjugation).
- **What it does not say:** that a multiquadratic `F` passing the test supplies such an `A`. That is FS-37, and the
  docstring must say so.
- **Why the characteristic-two hypothesis is not decoration:** the `ZMod 3` red.
- **Why the functional is additive:** the `ℚ(√5)` remark in the docstring (D10).

### `fieldOfRadicands_le_sup`, with `four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap` and `minusOne_not_mem_map_inf_comap`

*For every set `D` of natural numbers, with `W` the square-class group of `D ∪ {2}`, the field `ℚ(√d : d ∈ D)` lies
in the compositum of the fields of `W`'s classes localizing into `{1,3,2,6}` and of those localizing into
`{1,3,10,14}`. If `D` contains 3 and 11, the plane over each of those two fields needs at least four colours, and
neither field's square classes contain `[−1]` in their 2-adic image.*

- **Against the handoff's §5** ("every finite real multiquadratic `F ⊇ K` has `K ⊆ A, B ⊆ F(√2)` with
  `χ(A²) = χ(B²) = 4` and `F ⊆ AB`"):
  - **Containment:** the kernel carries it, and more generally — the containment needs no `K`.
  - **`≥ 4`:** the kernel carries it, from `[3], [11]`.
  - **The test's hypothesis:** the kernel carries it; it is stated on the generating classes, which is exactly what
    the test reads, since the completion of `ℚ(√W)` at 2 is `ℚ₂(√twoAdic(W))`.
  - **`≤ 4`:** the kernel does **not** carry it — that is the test itself at the field level (FS-37).
- **Against `A, B ⊆ F(√2)`:** the pieces are subgroups of `W`, so their fields lie in `fieldOfClasses W`, by
  `gc_fieldOfClasses_classesOfField.monotone_l`. Worth one `example` in the spec.
- **One reading trap:** `TwoAdicSqClass` is a coordinate model of `ℚ₂^×/(ℚ₂^×)²` whose correctness is Hensel's lemma, not a
  kernel theorem. `twoAdicOfPrime`'s docstring says so, and the read-aloud must too.

### `fieldOfRadicands_deGrey_le_sup`, with its two `minusOne_not_mem_map_classGroup_…` lemmas

*De Grey's coordinate field `ℚ(√3,√5,√7,√11)` lies in `ℚ(√2,√3,√11,√35) · ℚ(√3,√10,√11,√35)`, and the square
classes generating each factor have no `[−1]` in their 2-adic span.*

This is the handoff's worked example verbatim, minus `χ = 4` for the factors. The identification of these explicit
factors with the general theorem's pieces is `independent_check.py`'s (tools); in the kernel it is optional (§8,
Phase C).

---

## 8. Phases, stop rules and traps

**Routes.** §M2 gives every leaf's proof route, and code for each leaf that took more than one attempt, all probed
against the committed definitions. The orders below follow it.

### Phase A — `TwoColourResidue.lean`

- **Order:** the two char-2 lemmas, the square-root-of-one step, the ring form, the valuation form, the plane form,
  the model's two facts, the reds.
- **Stop rule:** if the dual-functional lemma resists past 40 lines:
  - take the functional as an explicit hypothesis `(l : k →+ ZMod 2) (hl : l 1 ≠ 0)` in the three forms;
  - prove the existence lemma for `k = ZMod 2` only (`l = id`);
  - record the downgrade.

### Phase B1 — `SquareClass.lean` §1–§4

- **Order:**
  1. the lifting lemma (the probe's Q1b argument, with `Submodule.mem_sup` applied to the image);
  2. `sqClass_zero`, `sqClass_one`, `sqClass_mul`, `sqClass_prime`;
  3. `twoAdic_sqClass_prime`, `twoAdic_sqClass_three`, `twoAdic_sqClass_eleven`;
  4. the block facts (`Submodule.mem_span_pair` and a four-case `decide`);
  5. the local splitting (case analysis on the eight elements of `TwoAdicSqClass`: in a block, or `[5]` / `[−1]`, which
     `[2]` carries into `spanThreeTen`).
- **Stop rule:** if `Finsupp.comapDomain` fights for more than 60 lines, redefine `sqClass` through
  `Finsupp.onFinset n.primeFactors`, and record the change.

### Phase B2 — §5–§7

- **Order:**
  1. `isSquare_of_sqClass_eq_zero` via `Nat.sq_mul_squarefree` (a squarefree natural with all exponents even is 1);
  2. `exists_sqClass_eq` (the product of the support's primes, by `Finset.induction`);
  3. `classesOfField`'s three closure fields (`√a · √b = √(ab)`; `c : ZMod 2` by cases);
  4. `gc_fieldOfClasses_classesOfField`:
     - (→) a class in `W` is some `n`'s class, and `√n` is a generator;
     - (←) a generator `√n` with `sqClass n = sqClass m` and `√m ∈ F` has `n · m = s²`, so `√n = s / √m`, with
       `m = 0` or `n = 0` trivial;
  5. `fieldOfRadicands_eq_fieldOfClasses` (both directions through the connection);
  6. the planes;
  7. `fieldOfRadicands_le_sup` (from `fieldOfRadicands_eq_fieldOfClasses` at `insert 2 D`, monotonicity, and
     `fieldOfClasses_eq_sup`);
  8. the `χ ≥ 4` lemma.
- **Stop rule:** if B2 passes 250 lines or a day, land B1 and B3 (B3 does not need B2) and report B2 **not landed**,
  naming the lemma that resisted.

### Phase B3 — de Grey's field

`√5 = √2 · √10 / 2` and `√7 = √35 · √5 / 5` (the probe's Q7 pattern), then `Subfield.closure_le`, then the two span
facts through `Submodule.map_span`.

### Phase C — optional, only if A and B landed under their prices

Two items, independent:
1. **Heule-510 into the compositum, in the kernel.** Put Heule-510 into `planeOver (fieldOfRadicands {3, 11, 14, 70})`:
   - `Q4.eval` of a `√7`-free element lies in `fieldOfRadicands {3, 5, 11}`;
   - `√5 = √70 / √14` lies in `fieldOfRadicands {3, 11, 14, 70}`;
   - conclude `5 ≤ χ` from `chromaticNumber_heule510` through a graph homomorphism.

   This makes the handoff's item 2 a kernel fact: two fields passing the test whose compositum's plane needs five
   colours. **Stop rule:** half a day. **Risk:** how `heule510.point` relates to `Pt.toPlane` in `ℂ`.
2. **De Grey's factors are the pieces, in the kernel.** `fieldOfClasses (classesOfRadicands {2,3,5,7,11} ⊓ spanThreeTwo.comap twoAdic) =
   fieldOfRadicands {2, 3, 11, 35}`, and the same for `spanThreeTen`. The `≥` direction is four membership checks. The `≤`
   direction is a 32-case analysis on the classes of `{2,3,5,7,11}`. **Stop rule:** two hours.

### Traps

1. `σ.restrict A A hσ` — copy the coercion pattern from `ResidueColouring.map_mul_conj_eq_zero_iff`.
2. `Module (ZMod 2) k` does not exist until you make it: `letI := ZMod.algebra k 2`. Vector spaces are projective
   through `Module.Projective.of_free` and `Module.Free.of_divisionRing`.
3. **`IsReduced (ZMod 2)` needs the import `Mathlib.Algebra.Field.ZMod`** (found at the domain pass by tracing the
   instance search; §2). The module imports it. `Fact (Nat.Prime 2)` is a global instance, so a consumer at
   `k = ZMod 2` needs nothing more: the named model carries no local instance.
4. `Real.sqrt (n : ℝ)` needs `Nat.cast_nonneg` at every `Real.sqrt_mul`.
5. `lake env lean` without `-DautoImplicit=false` auto-binds stray identifiers: green there is not green.
6. **`tools/fplane.py usable` tests radicands one at a time.** `--rads 22,33` wrongly passes at 11. Do not use it for
   groups with two radicands divisible by the same prime (`VERIFICATION.md` §3).
7. **The skeleton's written proofs lean on leaves.**
   - `inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen`'s `simpa [twoAdic_sqClass_prime Nat.prime_two, twoAdicOfPrime]` needs
     `twoAdic_sqClass_prime` to state `twoAdicOfPrime p` exactly.
   - `multiquadratic_decomposition`'s `Submodule.subset_span (Set.mem_insert _ _)` needs `(1, 1, 0)` first in both
     block spans.

   If you reorder either, fix the written proof.
8. **Mutation audit** (G30 failure mode 6), required before the close. Delete in turn:
   - the lifting lemma's hypothesis;
   - `h2` from the 2-adic splitting;
   - `hψσ` from `map_mul_self_eq_one_of_mem_normOne_of_conj_eq`;
   - `CharP k 2` from the first lemma;
   - `h3` from the `χ ≥ 4` lemma.

   Each deletion must break the file. The control — an unused hypothesis added to a lemma nobody calls — must stay
   green.
9. **Headline docstrings state what is not proved** (the §R2 gap; `χ ≤ 4` for the pieces). A docstring that implies
   more fails the read-aloud.
10. **`Subfield.subset_closure` cannot infer its set through `fieldOfRadicands` or `fieldOfClasses`** when an anonymous constructor
    supplies the membership, so use `sqrt_mem_fieldOfRadicands`, which names the image. (Inside the connection's proof the
    expected type is fixed by the hypothesis, and `⟨n, hv, rfl⟩` works.)
11. **An anonymous constructor cannot see through `planeOver` or `seamPlane`**: go through `mem_planeOver` and
    `FieldWall4.mem_seamPlane_iff`.
12. **`simp` does not rewrite an `if` whose condition is an equality of subtypes** after `ext ⟨q, hq⟩`; split with
    `by_cases h : p = q` first (§M2, `sqClass_prime`).
13. **`(0 : SqClass) ⟨p, hp⟩` does not simplify to `0` inside `simpa`**: state `show sqClass a ⟨p, hp⟩ = 0`, then
    `rw [hca]; rfl`.
14. **`fin_cases` on `ZMod 2` leaves `Fin` literals** that `zero_smul` and `one_smul` do not match: split with
    `(by decide : ∀ c : ZMod 2, c = 0 ∨ c = 1) c`.
15. **`ZMod.algebra` needs `Mathlib.Algebra.Algebra.ZMod`**. Without the import, Lean reads `ZMod.algebra` as field
    notation on the function `ZMod` and reports `Function.algebra`. The skeleton now imports it. Pass it as
    `letI := ZMod.algebra k 2`; `(ZMod.algebra k 2).toModule` is not usable field notation.

---

## 9. The acceptance test

1. `./scripts/build.sh` green.
2. Zero `sorry` in both modules (`rg -n sorry Proofs/HadwigerNelson/TwoColourResidue.lean Proofs/HadwigerNelson/SquareClass.lean`).
3. Every public declaration below is registered in `scripts/Axioms.lean` under a new section, and
   `./scripts/axioms.sh` reads the standard three for each. Its count moves by exactly the number registered.
   - `TwoColourResidue`:
     - `exists_addMonoidHom_zmod_two_apply_one_ne_zero`
     - `map_mul_self_eq_one_of_mem_normOne_of_conj_eq`
     - `map_eq_one_of_mem_normOne_of_conj_eq`
     - `normOneColoringTwo`
     - `colorable_two_of_normOne_of_conj_eq`
     - `colorable_two_of_valuationSubring_of_conj_eq`
     - `colorable_two_unitDistance_induce_of_valuationSubring`
     - `colorable_two_cycleGraph_four_of_gaussResidue`
   - `SquareClass`, root namespace: `four_le_chromaticNumber_planeOver`.
   - `SquareClass`, namespace `SquareClass.`:
     - `inf_comap_sup_inf_comap_eq`
     - `isSquare_of_sqClass_eq_zero`
     - `exists_sqClass_eq`
     - `le_inf_spanThreeTwo_sup_inf_spanThreeTen`
     - `inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen`
     - `minusOne_not_mem_map_inf_comap`
     - `map_twoAdic_classesOfRadicands_le_iff`
     - `sqrt_mem_iff_of_sqClass_eq`
     - `gc_fieldOfClasses_classesOfField`
     - `fieldOfRadicands_eq_fieldOfClasses`
     - `fieldOfClasses_eq_sup`
     - `fieldOfRadicands_le_sup`
     - `four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap`
     - `multiquadratic_decomposition`
     - `fieldOfRadicands_deGrey_le_sup`
     - `map_twoAdic_deGreyTwo_le`
     - `map_twoAdic_deGreyTen_le`
4. `./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` green. Read the digest's count changes and put the
   new counts into `CLAUDE.md` § The gate.
5. `python3 tools/check_architecture.py` PASS, with the two rows' "Skeleton (FS-36)" removed and the row column set
   if a ledger row lands.
6. `python3 tools/bib_audit.py` reports zero unlogged works.
7. The spec examples and reds of §6 pass, and the mutation audit of §8 trap 8 is recorded in §R.
8. §7's paragraphs are re-read against the finished statements, and any change is written into §R.

---

## 10. What the close records (WORKFLOW step 9)

1. **Ledger row 63 — recommended as earned, modestly.** Draft (about 900 characters; `CLAUDE.md` is at 83,624 of its
   90,000):

   > | 63 | **Two colours from inertia, and the 2-adic splitting of multiquadratic fields**: a residue map into a reduced
   > characteristic-2 ring that conjugation does not move two-colours every unit-distance graph over its valuation
   > subring (`colorable_two_unitDistance_induce_of_valuationSubring`); a square-class group holding [2] is the sum of
   > two pieces whose 2-adic images avoid [−1], so every real multiquadratic field lies, once √2 is adjoined, in the
   > compositum of two fields that pass the four-colour test (`fieldOfRadicands_le_sup`) — each holding a Moser spindle when
   > the field contains ℚ(√3,√11); de Grey's field lies in ℚ(√2,√3,√11,√35)·ℚ(√3,√10,√11,√35). [hand] For real
   > multiquadratic F, χ(F²) = 2 iff no odd square class is ≡ 3 (mod 4). **Credit:** the decomposition is ChatGPT's
   > (OpenAI, with Kooshi, 2026-09-11). **Prior art:** the mechanism is Woodall's, `[Fischer1990]` Thm 8,
   > `[Moorhouse2010]` Thm 7.1, `[Madore2015]` Prop. 3.9; the multiquadratic iff is unchecked against
   > `[AxenovichEtAl2014]` and `[Johnson2006]`. | `TwoColourResidue.lean`, `SquareClass.lean` | FS-36 |

   If Phase B2 does not land, reduce "lies … in the compositum" to the class-level splitting and say so.
2. **`CLAUDE.md` § Frontier.**
   - "What the hunt has established": one clause, or none — this is not hunt material.
   - Extend G38 by one sentence: with conjugation in inertia the reduced norm-one group is trivial, so a real
     multiquadratic plane is 2-colourable iff no odd square class is `≡ 3 (mod 4)`. This corrects the field-wall
     note's Proposition 6.4 (§10.2 there).
   - Paths forward: add FS-37.
3. **`plans/FRONTIER-STUBS.md`.**
   - FS-36 goes to the closed list with one line.
   - Add FS-37 (`plans/STUB-field-level-criteria.md`) to the ranked table. Its bearing on χ ≥ 6 is none; it feeds
     FS-20's Theorem A section. A rank near FS-19 is the planning agent's suggestion.
   - Assert on the written file that each of FS-1 … FS-37 appears exactly once as a row.
4. **`CLOSED-QUESTIONS.md`.** A §2 row: `[Krebs2022]` Remark 2.3 and `[Fischer1990]` §1, answered for real
   multiquadratic fields at the value 2, as a hand theorem, with `[AxenovichEtAl2014]` and `[Johnson2006]` in its
   prior-art column. **Kooshi's call whether it enters §1 or §2.**
5. **`plans/STUB-theorem-B-writeup.md` (FS-20).** One paragraph:
   - the decomposition is a candidate proposition for the paper's field section, with its credit line;
   - the two-colour case is Theorem A's natural companion, and it dissolves Madore's "slight difficulty" in
     Prop. 3.9;
   - the Galois connection (D9) is the field-to-class-group dictionary the paper will need anyway.
6. **`plans/STUB-consolidation-remainder.md` (FS-27) §5.** One line: `tools/fplane.py usable` must test the whole
   square-class group, not each radicand.
7. **`reference/ChatGPT-multiquadratic/VERIFICATION.md` §4.** Move the skeleton row to "kernel" for whatever landed.

---

## 11. Registered predictions

| # | prediction | falsified by |
|---|---|---|
| P1 | Phase A lands in ≤ 180 code lines | a count above 180 |
| P2 | Phase B lands in ≤ 430 code lines (B1 + B2 + B3) | a count above 430 |
| P3 | `isSquare_of_sqClass_eq_zero` is B's longest leaf | another leaf longer |
| P4 | the Galois connection needs nothing Kummer-theoretic beyond `exists_sqClass_eq` and the square lemma | any appeal to the linear independence of square roots |
| P5 | no existing module is edited except `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` | any other edit |
| P6 | `frobenius_inj` closes `eq_one_of_mul_self_eq_one_of_charTwo` in ≤ 3 lines | a longer proof |
| P7 | the local splitting closes by case analysis on the eight elements of `TwoAdicSqClass` in ≤ 25 lines | a longer proof, or a proof that needs a dimension argument |

---

## §M1 — Domain-modeling pass (2026-09-11)

*A fresh invocation of `debruijn-domain-modeling`, scoped to FS-36's two skeleton modules. It changed the shape
of `SquareClass.lean` substantially and of `TwoColourResidue.lean` slightly; §1–§11 above already describe the result.
This section records what moved and why.*

### Grokking — what the simulation found before any rewrite

1. **The planning skeleton's splitting hypotheses were stronger than the truth.** Run by hand over the eight
   elements of `ℚ₂^×/(ℚ₂^×)²`, `blockTwo ∪ blockTen = {1, 3, 2, 6, 10, 14}` leaves only `[5]` and `[−1]` outside. `[2]`
   carries each into `blockTen` (`2 · 5 = 10`, `2 · 7 = 14`), so **every subgroup holding `[2]` splits**. `[3]` is not
   needed, and neither was the old lemma's hypothesis `U₁ ≤ W.map f`.

   The subgroups that fail to split are exactly `{1,5}`, `{1,7}` and `{1,3,5,7}` — measured afterwards, on all 16,
   by `independent_check.py` §5, not taken from the simulation.
   - `[3]` and `[11]` are needed only for "each piece contains `ℚ(√3,√11)`".
   - The containment `ℚ(√D) ≤ A ⊔ B` holds for **every** real multiquadratic field, not only those containing `K`.
2. **`hD : 0 ∉ D` was never used.** `√0 = 0` lies in every field, so the junk value `sqClass 0 = 0` is harmless at every
   field statement.
3. **Six declarations were identical modulo naming.** They were `minusOne_not_mem_map_pieceTwo`/`…Ten` and the four
   `sqClass_{three,eleven}_mem_piece{Two,Ten}`. The unnamed role is "the classes of `W` localizing into a plane `U`",
   which Mathlib already spells `W ⊓ U.comap loc2`.
4. **The hardest leaf was predicted before writing.** It is `isSquare_of_sqClass_eq_zero` (no Mathlib lemma), and
   every field-level statement routes through it plus `exists_sqClass_eq`. That concentration of cost is what (§
   deconstruct) looks for a named structure to absorb.

### Reframes walked, and where each landed

| reframe | question | verdict |
|---|---|---|
| function or relation | is `sqrtField` a function with ad-hoc monotonicity, or one side of an adjunction? | **adjunction** (D9). `kummerClasses F`, the classes of the naturals whose roots lie in `F`, is a submodule with no appeal to independence of square roots, and `sqrtField ⊣ kummerClasses`. The skeleton's `sqrtField_sup` becomes `gc.l_sup` in one line, and `sqrtField_eq_sup` one `rw` after it — both **written and compiled** |
| data or proof, quotient or canonical form | is the two-colour theorem about a functional, a quotient `k ⧸ H`, a ring hom to `𝔽₂`, or Fischer's `Σ₀`? | **the functional** (D10); the `ℚ(√5)` case (residue `𝔽₄`, no ring hom to `𝔽₂`) is the witness that additivity is the content |
| which hypothesis, placed where | `ψ ∘ σ = ψ` pointwise, as an equation of homs, or as Mathlib's `AddSubgroup.inertia`? one lemma to `ψ u = 1`, or two steps? | **pointwise, and split** (D11). This puts the three conjugation hypotheses on one ladder (none / kernel-stable / inertia ↔ `\|k\|` colours / the valuation law / two colours), and names the characteristic-free step `ψ u · ψ u = 1` |
| indexed or side predicate | `ℕ+` as the radicand carrier? | **no** (D12): the junk at `0` is harmless, and Mathlib's factorization API is on `ℕ` |
| bridging case | the splitting over any `(U₁, U₂)` | **the lifting lemma** `inf_comap_sup_inf_comap_eq`: its hypothesis, "the image splits", is necessary as well as sufficient, because the kernel lies in both pieces. The local lemma is then a finite fact about `𝔽₂³` |
| the catalog | is `LocTwo` better as `(ZMod 8)ˣ × ZMod 2`, or `ℚ₂^×/(ℚ₂^×)²` itself? | **kept** `(ZMod 2)³` (D4): `Submodule (ZMod 2)` needs the additive form; `ℚ₂` would cost Hensel's lemma for no consumer |

### What moved, in the files

| planning skeleton (`ab300bd`) | after §M1 |
|---|---|
| `le_inf_comap_sup_inf_comap (h₁ : U₁ ≤ W.map f) (h : W.map f ≤ U₁ ⊔ U₂)` | `inf_comap_sup_inf_comap_eq (h : W.map f ≤ (W.map f ⊓ U₁) ⊔ (W.map f ⊓ U₂))`, an equality |
| `blockTwo_sup_blockTen` | deleted: no consumer after the reshaping |
| — | `le_inf_blockTwo_sup_inf_blockTen (h2 : [2] ∈ V)`: the local splitting |
| `pieceTwo`, `pieceTen` + six mirrored lemmas | `W ⊓ U.comap loc2` + `minusOne_not_mem_map_inf_comap`, `sqClass_mem_inf_comap` (both **written**), `loc2_sqClass_three`, `loc2_sqClass_eleven` |
| `pieceTwo_sup_pieceTen (h2) (h3)` | `inf_comap_blockTwo_sup_inf_comap_blockTen (h2)` — **written** |
| `sqrtField` (its own closure), `sqrtField_mono`, `sqrtField_sup`, `mqField_le_sqrtField_span (hD : 0 ∉ D)` | `sqrtField W := mqField {n \| sqClass n ∈ W}`, `kummerClasses`, `gc_sqrtField_kummerClasses`, `sqrtField_sup` (**written**), `mqField_eq_sqrtField_classGroup` |
| — | `classGroup D`, `sqClass_zero`, `sqClass_one` |
| `mqField_le_sup_pieces (hD) (h3) (h11)`, a five-way conjunction | `mqField_le_sup D` (no hypothesis); `four_le_chromaticNumber_fieldPlane_sqrtField_inf_comap (h3) (h11) (hU)`; `multiquadratic_decomposition (h3) (h11)` bundled for reading aloud — **written** from its parts |
| — | `fieldPlane_seamField : fieldPlane seamField = seamPlane := rfl` — **written** |
| the model `example : (cycleGraph 4).Colorable 2 := sorry` | the model **applies** `colorable_two_of_normOne_of_conj_eq` to `ℤ[i]` with `starRingEnd GaussianInt`; its two leaves are the model's facts |
| `map_eq_one_of_mem_normOne_of_conj_eq` as one leaf | `map_mul_self_eq_one_of_mem_normOne_of_conj_eq` (no hypothesis on `k`), then `map_eq_one_of_mem_normOne_of_conj_eq` **written** from it |
| — | reds: `classGroup {7}` does not split (`[2]` is load-bearing) |

### What did not move, and why

- **The three forms of the two-colour theorem** (D2). The mirror of Theorem A's API is intrinsic to the consumer.
- **`fieldPlane`** is the same shape as `FieldWall4.seamPlane`, now proved equal to it by `rfl`.
- **`mqField`** stays the literal `Subfield.closure (√ '' D)`. The read-aloud gate prefers the literal definition, and
  the Galois connection makes it equal to `sqrtField (classGroup D)` anyway.
- **The explicit de Grey statement** stays a direct radical-identity check (Phase B3); the general theorem's instance
  sits beside it as an `example`, and identifying the two is optional (Phase C item 2).
- **The `FieldWall4` import in `TwoColourResidue`** (D14).

### Seams validated

- **Instruments before re-reading.**
  - The reshaped `SquareClass.lean` elaborates with no error under `lake env lean -DautoImplicit=false`, including the
    six written proofs.
  - `TwoColourResidue.lean` surfaced one seam: instance search does not find `IsReduced (ZMod 2)` from its imports
    (§8 trap 3).
  - `independent_check.py` §5 measures the local splitting claim on all 16 subgroups.
- **Unsampled members.**
  - `D = ∅`: `mqField ∅ = ℚ`, `W = ⟨[2]⟩`, and the pieces are `W` and `⊥`. The statement holds and says
    `ℚ ≤ ℚ(√2) ⊔ ℚ`.
  - `0 ∈ D`: harmless.
  - A non-squarefree radicand (4): class 0, `√4 = 2 ∈ ℚ`.
  - A prime `≡ 1 (mod 8)` (17): localizes to 0 and lies in both pieces.
- **Adversarial member (two-colour theorem).** Over `L = ℂ` the valuation form's hypotheses cannot be met — else the
  plane would be 2-colourable, and it contains triangles. The same holds with `A = ⊤`, since a field of
  characteristic 0 has no ring hom to a characteristic-2 ring. So the hypotheses are strong enough to exclude the
  impossible cases. The genuine inhabitant of the plane form is Woodall's `ℚ(i)` at `1 + i`, which only FS-37's
  machinery could construct; the ring form carries the kernel model.
- **Next-lemma test.** The handoff's `V₂(F)` states in the new vocabulary with no new definition: it is
  `(kummerClasses F).map loc2`.
  - The three-colour analogue (residue `𝔽₃`, conjugation trivial, square roots `±1`) would reuse
    `map_mul_self_eq_one_of_mem_normOne_of_conj_eq` as it stands.
  - Neither extension forces a restatement.
- **One structure noticed and not formalized.** `blockTwo` and `blockTen` are exactly the two planes of `𝔽₂³` through
  `[3]` that avoid `[−1]`, a pencil. Adjoining an even class chooses which of the two lies inside the image. No
  consumer needs the characterization, so it stays in this paragraph.

## §M2 — Obligation-modeling pass (2026-09-11)

*A fresh invocation of `debruijn-obligation-modeling`, scoped to FS-36.*

**What it did:**
- characterized every leaf's case split;
- chose the statement each leaf derives from;
- probed the risky leaves in Lean against the committed skeleton definitions;
- moved eleven statements into the skeleton so that every remaining leaf is local.

The probe files are local and gitignored: `build/probe-sqclass/Probe4.lean` (for `SquareClass`) and `Probe5.lean`
(for `TwoColourResidue`). Every proof they hold compiled against the skeleton. If they are gone, the routes and the
code below are complete.

### The obligations, characterized

| leaf | case split | the statement it derives from | probed |
|---|---|---|---|
| `inf_comap_sup_inf_comap_eq` | `≤` is `sup_le inf_le_left inf_le_left`; `≥` takes one element and `Submodule.mem_sup` on its image | its own hypothesis | ✅ 10 lines |
| `sqClass_mul`, `sqClass_one`, `sqClass_zero`, `sqClass_sq` | one prime coordinate | **`sqClass_apply`** (moved in; `rfl`) | ✅ 1–4 lines each |
| `sqClass_prime` | coordinate `q`: `p = q` or not | `sqClass_apply` and `by_cases` (§8 trap 12) | ✅ 7 |
| `isSquare_of_sqClass_eq_zero` | `n = b² · a` with `a` squarefree; `a`'s coordinates | `Nat.sq_mul_squarefree`, `sqClass_sq`, `Squarefree.natFactorization_le_one`, `ZMod.natCast_eq_zero_iff`, `omega`, `Nat.eq_of_factorization_eq` | ✅ 22 — **the longest leaf** |
| `exists_sqClass_eq` | `Finsupp.induction`: `zero`, `single_add` | the existential carries its own induction; `c = 1` by `decide` | ✅ 8 |
| `kummerClasses`'s closure | witnesses `1` and `a · b` | **the carrier with `n ≠ 0`** (D15) | ✅ 10 |
| `sqrt_mem_iff_of_sqClass_eq` | `n = 0` or `m = 0` (class 0: a square or 0, a rational root); otherwise `n · m` is a square `s²` and `√n = s / √m` | `isSquare_of_sqClass_eq_zero`, `ZModModule.add_self` | ✅ the core case (11 lines, one direction); the zero cases are not probed |
| `gc_sqrtField_kummerClasses` | forward: realize the class; backward: the closure's generators | `exists_sqClass_eq`, **`sqrt_mem_iff_of_sqClass_eq`** (D16) | ✅ 9 |
| `mqField_eq_sqrtField_classGroup` | `≤` through generators; `≥` through the connection, splitting `d = 0` from `d ≠ 0` | the connection, `Submodule.span_le` | ✅ 9 |
| the block facts | finite | `Submodule.mem_span_pair`, then `decide` | ✅ 1 each |
| `le_inf_blockTwo_sup_inf_blockTen` | three cases of one pointwise fact | **`mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen`** (moved in; `decide` over all eight vectors) | ✅ 9 + 2 |
| `loc2_sqClass_prime` | — | `sqClass_prime`, `Finsupp.linearCombination_single`, `one_smul` | ✅ 1 |
| `map_loc2_classGroup_le_iff` | — | `Submodule.map_span`, `Submodule.span_le`, `Set.image_subset_iff` | not probed; standard |
| `four_le_chromaticNumber_fieldPlane` | — | `SimpleGraph.induceHomOfLE`, **`mem_fieldPlane`** (moved in; `Iff.rfl`) | ✅ 5 |
| `seamField_le_sqrtField` | — | **`seamField_le_mqField`** (moved in), `mqField_mono` at `{3, 11} ⊆ …`, `mqField_eq_sqrtField_classGroup`, the connection's monotonicity | ✅ `seamField_le_mqField`, 10 lines |
| `mqField_le_sup` | — | **`mqField_mono`** (moved in) at `D ⊆ insert 2 D`, `mqField_eq_sqrtField_classGroup`, `sqrtField_eq_sup` | not probed; three rewrites |
| `four_le_…_sqrtField_inf_comap` | — | `seamField_le_sqrtField` with `[3]` and `[11]` in the piece (`loc2_sqClass_three`, `loc2_sqClass_eleven`, `hU`) | not probed |
| de Grey's containment and its two tests | the four generators; the four radicands' classes | **`sqrt_mul_sqrt_eq`** (moved in; ✅ 2 lines) for `√5 = √2 · √10 / 2` and `√7 = √35 · √5 / 5`; **`map_loc2_classGroup_le_iff`** (moved in) with four `loc2` values | the radical identity |
| `eq_one_of_mul_self_eq_one_of_charTwo` | — | `frobenius_inj k 2`, `frobenius_def` | ✅ 1 |
| `exists_addMonoidHom_zmod_two_apply_one_ne_zero` | — | `ZMod.algebra` (§8 trap 15), `CharP.nontrivial_of_char_ne_one`, `Module.forall_dual_apply_eq_zero_iff`, `not_forall` | ✅ 5 |
| `map_mul_self_eq_one_of_mem_normOne_of_conj_eq` | — | a `calc` of four cited steps: `hψσ`, `map_mul`, `Subtype.ext h`, `map_one` | ✅ 4 |
| `colorable_two_of_normOne_of_conj_eq` | — | `colorable_of_residue` at `l.comp ψ.toAddMonoidHom`, `cosetResidue_apply_of_mem`; `l 1 = 1` by `decide` | ✅ 10 |
| the valuation and plane forms | — | copies of `colorable_of_valuationSubring` and `colorable_unitDistance_induce_of_valuationSubring` | not probed; the same proofs |
| the model's two facts | — | `Zsqrtd.lift` by `simp [gaussResidue, Zsqrtd.lift, Zsqrtd.star_mk]`; the cycle's edges by `simp only [mem_normOne]; decide` | ✅ 3 + 2 |
| the reds | finite | `decide` | ✅ |

### Statements moved into the skeleton

1. `sqClass_apply` (written).
2. `sqClass_sq`.
3. `mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen`.
4. `map_loc2_classGroup_le_iff`.
5. `sqrt_mem_mqField` (written).
6. `mqField_mono`.
7. `sqrt_mem_iff_of_sqClass_eq`.
8. `sqrt_mul_sqrt_eq`.
9. `mem_fieldPlane` (written).
10. `seamField_le_mqField`.
11. `kummerClasses`'s carrier requires `n ≠ 0`.

`TwoColourResidue` gains the import `Mathlib.Algebra.Algebra.ZMod`. Everything else is unchanged.

### The probed proofs of the leaves that took more than one attempt

In the probe, names carried a `p_` prefix and the square-root lemma was the one-directional form (D16); they are
given here under the skeleton's names.

```lean
theorem sqClass_prime {p : ℕ} (hp : p.Prime) : sqClass p = Finsupp.single ⟨p, hp⟩ 1 := by
  ext ⟨q, hq⟩
  rw [sqClass_apply, hp.factorization]
  by_cases h : p = q
  · subst h; simp
  · have h' : (⟨p, hp⟩ : Nat.Primes) ≠ ⟨q, hq⟩ := fun e => h (congrArg Subtype.val e)
    simp [Finsupp.single_apply, h]
    exact h'

theorem sqClass_sq (b : ℕ) : sqClass (b ^ 2) = 0 := by
  ext p
  simp only [sqClass_apply, Nat.factorization_pow, Finsupp.smul_apply, smul_eq_mul, Nat.cast_mul,
    Finsupp.coe_zero, Pi.zero_apply]
  rw [show ((2 : ℕ) : ZMod 2) = 0 from rfl, zero_mul]

theorem isSquare_of_sqClass_eq_zero {n : ℕ} (hn : n ≠ 0) (h : sqClass n = 0) : IsSquare n := by
  obtain ⟨a, b, hab, ha⟩ := Nat.sq_mul_squarefree n
  have ha0 : a ≠ 0 := by rintro rfl; simp at hab; exact hn hab.symm
  have hb0 : b ≠ 0 := by rintro rfl; simp at hab; exact hn hab.symm
  have hca : sqClass a = 0 := by
    have hm := sqClass_mul (pow_ne_zero 2 hb0) ha0
    rwa [hab, h, sqClass_sq, zero_add, eq_comm] at hm
  have hfac : a.factorization = 0 := by
    ext p
    by_cases hp : p.Prime
    · have h1 : a.factorization p ≤ 1 := Squarefree.natFactorization_le_one p ha
      have h2 : ((a.factorization p : ℕ) : ZMod 2) = 0 := by
        show sqClass a ⟨p, hp⟩ = 0
        rw [hca]; rfl
      have h3 : 2 ∣ a.factorization p := (ZMod.natCast_eq_zero_iff _ _).mp h2
      simp only [Finsupp.coe_zero, Pi.zero_apply]
      omega
    · simp [Nat.factorization_eq_zero_of_not_prime a hp]
  have ha1 : a = 1 := Nat.eq_of_factorization_eq ha0 one_ne_zero (fun p => by simp [hfac])
  exact ⟨b, by rw [← hab, ha1, mul_one, sq]⟩

theorem exists_sqClass_eq (v : SqClass) : ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v := by
  induction v using Finsupp.induction with
  | zero => exact ⟨1, one_ne_zero, sqClass_one⟩
  | single_add p c f _ hc ih =>
    obtain ⟨m, hm, hfm⟩ := ih
    have hc1 : c = 1 := by revert hc; revert c; decide
    refine ⟨p * m, mul_ne_zero p.2.ne_zero hm, ?_⟩
    rw [sqClass_mul p.2.ne_zero hm, sqClass_prime p.2, hfm, hc1]
    rfl

-- the core case of `sqrt_mem_iff_of_sqClass_eq` (one direction, m ≠ 0); the zero cases go through
-- `isSquare_of_sqClass_eq_zero`: a class-0 natural is a square or 0, and its root lies in every field
example {F : Subfield ℝ} {n m : ℕ} (hm : m ≠ 0) (h : sqClass n = sqClass m)
    (hmF : Real.sqrt m ∈ F) : Real.sqrt n ∈ F := by
  rcases eq_or_ne n 0 with rfl | hn
  · simpa using F.zero_mem
  obtain ⟨s, hs⟩ := isSquare_of_sqClass_eq_zero (mul_ne_zero hn hm)
    (by rw [sqClass_mul hn hm, h, ZModModule.add_self])
  have hm0 : Real.sqrt m ≠ 0 := Real.sqrt_ne_zero'.mpr (by exact_mod_cast Nat.pos_of_ne_zero hm)
  have key : Real.sqrt n = (s : ℝ) / Real.sqrt m := by
    rw [eq_div_iff hm0, ← Real.sqrt_mul (Nat.cast_nonneg _), ← Nat.cast_mul, hs, Nat.cast_mul,
      Real.sqrt_mul_self (Nat.cast_nonneg _)]
  rw [key]
  exact F.div_mem (natCast_mem F s) hmF

-- `kummerClasses`'s closure fields, with the carrier of D15
  add_mem' := by
    rintro _ _ ⟨a, ha, rfl, haF⟩ ⟨b, hb, rfl, hbF⟩
    exact ⟨a * b, mul_ne_zero ha hb, sqClass_mul ha hb, by
      rw [Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg _)]; exact F.mul_mem haF hbF⟩
  zero_mem' := ⟨1, one_ne_zero, sqClass_one, by simpa using F.one_mem⟩
  smul_mem' := by
    rintro c _ ⟨n, hn, rfl, hnF⟩
    rcases (by decide : ∀ c : ZMod 2, c = 0 ∨ c = 1) c with rfl | rfl
    · exact ⟨1, one_ne_zero, by rw [sqClass_one, zero_smul], by simpa using F.one_mem⟩
    · exact ⟨n, hn, (one_smul _ _).symm, hnF⟩

theorem mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen (v : LocTwo) :
    v ∈ blockTwo ∨ v ∈ blockTen ∨ v + (0, 0, 1) ∈ blockTen := by
  simp only [blockTwo, blockTen, Submodule.mem_span_pair]
  revert v; decide

theorem le_inf_blockTwo_sup_inf_blockTen {V : Submodule (ZMod 2) LocTwo}
    (h2 : ((0, 0, 1) : LocTwo) ∈ V) : V ≤ (V ⊓ blockTwo) ⊔ (V ⊓ blockTen) := by
  intro v hv
  have h2B : ((0, 0, 1) : LocTwo) ∈ blockTwo := by
    simp only [blockTwo, Submodule.mem_span_pair]; decide
  rcases mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen v with h | h | h
  · exact Submodule.mem_sup_left (Submodule.mem_inf.mpr ⟨hv, h⟩)
  · exact Submodule.mem_sup_right (Submodule.mem_inf.mpr ⟨hv, h⟩)
  · exact Submodule.mem_sup.mpr ⟨(0, 0, 1), Submodule.mem_inf.mpr ⟨h2, h2B⟩, v + (0, 0, 1),
      Submodule.mem_inf.mpr ⟨V.add_mem hv h2, h⟩, by rw [add_left_comm, ZModModule.add_self, add_zero]⟩

theorem four_le_chromaticNumber_fieldPlane {F : Subfield ℝ} (hF : seamField ≤ F) :
    4 ≤ ((unitDistance ℂ).induce (fieldPlane F)).chromaticNumber :=
  four_le_chromaticNumber_seamPlane.trans (SimpleGraph.chromaticNumber_mono_of_hom
    (SimpleGraph.induceHomOfLE _ (fun z hz =>
      show z.re ∈ F ∧ z.im ∈ F from
        ⟨hF (FieldWall4.mem_seamPlane_iff.mp hz).1, hF (FieldWall4.mem_seamPlane_iff.mp hz).2⟩)).toHom)

theorem exists_addMonoidHom_zmod_two_apply_one_ne_zero (k : Type*) [Ring k] [CharP k 2] :
    ∃ l : k →+ ZMod 2, l 1 ≠ 0 := by
  letI := ZMod.algebra k 2
  haveI : Nontrivial k := CharP.nontrivial_of_char_ne_one (v := 2) (by norm_num)
  obtain ⟨φ, hφ⟩ := not_forall.mp
    (mt (Module.forall_dual_apply_eq_zero_iff (ZMod 2) (1 : k)).mp one_ne_zero)
  exact ⟨φ.toAddMonoidHom, hφ⟩
```

### Reading the ugliness the probes surfaced

- **The same simp chain in every `sqClass` identity.** This was the missing coordinate formula, now `sqClass_apply`.
  With it each identity is one `ext p; simp`, except the prime's, which also needs a `by_cases`.
- **A side condition the proof used and the truth did not.** `m ≠ 0` in the square-root lemma is gone (D16).
- **The junk value appearing as a proof witness.** It would have been `sqClass 0 = 0` in `kummerClasses`'s
  closure; it is gone (D15). The junk still appears in one place, `mqField_eq_sqrtField_classGroup`'s `d = 0`
  case, where it is a stated lemma (`sqClass_zero`) and not an unfolding.
- **Anonymous constructors failing against definitions.** Three times: `fieldPlane`, `seamPlane`, and the
  closure's set. Each was a definition without its membership lemma. `mem_fieldPlane` and `sqrt_mem_mqField`
  now supply two of them; `FieldWall4` already had `mem_seamPlane_iff`.

### Validation

- **Predictions (§11), against the probes.** They stay registered for the implementer to score.
  - P3 (the square lemma is the longest leaf) holds in the probe: 22 lines.
  - P6 (`frobenius_inj` in ≤ 3 lines) holds: 1 line.
  - P7 (the local splitting in ≤ 25 lines, by case analysis) holds in a sharper form: a two-line pointwise
    `decide` plus a nine-line lift.
  - P1 (≤ 180) and P2 (≤ 430) are expected to be met by wide margins: about 45 and about 220 lines.
- **Mutation plan, extended.** Beyond §8 trap 8, the audit deletes the `D ⊆ insert 2 D` step's `Set.subset_insert`
  (the containment must break) and the `hU` hypothesis of the `χ ≥ 4` lemma (the `[3]` membership must break).
  The iff is audited by specializing `m := 0`, which must still prove — that is D16's claim.
- **The next-lemma test.** The handoff's `K(√14) · K(√70) ∋ √5` is `sqrt_mul_sqrt_eq (a := 14) (b := 70) (c := 5)
  (s := 14)`, since `14 · 70 = 14² · 5`. So Phase C's first item starts from a stated lemma rather than a
  derivation.

## §M3 — Experience-modeling pass (2026-09-11)

*A fresh invocation of `debruijn-experience-modeling`, scoped to FS-36.*

**What it did:**
- designed the surface four consumers meet;
- renamed the skeleton;
- validated the result from a cold import.

**§1–§11 above use the final names.** §M1 and §M2 are records and keep the names of their time; the table below maps
them.

### The consumers, and what each holds at the moment of use

| consumer | holds | what it needed from the surface |
|---|---|---|
| **the paper's read-aloud gate** (FS-20) | the statement text, nothing else | names that say what each object is, and docstrings that say what is *not* proved |
| **FS-37** (field-level criteria) and **FS-19** (the 𝔭-adic distance classification) | Mathlib's number-field vocabulary; a need to evaluate colourings on pairs | no collision with Mathlib's `ClassGroup`; the four-colour test stated on a field's square classes; the two-colouring as data |
| **automation** (`simp`, `exact?`) | the tagged set; statement shapes | a confluent simp set; statements in the shapes the common goals take |
| **the gates** (`vacuity.sh`, `scripts/Axioms.lean`, `ARCHITECTURE.md`, `tools/check_architecture.py`) | declarations by name | a named inhabitant for the model; a registration list; row text naming real identifiers |

### The renames

| planning and §M1–§M2 name | final name |
|---|---|
| `mqField`, `sqrtField`, `kummerClasses`, `classGroup` | `fieldOfRadicands`, `fieldOfClasses`, `classesOfField`, `classesOfRadicands` |
| `LocTwo`, `loc2`, `locPrime` | `TwoAdicSqClass`, `twoAdic`, `twoAdicOfPrime` |
| `minusOne`, the literals `(0,0,1)`, `(1,1,0)`, `(0,1,0)`, `(0,1,1)` | `TwoAdicSqClass.minusOne`, `.two`, `.three`, `.five`, `.ten` |
| `blockTwo`, `blockTen` | `spanThreeTwo`, `spanThreeTen` |
| `fieldPlane`, `mem_fieldPlane`, `fieldPlane_seamField`, `four_le_chromaticNumber_fieldPlane` | `planeOver`, `mem_planeOver`, `planeOver_seamField`, `four_le_chromaticNumber_planeOver` — moved to the root `HadwigerNelson` namespace |
| `gc_sqrtField_kummerClasses`, `sqrtField_sup`, `sqrtField_eq_sup`, `mqField_eq_sqrtField_classGroup` | `gc_fieldOfClasses_classesOfField`, `fieldOfClasses_sup`, `fieldOfClasses_eq_sup`, `fieldOfRadicands_eq_fieldOfClasses` |
| `sqrt_mem_mqField`, `mqField_mono`, `seamField_le_mqField`, `seamField_le_sqrtField`, `mqField_le_sup` | `sqrt_mem_fieldOfRadicands`, `fieldOfRadicands_mono`, `seamField_le_fieldOfRadicands`, `seamField_le_fieldOfClasses`, `fieldOfRadicands_le_sup` |
| `le_inf_blockTwo_sup_inf_blockTen`, `inf_comap_blockTwo_sup_inf_comap_blockTen`, `minusOne_not_mem_blockTwo`/`…Ten` | `le_inf_spanThreeTwo_sup_inf_spanThreeTen`, `inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen`, `minusOne_not_mem_spanThreeTwo`/`…Ten` |
| `mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen` | `mem_spanThreeTwo_or_mem_spanThreeTen_or_add_two_mem`, now **private** |
| `loc2_sqClass_prime`, `loc2_sqClass_three`, `loc2_sqClass_eleven`, `map_loc2_classGroup_le_iff` | `twoAdic_sqClass_prime`, `twoAdic_sqClass_three`, `twoAdic_sqClass_eleven`, `map_twoAdic_classesOfRadicands_le_iff` |
| `four_le_chromaticNumber_fieldPlane_sqrtField_inf_comap` | `four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap` |
| `mqField_deGrey_le`; `minusOne_not_mem_map_classGroup_two_three_eleven_thirtyFive`, `…_three_ten_eleven_thirtyFive` | `fieldOfRadicands_deGrey_le_sup`; `map_twoAdic_deGreyTwo_le`, `map_twoAdic_deGreyTen_le`, now stating *which* subgroup avoiding `[−1]` the classes lie in. The four-colour test itself is drawn in an `example` |
| `eq_one_of_mul_self_eq_one_of_charTwo` | unchanged, now **private** |
| the model `example` | the named theorem `colorable_two_cycleGraph_four_of_gaussResidue` |
| — | **new**: `normOneColoringTwo` and `normOneColoringTwo_apply` (D19) |

### Decisions

D17 (the naming family), D18 (the simp set), D19 (the colouring as data), D20 (the bundled headline kept for reading
aloud), D21 (`planeOver` in the root namespace) and D22 (no abbreviation for a piece; two private helpers). Each is in
§3 with its alternative, its reason and its confidence.

### Validation as the user

- **The new-import test** (`build/probe-sqclass/Probe6.lean`: a cold file importing only the two modules; 3.8 s wall,
  20 s CPU on the desktop).
  - The four goals of the simp set close by bare `simp`.
  - The named Gaussian model elaborates at `k = ZMod 2` with no local instance.
  - `exact?` returns the intended lemma for each of six common goals, and every suggestion is pasteable:
    - `exact inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen h2`
    - `exact gc_fieldOfClasses_classesOfField`
    - `exact fieldOfRadicands_eq_fieldOfClasses D`
    - `exact map_twoAdic_classesOfRadicands_le_iff.mpr h`
    - `exact four_le_chromaticNumber_planeOver hF`
    - `exact (sqrt_mem_iff_of_sqClass_eq (id (Eq.symm h))).mp hm`
- **The simp set's confluence, checked by hand.** The critical pairs of `sqClass_zero`, `sqClass_one` and
  `sqClass_sq` with Mathlib's `zero_pow` and `one_pow` join (`sqClass (0²)`, `sqClass (1²)`). Adding `sqClass_apply`
  would create the unjoinable pair `sqClass (b²) p` (D18).
- **No deprecation aliases.** The renamed declarations exist only in these two skeleton modules, and a scan of
  `Proofs/` found no other file naming them. "Deprecate, never delete" protects consumers, and there are none.
- **One uninformative probe, recorded as such.** The "stale name" check in `Probe6.lean` wrapped the old name in
  `first | … | trivial`, which swallows the unknown-identifier error it meant to show. It is not evidence. Lean's own
  "unknown identifier" is the breakdown surface for a stale name, and no custom surface is needed.
- **The read-aloud, re-run on the final names** (§7).
  `fieldOfRadicands D ≤ fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTwo.comap twoAdic) ⊔ …` reads as
  "the field of the radicands `D` lies in the compositum of the field of the classes of `D ∪ {2}` whose 2-adic image
  lies in the span of `[3]` and `[2]`, and …". That matches §7's paragraph without consulting a docstring.

### What the implementer must know about the surface

- **`normOneColoringTwo`'s linter warnings are expected.** `hσ`, `hψσ`, `hl` and `hnorm` are used only in its
  properness proof, so the skeleton may draw unused-variable warnings; they go quiet when that leaf is proved.
- **Keep `sqClass_apply` out of the simp set** (D18). A proof that wants coordinates writes `simp [sqClass_apply, …]`.
- **`planeOver` lives in the root namespace.** `open HadwigerNelson` brings it; `open HadwigerNelson.SquareClass` does
  not.
- **The `decide` proofs in §M2 now meet named classes.** `simp only [spanThreeTwo, spanThreeTen,
  Submodule.mem_span_pair]` still turns membership into a finite existential, and `decide` unfolds
  `TwoAdicSqClass.two` and its siblings itself. If it does not, add them to the `simp only` list.
- **The `ARCHITECTURE.md` rows still say "Skeleton (FS-36)".** Remove that at the close (§9 item 5).

## §R — Results (WORKFLOW steps 7–10)

*The implementer's running record, written at each phase boundary. §1–§11 are the plan as approved and are not
rewritten. "Code lines" means non-blank lines outside comments and docstrings; "added" is against the skeleton at
`6338951`.*

### R1 Phase A — `TwoColourResidue.lean`: landed

- Every leaf closed on §M2's routes. The three forms, the colouring's properness, the model's two facts and both reds
  compile with no message (`lake env lean -DautoImplicit=false`: exit 0, 2.2 s wall).
- **Code lines:** 71 in the skeleton, 100 now, **29 added**. P1 (≤ 180) holds; §4 estimated about 45.
- **P6 holds:** `eq_one_of_mul_self_eq_one_of_charTwo` is one line through `frobenius_inj`.
- **The stop rule was not approached:** the dual-functional lemma is six lines.
- **Small deviations, none in a statement:**
  - `normOneColoringTwo`'s properness is five lines: `cosetResidue_eq_iff`, `cosetResidue_apply_of_mem`, a `change` that
    exposes `l (ψ ⟨…⟩)`, then `map_eq_one_of_mem_normOne_of_conj_eq` and `hl`.
  - The model's norm-one leaf wraps the probe's `decide` in `intro v w … revert v w`, because the theorem's binders are
    strict-implicit.
  - `normOneColoringTwo_apply` gained a docstring.
- Review note 2 (the duplicated header row of §4's estimates table) is fixed.

### R2 Phase B — `SquareClass.lean` (B1, B2 and B3): landed

- **One pass, one commit.** All three sub-phases were written from §M2's routes and compiled together, so they share a
  commit. The per-section counts below keep the phase split.
- **The first compile** gave five errors from two causes. Both were fixed without touching a statement:
  - `norm_num` does not prove `Nat.Prime 7` or `Nat.Prime 11` without `Mathlib.Tactic.NormNum.Prime`, which the module
    now imports;
  - `Set.image_subset` is now `Set.image_mono`.

  Four `simpa using F.one_mem`-shaped closers also drew the unnecessary-`simpa` linter; they are now `simp`. The second
  compile gave exit 0 and no messages.
- **Code lines:** 172 in the skeleton, 401 now, 229 added. **P2 (≤ 430) holds**, counted either way. §4 estimated about
  220 added.

  | phase | sections | code lines now |
  |---|---|---|
  | — | §0 `planeOver` | 9 |
  | B1 | §1–§4 | 126 |
  | B2 | §5–§7 | 143 |
  | B3 | §8 | 50 |
  | spec | §9 | 54 |
- **P3 holds, narrowly.** Counting proof lines, `isSquare_of_sqClass_eq_zero` (19) is the longest leaf. Next come the
  `[7]` red (18), then `sqrt_mem_iff_of_sqClass_eq` and `fieldOfRadicands_deGrey_le_sup` (17 each). The longest
  declaration is the bundled headline (23), and most of that is statement.
- **P4 holds.** The connection cites `exists_sqClass_eq` and `sqrt_mem_iff_of_sqClass_eq`, which cites
  `isSquare_of_sqClass_eq_zero`. Nothing appeals to the independence of square roots.
- **P7 holds:** the local splitting is a two-line `decide` over the eight classes plus an eleven-line lift.
- **D16's two zero cases**, unprobed at planning, close in four lines: `a = 0` by `simp`; `b = 0` makes `a` a perfect
  square with a natural root.
- **Statement changes, recorded openly** (the main session's review note 1). Nothing in the approved skeleton was
  weakened.
  - **`multiquadratic_decomposition` now carries every clause of the handoff's sentence**: `ℚ(√3,√11) ⊆ A, B`;
    `A, B ⊆ ℚ(√(D ∪ {2}))`; `ℚ(√D) ⊆ A ⊔ B`; `χ ≥ 4` for both planes; the test on both pieces. The clauses are grouped
    in pairs, with `A` and `B` bound by `let`. It is strictly stronger than the approved statement.
  - **Two parts were named for it**, parametrized by the plane `U` (D13, D22):
    - `seamField_le_fieldOfClasses_inf_comap`, the `K ⊆ A` clause, which the `χ ≥ 4` lemma now cites;
    - `fieldOfClasses_inf_comap_le_fieldOfRadicands`, the `A ⊆ F(√2)` clause. The spec's example now covers both
      pieces.
  - **One API lemma was added**, `sqrt_mem_of_mul_eq_sq_mul`: `a · b = s² · c` with `s ≠ 0` puts `√c` in every field
    holding `√a` and `√b`. B3 and the `√5` spec example use it, and Phase C's first item would start from it.
  - **Two private helpers** compute `twoAdic (sqClass 10)` and `twoAdic (sqClass 35)`.
  - **`isSquare_of_sqClass_eq_zero` lost its `n ≠ 0` hypothesis.** This was found while designing the mutation audit.
    The statement is true at `0`, since `0 = 0 · 0`, but the proof used the hypothesis. Deleting it would therefore
    have broken the proof, and a deletion audit would have scored it load-bearing although the truth does not need
    it. It is the same kind of side condition D16 removed. The fix costs two lines, and its two callers drop an
    argument.

### R3 The mutation audit (§8 trap 8, §M2's extensions): 20 of 20 as expected

The harness (`mutate.py`, kept in the session scratchpad, not committed) applied each mutation to the committed file at
`4250187`. For each, it elaborated the file with `lake env lean -DautoImplicit=false`, restored it from git, and checked
the restore with `git diff --quiet`. It refuses to start on a dirty tree and fails on a mutation whose target is not
found. Total: 50 s wall.

| id | mutation | expected | got | first message |
|---|---|---|---|---|
| T8.1 | delete the lifting lemma's hypothesis | break | break | unknown identifier `h` |
| T8.2 | delete `h2` from the 2-adic splitting | break | break | unknown identifier `h2` |
| T8.3 | delete `hψσ` from `map_mul_self_eq_one_of_mem_normOne_of_conj_eq` | break | break | unknown identifier `hψσ` |
| T8.4 | delete `[CharP k 2]` from the first lemma | break | break | failed to synthesize an instance |
| T8.5 | delete `h3` from the `χ ≥ 4` lemma | break | break | unknown identifier `h3` |
| M2.1 | replace the `D ⊆ insert 2 D` step by a direct equation | break | break | type mismatch |
| M2.2 | delete `hU` from the `χ ≥ 4` lemma | break | break | unknown identifier `hU` |
| M2.3 | specialize the root iff at `m := 0` and derive "class 0 puts `√n` in every field" (D16) | green | green | — |
| X.1 | delete `[IsReduced k]` from the first lemma | break | break | failed to synthesize an instance |
| X.2 | delete `hl` from `normOneColoringTwo` | break | break | unknown identifier `hl` |
| X.3 | delete `hσσ` from the valuation form | break | break | unknown identifier `hσσ` |
| X.4 | delete `hS` from the plane form | break | break | unknown identifier `hS` |
| X.5 | delete `hs : s ≠ 0` from `sqrt_mem_of_mul_eq_sq_mul` | break | break | unknown identifier `hs` |
| X.6 | delete `h11` from `seamField_le_fieldOfClasses` | break | break | unknown identifier `h11` |
| X.7 | delete `h2` from the local splitting | break | break | unknown identifier `h2` |
| X.8 | delete `h3` from the bundled headline | break | break | unknown identifier `h3` |
| X.9 | delete `hF` from `four_le_chromaticNumber_planeOver` | break | break | unknown identifier `hF` |
| X.10 | delete `ha` from `sqClass_mul` | break | break | unknown identifier `ha` |
| C.1 | **control:** add an unused hypothesis to `planeOver_seamField`, which nothing calls | green | green | the unused-variable linter warns |
| C.2 | **control:** add an unused hypothesis to `colorable_two_cycleGraph_four_of_gaussResidue`, which nothing calls | green | green | the unused-variable linter warns |

**What this audit can and cannot see.**
- **It detects unused hypotheses.** Fifteen of the eighteen breaks are "unknown identifier", which proves only that the
  proof names the binder. It does not prove that the truth needs the binder; `hn` in `isSquare_of_sqClass_eq_zero`
  would have scored the same way (R2).
- **Necessity comes from the reds and a counterexample for each remaining binder:**
  - `CharP k 2`: the `ZMod 3` red.
  - `hψσ`: the `F4` red.
  - `h2` in the splitting: the `[7]` red.
  - the lifting lemma's hypothesis: the `𝔽₂²` red.
  - `hs`: with `s = 0`, `0 · 2 = 0 · 3` and `√0, √2 ∈ ℚ(√2)`, but `√3 ∉ ℚ(√2)`.
  - `ha` in `sqClass_mul`: `sqClass (0 · 2) = 0 ≠ sqClass 2`.
  - `hU`, `h3`, `h11`: `ℚ(√3, √11) ⊄ ℚ(√2)`, a hand fact that is not in the kernel.

### R4 Phase C — item 1 landed; item 2 not attempted, by choice

- **The condition held.** Phase A used 29 of its 180 predicted lines and Phase B 229 of 430, so the optional phase
  ran.
- **Item 1, Heule-510 in the compositum: landed** in a new instance module, `Instances/CompositumFive.lean`. It is not
  in `SquareClass`, which stays a leaf with no Heule-510 data behind it. It is 76 code lines (stop rule: half a day)
  and compiled on the first attempt.
  - **The general step is stated for any valid `√7`-free certificate**: `UDCert.chromaticNumber_le_planeOver_of_sevenFree`,
    through `Q4.eval_mem_of_mem_sevenFree` (the eight-component analogue of `SeamCert`'s bridge), with Heule-510 as its
    named inhabitant.
  - **The risk §8 named did not bite.** `UDCert.point` is `Pt.toPlane`, whose coordinates are `Q4.eval` over the
    denominator, exactly as `SeamCert.point_mem_seamPlane` already used them.
  - **`√5` enters through `sqrt_mem_of_mul_eq_sq_mul`** at `14 · 70 = 14² · 5`, the next-lemma test §M2 predicted.
  - **What the kernel now holds:** `ℚ(√3,√11,√14)` and `ℚ(√3,√11,√70)` pass the 2-adic test (`map_twoAdic_fourteen_le`,
    `map_twoAdic_seventy_le`), and the plane over their compositum needs five colours
    (`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`). So a combining rule
    "`χ(A²), χ(B²) ≤ 4` implies `χ((AB)²) ≤ c`" for test-passing fields needs `c ≥ 5`. The factors' own `χ ≤ 4` is
    still FS-37's.
- **Item 2, de Grey's factors identified with the general theorem's pieces: not attempted.** It would restate, as a
  32-case analysis, an identification `independent_check.py` already makes, and nothing consumes it.
