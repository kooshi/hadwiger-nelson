# FS-36 — The multiquadratic handoff folded in: two colours from inertia, and the 2-adic splitting

*Opened 2026-09-11. WORKFLOW steps 3, 3a and 4 by the planning agent; step 5's three modeling passes are §M1–§M3
below; steps 7–10 belong to the implementer, who starts from this file and remembers nothing of the conversation
that produced it. The source and its verification are `reference/ChatGPT-multiquadratic/` (`handoff.md`,
`VERIFICATION.md`, two check scripts). After this milestone the project returns to M63.*

**Kooshi's framing, which sizes this milestone.** He brought a handoff from his conversation with ChatGPT (OpenAI)
about colouring the plane over multiquadratic fields. He had told ChatGPT he would credit it with one result, the
decomposition theorem, if the project did not already hold it; the project does not. His verdict on the whole:
*"less insightful than I hoped, but worth formalizing."* So this is a modest milestone: fold the material in
properly, formalize what earns formalizing, stub the rest.

---

## 0. For the implementer — read this first

**What you are building.** Two new leaf modules, both skeletons already committed with every statement
elaborating:

1. `Proofs/HadwigerNelson/TwoColourResidue.lean` — **Theorem A's two-colour case.** If complex conjugation leaves
   every residue unchanged and the residue ring is reduced of characteristic two, every unit vector has residue
   `1`, so an additive functional to `ZMod 2` that is `1` at `1` two-colours the plane.
2. `Proofs/HadwigerNelson/SquareClass.lean` — **the 2-adic splitting.** The positive rational square classes as an
   `𝔽₂`-vector space, localization at 2, the splitting of any square-class group containing `[2]` and `[3]` into two
   pieces whose 2-adic images avoid `[−1]`, and the field-level consequence: every real multiquadratic field
   containing `ℚ(√3, √11)` lies in the compositum of the two pieces' fields, each of whose planes needs four colours.

**What you must not do** (each rule has cost this project before; `CLAUDE.md` gives the history):
- **Build only with `./scripts/build.sh`, never `lake build`**, bare or named. `lake env lean <file>` is fine for
  iterating but does not apply `autoImplicit := false`; pass `-DautoImplicit=false` or wait for `build.sh`.
- **Do not add or change a declaration or a `/-- docstring -/` in `ResidueColouring.lean`, `FieldWall4.lean` or
  `UnitQuadrance.lean`.** Every module downstream of them would rebuild. Both new modules are leaves on purpose.
- **No `native_decide`.** The standard three axioms only.
- **One heavy job at a time. Any unexplained process crash: stop and report**, do not retry.
- **Commit on `backlog`, never push**, and end every commit message with the two attribution lines the session
  gives you.
- **Do not write `χ ≤ 4` for the pieces anywhere as if the kernel proved it.** It does not; see §7.

**The acceptance test is §9.** What the close must record is §10.

---

## 1. Purpose

### 1.1 What came in, and what of it is new

The handoff (`reference/ChatGPT-multiquadratic/handoff.md`) is short and careful about its own scope. Every claim
in it was re-derived before this plan was written (`VERIFICATION.md`). Sorted against the repository:

| the handoff's item | already here? |
|---|---|
| `χ(ℚ(√3,√11)²) = 4` | yes — Theorem B, ledger row 57 (a reproduction; Kooshi said so in the conversation) |
| the 2-adic four-colour test `[−1] ∉ V₂(F)` | yes — `plans/FIELD-WALL-THEOREM.md` §6.2, grokking G35 |
| the odd-prime reduction to `UD(𝔽_p, 2)` | yes — ledger row 52 (prior art Moorhouse, Manturov, Madore) |
| the example field values `K(√35) = 4`, `K(√5) = K(√247) = 5`, … | yes — `plans/M58-field-sieve.md`, ledger rows 47, 52 |
| de Grey's field "open to six" | yes — G43 |
| the six-colour cutoff at `p = 83` | yes, sharper — `plans/M61-local-global-tightness.md` §S2's exact Hoffman floors exclude 71 too |
| **the decomposition theorem** (§5) | **new** — credit ChatGPT (§3 D8) |
| **`K(√14)`, `K(√70)` meet the four-colour test; their compositum holds `√5` and is 5-chromatic** (§4) | **new** |
| **the screening rule for several added roots at once** (§4) | **new**; proved by exhaustion over local classes in `independent_check.py` |
| **the two-colour criterion `[−1], [3] ∉ V₂(F) ⟹ χ(F²) = 2`** (§3), with the main session's converse making it an iff | **new**; corrects `plans/FIELD-WALL-THEOREM.md` Proposition 6.4 (recorded there as §10.2) |

### 1.2 What the decomposition is worth, stated so it cannot be oversold

It colours nothing. A point of the compositum's plane generally lies in neither piece's plane. Its content is a
statement about what a *combining rule* would have to do. Every multiquadratic unit-distance graph lives in some
real multiquadratic `F ⊇ ℚ(√3, √11)`, and the decomposition puts every such `F` inside a compositum of two fields
meeting the four-colour test. So a rule "`χ(A²), χ(B²) ≤ 4 ⟹ χ((AB)²) ≤ c`" would give `χ ≤ c` for every
multiquadratic field plane. The `K(√14) · K(√70)` example forces `c ≥ 5`. And `c = 5` would mean that no
6-chromatic unit-distance graph has multiquadratic coordinates. This makes exact the remark in
`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 that "their colourings do not glue". **Bearing on χ(ℝ²) ≥ 6: none
directly.** Its natural home is the Theorem B paper (FS-20, `plans/STUB-theorem-B-writeup.md`).

### 1.3 What the two-colour criterion is worth

- **It corrects this project's own note.** Proposition 6.4 granted two colours only when the residue field at 2 is
  `𝔽₂`, which leaves out `ℚ(√5)`, `ℚ(√13)`, `ℚ(√2, √5)` and every field whose 2-adic image contains `[5]`.
- **It settles, by a hand theorem, which real multiquadratic planes are 2-colourable**: exactly those whose
  square-class group has no odd element `≡ 3 (mod 4)`.
- **It bears on two questions posed in print** (§PA(c)).
- **Its kernel part is small and honest**: the mechanism, in the valuation-subring language Theorem A already
  speaks. Which multiquadratic fields actually supply such a valuation subring is the same gap as Theorem A's own
  (FS-37).

---

## §PA — The prior-art gate (WORKFLOW step 3a)

Run 2026-09-11, before any derivation in this plan, in the disciplines' own vocabulary and never in this project's.
The disciplines: Kummer theory and square classes of multiquadratic fields; chromatic numbers of planes over
`ℚ(√d)` and number fields; unit-distance graphs over fields; additive colourings.

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
- `[AxenovichEtAl2014]`, whose abstract names "extensions of the rational plane". It is not held: the preprint host's
  certificate chain is broken, and the journal copy is closed. It needs a browser save.
- `[Johnson2006]`, which discusses `ℚ(√m)²`. It is not held.

`[Fischer1990b]`, on multiquadratic planes specifically, is a components paper by its zbMATH review. No colouring
criterion appears there, but it is unread.

**Consequence for the shape.** The kernel statement is the valuation-subring form of the mechanism, which none of
the four sources states and all four instantiate. The multiquadratic iff stays a hand theorem, recorded with its
prior-art caveat.

### (b) The decomposition — nothing found, and nothing expected

- **Searched:** *"multiquadratic field compositum of two subfields square class group 2-adic localization"*,
  *"Kummer theory multiquadratic subgroup preimage local square classes"*, *"chromatic number of the plane over
  multiquadratic field"*, and *"two-colorable plane real multiquadratic extension"*.
- **Found:** Kummer-theory papers on degrees of Kummer extensions (`BIBLIOGRAPHY.md` § C, negative), and the
  colouring literature above. Neither has a splitting statement.
- **ChatGPT's own targeted search** also found nothing (handoff §1).

The statement is two lines of linear algebra once the 2-adic criterion is in hand, so its absence from print is
not surprising. **Credit line** (D8): *a corollary of the 2-adic four-colour criterion
(`plans/FIELD-WALL-THEOREM.md` §6.2), stated and proved by ChatGPT (OpenAI) in conversation with Kooshi,
2026-09-11; no prior statement found.*

### (c) The questions this work bears on, searched for as questions

- **`[BendaPerles2000]` Open Problem 11.6**, via `[Soifer2024]` ch. 11: *"Find the chromatic number of `ℚ²(√2)`
  and, in general, of any algebraic extension of `ℚ²`."* It is restated in `[GrahamTressler2010]` §3. The first
  half was answered in 1990 (`[Fischer1990]` Theorem 8; again `[Madore2015]` Prop. 3.9). The two-colour criterion
  answers the second half at the value 2, for real multiquadratic fields, as a hand theorem.
- **`[Fischer1990]` §1**: *"This still begs the general question, however, whether some algebraic criterion can be
  found to determine the chromatic number of F² where F is a subfield of R, of finite degree over Q."*
- **`[Krebs2022]` Remark 2.3**: *"It might be interesting, however, to try to find necessary and sufficient
  conditions for UD(F,n) to be bipartite for such fields"* (characteristic zero). The same remark misquotes
  Fischer's Theorem 8 as *"N is not congruent to 2 (mod 3)"*, which is Theorem 9's hypothesis.
- **Citation walks of the works that posed them**:
  - `[Fischer1990]` has 13 citers on OpenAlex and 11 on Semantic Scholar; the two lists agree apart from duplicate
    records. The citers in the neighbourhood were opened: `[AxenovichEtAl2014]` (not obtainable, above),
    `[Johnson2010]` (read), `[Reid1996]` (connectivity; named). The rest are expository, `ℚⁿ`-only or held and read
    (`[Payne2009]`, `[CranstonRabern2015]`, `[CurrieEggleton2016]`, `[Krebs2022]`).
  - `[Krebs2022]` has one citer on OpenAlex and two on Semantic Scholar, both `[LorenzZimmermann2023]`'s two papers
    (held; finite local rings). **Nobody citing Krebs has answered his remark.**
- **Recommendation for the close** (§10): a `CLOSED-QUESTIONS.md` §2 row, "answered for a class of fields", with the
  hand-theorem status and the two unread works in its prior-art column.

### (d) The spectral citation in the handoff

`[BrittenhamPakianathan2024]` (scanned) gives the eigenvalues of every finite Euclidean distance graph as twisted
Kloosterman sums (Theorem 3.1). It quotes the Weil bound (`[Weil1948]`) and says nothing about colourings. The
repository's `tools/fplane.py spectral --all-below 100` gives exact Hoffman floors of 6, 6, 7, 6, 6 at
`p = 59, 67, 71, 79, 83`. So `p = 71` refuses six colours by its exact spectrum, which the handoff's Weil estimate
cannot see.

### (e) What the gate changed in this repository the same day

`BIBLIOGRAPHY.md` gained rows for `[AxenovichEtAl2014]`, `[BrittenhamPakianathan2024]`,
`[BannaiShimabukuroTanaka2009]`, `[Kwok1992]`, `[Johnson2010]` / `[GrahamTressler2010]`, `[Reid1996]` and
`[JungreisReidWitte1990]`. It corrected `[Krebs2022]`, `[Fischer1990]`, `[Fischer1990b]`, `[Madore2015]`,
`[Moorhouse2010]` and `[Johnson2006]`. It also replaced a § C verdict that had dismissed `[AxenovichEtAl2014]`
unread as having "no field content", which its own abstract contradicts.

---

## 2. What the kernel already holds — read these before writing a line

| where | names you will use |
|---|---|
| `ResidueColouring.lean` | `colorable_of_residue` (a graph drawn in an abelian group, edge differences in a subgroup `A`, nonzero under `ψ : A →+ G`, is `\|G\|`-colourable); `normOne`, `mem_normOne`; `isUnit_of_mem_normOne`; `normOne_subset_valuationSubring`; `colorable_of_valuationSubring`; `conjOn`, `conjOn_conjOn`; `colorable_unitDistance_induce_of_valuationSubring` (Theorem A, the plane form to mirror); `sub_mem_normOne_conj_iff`; `map_mul_conj_eq_zero_iff` (its `hker` binder is the shape of our `hψσ`) |
| `FieldWall4.lean` | `seamField : Subfield ℝ`, `seamPlane`, `mem_seamPlane_iff` (`Iff.rfl`), `mem_seamField_iff` (`x = a + b√3 + c√11 + d√33`, rational `a b c d`), `sqrt3_mem`, `sqrt11_mem`, `four_le_chromaticNumber_seamPlane`, `FieldWall4.F4`, `FieldWall4.F4.sq` (Frobenius, a ring hom) |
| `Instances/FinitePlane11.lean`, `UnitQuadrance.lean` | Phase C only: `chromaticNumber_heule510`, `heule510_coordsIn_sevenFree`, `Q4.sevenFree`, `Q4.sevenFree.toQ3` |
| Mathlib, **measured** by the planning probe | `Submodule.mem_sup`, `Submodule.mem_map_of_mem`, `Submodule.mem_span_pair`, `Submodule.map_span`, `Finsupp.linearCombination`, `Finsupp.comapDomain`, `Nat.factorization_mul`, `Nat.Prime.factorization`, `Nat.sq_mul_squarefree`, `Module.forall_dual_apply_eq_zero_iff` (needs `Module.Projective`), `ZMod.algebra k 2` (needs `CharP k 2`), `Subfield.closure_le`, `Real.sqrt_mul`, `Real.sqrt_mul_self`, `SimpleGraph.chromaticNumber_mono_of_hom`, `SimpleGraph.induceHomOfLE`, `SimpleGraph.cycleGraph` (import `Mathlib.Combinatorics.SimpleGraph.CycleGraph`) |
| Mathlib, **not found** | "even factorization ⟹ `IsSquare`" in that shape (`exact?` failed): go through `Nat.sq_mul_squarefree` |
| Mathlib, **likely, query it** | `frobenius_inj` (Frobenius is injective on a reduced ring of characteristic `p`) for §1's first lemma |

---

## 3. The shape, and every decision in it

**Two leaf modules**, each importing `FieldWall4` and nothing downstream of it. `TwoColourResidue` needs
`FieldWall4` only for its red (the four-element field with Frobenius). `SquareClass` needs it for `seamField` and
the Moser spindle.

| # | the choice | the alternative weighed | why this one | confidence |
|---|---|---|---|---|
| D1 | Formalize the decomposition **at the field level**: `ℚ(√D) ≤ A ⊔ B` as subfields of `ℝ`, each piece containing `ℚ(√3,√11)` so its plane needs four colours, and the wall predicate on each piece's classes | the class-level linear algebra alone (about 150 lines) | the handoff's claim is about fields. Class level alone is the failure mode the main session named — a vector-space lemma that reads like a chromatic result. The field level costs about 180 more lines and leaves the kernel statement equal to the claim minus exactly one named step (`χ ≤ 4`), which the docstring names | medium: if Phase B2 passes its stop rule (§8), land B1 + B3 and report B2 not landed |
| D2 | The two-colour theorem **in Theorem A's three forms** (ring, valuation subring, plane), with conjugation acting trivially on residues as the hypothesis | (i) the plane form only; (ii) "Theorem A′": colour through `G/H` for an additive `H` avoiding the reduced norm-one set | (i) breaks the symmetry with Theorem A's API, which consumers already know. (ii) is `colorable_of_residue` composed with a quotient map, which adds no content. The content is the mechanism: conjugation-trivial residues in characteristic two send every unit vector to `1` | high |
| D3 | **No field-level instance** (`χ(K(√2,√35)²) = 4` in the kernel); stub it as FS-37 | (c) a `FieldWall4`-style order for `K(√2,√35)(i)`; (d) closing `plans/A1-theorem-A-kernel.md` §R2 | **(c) priced at a week or more.** `FieldWall4` is 1,392 lines for a rank-8 order with ramification index 2 at the prime above 2, where the joint kernel of the residue maps is visibly `(1+i)·O` and one parity step suffices. `ℚ(√2,√3,√11,√35,i)` has rank 32 and ramification index 4 (`√2` and `i` both ramify), so the descent becomes a four-step valuation argument and every kernel product is sixteen times larger. The residue field's fourth element comes from `ζ₃`, so a residue map defined on the generators alone only reaches `𝔽₂` — the trap the main session flagged. **(d) closes only the generic half:** each field still needs its prime's residue degree computed, and Mathlib's decomposition-group API does not deliver that for multiquadratic fields | medium-high: if Mathlib has grown a residue-degree computation for Kummer extensions since the epoch, (d) gets cheaper — FS-37 says to check first |
| D4 | **Square classes as `Nat.Primes →₀ ZMod 2`**; the 2-adic group as `ZMod 2 × ZMod 2 × ZMod 2` in coordinates `(−1, 5, 2)`; localization defined on primes by `p mod 8` | (i) `ℚˣ` modulo squares, with 2-adic squares through Hensel's lemma in `ℚ₂`; (ii) `ℕ →₀ ZMod 2` | the prime basis is the classical basis. The mod-8 table is the classical fact (Hensel), and no consumer needs `ℚ₂` itself; the docstring says the table is a table. (ii) has directions that no natural number populates, which breaks `exists_sqClass_eq` | medium; the domain pass is where this should be challenged |
| D5 | **Two new leaves; no edit to `ResidueColouring`** | put the two-colour theorems in `ResidueColouring.lean` beside Theorem A | a declaration added there rebuilds `FieldWall4`, `SeamCert`, `ValuationLaw` and everything that imports them | high |
| D6 | The milestone runs as **FS-36**; its carry-forward is **FS-37** | number it M65 | small consolidation-sized items run under their FS number (FS-24 landed ledger row 61), and M63 is open with M62 paused behind it, so an M-number would misstate the queue | high |
| D7 | **The splitting needs one hypothesis, not the handoff's two cases**: `U₁ ≤ W.map f` and `W.map f ≤ U₁ ⊔ U₂` | formalize the handoff's two-case proof | shorter, strictly more general, and the planning probe compiled it in eight lines | high |
| D8 | The credit line of §PA(b), in the docstring of `SquareClass.lean` and in any ledger row | the main session's wording, *"a corollary of the project's 2-adic criterion, stated and proved by ChatGPT…"* | "the project's" claims a criterion whose mechanism is `[Fischer1990]`'s and `[Madore2015]`'s; naming it by where it is written avoids that, and the line carries the search's negative | high |

---

## 4. Prices

**Measured** (desktop, 32 cores, CPU seconds as user + sys). The probe `build/probe-sqclass/Probe.lean` imports all
of Mathlib plus `FieldWall4` and elaborates in **60 s**, including one `exact?` that timed out. Each skeleton module
elaborates in **1.3–1.7 s** with cached `.olean`s.

| item | measurement |
|---|---|
| the splitting lemma, by hand | **8 lines, compiled** (probe Q1b) |
| `x * x = 1 → x = 1` in a reduced ring of characteristic 2 | **7 lines, compiled** (probe Q5) |
| `√2 · √10 = 2 · √5` | **3 lines, compiled** (probe Q7) |
| `exact?` on "even factorization ⟹ square" | **not found** |
| `exact?` on the splitting lemma | **timed out** at 200,000 heartbeats — inconclusive, and the hand proof is short |
| `Algebra (ZMod 2) k` from `CharP k 2` | `exact ZMod.algebra k 2` (the `exact?` suggestion) |

**Estimates**, each against its phase in §8:

| phase | content | code lines | time |
|---|---|---|---|
| A | `TwoColourResidue.lean`: two char-2 lemmas, the mechanism, three forms, the model and two reds | ≤ 180 | half a day |
| B1 | `SquareClass.lean` §1–§3: splitting lemma, `sqClass` API, `loc2` on primes, the blocks, the pieces | ≤ 170 | half a day |
| B2 | §4–§6: `sqrtField`, `mqField`, `sqrtField_sup` (needs `exists_sqClass_eq` and `isSquare_of_sqClass_eq_zero`), the headline | ≤ 180 | half a day to a day |
| B3 | §7 de Grey's field, and the spec | ≤ 80 | two hours |
| C (optional) | `K(√14) · K(√70)` holds Heule-510 in the kernel (§8) | ≤ 150 | half a day |

**Total for A + B: about 1.5–2 days. This is at the upper edge of "a day or two"**, which is why §8 has a stop
rule per phase, and why Phase C is optional.

---

## 5. The skeleton, as committed

Both files are the specification: every signature and every full statement, `sorry` at every leaf. The table
below says what each statement is; the file says it exactly.

### 5.1 `TwoColourResidue.lean`

| name | the statement, in words | proof, at leaf size |
|---|---|---|
| `eq_one_of_mul_self_eq_one_of_charTwo` | in a reduced ring of characteristic 2, `x · x = 1` forces `x = 1` | `frobenius_inj`, or `(x + 1)² = 0` then reducedness (probe Q5) |
| `exists_addMonoidHom_zmod_two_apply_one_ne_zero` | a ring of characteristic 2 has an additive map to `ZMod 2` that is nonzero at `1` | `letI := ZMod.algebra k 2`; vector spaces are projective; `Module.forall_dual_apply_eq_zero_iff` at `v = 1 ≠ 0` |
| `map_eq_one_of_mem_normOne_of_conj_eq` | if conjugation fixes every residue, a norm-one element of the subring has residue `1` | `ψ u · ψ (σ u) = ψ 1`, rewrite `ψ (σ u) = ψ u`, the first lemma |
| `colorable_two_of_normOne_of_conj_eq` | ring form: a graph drawn in `L` with integral norm-one edge differences is 2-colourable | `colorable_of_residue` with `l ∘ ψ`, where `l` is the functional; `rw [ZMod.card]` |
| `colorable_two_of_valuationSubring_of_conj_eq` | valuation form: integrality is free | the ring form plus `normOne_subset_valuationSubring` |
| `colorable_two_unitDistance_induce_of_valuationSubring` | **the headline**: plane form, mirroring Theorem A | copy `colorable_unitDistance_induce_of_valuationSubring`'s proof |

### 5.2 `SquareClass.lean`

| name | the statement, in words |
|---|---|
| `le_inf_comap_sup_inf_comap` | a submodule `W` is the sum of its preimages of `U₁` and `U₂` when `U₁ ≤ f(W) ≤ U₁ ⊔ U₂` |
| `SqClass`, `sqClass` | `Nat.Primes →₀ ZMod 2`; a natural number's prime exponents mod 2 (junk `0` at `0`) |
| `sqClass_mul`, `sqClass_prime` | multiplicative on nonzero naturals; a prime's class is its basis vector |
| `isSquare_of_sqClass_eq_zero` | a nonzero natural with trivial class is a perfect square |
| `exists_sqClass_eq` | every class is a natural number's class |
| `LocTwo`, `locPrime`, `loc2` | `(ZMod 2)³` in coordinates `(−1, 5, 2)`; the table on primes; its linear extension |
| `loc2_sqClass_prime` | on a prime, `loc2` is the table |
| `minusOne`, `blockTwo`, `blockTen` | `[−1]`; the planes `{1,3,2,6}` and `{1,3,10,14}` |
| `minusOne_not_mem_blockTwo`, `…_blockTen`, `blockTwo_sup_blockTen` | neither plane holds `[−1]`; together they span |
| `pieceTwo`, `pieceTen` | `W ⊓ comap loc2 blockTwo`, `W ⊓ comap loc2 blockTen` |
| `pieceTwo_sup_pieceTen` | **the 2-adic splitting**: with `[2], [3] ∈ W`, the pieces sum to `W` |
| `minusOne_not_mem_map_pieceTwo`, `…_pieceTen` | neither piece's image holds `[−1]` |
| `sqClass_three_mem_pieceTwo` and its three siblings | `[3]` and `[11]` lie in both pieces |
| `sqrtField`, `mqField` | the field generated by `√n` for `sqClass n ∈ W`; the field `ℚ(√d : d ∈ D)` |
| `sqrtField_mono`, `mqField_le_sqrtField_span`, `sqrtField_sup` | monotone; `ℚ(√D)` lies in its class group's field; **the field of a sum is the compositum** |
| `sqrtField_eq_sup` | **the decomposition at the field level** |
| `fieldPlane` | `{z : ℂ \| z.re ∈ F ∧ z.im ∈ F}` |
| `seamField_le_sqrtField`, `four_le_chromaticNumber_fieldPlane` | a field whose classes hold `[3]` and `[11]` contains `ℚ(√3,√11)`; its plane needs four colours |
| `mqField_le_sup_pieces` | **the headline**, bundled for reading aloud (§7) |
| `mqField_deGrey_le`, `minusOne_not_mem_map_span_two_three_eleven_thirtyFive`, `…_three_ten_eleven_thirtyFive` | de Grey's field in `ℚ(√2,√3,√11,√35) · ℚ(√3,√10,√11,√35)`; both pieces pass the test |

**Elaboration status.** Both files elaborate with no error and no warning except the `sorry` leaves:
- `lake env lean -DautoImplicit=false` accepts each in 1.3–1.7 CPU s;
- `./scripts/build.sh` reports OK on 170 batches, rebuilding `TwoColourResidue` in 1.4 s, `SquareClass` in 1.7 s
  and `Proofs` in 1.3 s (3 min 21 s wall on the desktop; log `build/gate/build/20260911T165548Z-2264217.log`);
- `tools/check_architecture.py` passes with the two skeleton rows in `ARCHITECTURE.md` § 3.6.

---

## 6. Sanity examples and models of every hypothesis

| declaration | the check that would fail if it drifted | where |
|---|---|---|
| `locPrime` | `#guard`s at 2, 3, 5, 7, 11 | `SquareClass` §8 |
| `sqClass` | `sqClass 12 = sqClass 3` | §8 |
| `loc2` | `loc2 (sqClass 35) = (1, 1, 0)` — `[5] + [−1] = [3]` | §8 |
| `blockTwo` | `[6] ∈ blockTwo`, `[10] ∉ blockTwo` | §8 |
| `mqField` | `√5 ∈ mqField {2, 10}` | §8 |
| `fieldPlane` | `(√3, 1) ∈ fieldPlane seamField` | §8 |
| the splitting lemma's `h₁` | **red**: in `𝔽₂²` the diagonal is covered by the two axes and meets each in `0` | §8 |
| the decomposition's hypotheses `[2], [3] ∈ W` | **model**: de Grey's field (§7 of the file). **Red, tools-level**: without `√2`, `K(√7)` does not split (`independent_check.py`). The implementer may add a kernel red if it is short | §7, `reference/` |
| the two-colour theorems, all forms | **model**: `ℤ[i]` with its nontrivial conjugation and residue `a + bi ↦ a + b (mod 2)`, two-colouring the 4-cycle drawn at `0, 1, 1+i, i` | `TwoColourResidue` §4 |
| `hψσ` | **red**: in `F4` with Frobenius, `Ω · Ω² = 1` and `Ω ≠ 1` — Theorem B's own residue field, where conjugation induces Frobenius | §4 |
| `CharP k 2` | **red**: in `ZMod 3`, `2 · 2 = 1` and `2 ≠ 1` | §4 |

**The vacuity gate.** Each headline whose hypothesis is a structure ships a named inhabitant in its own file, or a
one-line note naming the theorem that supplies one.
- **Two-colour theorems:** the `ℤ[i]` model is the inhabitant of the ring form. The valuation and plane forms take a
  `ValuationSubring` binder, which the gate did not treat as a site for Theorem A's own valuation form (its latest
  log lists no `colorable_of_valuationSubring` row). Say that in a one-line note, as `ResidueColouring.lean` does.
- **The square-class theorems** are over arbitrary submodules, so they are generic. De Grey's instance is their
  model.

---

## 7. The headlines, read aloud against the informal claims

**`colorable_two_unitDistance_induce_of_valuationSubring`.** *Let `L` be a subfield of `ℂ` closed under complex
conjugation, `A` a valuation subring of `L` that conjugation maps into itself, and `ψ` a ring homomorphism from `A`
to a reduced ring of characteristic two that takes the same value on `z` and on its conjugate. Then every
unit-distance graph drawn in `L` is 2-colourable.*
- **Against the informal claim** — "if `[−1], [3] ∉ V₂(F)` then `χ(F²) = 2`": the arithmetic hypothesis is
  replaced by the two properties its proof uses. The prime above 2 must be fixed by conjugation (so `A` is
  conjugation-stable), and conjugation must lie in its inertia group (so `ψ` does not see conjugation).
- **What it does not say:** that a multiquadratic `F` meeting the test supplies such an `A`. That is FS-37, and the
  docstring must say so.
- **Why the characteristic-two hypothesis is not decoration:** the `ZMod 3` red.

**`mqField_le_sup_pieces`.** *Let `D` be a set of positive integers containing 3 and 11, and `W` the square-class
group of `D ∪ {2}`. Then `ℚ(√d : d ∈ D)` lies in the compositum of the fields of `W`'s two pieces; the plane over each
piece's field needs at least four colours; and neither piece's image in the 2-adic square-class group contains the
class of `−1`.*
- **Against the handoff's §5** — "`F ⊆ AB` with `χ(A²) = χ(B²) = 4`": the kernel carries the containment, `≥ 4`, and
  the hypothesis of the four-colour test. It does **not** carry `≤ 4`, which is the test itself at the field level
  (FS-37).
- **Against `A, B ⊆ F(√2)`:** the kernel's pieces are subgroups of `W`, so their fields lie in `ℚ(√(D ∪ {2}))` by
  `sqrtField_mono`; this is worth one `example` in the spec.
- **Against "each piece contains `K`":** `seamField_le_sqrtField` from `[3], [11]` in both pieces.
- **One reading trap:** `LocTwo` is a coordinate model of `ℚ₂^×/(ℚ₂^×)²` whose correctness is Hensel's lemma, not
  a kernel theorem. The docstring of `locPrime` says so, and the read-aloud must too.

**`mqField_deGrey_le` with its two `minusOne_not_mem_map_span_…` lemmas.** *De Grey's coordinate field
`ℚ(√3,√5,√7,√11)` lies in `ℚ(√2,√3,√11,√35) · ℚ(√3,√10,√11,√35)`, and the square classes generating each factor
have no `[−1]` in their 2-adic span.* This is the handoff's worked example verbatim, minus `χ = 4` for the factors.

---

## 8. Phases, stop rules and traps

**Phase A — `TwoColourResidue.lean`.**
- **Order:** the two char-2 lemmas, the mechanism, the ring form, the valuation form, the plane form, the spec.
- **Stop rule:** if the dual-functional lemma resists past 40 lines, take the functional as an explicit hypothesis
  `(l : k →+ ZMod 2) (hl : l 1 ≠ 0)` in the three forms, keep the existence lemma for `k = ZMod 2` only
  (`l = id`), and record the downgrade.

**Phase B1 — `SquareClass.lean` §1–§3.**
- **Order:** the splitting lemma (probe Q1b, copy it), then `sqClass_mul` and `sqClass_prime`, then `loc2_sqClass_prime`,
  then the block facts (`Submodule.mem_span_pair` and a four-case `decide`), then the pieces.
- **Stop rule:** if `Finsupp.comapDomain` fights for more than 60 lines, redefine `sqClass` by
  `Finsupp.onFinset n.primeFactors`, or change the index to `ℕ` and restate `exists_sqClass_eq` over the span of a
  set of classes. Record whichever is chosen.

**Phase B2 — §4–§6.**
- **Order:** `isSquare_of_sqClass_eq_zero`, via `Nat.sq_mul_squarefree`: a squarefree natural with all exponents
  even is 1. Then `exists_sqClass_eq`, as the product of the support's primes by `Finset.induction`. Then
  `sqrtField_sup`: a generator `√n` with `sqClass n = sqClass a + sqClass b` has `n · a · b` a square `s²`, so
  `√n = s / (√a · √b)`. Then the headline.
- **Stop rule:** if B2 passes 250 lines or a day, land B1 and B3 (B3 does not need B2) and report B2 **not landed**,
  naming the lemma that resisted.

**Phase B3 — de Grey's field.**
- **Content:** `√5 = √2 · √10 / 2` and `√7 = √35 · √5 / 5` (probe Q7's pattern), `Subfield.closure_le`, and the
  two span facts through `Submodule.map_span`.

**Phase C — optional, only if A and B landed under their prices.** Put Heule-510 into
`fieldPlane (mqField {3, 11, 14, 70})` in the kernel:
- show that `Q4.eval` of a `√7`-free element lies in `mqField {3, 5, 11}`;
- show that `√5 = √70 / √14` lies in `mqField {3, 11, 14, 70}`;
- conclude `5 ≤ χ` from `chromaticNumber_heule510` through a graph homomorphism.

This makes the handoff's item 2 a kernel fact: two fields meeting the test whose compositum's plane needs five
colours. **Stop rule:** half a day. **Risk:** how `heule510.point` relates to `Pt.toPlane` in `ℂ`.

**Traps.**
1. `σ.restrict A A hσ` — copy the coercion pattern from `ResidueColouring.map_mul_conj_eq_zero_iff`.
2. `Module (ZMod 2) k` does not exist until you make it: `letI := ZMod.algebra k 2`. Vector spaces are projective
   through `Module.Projective.of_free` and `Module.Free.of_divisionRing`.
3. The residue field of a valuation ring is a field, hence reduced. The model's `ZMod 2` gets `IsReduced` from
   being a field.
4. `Real.sqrt (n : ℝ)` needs `Nat.cast_nonneg` at every `Real.sqrt_mul`.
5. `lake env lean` without `-DautoImplicit=false` auto-binds stray identifiers; green there is not green.
6. **`tools/fplane.py usable` tests radicands one at a time.** `--rads 22,33` wrongly passes at 11. Do not use it
   for groups with two radicands divisible by the same prime (`VERIFICATION.md` §3).
7. **Mutation audit** (G30 failure mode 6), required before the close. Delete in turn:
   - `h₁` from the splitting lemma;
   - `h2` from `pieceTwo_sup_pieceTen`;
   - `hψσ` from the mechanism;
   - `CharP k 2` from the first lemma.

   Each deletion must break the file. The control — an unused hypothesis added to a lemma nobody calls — must stay
   green.
8. **Headline docstrings state what is not proved** (the §R2 gap, `χ ≤ 4` for the pieces). A docstring that implies
   more fails the read-aloud.

---

## 9. The acceptance test

1. `./scripts/build.sh` green.
2. Zero `sorry` in both modules (`rg -n sorry Proofs/HadwigerNelson/TwoColourResidue.lean Proofs/HadwigerNelson/SquareClass.lean`).
3. Every headline registered in `scripts/Axioms.lean` under a new section. `./scripts/axioms.sh` reads the standard
   three for each, with the count moved by exactly the number registered.
4. `./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` green. Read the digest's count changes and put
   the new counts into `CLAUDE.md` § The gate.
5. `python3 tools/check_architecture.py` PASS, with the two rows' "Skeleton (FS-36)" removed and the row column
   set if a ledger row lands.
6. `python3 tools/bib_audit.py` reports zero unlogged works.
7. The spec examples and reds in §6 pass; the mutation audit of §8 trap 7 is recorded in §R.
8. §7's paragraphs are re-read against the finished statements, and any change is written into §R.

---

## 10. What the close records (WORKFLOW step 9)

1. **Ledger row 63 — recommended as earned, modestly.** Draft (about 900 characters; `CLAUDE.md` is at 83,624 of
   its 90,000):

   > | 63 | **Two colours from inertia, and the 2-adic splitting of multiquadratic fields**: a residue map into a
   > reduced characteristic-2 ring that conjugation does not move two-colours every unit-distance graph over its
   > valuation subring (`colorable_two_unitDistance_induce_of_valuationSubring`); a square-class group holding
   > [2] and [3] is the sum of two pieces whose 2-adic images avoid [−1], so every real multiquadratic field
   > containing ℚ(√3,√11) lies in the compositum of two fields that meet the four-colour test and hold a Moser
   > spindle (`mqField_le_sup_pieces`; de Grey's field in ℚ(√2,√3,√11,√35)·ℚ(√3,√10,√11,√35)). [hand] For real
   > multiquadratic F, χ(F²) = 2 iff no odd square class is ≡ 3 (mod 4). **Credit:** the decomposition is
   > ChatGPT's (OpenAI, with Kooshi, 2026-09-11). **Prior art:** the mechanism is Woodall's, `[Fischer1990]`
   > Thm 8, `[Moorhouse2010]` Thm 7.1, `[Madore2015]` Prop. 3.9; the multiquadratic iff is unchecked against
   > `[AxenovichEtAl2014]` and `[Johnson2006]`. | `TwoColourResidue.lean`, `SquareClass.lean` | FS-36 |

   If Phase B2 does not land, drop "lies in the compositum" to the class-level statement and say so.
2. **`CLAUDE.md` § Frontier.**
   - One clause in "What the hunt has established", or none: this is not hunt material.
   - Extend G38 by one sentence: with conjugation in inertia the reduced norm-one group is trivial, so a real
     multiquadratic plane is 2-colourable iff no odd square class is ≡ 3 (mod 4) — which corrects the field-wall
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
   - the two-colour case is Theorem A's natural companion, and it answers Madore's "slight difficulty" in Prop. 3.9.
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
| P4 | `sqrtField_sup` needs nothing Kummer-theoretic — only `exists_sqClass_eq` and the square lemma | any appeal to linear independence of square roots |
| P5 | no existing module is edited except `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` | any other edit |
| P6 | `frobenius_inj` closes `eq_one_of_mul_self_eq_one_of_charTwo` in ≤ 3 lines | a longer proof |

---

## §M1 — Domain-modeling pass

*(to be written by the pass)*

## §M2 — Obligation-modeling pass

*(to be written by the pass)*

## §M3 — Experience-modeling pass

*(to be written by the pass)*
