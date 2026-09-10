# M64 — the orbit-filling geometry of a level set (FS-34)

*Subplanned 2026-09-10 on Kooshi's go. The stub is `plans/STUB-orbit-filling-polytope.md`; read it
for the motivation and the prior art. **This subplan supersedes the stub's §3 conjecture and §4 phase
order**, because the stub's phases 1, 2 and the core of 4 were run during subplanning (WORKFLOW step 3:
"where cost decides the shape, measure before specifying"), took under two hours, and returned an
answer of a different species than the one conjectured. §0 records what changed and why; §1 restates
the objects on the measurements; §2 is the corrected conjecture; §3 the acceptance test; §4 the
phases; §5 the registered predictions; §6 what must not be done; §7 the instruments.*

---

## §PA — The prior-art gate (WORKFLOW step 3a)

**It was not run when the stub was minted, and it was not run by me at the top of this subplan — I
went straight to measurement. Poros ran it** (advisory 2026-09-10, `plans/POROS-2026-09-10-orbit-polytope.md`)
**and it named four literatures, three of which own a piece of this milestone.** That is `G49`/`G50`
again: the recognition step supplies the search query for free, and the query was never issued.

**(a) The polytope question has a name and a testable hypothesis: IDEALNESS.** `{M}` is the set of
minimum hitting sets of `Y` (M63 §O). A 0/1 matrix `A` is **ideal** when `{x ≥ 0 : Ax ≥ 1}` is
integral; then the minimum hitting sets are exactly the integer points of that polyhedron's optimal
face — which is C1 *stated upstairs, at the atoms*, as a theorem with a hypothesis one can check.
**Lehman** characterised the minimally non-ideal matrices completely. Entry points: Abdi's LTCC
*Blocking and antiblocking theory* notes and CO750 *Packing and Covering*; Conforti–Cornuéjols–
Zambelli *Integer Programming*, the ideal-matrices chapter; Cornuéjols, *Combinatorial Optimization:
Packing and Covering* (CBMS 74). **This is the cheapest theorem the milestone was missing.**

**(b) Overcompression is the SYMMETRY GAP of symmetric integer programming, and that field owns it.**
For a linear program with an invariant objective, averaging over the group puts an optimum in the
fixed space; for an *integer* program averaging leaves the lattice, so the fixed-space optimum can be
strictly worse. **That gap is Parts's overcompression in the vocabulary of the field that owns it**,
and our `Λ_H` slices are its fixed spaces. Machinery: **core points** (Herr–Rehn–Schürmann, ORL 2013,
arXiv:1202.0435; Bödi–Herr–Joswig, Math. Prog. 2013, arXiv:1012.4941; arXiv:2007.10863),
**orbitopes** (Kaibel–Pfetsch, *Packing and partitioning orbitopes*, arXiv:math/0603678 — literally
the convex hulls of orbit-restricted 0/1 matrices, with complete facet descriptions in the cyclic
case), **orbitopal fixing**, **orbital branching** (Ostrowski–Linderoth–Rossi–Smriglio, Math. Prog.
2011), and Margot's survey *Symmetry in integer linear programming*. **C2 is restated in this
vocabulary in §2 and every artifact of this milestone uses it.**

**(c) The projection step has a theorem, and it predicts C1's failure a priori.** Ginsburg–Spanier:
Presburger-definable = semilinear; semilinear sets are closed under projection, and *polytopes'
integer points are not*. Barvinok–Woods, and Nguyen–Pak for the unbounded case (arXiv:1612.08030),
give the structure and the complexity of exactly *"the projection of the integer points of a
polyhedron"*. **`Prof` is a linear image of `{M}`, so it is semilinear and generally NOT a polytope's
integer points — the species was nameable before we measured it, and the L side's 2-point defect is
generic projection behaviour rather than a surprise.**

**(d) What was NOT found, and it is the encouraging half.** No prior art for the specific claim
*"the minimum symmetric optimum is not an overgraph of the minimum asymmetric one"* as a structural
statement about covering optima. The symmetry-breaking literature knows that *incomplete* symmetry
breaking loses solutions (arXiv:2502.10056 is set-covering-flavoured) — a different statement.
**Restated in (b)'s vocabulary, the conjecture has room.**

Every one of these goes into `BIBLIOGRAPHY.md` as named-only rows the day this milestone opens.

---

## §0 — What subplanning measured, and what it overturned

The stub conjectured (C1) that the profile set `Prof` of a complete level set is *"the integer points
of a low-complexity polytope"*, and proposed fitting `conv(Prof)` as phase 1. That was run. **The
polytope framing is not wrong so much as it is the small half of the truth, and it was hiding the
mechanism.**

Everything below is measured on the two complete level sets M63 produced, with **no solver except
where marked**, and every number carries its enumeration.

### (i) `Prof` has two exact conservation laws nobody predicted

On the L side (375-vertex level, **3,264 minima, `exhaustive-level`, zero undecided asks**) the four
varying orbits satisfy, in **all 27** realised profiles:

```
    |S n (2,0,6,4)|  +  |S n (10,0,2,4)|  ==  12
    |S n (4,0,10,2)| +  |S n (6,2,8,0)|   ==  12
```

So `Prof` has **affine dimension 2**, not 4. This is the single largest fact about it and the stub
does not contain it.

### (ii) The laws are a PERFECT MATCHING, and 24 of 24 are DERIVED, not observed

Each law is **twelve disjoint pairs `{u, v}`, one endpoint in each orbit, with exactly one endpoint
kept in every minimum.** The matching was found by exclusion over the level set (an observation), and
then **derived**: for all 24 pairs, `A - {u,v}` is 4-colourable (24 solver asks, 0.23 s mean, zero
undecided) — so `{u,v}` **is a size-2 minimal correction set** and at least one endpoint is needed by
*every* refusing selection, not merely by the ones we enumerated.

**The S side is where the derivation bites, and it kills part of the observation.** Of its 15
exclusive pairs, **only 9 are correction sets**; the other **6 are exclusive across all 48 minima and
are NOT forced pairwise** — their exclusivity is a fact about the level set, not about the stage.
*Measurement generated 15 candidates; derivation killed 6.*

### (iii) The whole atom set decomposes, and the arithmetic closes exactly

With the level set complete and `R` upward closed, `a` lies in every minimum **iff** `A - {a}` is
colourable **iff** `{a}` is a correction set — so the necessary atoms are readable off the minima with
no solver at all. Both sides then decompose:

| | S (136-vertex level) | L (375-vertex level) |
|---|---|---|
| minima, complete | 48 | 3,264 |
| atoms in `A` | 165 | 402 |
| **necessary** (= the degree-1 correction sets) | **105** | **336** |
| **in exclusive pairs** | 30 (15 pairs) | 48 (**24 pairs**) |
| **residual free** | 30 | 18 |
| every minimum is | 105 + 15 + **15 of 30** = 135 | 336 + 24 + **14 of 18** = 374 |

**The reduction run's own `degree_1` count is LOWER than the necessary count — 96 vs 105, and 312 vs
336.** That is not a defect: it is `Y`'s laziness measured. M63 §O(1) states the invariant that the
harvested hypergraph is a *subset* of the true one; this is the first number attached to it — the
harvest missed **9** and **24** degree-1 hyperedges respectively, and the level set is complete anyway
because the SAT step closes the gap.

### (iv) On the L side the profile map factors through the matching, exactly

`profile = pi(pair-pattern)`: **2,943 distinct pair-patterns → 27 profiles**, a function, verified on
all 3,264 minima. The 18 residual atoms live in two orbits whose per-orbit counts are **constant**
(10 of 12 in `(2,0,2,4)`, 4 of 6 in `(4,0,0,0)`) — they permute *within* orbits and are
profile-invisible. **On the S side the factorisation FAILS** (24 pair-patterns → 4 profiles, not a
function): there the residual atoms sit inside the varying orbits and do move the profile. The two
sides are structurally different and that is a finding, not noise.

### (v) The convexity story is SMALL, one of its two numbers was an ARTIFACT, and on one side the test could not fail

Exact integer hulls, rational arithmetic:

| | S | L |
|---|---|---|
| box points with the right sum | 5 | 135 |
| **box points in `aff(Prof)`** | **5** | **35** |
| `\|Prof\|` | **4** | **27** |
| `\|conv(Prof) ∩ ℤ^O\|` | **4** | **29** |

**~~fill fraction 0.80 (S) against 0.20 (L)~~ — CORRECTED, and the correction deletes a finding.**
The stub's headline contrast between the two sides was a **dimension artifact**: `Prof` has affine
dimension 2 on *both* sides, so the L side's 135-point box is 100 points of ambient space the set was
never free to occupy. Against the affine box the fills are **S 0.800 and L 0.771 — the same
density** — and the stub's §2 finding (i), *"the profiles are sparse in the box"*, and its S-vs-L
contrast both dissolve. (Found by Poros; verified here independently.) **Any fill fraction this
milestone prints carries its ambient dimension in the same sentence.**

**And the S-side convexity result was structurally forced, so it measured nothing.** `Prof` there is
4 points whose hull is a triangle of area 1; by Pick's theorem `1 = I + 4/2 − 1` gives `I = 0`, so it
has **no interior lattice point and `Prof = conv(Prof) ∩ ℤ^O` could not have failed** whatever the
data said. That is `G21` on my own subplanning measurement: a check run against a criterion that
cannot fire measures the criterion.

**What survives, decomposed in the only honest order.** Of the L side's 108 excluded box points:
**100 are the two conservation laws** (135 → 35 before convexity is invoked at all), **6 are
convexity** (35 → 29), and **2 are neither** — `(5,3,9,7)` and `(5,4,8,7)`.

**The replacement test, with a null that is not vacuous.** `Prof` is an **order ideal** — a down-set
in the coordinatewise order on the two free coordinates. Measured here: on the L side it is a
down-set in **exactly one of the four orientations** of the two conservation blocks, and of the
`C(35,27) = 23,535,820` subsets of the affine box only **17 are down-sets in a given orientation**,
so `p ≤ 4·17/23,535,820 ≈ 2.9 × 10⁻⁶`. **That is a test convexity could not be: it discriminates on
both sides, and it fires where convexity was guaranteed to pass.**

### (vi) THE MECHANISM OF OVERCOMPRESSION, measured — and it reproduces his parenthetical

The matching is **equivariant under exactly the stage's stabiliser**: `Aut(A)` has order 12 on the L
side and 6 on the S side, and **every one of its elements permutes the pair set onto itself** (12/12
and 6/6; the other twelve and eighteen group elements do not preserve `A` at all). So a symmetry rung
`H <= Aut(A)` acts on the pair-choices, and `Prof(H)` is the image of the `H`-constant patterns.

Which makes C2 computable with **no new solving at all**, and it was:

| | S, `\|Aut(A)\| = 6`, 6 subgroups | L, `\|Aut(A)\| = 12` (dihedral), 16 subgroups |
|---|---|---|
| rungs with an invariant minimum **at this level** | **only the trivial one** | the trivial one, and **exactly 3 of the 6 involutions** (40 minima each, 9 profiles each) |
| every other rung | **0 invariant minima** | **0 invariant minima** |

**Every nontrivial rung on the S side, and 12 of the 15 nontrivial rungs on the L side, have NO
minimum at the minimum size.** Their own minima are therefore strictly larger — which is the setting
of `[Parts2020a]` §6's *"none of the 376-vertex graphs is an overgraph of any of the 375-vertex
graphs"*. And his §5.8 parenthetical — ***"this is especially noticeable for S-subgraphs"*** — is
reproduced from an independent computation: **the S side is the one where the symmetric level is empty
at every nontrivial rung.**

### (vii) The stub's §5 claim about the artifacts is FALSE and it blocks phase 2

`plans/STUB-orbit-filling-polytope.md` §5 says the harvested correction sets are *"the `hypergraph`
field of each reduction record"*. **They are not.** `parts_reduce.reduce_stage` stores
`{"degree_1": <count>, "correction_sets": <count>, "by_size": {...}}` — cardinalities only. `Y` itself
was computed at a cost of ~10 minutes per side and thrown away. Fixing that is phase A below, and it
is a schema obligation, not a nicety: **`Y` is the explanatory object of this entire milestone.**

### (viii) It is NOT a matroid, and that was worth refuting

The natural reframe is the complement: `S` refuses **iff** the dropped set `D = A \ S` contains no
member of `Y`, so the droppable sets are the **independence complex of `Y`** — a downward-closed set
system — and `{M}` corresponds to its **maximum** faces, all of one size (28 on L, 30 on S). If that
complex were a **matroid**, `{M}` would be its bases, `Prof` would be a linear image of a matroid base
polytope, and every integer point of the image would be attained — which the 2-point defect would
contradict. **Measured: the basis-exchange axiom fails in 3,296 of 4,000 sampled trials on the L side
and 1,029 of 1,128 on the S side.** Not a matroid, decisively — so the complex, not the matroid, is
the species, and the defect is consistent with §PA(c)'s theorem rather than with a broken measurement.

### (ix) The exchange classes, and a free completeness control

The difference lattice of `Prof` is generated by **single orbit swaps** `e_o − e_o'` realised between
actual profiles. S: all six swaps among its three varying orbits — **one exchange class of size 3**.
L: exactly `±(e_a − e_d)` and `±(e_b − e_c)`, none across — **two classes of size 2**, which is what
the conservation laws are, seen from the lattice side. Inside its affine hull the L set is literally
`{a ≤ 4} ∪ {b ≤ 2}` — one disjunction, and therefore non-convex by construction.

Poros pre-registered the class structure and ran it on **all four of `[Parts2020a]`'s independently
published `{M}` columns**: on `374_m6c` the partition is **forced and is our pair with our constant
12**; on `374_m6ab` (13 consistent partitions) and `375_m6ab` (4) **exactly one contains both of our
measured pairs**; on `376_m6a` (27,202) it is consistent but uninformative. Its first form of the
claim — *pairs* — fired its own registered falsifiers on `376_m6a` and on our S side; the general
form, **constant-sum groups**, passes everywhere, and the S side is a class of size 3 rather than a
failure.

**The control this buys, and it is free on every future run: the exchange classes determine
`aff(Prof)`, so a level set whose profiles do not span the predicted affine hull is INCOMPLETE** — a
completeness check entirely orthogonal to `exhaustive-level`'s own proof.

### (x) One artifact has no producer

`data/m62/m63-profiles-S.json` and `-L.json` were written by a scratchpad script that was never
committed, so the atom → profile map is not recoverable from the repository and the advisory could
not re-derive it. Phase B owns the fix: the profile computation lives in `tools/parts_faces.py` and
the JSON records its producer and fingerprints.

---

## §1 — The objects, restated on the measurements

Fix the base `B` (`tools/parts_repro.Base`, `[Parts2020a]` §5.6, radius `PARTS_R = 2.6`), its orbit set
`O` under the order-24 group, and a **stage** (`tools/parts_stage.Stage`) = a side (`L` or `S`), a
working graph `W`, a frozen companion `C`, and the atom set `A` of deletable vertices.

- **`R`** — the refusing selections (`W u C` not 4-colourable). Upward closed (M63 §O).
- **`Y`** — the minimal correction sets: `S in R` **iff** `S` meets every member of `Y`. Harvested
  lazily, so at any moment `Y_harvested ⊆ Y`; every hitting-set bound over the harvest is a **lower
  bound**, closed by the SAT step (M63 §O(1)).
- **`{M}`** — the minimum-size members of `R`; **`Prof = f({M})`** its profile set, `f_o(S) = |S ∩ o|`.
- **The three atom classes**, all derivable from a complete level set with no solver:
  **necessary** (`{a} ∈ Y`), **paired** (in a size-2 hyperedge that the budget makes tight),
  **residual**.
- **Rung.** `H <= Aut(A)`, where `Aut(A)` is the subgroup of the order-24 group preserving the atom
  set — **measured, not chosen**: order 12 (L, dihedral) and 6 (S).

**Two vocabulary fixes, binding on every artifact this milestone writes.** `Aut(A)` is *the stage's*
stabiliser and is never called "the group"; and a count of `H`-invariant objects **at a stated size**
is never called the `H`-minimum until a search at rung `H` has returned one.

---

## §2 — The corrected conjecture, in the vocabulary of the fields that own it

> **C1-upstairs (idealness).** Is `Y` an **ideal** 0/1 matrix? If it is, `{M}` is exactly the integer
> point set of the optimal face of `{x ≥ 0 : Ax ≥ 1}`, and everything the stub wanted about `Prof`
> follows from a named theorem rather than from a fit (§PA(a)).

*Falsifier:* `Y` is not ideal — in which case Lehman's characterisation of the minimally non-ideal
matrices says which sub-structure to look for, so the negative is informative too.

> **C1-downstairs (the species).** `Prof` is **not** the integer points of a polytope and was never
> going to be: it is a linear image of `{M}`, hence **semilinear** (§PA(c)). Its measured description
> is *exchange classes* (equalities) **∩** box **∩** an **order ideal** in one orientation, with
> convexity as a residual approximation good to 6 of the last 8 exclusions.

*Falsifier:* a level set whose `Prof` is not an order ideal in any orientation — at `p ≈ 3 × 10⁻⁶`
per level set, that is a test with teeth.

> **C2 (overcompression = the symmetry gap).** In the vocabulary of symmetric integer programming:
> the objective is invariant, so averaging puts an *LP* optimum in the fixed space, but averaging
> leaves the lattice, so the *IP* optimum over `Fix(H)` can be strictly worse. **Overcompression is
> that gap, and its combinatorial face is the emptiness of `{M} ∩ Fix(H)`** — at most rungs the
> minimum level carries no invariant member, so the rung's own minimum is strictly larger and cannot
> be an overgraph of anything at the smaller level.

*Falsifier, the decisive experiment:* run the reduction **at rung `H`** on a rung whose invariant
level is empty, obtain `{M_H}`, and test containment both ways against `{M}`. If some member of `{M}`
sits inside some member of `{M_H}`, C2 dies on our own reproduction of his own object.

> **C3 (the payoff), sharpened.** The expansion step's missing measure is not *"optimise over an
> inequality description"*. It is **the exchange classes and their totals** — a short integer vector
> per iteration that moves when the problem changes. M63 §O(3) proved his outer loop has **no
> termination measure at all**; this is a candidate for one.

*Falsifier:* the classes are constant across the loop's own recorded moves, so the vector carries no
information about progress.

**Bearing on χ(ℝ²) ≥ 6: indirect, and stated as such.** A theory of search landscapes, not a
construction. Its value is a measure for the expansion step, and a proof for the record-holder's
stated nuisance.

## §3 — The acceptance test

The milestone lands if, and only if:

1. **`Y` is an artifact.** Both reduction records carry the harvested correction sets themselves, with
   their by-size census, and a re-run reproduces the recorded `Y` under a stated fingerprint.
2. **The decomposition is reported with its derivation status per part** — necessary / paired /
   residual, with the number of pairs *derived* by ask separated from the number merely *observed*
   over the level set. The S side's 9-of-15 must appear as 9-of-15 and never as 15.
3. **The exclusion budget is decomposed** — laws first, convexity second, unexplained third, in that
   order, in the same sentence as any fill-fraction number.
4. **At least one rung with an empty invariant level is searched to its own minimum**, with the
   containment test run against the complete smaller level set, and the verdict recorded whichever way
   it comes out.
5. **Every count carries its enumeration and its method** (`parts_report.Count`), every bound its rung
   (`parts_report.Bound`), and no verdict word means "clean".

**Not gated:** whether `Prof` is exactly `conv(Prof) ∩ ℤ^O`. §0(v) shows the convexity layer is small;
promoting it to a gate would let a 2-point defect sink a milestone whose content is elsewhere. It is
**reported, never gated.**

---

## §4 — Phases

**Phase A — `Y` becomes an artifact.** Change `reduce_stage` to store the harvested correction sets
(sorted, deduplicated) alongside their census, add a `Y` fingerprint to `parts_report`, and re-run both
sides to regenerate the records. *Cost: ~25 min of compute, mostly the two re-runs.* The old records
are kept under their fingerprints; nothing is silently overwritten.

**Phase B — the decomposition module.** `tools/parts_faces.py`: from a complete level set, compute the
three atom classes, the exclusive pairs, the derivation status of each pair (by ask), the profile
factorisation test, the exact integer hull with the exclusion budget decomposed, and the per-orbit
table. Self-test with planted controls: a level set with a broken conservation law must not report one;
an observed-but-underived pair must never be reported as derived. *Cost: half a day, one solver pass of
~40 asks.*

**Phase C — the rung census, and then the decisive experiment.**
1. For every subgroup `H <= Aut(A)`, the invariant count at the minimum level (done in subplanning;
   re-run inside the instrument with its controls).
2. **Extend the stage to an arbitrary rung.** `Stage._atoms` raises `NotImplementedError` for
   everything but rungs 1 and 24, and the fix is *not* a new atom construction: add
   `sel[a] <-> sel[g(a)]` for `g` in a generating set of `H` to the existing rung-1 CNF. That is a
   handful of clauses and it makes every one of the 16 subgroups searchable.
3. Run the reduction at a rung with an empty invariant level, get `M_H` and its level set, and **test
   containment both ways** against `{M}`.
*Cost: one day. The symmetric runs have far fewer free variables than the rung-1 run's 600 s.*

**Phase D — `Y`'s small layers against the exclusions.** Project the degree-1 and degree-2 layers onto
orbit coordinates, attribute each excluded box point to the layer that kills it, and report what is
left. Only here does convexity enter, and only as the residual. *Cost: half a day, no solver.*

**Phase E — the L-vs-his range fork (stub §2 ii). THE CHEAP TEST IS ALREADY RUN AND ITS REGISTERED
FALSIFIER FIRED.** Poros noticed what the stub's table hides: expressed in the two free coordinates,
his published `375` ranges give exactly `[0,4] × [2,6]` — **25 profiles — and ours is that plus
exactly `(5,2)` and `(6,2)`, which are precisely the two points that make `Prof` non-convex.** It
pre-registered the discriminator: *if his enumeration was truncated, the two tail profiles should
carry far fewer minima than the body average; falsifier — either one at ≥ 40 minima.*

**Measured here: `(5,2,10,7)` carries 120 minima against a body mean of 124.8 across the 25 body
profiles, and `(6,2,10,6)` carries 24 (the smallest body multiplicity is 6).** The falsifier fires on
the first. **A profile carrying 120 of 3,264 minima is not something a size-ordered enumeration
plausibly misses while recording 282 others, so truncation is not supported and the live explanation
is that our stage is genuinely wider** — his minimal M6A subtype uses 18 connection edges where our
companion carries 24. The phase is therefore reduced to one run: re-reduce L with the companion
restricted to 18 connection edges and see whether the two tail profiles disappear. **State before
running that this changes the problem**, so their disappearance is evidence about the connection
count and not proof about his 282.

**Phase F — C3', only if D leaves the description usable.** State the expansion as an integer program
over profile coordinates and test it against one recorded move of Parts's own four-state path.

---

## §5 — Registered predictions

| # | prediction | how it is scored |
|---|---|---|
| P1 | Every pair the S side reports as *derived* stays derived on re-run; the 6 underived stay underived. | phase B |
| P2 | At least one rung with an empty invariant level has its own minimum **≥ 2 vertices above** the rung-1 minimum. | phase C3 |
| P3 | **The containment test fails** — no member of `{M}` sits inside any member of `{M_H}`. | phase C3 |
| P4 | `Prof` is an **order ideal** in some orientation at every complete level set this milestone produces, including the rung-`H` ones. | phases B, C3 |
| P5 | `Y` is **not** ideal (§PA(a)) — the L side's 2-point defect is the visible shadow of it. | phase D |
| P6 | The two unexplained L profile points `(5,3,9,7)`, `(5,4,8,7)` are excluded by a hyperedge of size ≥ 3. | phase D |
| P7 | `Aut(A)` on the L side is dihedral of order 12 and the three live involutions are conjugate in it. | phase C1 |
| P8 | The S side's profile map does **not** factor through its matching at any rung. | phase B |
| P9 | Restricting the L companion to 18 connection edges removes **both** tail profiles `(5,2)` and `(6,2)`. | phase E |
| P10 | Every complete level set spans the affine hull its exchange classes predict (the free completeness control, §0 ix). | phases B, C3 |

---

## §6 — What must not be done

1. **No fill fraction without its decomposition.** "0.20" and "98 %" are both true and both misleading
   alone; the laws-then-convexity-then-residual split travels with every such number.
2. **No promotion of an observed exclusion to a derived one.** The S side's 15-vs-9 is the standing
   example and the instrument must make the conflation impossible, not merely discouraged.
3. **No containment claim from the size ordering.** The stub's own trap: our symmetry ladder reads 582
   at rung 1 against 558 at rung 3, and that is our *search* failing in a larger space — rung 1 admits
   every rung-3 selection, so its true minimum is ≤ 558 by definition. C2' is about containment and
   never about which number is smaller.
4. **No "the H-minimum is X" from an invariant-count of zero.** Zero invariant minima at a level says
   the rung's minimum is larger; it does not say by how much.
5. **No re-use of `Aut B` where `Aut(A)` is meant.** They are order 24 and order 12/6, and M63's §5.9
   pin bug is what happens when a symmetry is assumed rather than measured.
6. **No silent overwrite of a reduction record.** Phase A regenerates both; the old ones keep their
   fingerprints.
7. **No fill fraction, ever, without its ambient dimension in the same sentence.** The stub's own
   headline contrast between the two sides was a dimension artifact and it survived into a committed
   file; that is the standing example.
8. **No convexity test on a hull that cannot have an interior point.** Report the affine dimension and
   the Pick/volume bound first; if the test cannot fail, it is not run and the order-ideal test is run
   instead.
9. **No artifact without a committed producer.** `m63-profiles-*.json` was written by a throwaway
   script and could not be re-derived from the repository by an outside reader; every JSON this
   milestone writes names the module and function that made it.

---

## §7 — Instruments

**Existing, reused:** `tools/parts_repro.py` (base, orbits, labels, `fillings`, self-test),
`tools/parts_stage.py` (the stage, the §5.9 pin and its soundness control), `tools/parts_reduce.py`
(the oracle, phase 1, minimal correction sets, `reduce_stage`), `tools/parts_report.py` (`Count`,
`Bound`, `SetSize`, the fingerprints, the 13 planted refusals), `tools/parts_vtx.py` (exact `.vtx`
parsing), `tools/typem.py` (`parts_lattice`, `parts_group`, `parts_orbits`).

**To build:** `tools/parts_faces.py` — the decomposition, the pair derivation, the exact integer hull
in rational arithmetic, the exclusion attribution, and the rung census. Its self-test plants a broken
law, an underived pair reported as derived, and a hull computation with too few facets (**the bug this
session actually hit: facets of a `k`-dimensional hull are spanned by `k` points, not `k-1`, and taking
`k-1` silently returns "no facets", which makes every box point read as inside the hull**) — each
must flip a verdict.

**Data:** `data/m62/m63-S166-reduction.json`, `m63-L451-reduction.json` (the two complete level sets),
`data/m62/parts-ref11/JP/Large/` (his 43 exact objects), `data/m62/parts-table2-orbit-fillings.json`.

---

## §R — Results

*Written as each phase closed. Every number carries its enumeration; every bound carries its rung.*

### §R1 — THE DECISIVE EXPERIMENT: overcompression measured, at his own two vertex counts

`[Parts2020a]` §6, on his own search: ***"none of the 376-vertex graphs is an overgraph of any of
the 375-vertex graphs"***. He states it as a nuisance of his procedure and does not explain it.

**Reproduced here as a statement about symmetry rungs, from an independent computation, at exactly
375 and 376.** The reduction was run at four rungs of the L stage's own stabiliser `Aut(A)`
(order 12, dihedral, **7 involutions**, of which 3 are live — **P7 met** in its order half), each to a **closed bound with zero undecided
asks**, each level `exhaustive-level`:

| rung | \|H\| | atoms | minimum | **vertices** | minima (complete) | **contains a rung-1 minimum** |
|---|---|---|---|---|---|---|
| trivial | 1 | 450 | 374 | **375** | 3,264 | — |
| **live involution** (40 invariant members at the 374-level) | 2 | 232 | 374 | **375** | **40** | **40 of 40** |
| **dead involution** (0 invariant members) | 2 | 237 | 375 | **376** | **1,302** | **0 of 1,302** |
| **full stabiliser** | 12 | 47 | 378 | **379** | **4** | **0 of 4** |

*(Of the 16 subgroups, **7 have order 2** — dihedral of order 12 has six reflections and one
central rotation — and exactly **3** of those seven carry invariant minima at the 374-level. An
earlier draft of this section said "3 of the 6 involutions"; it is 3 of 7.)*

**The positive control is the row that makes the rest readable.** The live involution's rung was
predicted, before it ran, to return the rung-1 minimum and to contain trivially — because the
rung-1 level set has exactly 40 members invariant under it, counted independently by
`RungCensus` with no solver. It returned **375 vertices, exactly 40 minima, and 40 of 40
containments**. The instrument agrees with the census on a number the census computed a different
way.

**Then the finding.** One step of symmetry in the *other* involution class costs **one vertex** —
376 against 375 — and **not one of its 1,302 minima contains any of the 3,264 minima at 375**;
that is 4.25 million containment tests, all negative. The full stabiliser costs **four** vertices
and its four minima contain nothing either. **So Parts's sentence is not a fact about his search:
it is what a symmetry rung does to a covering problem, and the rung whose invariant level is empty
is exactly the rung whose minimum sits above and outside.**

Total compute for all four rungs: **195 seconds, one core.**

**Predictions scored.** **P3 met** (containment fails, 0 of 1,302 and 0 of 4). **P2 met with its
number reported against the registration**: it asked for a dead rung whose minimum is **≥ 2**
vertices above rung 1, and the full stabiliser gives **+4** — but the *smallest* dead rung gives
**+1**, so the registered threshold is met by one rung and missed by another, and the honest form
is *the gap is 1 at the cheapest dead rung and 4 at the full one*. **P7 met** in its order half;
the conjugacy of the three live involutions is not yet checked.

**What this does NOT say, and §6(4) forbids inferring:** an empty invariant level says the rung's
minimum is larger, never by how much — the +1 and +4 above are *measured*, one rung at a time, and
nothing here predicts the twelve other dead rungs.

### §R2 — The decomposition, reproduced by the instrument on both complete level sets

`tools/parts_faces.py`, **18 planted controls, all fire** (`--self-test`), including the facet bug
that inflated a hull count during subplanning. Run on both M63 level sets with derivation by ask:

| | S (136-vertex level) | L (375-vertex level) |
|---|---|---|
| atoms | 165 | 402 |
| **necessary + paired + residual** | 105 + 30 + 30 | 336 + 48 + 18 |
| **every minimum is** | 105 + 15 + **15 of 30** = 135 | 336 + 24 + **14 of 18** = 374 |
| exclusive pairs **observed** | 15 | 24 |
| exclusive pairs **derived by ask** | **9** | **24** |
| **not derived** | **6** | 0 |
| affine dim of `Prof` (of ambient) | 2 of 3 | 2 of 4 |
| fill within `aff(Prof)` | **0.800** | **0.771** |
| exchange classes | **one of size 3**, sum 27 | **two of size 2**, each sum 12 |
| `conv(Prof) ∩ ℤ` vs `Prof` | 4 vs 4 — **WEAK, 1 opportunity** | 29 vs 27, unexplained `(5,3,9,7)`, `(5,4,8,7)` |
| **order ideal** | yes, 1 of 4 orientations; **null 2 of 15 — not discriminating** | yes, 1 of 4; **null 17 of 23,535,820, `p ≤ 2.9 × 10⁻⁶`** |

**P1 met** (9 derived and 6 not, reproduced). **P4 met on both sides**, and the instrument reports
the S side's null as too small to mean anything rather than counting it as a pass. **P8 met** — the
S profile map does not factor through its matching.

### §R3 — Phase A: `Y` is an artifact

`reduce_stage` now stores the harvested correction sets themselves beside their census, with the
laziness note attached. Every record is regenerated; the pre-change records are kept as
`*.pre-Y.json`, since they are what §R1 and §R2 were computed from.

### §R4 — Two design corrections found at implementation

1. **The rung is an atom construction, not a set of symmetry clauses.** §4 phase C2 specified
   `sel[a] ↔ sel[g(a)]` on the rung-1 CNF. Implementation found the orbit form strictly cheaper:
   `reduce_stage` already weights an atom by its vertex count, so an H-orbit costs its size for
   free, and phase 1, the correction sets, the pin and its soundness control all carry over
   unchanged — where the clause form needed a new weight accounting for the same answer. The clause
   generator was written, found unused, and **deleted**; the reason is recorded in
   `Stage._atoms`'s docstring so nobody re-derives it.
2. **An exchange class of size `k` contributes `k − 1` free coordinates, not one.** The first
   version took one representative per class, which gave the S side a single free coordinate and
   made the order-ideal test **decline on a set it should have decided**. Caught because the S row
   came back empty where the L row did not. Now a control.

### §R5 — THE MECHANISM: overcompression is an orbit-closure gap, and it is two lines

§R1 measured that containment fails. This is *why*, and it is a derivation rather than a census.

> **Theorem (orbit-closure obstruction).** Let `R` be upward closed and `H ≤ Aut(A)`. For any
> `M ∈ R`, every `h(M)` is in `R`, so the **orbit closure** `cl_H(M) = ⋃_{h ∈ H} h(M)` is an
> `H`-invariant member of `R`. Hence:
>
> **(i)** `min_{M ∈ {M}} |cl_H(M)|` is an **upper bound on the rung-`H` minimum**, computable from
> the rung-1 level set with **no solver at all**; and
>
> **(ii)** if `S ∈ R` is `H`-invariant and `S ⊇ M`, then `S ⊇ h(M)` for every `h`, so
> `|S| ≥ |cl_H(M)|`. Therefore
> **`min_M |cl_H(M)| > |M_H|` forbids containment outright** — no minimum sits inside any rung-`H`
> minimum.
>
> *Proof of (ii): an `H`-invariant set containing `M` contains its image under every element. ∎*

**Attribution, stated plainly: the theorem is elementary and no novelty is claimed for it.** "The
orbit of a feasible solution generates an invariant feasible solution" is the combinatorial shadow
of the averaging argument that the symmetric-IP literature is built on (§PA(b)), and anyone in that
field would write these two lines on request. **What is ours is the use and the numbers:**
identifying this gap as the content of `[Parts2020a]`'s *overcompression*, turning it into a
solver-free upper bound on every rung, and measuring it on the record-holder's own object — where
it forbids containment at 375-against-376, which is the sentence he wrote.

**Measured, on both stages, from the level sets alone** (`data/m62/m64-orbit-closure.json`):

| stage | \|Aut(A)\| | closure excess `min_M \|cl_H(M)\| − \|M\|`, by rung order |
|---|---|---|
| **L**, 374-atom level, 3,264 minima | 12 | order 1: **0** · order 2: **0** (×3, the live rungs), **+2** (×3), **+4** (×1) · order 3: **+10** · order 4: **+4** · order 6: **+10, +16, +16** · **order 12: +16** |
| **S**, 135-atom level, 48 minima | 6 | order 1: **0** · **order 2: +8** · order 3: **+12** · **order 6: +24** |

**Against §R1's four searched rungs the theorem holds and is not tight, which is the whole point:**

| rung | `min_M \|cl_H(M)\|` (the bound) | `\|M_H\|` searched | containment |
|---|---|---|---|
| live involution | 374 | **374** | bound tight; containment **holds** (40 of 40) |
| dead involution | **376** | **375** | `376 > 375` ⟹ **containment forbidden**, and it was measured 0 of 1,302 |
| full stabiliser | **390** | **378** | `390 > 378` ⟹ **forbidden**, measured 0 of 4 |

**So overcompression, stated exactly: the cheapest object obtainable by SYMMETRISING an optimum
costs 376 and 390, while the true symmetric optima are 375 and 378. Symmetrisation overshoots by
one vertex and by twelve, and the true symmetric optimum lies strictly below every symmetrisation
— which is why no asymmetric optimum can sit inside it.** That is the symmetry gap of symmetric
integer programming (§PA(b)) in the combinatorial form this problem wears: averaging an LP optimum
stays feasible, but the closure of an *integer* optimum overshoots the integer optimum of the fixed
space.

**And it quantifies his parenthetical.** `[Parts2020a]` §5.8 says overcompression is *"especially
noticeable for S-subgraphs"* and gives no number. **On the S side the cheapest nontrivial rung
costs 8 vertices against the L side's 1** — every S-side closure excess (8, 12, 24) exceeds every
L-side one below order 6. His side-by-side impression, measured.

**A free instrument falls out of (i):** the rung-`H` minimum has a computable upper bound before
any search, so a rung sweep can be *ordered by how expensive its symmetry looks* and a search that
returns a value above its own closure bound is wrong. Both R1 searches respect their bounds.

### §R6 — Phase D: `Y` explains every exclusion, and convexity was never needed

With `Y` stored (phase A) the attribution runs directly: for each excluded box point, is there a
selection of the minimum size with that profile hitting every harvested correction set?

| | S (136-level) | L (375-level) |
|---|---|---|
| `\|Y\|` harvested | **773** sets, sizes 1–10 | **703** sets, sizes 1–7 |
| box exclusions | 1 | 108 |
| by the exchange equalities | 0 | **100** |
| left inside `aff(Prof)` | 1 | **8** |
| **excluded by `Y` directly** | **1 of 1** | **8 of 8** |
| **unattributed** | **0** | **0** |

**So the whole exclusion budget is `Y`'s**, and the convexity layer — which explained 6 of those 8
and missed 2 — turns out to have been a proxy the milestone did not need. `Prof` is not the integer
points of a polytope (§PA(c) said so a priori) and it does not have to be: the hypergraph accounts
for it exactly.

**P6 met, and more sharply than registered.** It predicted the two convexity-unexplained points
`(5,3,9,7)` and `(5,4,8,7)` need a hyperedge of size ≥ 3. Measured layer by layer: **all eight L
survivors are excluded by `Y` restricted to size ≤ 5 and by nothing smaller**, so a **size-5**
hyperedge is load-bearing, not merely a size-3 one. The S survivor needs size ≤ 9.

**P5 is UNDECIDED and the measurement says why.** The LP relaxation over the *harvested* `Y` reads
**369.00 against the integer optimum 374** on the L side and **125.25 against 135** on the S side.
That looks like a fractional gap and it **cannot** be read as one: the harvest is a **subset** of
the true `Y`, so `LP_harvest ≤ LP_true ≤ IP`, and `369 < 374` is consistent with the true matrix
being ideal. Settling idealness needs the complete hypergraph, which a lazy harvest by construction
does not give. Recorded as undecided with its numbers rather than scored either way.

### §R7 — Reproducibility, and the prediction scorecard

**Both reductions were re-run from scratch under the phase-A schema change and returned the same
objects**: S `136 vertices / 48 minima / |Y| = 773`, L `375 vertices / 3,264 minima / |Y| = 703` —
identical counts to the records they replaced, which is the reproducibility control the milestone
never registered and got for free from the regeneration.

| # | prediction | outcome |
|---|---|---|
| P1 | derived pairs stay derived, underived stay underived | **met** (9 and 6 on S; 24 and 0 on L) |
| P2 | a dead rung's minimum is ≥ 2 vertices above rung 1 | **met by the full rung (+4), missed by the cheapest dead rung (+1)** — reported as the pair |
| P3 | containment fails | **MET** — 0 of 1,302 and 0 of 4 |
| P4 | `Prof` is an order ideal in some orientation | **met on both sides**, with the S null reported as too small to mean anything |
| P5 | `Y` is not ideal | **UNDECIDED** — the LP over a lazy harvest is a lower bound; see §R6 |
| P6 | the two unexplained points need a hyperedge of size ≥ 3 | **met, and sharper: size 5** |
| P7 | `Aut(A)` is dihedral of order 12 | **met in its order half**; the conjugacy of the three live involutions is **not checked** |
| P8 | the S profile map does not factor through its matching | **met** |
| P9 | restricting the L companion to 18 connection edges removes both tail profiles | **not run** (phase E) |
| P10 | every complete level set spans its predicted affine hull | **not scored** — on the two stages the classes were computed *from* the profiles, so the check is only meaningful on a level set produced later; the three rung level sets are the first such and were not tested |

### §R8 — What is not done, reported as not done

**Phase E** (the 18-connection-edge re-run, P9) is **not run**; its cheap discriminator fired during
subplanning and is recorded in §4. **Phase F** (C3 as an integer program) is **not run**. The
conjugacy structure of `Aut(A)`'s involutions is **not checked**. Twelve of the sixteen L rungs and
five of the six S rungs were **not searched to their own minima** — only their closure bounds are
known, and §6(4) forbids reading a bound as a minimum.

**The modeling passes, honestly.** `debruijn-domain-modeling` was invoked fresh and did the work
recorded in §0(viii)–(ix) and in `parts_faces`'s type design — the matroid refutation and the
species identification are its product. The **obligation** and **experience** passes were **not run
as separate skill invocations**; their content arrived inside the implementation (the orbit-closure
theorem and the necessary-atom equivalence are obligation-pass work; the five structural refusals
are experience-pass work), and this note exists so the record does not imply a discipline that was
not followed.
