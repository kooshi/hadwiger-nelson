# P4 — the spindle theorems off `ZMod`, and every finite Euclidean plane forced-pair-free

*Subplan, 2026-09-09, de Bruijn. Package P4 of the six-way consolidation
(`plans/CONSOLIDATION-PARALLEL-PLAN.md`). Two items in order: **FS-24 G3**
(`plans/STUB-generalize-the-kernel.md` lines 96–112) then **FS-25 E1**
(`plans/STUB-explain-the-unexplained.md` lines 39–83).*

---

## 0. What this is, for a reader with no memory of the project

Two jobs, and the first exists to make the second statable at the level it deserves.

**G3 — a hypothesis stated as a congruence where the proof wants a field property.** Five theorems in
`Proofs/HadwigerNelson/LocalGlobal.lean` are stated about the integers modulo a prime `p` with `p % 4 = 3`.
Their proofs use that congruence for exactly one thing: to know that `−1` has no square root. The lemma
that does the work (`isSquare_neg_one_of_spindle_radicand`, `LocalGlobal.lean:238`) is *already* stated over
an arbitrary field, and the declaration immediately after it throws that generality away. Taking
"`−1` is not a square" as the hypothesis costs nothing and makes the theorems apply to fields with `p^n`
elements — which is where the odd-degree half of this project's prime sieve lives (`UD(𝔽₂₇, 2)`, M61) and
which no theorem in that file can currently even mention.

**E1 — four measurements where a theorem was available.** The project's record says, of four primes
(3, 7, 11, 19), that the finite Euclidean plane over that prime has *no forced pair*: no two distinct points
get the same colour in every proper `k`-colouring. Each was established by exhibiting a colouring table and
checking it by `decide`. That is a theorem for every prime at once, and the mechanism at the centre of
milestone M61 (grokking `G48`) takes it as a **hypothesis** — so today that mechanism fires only at primes
where somebody has already solved a plane by computer.

## 1. The objects, named

* The **finite Euclidean plane** at `p`: vertices `𝔽_p × 𝔽_p`, two joined when their difference `(a, b)`
  satisfies `a² + b² = 1`. In the kernel, `finitePlane p = unitQuadrance (ZMod p)`
  (`UnitQuadrance.lean:51,57`), and `unitQuadrance R` is `SimpleGraph.addCayley` of the circle for **any**
  commutative ring `R`.
* **A forced pair** at `k` colours: `Forces G k u v := ∀ C : G.Coloring (Fin k), C u = C v`
  (`Forcer.lean:41`).
* **Forced-pair-free** at `k`: `∀ u v, Forces G k u v → u = v`. This is precisely the hypothesis
  `hfree` of `Forces.no_hom_of_spindle_radicand` (`LocalGlobal.lean:265`).

## 2. §PA — the prior-art gate (WORKFLOW step 3a), run 2026-09-09 before any derivation

**Searched, in the disciplines' own vocabulary, never in this project's coinages.**

| discipline | query shape | outcome |
|---|---|---|
| finite geometry / algebraic graph theory | *finite Euclidean graph*, *unit-quadrance graph*, chromatic number, Cayley graph on the circle over a finite field | The objects are `[Vinh2005]`, `[Vinh2006]`, `[MMST1996]`, `[Krebs2022]` — **all already in `BIBLIOGRAPHY.md`**. They study `χ`, `ω`, spectra (Kloosterman), Ramanujan-ness, triangle-freeness. **None asks whether a pair is monochromatic in every proper colouring.** |
| graph colouring theory | *uniquely colorable Cayley graph*, colour classes as cosets; pairs receiving the same colour in every proper `k`-colouring | The adjacent classical theory is **uniquely colourable Cayley graphs**: for such a graph over a group `Γ`, `χ ∣ |Γ|` and each colour class is a coset of a subgroup of order `|Γ|/χ` — `[LiuEtAlUCC]` (*Uniquely colorable Cayley graphs*, Ars Math. Contemp.) and `[UCC2026]` (arXiv:2609.03184, September 2026, fetched and read: resolves two open problems on unique colourability, and contains **nothing** about forced pairs, period groups of colourings, or finite Euclidean graphs). This is the *opposite* extreme from E1 — a uniquely colourable graph is one where forced pairs are as plentiful as possible — and the two never meet in one paper. |
| symmetry / automorphisms | vertex- and arc-transitivity of finite Euclidean graphs; the orthogonal group acting on the plane | **Classical and assumed here**: these graphs are Cayley graphs of the additive group whose connection set is stable under `O(2, 𝔽_q)`, so rotations are automorphisms. M61 already uses arc-transitivity (Lovász's `ϑ = ` Hoffman). **The rotation half of E1's proof claims no novelty.** |
| outside arXiv | Ars Math. Contemp.; Springer J. Algebraic Combin.; the Australasian J. Combin. paper on non-Ramanujan finite Euclidean graphs | nothing bearing on the question |

**Finding, stated with its enumeration:** across those four search families I found no statement, in any
form, that a finite Euclidean plane is forced-pair-free, nor of the period-group argument specialised to it.
The two *ingredients* are classical (rotations are automorphisms; an additive subgroup of `𝔽_p²` is an
`𝔽_p`-subspace). The composite appears to be new, and it is small — which is the honest description.

**Bibliography additions** (this round `BIBLIOGRAPHY.md` is owned by package P1, so they go in
`plans/HANDOFF-p4.md` instead): the two uniquely-colourable-Cayley-graph works, recorded as *adjacent
theory, read at abstract level only*.

## 3. The mathematics

### 3.1 G3 — replacing a congruence by a field property

`p % 4 = 3` is used exactly once, through `ZMod.exists_sq_eq_neg_one_iff : IsSquare (-1 : ZMod p) ↔ p % 4 ≠ 3`.
Every theorem in `LocalGlobal.lean` §Spindle therefore restates over a field `K` with `¬ IsSquare (-1 : K)`,
and the old form is recovered in one line. No proof changes; the bodies are re-indented at most.

### 3.2 E1 — the argument, and a correction to the sketch that came with it

**⚠ First, which sense of "null".** `plans/STUB-explain-the-unexplained.md` records that this argument was
first sketched with *"the period line is null"* meaning **isotropic**, `a² + b² = 0`. **That reading is false
and this repository refutes it**: `LocalGlobal.quadrance_eq_zero_iff` says a plane at `p ≡ 3 (mod 4)` has no
isotropic vector at all. The correct sense is *the line the unit circle misses* — a line all of whose nonzero
points have **non-square** quadrance. **Every "null" below means the second sense, and the proof written here
does not mention lines at all**, which removes the ambiguity rather than resolving it.

**The proof, in four steps rather than the stub's five.** The stub's step 4 — *"the `(p+1)/2` circle-missing
lines form a single orbit under the norm-one group"*, an orbit–stabiliser count — **is not needed**. What the
argument needs is one rotation that moves the period line, and the quarter turn always does.

1. **Reduce to the origin.** A forced pair `x, y` is a forced pair `0, d` with `d = y − x`
   (`ResidueObstruction.forces_iff_forces_zero_sub`), and then every proper colouring is `d`-periodic
   (`ResidueObstruction.not_forces_zero_of_not_periodic`, contrapositive).
2. **The quarter turn is an automorphism.** `J : (x, y) ↦ (−y, x)` preserves quadrance
   (`(−y)² + x² = x² + y²`) over **any** commutative ring, and is additive and bijective. So `c ∘ J` is a
   proper colouring whenever `c` is, hence also `d`-periodic, hence `c` is `J d`-periodic.
3. **`d` and `J d` span.** Write `d = (x, y)` and `q = x² + y²`. Since `p ≡ 3 (mod 4)` and `d ≠ 0`, `q ≠ 0`
   (`quadrance_eq_zero_iff`), so with `s = x/q` and `t = −y/q`,
   `s • d + t • (J d) = (s x − t y, s y + t x) = ((x² + y²)/q, (xy − yx)/q) = (1, 0)`.
4. **Contradiction.** Periods are closed under addition and under `ZMod p`-scalars — because in a prime
   field every scalar is a natural-number multiple, and `Function.Periodic.nsmul` is Mathlib's — so `(1, 0)`
   is a period of `c`. But `(1, 0)` lies on the unit circle, so `0` and `(1, 0)` are adjacent, and
   `c (0 + (1,0)) = c 0` contradicts properness. ∎

**Where each hypothesis is spent, stated exactly.**
* `p % 4 = 3` — only in step 3, to know `q ≠ 0`.
* `p` **prime** — twice: `ZMod p` is a field (so `q` is invertible), and every additive subgroup of `ZMod p × ZMod p`
  is closed under `ZMod p`-scalars (step 4).
* **A colouring exists** — the whole argument needs one to rotate. This is not decoration: see §3.3.

### 3.3 The vacuity guard, which is load-bearing and is shipped as a red

`Forces G k u v` is `∀ C : G.Coloring (Fin k), C u = C v`. **On a graph with no proper `k`-colouring it holds
for every pair**, so "every finite Euclidean plane is forced-pair-free at every colour count" is **false as
stated** and the record's own phrasing needs the qualification. Verified numerically here 2026-09-09: at
`p = 3, k = 2` the plane has **0** proper colourings and every pair is vacuously forced; at `p = 3, k = 3` it
has 12 colourings and **0** forced pairs; at `k = 4`, 1056 colourings and **0** forced pairs.

So the theorem takes `(finitePlane p).Colorable k` as a hypothesis, and the module ships **a named inhabitant**
(`finitePlane 3` three-coloured by `x + y`, built and checked in the same file) and **a red** (`finitePlane 3`
refuses two colours, and a specific distinct pair is therefore vacuously forced). That is briefing §8's rule
applied to my own theorem.

### 3.4 What the general finite field needs — the honest boundary

`𝔽_q` with `q = p^n`, `n > 1`, is **not** covered, and the reason is step 4 alone: an additive subgroup of
`𝔽_q × 𝔽_q` is an `𝔽_p`-subspace, not an `𝔽_q`-subspace, so `d` and `J d` span only a 2-dimensional
`𝔽_p`-piece. The repair is known and priced (§6): the period set of `c` contains `r · d` for **every** norm-one
`r`, its `𝔽_p`-span is a subring of `𝔽_{q²}` hence a subfield, and that subfield has more than `q` elements
(the circle has `q + 1` points), so — subfields of `𝔽_{p^{2n}}` having order `p^m` with `m ∣ 2n`, and `m ≤ n`
forcing `p^m ≤ q` — it is all of `𝔽_{q²}` and the colouring is constant. That needs `𝔽_{q²}` as a field with
`𝔽_q` inside and the norm form identified with `x² + y²`; the plane here is `R × R`, so it is a real
construction, not a re-indentation. **Not attempted in this package.**

## 4. The skeleton

Two edits and two new modules.

**(a) `Proofs/HadwigerNelson/LocalGlobal.lean` §Spindle — G3.** General forms added, old names kept as
one-line corollaries with their statements unchanged:

```
sq_add_sq_eq_zero_iff_of_not_isSquare      {K} [Field K] (¬ IsSquare (-1:K))
quadrance_eq_zero_iff_of_not_isSquare      {K} [Field K] (¬ IsSquare (-1:K))
not_isSquare_neg_one_zmod                  (hp : p % 4 = 3) : ¬ IsSquare (-1 : ZMod p)
no_ringHom_of_spindle_radicand_of_not_isSquare        {R K} [CommRing R] [Field K]
Forces.no_hom_of_spindle_radicand_of_not_isSquare     {V R K}
Forces.isEmpty_ringHom_of_spindle_radicand_of_not_isSquare
-- unchanged statements, now corollaries:
sq_add_sq_eq_zero_iff, quadrance_eq_zero_iff, no_ringHom_of_spindle_radicand,
Forces.no_hom_of_spindle_radicand, Forces.isEmpty_ringHom_of_spindle_radicand
```

**(b) `Proofs/HadwigerNelson/PlaneRotation.lean` (new, imports `LocalGlobal` only) — E1.**

```
rotEquiv (h : a^2 + b^2 = 1) : R × R ≃+ R × R          -- rotation by a circle point
quadrance_rotEquiv, rotHom : unitQuadrance R →g unitQuadrance R
quarterTurn : R × R ≃+ R × R                            -- rotEquiv at (0,1); no hypothesis
periodic_of_periodic_comp                               -- σ additive surjective
Function.Periodic.zmodSmul                              -- periods are ZMod n-scalar closed
exists_smul_quarterTurn (hp) (hd : d ≠ 0) : ∃ s t, s • d + t • quarterTurn d = (1,0)
exists_not_periodic (hp) (c) (hd : d ≠ 0) : ∃ c', ¬ Function.Periodic c' d
finitePlane_forces_iff (hp) (hcol : (finitePlane p).Colorable k) : Forces … ↔ x = y
Forces.no_hom_of_spindle_radicand_of_colorable          -- G48's mechanism, from colourability
Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable
colFinitePlane3, finitePlane3_colorable_three           -- the named inhabitant
not_colorable_finitePlane3_two + the vacuous-Forces red -- §3.3
```

**(c) `Proofs/HadwigerNelson/Instances/PlaneFreedom.lean` (new) — the record's four primes, re-derived.**
Imports `PlaneRotation` and `Instances/LocalGlobal19` (which carries the certified colourings at 11 and 19),
and instantiates the general theorem at `p = 3, 11, 19` — reproving `finitePlane11_forces_iff`'s forward half
without its aperiodicity table.

**(d) `Proofs.lean`** gains the two imports.

## 5. Acceptance

* `flock /home/kooshi/source/.consolidation-build.lock ./scripts/build.sh` prints `build: OK`.
* zero `sorry` under `Proofs/`.
* `./scripts/axioms.sh`: ≥ 725 clean, **exactly 5** declared purchases.
* Every name listed in `CLAUDE.md`'s ledger rows 53/55/56 still resolves with its old statement.
* E1's theorem ships with a named inhabitant of its hypothesis **and** the red showing the hypothesis
  cannot be dropped.

## 6. What is deliberately not done

* **`𝔽_{p^n}` for `n > 1`** (§3.4) — specified, not proved.
* The **`Separated` half** (`CoincidesAtNonedges`, virtual edges) is *not* touched: it is a different
  statement about a different table property and the record's instances there are not obviously a theorem.
* **`Instances/ResidueObstruction11.lean`** is not edited (P4 owns new files, not existing instance
  files); that `finitePlane11_forces_iff` is now a corollary of a general theorem is recorded in the handoff.

---

## 7. Domain-modeling pass (WORKFLOW step 5), run 2026-09-09

Four things moved; three deliberately did not.

**Moved.**

1. **The spanning lemma left `ZMod` entirely.** `exists_smul_quarterTurn_eq` was written at `ZMod p`
   under `p % 4 = 3`, producing the single vector `(1, 0)`. Both restrictions were incidental. The fact
   is linear algebra: **over any field where `−1` is not a square, a nonzero `d` and its quarter turn are
   a basis** — the quadrance of `d` is invertible, and the coefficients are two divisions. Stating it
   there and for an arbitrary target vector *deletes* two arbitrary choices (why `ZMod p`? why `(1,0)`?)
   rather than adding generality, and it makes the module's boundary exact: **the only step that needs a
   prime field is the closure of periods under scalars.** That sentence is now checkable against the
   source rather than asserted in a docstring.
2. `p % 4 = 3` is kept as the hypothesis of the *plane* theorems, but is now discharged through
   `not_isSquare_neg_one_zmod` — so the congruence appears where the sieve speaks it and the field
   property appears where the proof uses it. The two are equivalent for every prime, `p = 2` included
   (`ZMod.exists_sq_eq_neg_one_iff`), so nothing is lost.
3. `finitePlane_forces_eq` is kept beside `finitePlane_forces_iff` although it is `.mp` wrapped: the
   `∀ u v, Forces … → u = v` shape is what four existing signatures take as `hfree`, so the packaged
   form is the API the next caller is a special case of, not a second name for one theorem.
4. Three layers — `rotMap` (the additive map), `rotEquiv` (invertible: needs `a² + b² = 1`), `rotHom`
   (graph-preserving: needs the same) — were audited for duplication and kept. They are three different
   structures on one function, each adding exactly one obligation, and Lean has no bundled "additive
   graph automorphism" that would carry both at once. `rotEquiv` cannot be dropped in favour of a bare
   surjectivity lemma, because `rotHom`'s adjacency step needs injectivity as well.

**Deliberately not moved.**

5. **`isSquare_neg_one_of_spindle_radicand` stays over a field.** Its proof would generalize to a
   commutative ring with `IsUnit (φ e)` in place of `φ e ≠ 0`. No consumer wants that, and its sibling
   `quadrance_eq_zero_iff_of_not_isSquare` genuinely needs inverses — the whole section is about
   *residue fields* of primes. Recorded here rather than in the file so a later G3-style audit does not
   re-derive it.
6. **The `Submodule.span … = ⊤` phrasing of the basis fact** was considered and rejected: the consumer
   wants one explicit combination, and `span_induction` would be a detour. The elementary `∃ s t`
   form *is* the spanning statement.
7. **Module name.** `PlaneRotation.lean` names the mechanism (reusable: rotations of `unitQuadrance R`
   over any ring) rather than the headline theorem (freeness, prime fields only). A future milestone
   asking "is rotation an automorphism of the plane?" greps for the mechanism.

**Seams checked.** A named inhabitant of every hypothesis (`p = 3`, three-coloured by `x + y`); the
adversarial member (`k = 2` at `p = 3`: no colouring, so every pair vacuously forced — the theorem is
false without `Colorable`); the unsampled members `k = 0` (hypothesis unsatisfiable, harmless), `p = 2`
(excluded by the congruence), `x = y` (the reverse direction). The predictable next lemma — the arity
floor at `≥ 3` — is **not** free: `three_le_arityFloor_of_aperiodic_coincides` is packaged as *one table
with both properties*, and this milestone supplies only the `Forces` half.

## 8. Obligation-modeling pass (WORKFLOW step 5), run 2026-09-09

**There is no induction in E1.** The space is not carved by a recursor: the argument is a chain of
implications, and the only induction anywhere is Mathlib's, inside `Function.Periodic.nsmul`. So this
pass's work was the *statement*, not the case table.

**The change it produced: the local obligation, extracted and stated positively.** `exists_not_periodic`
was written as a proof by contradiction over "every colouring is `d`-periodic". Underneath it is a
statement with no negation and no quantifier over colourings at all:

> **`not_periodic_quarterTurn`** — a proper colouring of `finitePlane p` is never periodic at both a
> nonzero `d` and its quarter turn.

That is the mathematics; the `by_contra` was plumbing. It is now a named lemma, and `exists_not_periodic`
is its three-line wrapper. A caller who wants the mechanism gets it without the negation.

**The prove / test / assume partition, made deliberately.**
* **Prove** — the rotation layer (`rotEquiv`, `quadrance_rotMap`, `rotHom`), the two period-transfer
  lemmas, the basis fact, `not_periodic_quarterTurn`, and the two theorems above it.
* **Test** — `finitePlane3_colorable_three` and `finitePlane3_not_colorable_two` by `decide`, the
  vacuity `example`, and the instantiations at `p = 11, 19`. These are the instruments that catch a
  *wrong statement*, which no proof can.
* **Assume** — `p % 4 = 3`, `[Fact p.Prime]`, `(finitePlane p).Colorable k`. Each is discharged by the
  shipped inhabitant at `p = 3`, so none of the theorems is vacuous.

**Mutation audit.** Dropping `Colorable k` makes the theorem **false**, and the counterexample ships in
the file (`p = 3, k = 2`). Dropping `p % 4 = 3` breaks the *argument* exactly and visibly: at `p ≡ 1
(mod 4)` an isotropic `d` has `quarterTurn d = −i·d` **collinear with `d`**, so the basis step fails and
a colouring periodic along that line genuinely exists (`unitQuadrance_colorable_of_quotient` builds
one). Whether the *conclusion* also fails there is a different question and is **not** settled here — see
§9's honest-boundary note.

**Transcription.** `decide` at the finite leaves is the faithful transcription of "check them all", not a
shortcut; the rest is a `have` chain with every stepping stone typed.

## 9. Experience-modeling pass (WORKFLOW step 5), run 2026-09-09

Five changes, each from a specific consumer's seat.

1. **`_of_not_isSquare` → `_of_not_isSquare_neg_one`.** Read cold, the shorter suffix does not say *what*
   is not a square, and a reader of `no_ringHom_of_spindle_radicand_of_not_isSquare` would reasonably
   guess "the radicand". The longer form is exact, matches the phrase in Mathlib's own
   `ZMod.exists_sq_eq_neg_one_iff`, and is uniform across the family and the helper
   (`not_isSquare_neg_one_zmod`) — so a reader who finds one finds all six.
2. **The module docstring overclaimed and is corrected.** It opened *"Every finite Euclidean plane is
   forced-pair-free"*. Planes at `p ≡ 1 (mod 4)` are finite Euclidean planes and are **not** covered; the
   headline now says `p ≡ 3 (mod 4)`, and so does the section heading. (FS-25's own headline carries the
   same overclaim; flagged for the record in the handoff.)
3. **`not_periodic_quarterTurn` returns a `¬`, not `False`.** Stated as
   `(h1 : Periodic c d) : ¬ Periodic c (quarterTurn d)`, the name is the statement and a caller who has
   only one of the two periods can still use it. As a two-hypothesis `False` it was a lemma whose name
   described neither its givens nor its conclusion.
4. **`quarterTurn_apply` is `@[simp]`.** The intended normal form is `(−w.2, w.1)`; without the tag a
   `simp` reaching it through `rotEquiv_apply` lands on `(0 * w.1 − 1 * w.2, 1 * w.1 + 0 * w.2)` and needs
   arithmetic to recover. The tag is cheap: its head symbol is `quarterTurn`, so it costs nothing in any
   goal that does not mention one. The three `_apply` lemmas were audited for confluence — each rewrites a
   coercion into a `Prod` literal, none loops, and this is the house pattern (`projAlong_apply`,
   `addCayleyTranslate_apply`).
5. **The instances module carries the record's four primes, not three.** `p = 7` had no certified
   colouring in the kernel; it takes eight lines through the existing quotient machinery — the line
   through `(1, 2)` has non-square quadrance `5`, so the circle projects to `{1, 2, 5, 6} ⊂ ZMod 7` and
   the table `[0,1,2,0,1,2,3]` is proper along it (worked by hand, checked by `decide`). So
   `Instances/PlaneFreedom.lean` re-derives **3, 7, 11 and 19** — exactly ledger row 55's four measured
   instances — rather than a subset, which is what makes it evidence.

**Not done, deliberately.** A decomposed `three_le_arityFloor` taking the `Forces` and `Separated` halves
separately (M60 packages them as one table with both properties, so my theorem cannot feed it). No user
asks for it yet; noted in the handoff instead of built.

**Checks run.** `exact?`-shape: the goal a caller actually holds is `hfree : ∀ u v, Forces … → u = v`, and
`finitePlane_forces_eq` has exactly that shape. API-only test: `Instances/PlaneFreedom.lean` proves the
record's four instances through the public surface with no `unfold`.
