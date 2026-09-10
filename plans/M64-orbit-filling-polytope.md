# M64 — the orbit-filling geometry of a level set (FS-34)

*Subplanned 2026-09-10 on Kooshi's go. The stub is `plans/STUB-orbit-filling-polytope.md`; read it
for the motivation and the prior art. **This subplan supersedes the stub's §3 conjecture and §4 phase
order**, because the stub's phases 1, 2 and the core of 4 were run during subplanning (WORKFLOW step 3:
"where cost decides the shape, measure before specifying"), took under two hours, and returned an
answer of a different species than the one conjectured. §0 records what changed and why; §1 restates
the objects on the measurements; §2 is the corrected conjecture; §3 the acceptance test; §4 the
phases; §5 the registered predictions; §6 what must not be done; §7 the instruments.*

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

### (v) The convexity story is real but SMALL, and the stub's headline number was mostly the laws

Exact integer hulls, computed in rational arithmetic:

| | S | L |
|---|---|---|
| box points with the right sum | 5 | 135 |
| `\|Prof\|` | **4** | **27** |
| `\|conv(Prof) n Z^O\|` | **4** | **29** |
| exclusions convexity explains | 1 of 1 | 106 of 108 |

That 98% reads impressively and **it must not be reported that way**: of the 108 L-side exclusions,
**100 are the two conservation laws** (which cut 135 → 35 before any convexity is invoked) and
convexity adds **6 of the remaining 8**. The two survivors are named: `(5,3,9,7)` and `(5,4,8,7)`.
*A phase that reports 98% without that decomposition is measuring its own framing.*

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

## §2 — The corrected conjecture

> **C1' (structure).** A complete level set's profile set is the image of a hitting-set feasible
> region under orbit-aggregation: `Prof = pi(F)`, `F ⊆ {0,1}^(free atoms)` cut out by `Y` and the
> budget. Its dominant structure is the **small-hyperedge layer of `Y` together with the tightness of
> the budget** — degree-1 hyperedges give the stable orbits, degree-2 hyperedges plus a tight budget
> give exact conservation laws, and convexity is a *residual approximation* to whatever is left.

*Falsifier:* a level set where the degree-1 and degree-2 layers of `Y` plus the budget leave most of
the box unexplained, so that convexity — not `Y` — is carrying the description.

> **C2' (overcompression).** Overcompression is the emptiness of `{M} ∩ Fix(H)`: at most rungs the
> minimum level carries no invariant member, so the rung's own minimum is strictly larger, and the
> larger symmetric object is not an overgraph of any member of the smaller level.

*Falsifier, and this is the milestone's decisive experiment:* run the reduction **at rung `H`** on a
rung whose invariant level is empty, obtain its true minimum `M_H`, and test containment. If some
member of `{M}` at the smaller size **is** contained in some member of `{M_H}`, overcompression is not
this, and C2' dies on our own reproduction of his own object.

> **C3' (the payoff).** With `Y`'s small layers in hand, *which orbits to add and how much of each* —
> Parts's expansion stage, which M63 §O(3) proved has **no termination measure at all** — is an integer
> program over the profile coordinates.

*Falsifier:* the useful directions leave the current base's orbit support entirely, so no inequality
over present orbits can see them.

**Bearing on χ(ℝ²) ≥ 6: indirect, and stated as such.** This is a theory of search landscapes, not a
construction. Its value is a measure for the expansion step, and a proof for the record-holder's
stated nuisance.

---

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

**Phase E — the L-vs-his range fork (stub §2 ii), if C's containment test leaves time.** Our L ranges
are wider than his on two of four orbits. Re-run the L reduction with the companion restricted to the
M6A subtype's 18 connection edges (ours carries 24) and see whether `Prof` narrows to his. **State
before running that this changes the problem**, so a narrowing is evidence about the connection count
and not proof that his 282 was a count. *Cost: one reduction run.*

**Phase F — C3', only if D leaves the description usable.** State the expansion as an integer program
over profile coordinates and test it against one recorded move of Parts's own four-state path.

---

## §5 — Registered predictions

| # | prediction | how it is scored |
|---|---|---|
| P1 | Every pair the S side reports as *derived* stays derived on re-run; the 6 undderived stay underived. | phase B |
| P2 | At least one rung with an empty invariant level has its own minimum **≥ 2 vertices above** the rung-1 minimum. | phase C3 |
| P3 | **The containment test fails** — no member of `{M}` sits inside any member of `{M_H}`. | phase C3 |
| P4 | The degree-1 and degree-2 layers of `Y` alone account for **≥ 90 %** of the L-side box exclusions. | phase D |
| P5 | The two unexplained L profile points `(5,3,9,7)`, `(5,4,8,7)` are excluded by a hyperedge of size ≥ 3. | phase D |
| P6 | Restricting the L companion to 18 connection edges narrows at least one of the two wide ranges. | phase E |
| P7 | `Aut(A)` on the L side is dihedral of order 12 and the three live involutions are conjugate in it. | phase C1 |
| P8 | The S side's profile map does **not** factor through its matching at any rung. | phase B |

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
