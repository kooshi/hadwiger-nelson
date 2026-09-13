# M63 phase H4 — Is `ℚ(√3,√7,√11)` family-keeping? The measurement

*Opened 2026-09-12 against `plans/STUB-family-keeping-thickening.md` (FS-6), whose §7 withdrawal banner
(same day) says: `ℚ(√3,√7,√11)` **is a second field for this stub's slot**, and **whether it is
family-keeping is unmeasured**. This file is that measurement. Every number carries its population; every
control says what it was seen to do; every prediction is registered before its run and scored after.*

## The four answers, before the reasoning

1. **The family.** The `ρ₆₃` arena — 51,133 vertices, 544,530 edges, `ℚ(√3,√7,√11)`, ledger row 64 — keeps
   **96 ℤ/5-homomorphisms exactly** (24 colour partitions) of its rank-8 direction lattice, over the 63
   distinct unit directions of its 544,530 edges, with **0 of 63 directions 5-divisible**. Exact
   enumeration of the complete space, not a sample.
2. **The dial.** By construction stage at the endpoint bound: **48 → 2,304 → 240 → 96** (base · plus the
   rotated copy · plus 30 diagonal cross edges · plus 36 off-diagonal). By radius: **flat, and provably so
   — 96 at every radius from 4.000 to 5.000**, because growth adds no direction and no cross edge. Shape:
   **de Grey's, not `F₂₄₇`'s** — a bounded fall to a nonzero floor, never a collapse.
3. **D1's classifier, predicted before it was run and met.** Adjoining the rotated copy is
   **272,298 of 272,298 unit vectors new-direction**, 0 killers; growing the radius is **63 of 63
   directions in-lattice**, 0 killers. Every growth move this construction has is D1-clean, and the reason
   is a theorem about the field, not a property of the radius.
4. **The verdict.** **`ℚ(√3,√7,√11)` is family-keeping**, so the stub's *"the one field we hold that is
   both 6-open and family-keeping"* is false and needs rewriting: there are now two, and ours is at half
   the degree (8 against 16). **But the gauge is the headline and it is negative.** On the **pure
   unit-distance graph, no cheats**: `γ̄ = 1,118.0` per additive colouring, `γ = 107,328` over the whole
   96-hom family (26,832 over its 24 partitions), and **960 of the family's 960 two-colour Kempe subgraphs
   are disconnected — none connected**, the best splitting into 33 pieces. Growing the object makes it **worse** (`γ̄` 1,118.0 → 1,380.0 → 1,700.0 as the arena goes from 51,133 to 79,657 to 121,381 vertices),
   and the entire cross structure — 126 edges of 544,530 — moves it 2.4 %. **No pure unit-distance graph
   in this repository has ever been Kempe-closed; the sole `γ = 0` object is a `{1,2}`-distance graph
   gauged with its non-unit edges. That is the finding, and it is the headline.**

**Un-eliminated is not alive.** A family that survives means one obstruction did not fire, nothing more.

---

## §0 — What "family-keeping" means, and one correction to the stub's framing before anything is measured

M57's design principle needs a **ℤ/5-homomorphism of an object's difference lattice that is nonzero on
every one of its unit vectors** — an *additive 5-colouring*, the "family" — and it needs that family to
survive as material is added. The stub's D1 is the classifier: *a thickening keeps the family iff its new
points are in-lattice or new-direction, never rational of order divisible by 5.*

**Correction 1 — D1 is a classifier for ONE of the two kill mechanisms, and the stub's "iff" overstates
it.** M57 §M1.5's own case analysis (D5) has two ways a new point removes homs: (i) the **5-divisibility**
obstruction — the new point's unit vector is rational of order divisible by 5, so an old unit vector lands
in `5Λ′` and *no* hom can be nonzero on it; and (ii) **coverage/admissibility** — the new point's edges
reach existing points in a pattern that no surviving hom can avoid. D1 decides (i) exactly. It says
nothing about (ii), and M57 §R4 measured (ii) doing real work on the same object D1 clears: W's family
fell 1,728 → 960 at **in-lattice** points, purely by admissibility. So **"D1 clears the construction" is
necessary for family-keeping and is not sufficient**, and this measurement is built to separate them.

**Correction 2 — family-keeping is a property of a CONSTRUCTION'S LATTICE, not of a field.** The stub
calls de Grey's *"the one field we hold that is both 6-open and family-keeping"*, but what M57 measured was
an **object**: his gen-1 half-spindle closure, 24,065 points, 358 directions, rank 32. Two constructions
over one field can differ: Heule-510 and de Grey's 1581 live in fields that differ only by `√7`, and their
dials are 3,456 → 96 against ≥ 300 flat. So the question this file can answer is *"is the `ρ₆₃` arena
family-keeping?"*, and the field-level sentence is only ever a summary over the objects measured in it.
Where the deliverable says "the field", read "the objects we hold over that field", which as of today is
**one**.

**Correction 3 — over a wall-broken field the FIELD-level family is empty for every `k ≤ 10`, and always
was.** M56 §M1.7 (L7) derives `1/2 ∈ Σ₀(F²)` for every wall-broken `F`, hence **no additive `k`-colouring
of the whole plane `F²` exists for any `k ≤ 10`** — and `ℚ(√3,√7,√11)` is wall-broken by construction
(`√7`; G1, G35), exactly as de Grey's field is. So the field-level answer is *"empty"* for **both** fields
and carries no information. The chunk level is the only level at which the question has content. This is
why the measurement is on the object.

---

## §P — Registered predictions (written and saved BEFORE the corresponding runs; §R scores them)

Each row states the **uninformative** outcome as well as the predicted one, and why the apparatus can
reach both — the requirement this milestone has twice failed.

| # | prediction | both outcomes reachable? | confidence |
|---|---|---|---|
| **P1** | **`units_in_5Λ = 0` on the `ρ₆₃` arena at every radius and every stage** — no unit vector of base, copy or cross becomes 5-divisible in the arena's lattice. | YES. The identical instrument reads **500** on W + 63 `F₂₄₇` cross points and **2,838–36,370** on every `F₂₄₇` depth-2 ball (M57 §R5). A nonzero is a routine output of this counter. | **high** — derived below (§R3), not guessed |
| **P2** | **The arena's direction lattice has rank exactly `2 × rank(base)`** — the base's ℚ-span and the rotated copy's meet only at `0`, so the cross edges add constraints and no rank. | YES. A rank below `2r` is what the instrument reports whenever the spans intersect; de Grey's closure reads 32 where its two halves could have read 16. | **high** — derived (§R3) |
| **P3** | **Every point of the rotated copy classifies as NEW-DIRECTION under D1**; zero copy points are in-lattice and zero are rational of order divisible by 5. | YES. The classifier returned **67 in-lattice / 4 index-5** on W's 71 depth-one cross points (M57 §R4), so all three verdicts are live outputs. | **high** — derived (§R3) |
| **P4** | **The dial is FLAT upward and only informative downward.** Growing the base disk past the endpoint bound `32/√63` changes no direction, no rank and no hom count; shrinking it removes cross edges and can only raise the count. So a radius sweep in M57's shape is **uninformative by construction on this object**, and the informative axis is the CONSTRUCTION STAGE. | YES — a rising, falling or ragged curve in radius would all falsify it, and M57's own two dials (Heule falling 3,456 → 96 with radius; de Grey flat) show the instrument produces both. | **medium-high** |
| **P5a** | The **base alone** (Parts's shaped lattice, 30 unit vectors, rank 4) keeps a nonzero ℤ/5-hom family, of size **10–60**. | YES: 0 is the answer for the same lattice at `k = 4` (below), and the instrument returns 3,456 elsewhere. | **medium** |
| **P5b** | The **full arena** (base + copy + all 126 cross edges) has **ZERO** ℤ/5-homs — it is **NOT** family-keeping — and it dies by **coverage (mechanism ii)**, with `units_in_5Λ = 0` throughout, i.e. **D1 clears the construction and the family dies anyway.** Heuristic: the 36 off-diagonal cross edges impose ~`(4/5)^36 ≈ 3·10⁻⁴` on a pool of order `10²`. | YES — any positive count falsifies it, and the same code path returns ≥ 300 on de Grey's object. | **low-medium** — this is the honest prediction, and I would rather be wrong here |
| **P5c** | The kill is **monotone across the stages** in this order: base² ≥ (+ 60 free cross) ≥ (+ 30 diagonal) ≥ (+ 36 off-diagonal), with the **diagonal** stage — not the off-diagonal — doing the largest single proportional cut. | YES; the ordering is forced but the *location* of the largest cut is free, and either stage could carry it. | **low** |
| **P6** | At `k = 4` the same arena has **ZERO** additive colourings **by a theorem, not a measurement**: the circle is `4·S₁` and every group of order 4 has exponent dividing 4, so `φ(4u) = 0` for every hom and every diagonal cross edge is violated identically. This is the **negative control on the same object** — it proves a zero is reachable here for reasons having nothing to do with `ρ₆₃`. | YES — a nonzero at `k = 4` would refute the derivation. | **high** |

**The load-bearing distinction P5b rests on, stated so it cannot be blurred later:** a zero at `k = 5` by
**coverage** and a zero by **5-divisibility** are different findings. The second is F₂₄₇'s, is an exact
lattice obstruction, and is what D1 was minted to detect. The first is compatible with D1 clearing the
construction completely, and it would mean **D1 is not a sufficient screen** — which is a result about the
stub's instrument, not about this object.

---

## §P2 — The brief's second half, registered separately (added 2026-09-12, after the coordinator redirected: the object GROWS, and the gauge is measured beside the family)

**The question, restated:** rigidity is a closure property — the gauge `γ = Σ over (additive colouring,
colour pair) of (components − 1)` counts **disconnected** two-colour Kempe subgraphs, so adding edges can
only merge components and **growing** is the lever that could drive `γ` to 0, while growing is also what
kills families. *As the object grows, does `γ` fall faster than the additive family dies?*

**What growth means on this object, classified under D1 before any measurement (this is P4's other face).**
The base is a **lattice disk**: `{p ∈ M : σ_k(|p|²) ≤ r² for all embeddings}` with `M` Parts's
denominator-12 module. Growing `r` adds points of the *same* module `M`, whose unit vectors are the *same*
30 norm-1 vectors of `M`; the copy grows by the ρ-images of those, whose unit vectors are the same 30
`ρ`-images. And the cross-edge law caps its endpoints at the endpoint bound `2n/√(4n−1) = 32/√63`, which
**is** the radius the arena is cut at, so growth adds **no cross edge at all**. Hence:

> **Growth of this object adds 100% in-lattice points, 0% new-direction, 0% rational-of-order-divisible-
> by-5. Under D1 the family is not merely kept — it is UNCHANGED, exactly, at every radius above the
> endpoint bound.** (Predicted here; measured in §R.)

| # | prediction | both outcomes reachable? | confidence |
|---|---|---|---|
| **P7** | The additive family (count, rank, direction set, `units_in_5Λ`) is **identical** at `r = 32/√63` and at every larger radius — growth is free for the family. | YES: Heule-510's family falls 3,456 → 96 on exactly this kind of radius sweep with the same code, so a fall is a routine output. | **high** — derived above |
| **P8** | `γ̄` **RISES** with radius rather than falling, roughly like the perimeter, because `γ`'s loose part is carried by boundary vertices whose unit shell is incomplete, and a disk's boundary grows. **So the two curves do not cross in the favourable direction: the family never dies and the gauge never closes.** | YES — a falling `γ̄` is what the coordinator's lever predicts and would falsify this outright. | **medium** |
| **P9** | For a **full-shell** vertex (all 30 unit directions present), looseness is a property of the **hom alone** and not of the vertex: `v` is loose for colour `b` iff `b − φ(v) ∉ φ(S₁)`, and `φ(S₁)` does not depend on `v`. So `γ`'s loose part splits cleanly into a **bulk** term (zero exactly when `φ(S₁) = {1,2,3,4}`) and a **boundary** term. I predict every surviving hom has `φ(S₁) = {1,2,3,4}`, so the bulk term is 0 and **γ is entirely a boundary phenomenon**. | YES — a hom with `\|φ(S₁)\| < 4` would give a bulk term proportional to `n`, visibly different. | **medium** |
| **P10** | **The stub's own P2 is UNDECIDABLE on this object, and that is a finding about the prediction rather than about the object.** P2 — *"no in-lattice-plus-new-direction thickening reaches `γ̄` below half its value before its family falls below 100"* — was calibrated against W's family of **1,728**. If the `ρ₆₃` arena's family starts **below 100**, P2 is decided before the first thickening step and its verdict is empty. I predict exactly that. | YES — a family above 100 would make P2 a live test here. | **medium** |
| **P11** | No pure unit-distance object in this repository has ever had `γ = 0`, and this one will not either: `γ > 0` by at least three digits. The only `γ = 0` object on record is Exoo–Ismailescu's `G`, and **only with its non-unit "cheat" edges counted as edges of the graph** (G42). | YES — `γ = 0` is the instrument's `family-kempe-closed` verdict and it has fired before (on `G`). | **high** |

---

## §C — Controls, and what each was seen to do

*Every one run with my own invocation. Nothing below is inherited from a record.*

| # | control | what it must do | what it did |
|---|---|---|---|
| **C1** | **Known positive, reproduced.** `python3 tools/m57_richness.py --field heule` — M57's own dial on Heule-510. | return the recorded **3,456** on the inner balls and **96** on the whole 510 | **PASSED.** 3,456 · 3,456 · 3,456 · 3,456 · 96 · 96, with points, edges, rank 8, `units_in_5Λ = 0` and every fingerprint identical to `data/m57/richness-heule-k5.json`. Two non-load-bearing columns differ (a `directions` column the stored record predates, and a sign convention in `unit_classes_mod5` — the current code counts one class per ± pair, the stored record counted both signs); the hom counts, which are sign-invariant, are identical. **The instrument returns a large positive and a fall, under my hands, before any zero of mine was believed.** |
| **C2** | **Provenance of the object.** Rebuild the `ρ₆₃` arena from `[Parts2020a]` §5.6's closed form at the exact endpoint bound `r² = 1024/63`, and from `typem.CrossLaw.collinear(31/32)` — the committed cross-edge law. | reproduce `data/m62/m63-phaseH2-rho63-certificate.json` | **PASSED, every number:** base **25,567** points · base unit edges **272,232** · cross **126 = 60 centre + 30 diagonal + 36 off-diagonal** · arena **51,133** vertices, **544,530** edges. |
| **C3** | **Second object, same code.** The record's own arena — `ρ₁₅`, `cos = 7/8`, endpoint bound `r² = 64/15`. | reproduce 1,771 base points and `126 = 60/30/36` (`plans/M63-phaseH3-solver.md` §2d) | **PASSED:** 1,771 · 12,810 base unit edges · 126 = 60/30/36 · 3,541 vertices. |
| **C4** | **A recorded number from a different tool.** The shaped base's additive **four**-colouring count. | 12 per group (`plans/M63-phaseH3-solver.md` §2d: "12") | **PASSED:** `ℤ/4` → **12**, `ℤ/2×ℤ/2` → **12**. |
| **C5** | **The zero outcome is reachable on THIS object, and for a reason that has nothing to do with `ρ₆₃`.** The same pipeline at `k = 4`. | 0 at the diagonal stage. For `ρ₆₃` this is a theorem: its circle is `4·S₁`, every group of order 4 has exponent dividing 4, so `φ(4u) = 0` for every hom and every diagonal cross edge is violated identically. (For the record's `t = 2` the theorem covers only `ℤ/2×ℤ/2` — see §V2(b).) | **PASSED**, on both arenas: `ρ₆₃` 24 → 288 → **0** → 0; the record 24 → 288 → **0** → 0, in both groups of order 4. The **faithful partner that must pass** is the stage one earlier, 288, from the same code on the same object in the same second. |
| **C6** | **Planted pair on the family detector, two-sided.** Guarded = the real full arena's 63 directions. Plant A adds one direction `5u`; plant B (faithful partner) adds `3u`. | A: `units_in_5Λ ≥ 1` and homs **0**; B: `units_in_5Λ = 0` and homs **unchanged**. Asserted as `0 < guarded − plantedA` **and** `guarded − plantedB = 0` — the lower bound fails if the plant has stopped firing, the upper bound fails if the refusal is not specific to 5-divisibility. | **PASSED:** guarded **96** homs / `units_in_5Λ = 0`; plant `5u` → **0** homs / `units_in_5Λ = 1`; plant `3u` → **96** homs / `units_in_5Λ = 0`. |
| **C7** | **Equivalence of the fast edge rule.** Unit edges built by translation through the exact 30-vector norm-1 shell (a theorem on a lattice disk: a difference of module points is a module point, unit iff its norm is 1) against `typem.unit_edges_fast` (float proposal, exact disposal). | edge-for-edge identical | **PASSED** on two bases: **12,810 = 12,810** and **11,286 = 11,286**, identical lists, ~400× faster. **Planted control:** running the rule on 29 of the 30 shell vectors gives 10,900 against 11,286 — the comparison goes **RED**, so it can bite. |
| **C8** | **Module provenance.** See the incident below. | refuse to run against a foreign module of the same name | **PASSED, and provoked:** with the foreign `additive.py` pre-bound in `sys.modules`, the harness raises `WRONG MODULE: additive loaded from …/tmp/additive.py`. A guarded re-run of C3's full k=5 dial reproduces the unguarded numbers exactly (234.0 · 461.6 · 468.0, families 48 · 240 · 48). |

### C-incident — a shared scratch directory held another agent's `additive.py`, and my scripts put that directory on the module path

The scratch directory this session was given is **shared**, and it already contained a file named
`additive.py` written by another agent at 18:40. Three of my scripts appended that directory to
`sys.path`. In two of them the repository's `tools/` happened to be inserted first by an import that ran
earlier, so they loaded the right module; in the third the foreign one won and the run died with
`module 'additive' has no attribute 'Lattice'`.

**This is `CLAUDE.md`'s named hazard verbatim** — *"a check that loads two versions of something and
identifies them BY NAME"* — and it is worth stating that **the crash is the only reason it was caught**.
Had the foreign module happened to define a class called `Lattice`, every number in this file would have
been produced by the wrong code while printing normally. What makes the earlier runs defensible is not
care: it is that the foreign module **cannot** supply `Lattice`, so any run that completed must have used
the repository's. The repair is C8's assertion, in every script, provoked and seen to refuse — plus
moving my scripts into a private subdirectory so the collision cannot recur.

### The generator's image, checked against the problem's, before any zero was believed

A homomorphism from a free abelian group of rank `r` into a group `G` **is** an element of `G^r`, and
`additive.enumerate_homs` ranges over all of `G^r` for every abelian group `G` of order `k`. So the
generator's free parameters **are** the problem's free parameters — `5^8 = 390,625` maps at rank 8, all
enumerated, exactly. There is no restricted shape a target could sit outside of. The one place a gap
could hide is the **direction set**: a missed unit direction would remove a constraint and make the family
**too large**. So on this instrument **a positive is the suspect verdict and a zero is the robust one** —
the opposite of the refutation case, and the reason C6, C7 and C2 are pointed at completeness of the
edge set rather than at soundness.

---

## §R — Results

*The object: the `ρ₆₃` arena of ledger row 64 — `[Parts2020a]` §5.6's denominator-12 lattice cut by the
exact totally-real disk at the endpoint bound `r = 32/√63`, together with its image under
`ρ₆₃ = (31 + 3i√7)/32` about the shared centre, plus all unit edges. **51,133 vertices, 544,530 edges, in
`ℚ(√3,√7,√11)`.** Rebuilt here from the closed form and the committed cross-edge law, matching its
certificate on every number (C2). Every edge of it is at exact unit distance: there are **no cheats and no
non-unit edges anywhere in what follows**, which is the load-bearing scope note for the gauge (§R4).*

### R1 — The additive family at its own radius

> **96 admissible ℤ/5-homomorphisms = 24 distinct colour partitions.** Exact, by full enumeration of all
> `5^8 = 390,625` maps from the arena's rank-8 direction lattice to `ℤ/5` — the complete space, not a
> sample and not a restricted shape. **`units_in_5Λ = 0`.**

| | |
|---|---|
| population | the 63 distinct unit directions (up to sign) of 544,530 unit edges on 51,133 vertices |
| direction lattice | rank **8**, `\|S₅\| = 54` unit classes mod 5, **0** of 63 directions in `5Λ` |
| family | **96** homs = **24** partitions. `partitions = homs / 4` is a derivation, not a convention: `φ` and `cφ` have the same fibres for every `c ∈ 𝔽₅*`, and conversely equal fibres force such a `c`. Checked on the record's arena at both its stages (48 homs, 12 partitions, ratio 4.00). M57's `γ` is over partition reps, ours over all homs, and `γ̄` is identical either way |
| every hom's image on the directions | `\|φ(directions)\| = 4` for **96 of 96** — every admissible hom hits all four nonzero residues |

**So the `ρ₆₃` arena is family-keeping at five colours.** For contrast on the same code: at **four**
colours its family is **0** (C5), by a theorem rather than a measurement.

### R2 — The dial, on both axes

**Axis A — the construction stages, at the endpoint bound.** Each stage adds edges to the one above it;
the 60 "centre" cross edges are duplicates of internal edges and impose nothing, which is why they get no
stage of their own.

| stage | vertices | edges | dirs | rank | units in 5Λ | **ℤ/5-homs** | **γ̄** | disconnected |
|---|---|---|---|---|---|---|---|---|
| base half alone | 25,567 | 272,232 | 15 | 4 | **0** | **48** | 570.0 | 480 of 480 (all 48 homs) |
| + rotated copy (internal edges only) | 51,133 | 544,464 | 30 | 8 | **0** | **2,304** | 1,146.0 | 480 of 480 (48 of 2,304 homs) |
| + the 30 **diagonal** cross edges | 51,133 | 544,494 | 45 | 8 | **0** | **240** | 1,128.4 | 480 of 480 (48 of 240 homs) |
| + the 36 **off-diagonal** cross edges = the whole arena | 51,133 | 544,530 | 63 | 8 | **0** | **96** | 1,118.0 | **960 of 960** |

*The `γ̄` column is exact on the first and last rows (the whole family was censused) and a 48-hom sample
on the middle two; where a whole family has been censused the per-hom spread is under 0.04 %.*

`2,304 = 48 × 48` exactly — the base's family squared, which is the direct-sum structure of §R3 showing up
as a number. The two cross-edge steps then cut `2,304 → 240 → 96`.

**Axis B — the radius.** The object grows; the family does not move.

| radius | base points | arena vertices | arena edges | cross edges | **family (full arena)** | units in 5Λ | **γ̄ (base half)** | **γ̄ (full arena)** |
|---|---|---|---|---|---|---|---|---|
| 2.000 | 1,603 | 3,205 | 22,572 | 60 centre only | 2,304 | 0 | 236.0 | 478.0 |
| 3.000 | 7,879 | 15,757 | 146,700 | 60 centre only | 2,304 | 0 | 406.0 | 818.0 |
| 4.000 | 24,991 | 49,981 | 530,274 | 126 = 60/30/36 | **96** | 0 | 614.0 | 1,206.0 |
| **4.0316 = 32/√63** (the bound) | 25,567 | 51,133 | 544,530 | 126 = 60/30/36 | **96** | 0 | 570.0 | 1,118.0 |
| 4.500 | 39,829 | 79,657 | 881,346 | 126 = 60/30/36 | **96** | 0 | 692.0 | 1,380.0 |
| 5.000 | 60,691 | 121,381 | 1,386,930 | 126 = 60/30/36 | **96** | 0 | **850.0** | **1,700.0** |

*The cross-edge column is measured at every row: `60 = 60 centre + 0 diagonal + 0 off-diagonal` at radius
2 and 3 — and the 60 centre edges are duplicates of internal edges, so they constrain nothing — then
`126 = 60 + 30 + 36` at radius 4.000 and **unchanged at every larger radius**. The family column is
therefore identical from radius 4.000 up, and that is not a coincidence to be re-measured at each step:
§R3's move B shows the direction set is already complete there, so the rows above it are the same
computation on the same input.*

**The shape, stated against the two shapes on record.** De Grey's gen-1 closure is **flat at ≥ 300 with no
unit in `5Λ`** ("the family never dies"); the `F₂₄₇` cross lattice **collapses to 0 with 500 units in `5Λ`**
at depth one. Ours is **neither a collapse nor a flat line: a bounded fall `2,304 → 240 → 96` to a
nonzero floor, with `units_in_5Λ = 0` at every stage and every radius.** (The base's 48 is not the start of
that chain — it is a count on a different, rank-4 lattice; the arena's own chain starts at `2,304 = 48²`.)
On the question the stub asks — does the family die — it is de Grey's shape, not `F₂₄₇`'s.

**And the radius axis is uninformative here BY CONSTRUCTION, which is itself the finding.** The base is a
lattice disk, so its unit directions are the lattice's 30 norm-1 vectors at every radius above 1; the copy
contributes their `ρ`-images; and the cross-edge law caps its endpoints at the endpoint bound, so beyond
`r = 32/√63` **no cross edge exists to be added**. Measured (§R3, move B): at `r = 4.5` and at `r = 5` the arena has
the same **63** directions and the same **126 = 60/30/36** cross edges as at the bound. M57 §M1.6 said the
dial's axis is the direction set and the radius is incidental; on this object that is not a caution, it is
the whole answer.

### R3 — D1's classifier, applied to this construction's own growth moves

| move | what it adds | in-lattice | new-direction | rational of order divisible by 5 |
|---|---|---|---|---|
| **A — adjoin the rotated copy** (its internal edges and all 126 cross edges), classified against the **base's** lattice | 272,298 copy-incident unit vectors; **48** distinct directions | 0 | **272,298 of 272,298** — every one; **48 of 48** distinct | **0** |
| **B — grow the radius past the bound**, to `r = 4.5` and to `r = 5`, classified against the **bound arena's** lattice | 39,829 and 60,691 base points and their copies; **63** distinct directions each | **63 of 63** — every one | 0 | **0** |

**Every growth move this construction has is D1-clean, and the reason is structural rather than lucky.**
Write `ρ = c + is` with `c = 31/32 ∈ K` and `s = 3√7/32 ∉ K`, `K = ℚ(√3,√11)`. For `u = u_x + iu_y` with
`u_x, u_y ∈ K`, `ρu = (c u_x − s u_y) + i(c u_y + s u_x)`, whose `√7`-components vanish only when `u = 0`.
So the base's ℚ-span `W` and the copy's `ρW` **meet only at `0`** — hence rank 4 + 4 = **8** (P2, measured)
and the copy is entirely new-direction (P3, measured). And 5-divisibility is decided in the base module
alone: every cross direction projects to a base point, so `Λ ∩ W ⊆ M`, and a unit vector `u` with
`u/5 ∈ M` would have `|u/5|² = 1/25`, while every norm in `M` lies in `(1/144)ℤ[√33]` and `144/25 ∉ ℤ`.
**No unit vector of this construction can ever become 5-divisible, at any radius, for any rotation of this
family** — which is why `units_in_5Λ = 0` is not a measurement that could have come out otherwise (P1).

### R4 — The gauge, on the unit-distance graph alone

> **`γ̄ = 1,118.0` per additive 5-colouring; `γ = 107,328` over the whole family of 96 homs, `26,832` over
> its 24 colour partitions. And the number that says it plainly: the family has **960** two-colour Kempe
> subgraphs — 96 homs × 10 colour pairs — and **960 are disconnected, 0 are connected.** The best case
> anywhere in the family splits into **33** components; the worst into 205. Exact, whole family, no cap.**

**A correction to my own arithmetic, made before it reached a conclusion.** The first census here ran over
**48 of the 96** homs (a cap) and I wrote that `γ` per colouring is *constant* across the family, so that
the cap cost nothing. **That is false and the data I already held said so**: on the record's arena the
*pair* stage is exactly constant (474.0 at every checkpoint from 50 colourings to 2,300) but the *diagonal*
stage is not (461.60 · 461.46 · 461.51 · 461.54 · 461.60). The spread is small — under 0.04 % — but "small"
is not "zero", and a figure quoted as exact must be exact. The whole family was therefore re-censused
uncapped; the table below is that run.

| | `ρ₆₃` arena |
|---|---|
| graph the gauge is measured on | **the unit-distance graph alone** — all 544,530 edges at exact distance 1, **no cheats, no non-unit edges** |
| vertices / edges | 51,133 / 544,530 |
| family used | **all 96 homs, uncapped** — the exact whole-family census (the `base` stage below is likewise exact over its 48; the `pair` and `diag` rows of §R2 are over a 48-hom sample and their `γ̄` carries a spread of order 0.04 %, measured) |
| `γ̄` (per additive colouring) | **1,118.0** |
| `γ` over all 96 homs / over the 24 partitions (M57's convention) | **107,328** / **26,832** |
| loose part / Kempe part, per colouring | 1,086 / 32 |
| two-colour subgraphs disconnected | **960 of 960 — none connected** |
| components per subgraph | **33 to 205** |
| Kempe swaps built, verified proper, verdict | 960 built, 960 proper, **960 non-additive, 0 additive** — 960 explicit certificates that the family is not closed |
| loose vertices (in at least one hom and colour pair) | 5,256 of 51,133 |

**How far off is it?** Rigidity's necessary condition is `γ = 0`, i.e. every one of those 480 subgraphs
connected. We have zero of 960 connected, and the *easiest* one needs 32 merges. Against the objects M57
gauged — all of them, like ours, at 0 connected:

| object | vertices | family | `γ` (over partitions) | `γ̄` | components |
|---|---|---|---|---|---|
| Heule-510 | 510 | 24 partitions | 3,014 | 125.6 | 6–22 |
| W, `K(√247)` | 1,175 | 432 | 147,456 | 341.3 | 14–72 |
| de Grey's 1581 | 1,581 | 200 sampled | ≥ 76,115 | ≥ 380.6 | 22–63 |
| the record's `ρ₁₅` arena (measured here) | 3,541 | 12 | 5,616 | 468.0 | 23–73 |
| **`ρ₆₃` arena (this file)** | **51,133** | **24** (96 homs) | **26,832** | **1,118.0** | **33–205** |
| Exoo–Ismailescu's `G` — **not a peer, see below** | 205 | 18 colourings | **0** | **0** | all connected |

**And the last row is the whole point, so it must not be read as a peer.** `G` is a **{1, 2}-distance
graph** — 205 points carrying **966 unit edges AND 423 distance-2 edges** (M57 §R7) — and its `γ = 0` is
measured **on the graph including those 423 non-unit "cheat" edges**; G42 says so in those words, and
M57's gauge for it is computed on `unit ∪ cheats`. **No pure unit-distance graph in this repository has ever had `γ = 0`, or even one connected
two-colour subgraph.** Ours is now the largest pure unit-distance object ever gauged here, and it is
100 % open, exactly like every smaller one.

**One normalization makes our object look best, and it is the wrong one.** Per vertex, `γ̄/n` is
**0.0219** for `ρ₆₃` against 0.246 (Heule), 0.290 (W), 0.241 (the 1581) and 0.132 (the record's arena) —
an order of magnitude lower. That is **not** evidence of anything, because `γ`'s loose part is carried by
boundary vertices while `n` counts area, so `γ̄/n` falls whenever an object gets bigger. **It measures
size, not closure.** Rigidity needs the total, and the total is what grows.

**Why the loose part is a boundary phenomenon, measured rather than assumed.** Every admissible hom has
`|φ(directions)| = 4` — 96 of 96, at every stage and radius. A vertex carrying the **full** 30-vector unit
shell therefore sees all four other colours and can never be loose, so **every loose vertex has a
deficient shell**. Measured, the loose fraction is 598 of 1,603 (37.3 %) at radius 2, 1,196 of 7,879
(15.2 %) at radius 3 and 2,628 of 25,567 (10.3 %) at the bound, on the base half — falling like a
perimeter-to-area ratio, exactly as that reading predicts.

### R5 — The two curves on one axis, which is the question the brief actually asks

> *As the object grows, does `γ` fall faster than the additive family dies?*
>
> **On this object: no, and not narrowly. The family does not die at all, and the gauge does not fall —
> it rises.**

| radius | base points | arena vertices | **family** (full arena) | **γ̄** (base half) | **γ̄** (full arena) |
|---|---|---|---|---|---|
| 2.000 | 1,603 | 3,205 | 2,304 — no constraining cross edge exists yet | 236.0 | 478.0 |
| 3.000 | 7,879 | 15,757 | 2,304 — no constraining cross edge exists yet | 406.0 | 818.0 |
| 4.000 | 24,991 | 49,981 | **96** | 614.0 | 1,206.0 |
| 4.0316 (bound) | 25,567 | 51,133 | **96** | 570.0 | 1,118.0 |
| 4.500 | 39,829 | 79,657 | **96** | 692.0 | **1,380.0** |
| 5.000 | 60,691 | 121,381 | **96** | **850.0** | **1,700.0** |

**Read the last two columns as one sentence: the family column does not move at all, and the gauge column
rises by 52 % — 1,118.0 → 1,380.0 → 1,700.0 — over the two steps that take the object from 51,133 vertices
to 79,657 to 121,381.**

**The family curve is flat — provably, not just observedly** (§R3 move B: growth adds only in-lattice
points and not one cross edge). **The gauge curve rises**, roughly with the perimeter, because that is
where its loose part lives. The two curves therefore do not cross in the favourable direction; they
diverge in the unfavourable one.

**The one non-monotonicity is real and worth keeping.** From radius 4.000 to radius 4.0316 the base gains
576 points and `γ̄` **falls** from 614.0 to 570.0. The cut at `r² = 16` lands exactly on the shell
`|p|² = 16`, putting the 30 circle points on the boundary with deficient shells; growing a hair past it
fills them in. So `γ̄` is a **boundary functional and is sensitive to which lattice shells the cut lands
between**, not a smooth function of size. That is a genuine (small) lever — choose the cut just past a
shell, never on one — and it is worth about 7 % here, against the factor of ∞ that `γ = 0` asks for.

**The cross edges cannot be the lever either, and the arithmetic says so in one line.** The whole cross
structure is **126 edges of 544,530**, i.e. **0.023 %** of the graph. Adding all of it moves `γ̄` from
1,146.0 to 1,118.0 — a fall of **2.4 %** — while cutting the family from 2,304 to 96. A closure property
over 51,133 vertices is not going to be bought by 126 edges.

### R6 — A by-product: an explicit, solver-free 5-colouring of the arena

All **96** admissible homs were re-verified as proper colourings on the arena's complete edge list:
**0 monochromatic edges in 52,274,880 checks** (planted control: repainting one vertex to its neighbour's
colour produces 14 monochromatic edges — red). Every one of the 96 has the same colour-class size
multiset, **(10182, 10182, 10225, 10272, 10272)**.

So `χ(ρ₆₃ arena) = 5` **exactly**: `≥ 5` from ledger row 64's refutation, and `≤ 5` from a colouring that
is a group homomorphism of the direction lattice and needs no solver at all. The upper bound is not
surprising and is very likely already known by other means; what is worth having is its **form** — a
one-line certificate (`φ` on eight basis vectors) instead of a 51,133-entry table.

---

## §S — Scoring every registered prediction

| # | prediction | verdict | the measurement |
|---|---|---|---|
| P1 | `units_in_5Λ = 0` at every radius and stage | **MET** | 0 at all four stages and all six radii; and it is now *derived*, not merely observed (§R3) |
| P2 | arena rank = `2 ×` base rank | **MET** | base rank **4**, arena rank **8** |
| P3 | every copy point is new-direction, zero killers | **MET** | **272,298 of 272,298** copy-incident unit vectors; **48 of 48** distinct directions; **0** rational-of-order-divisible-by-5 |
| P4 | the radius axis is uninformative for the family by construction | **MET**, with an amendment | 63 of 63 directions in-lattice and 126 cross edges unchanged at radius 4.5 and 5. *Amendment:* the radius axis is **not** uninformative for the **gauge**, which rises — so the sweep earns its place after all, on the other curve |
| P5a | base-alone family nonzero, 10–60 | **MET** | **48** |
| P5b | **the full arena's family is ZERO** | **REFUTED** | **96.** My heuristic treated the 36 off-diagonal cross constraints as independent, giving `(4/5)^36 ≈ 3·10⁻⁴`. They are nothing like independent: they cut the family by a factor of **2.5**, not `10⁻⁴`. The prediction was wrong in the direction that matters and I would rather record why than round it off |
| P5c | the stage cuts are monotone and the **diagonal** carries the largest proportional cut | **MET** | `2,304 → 240` (÷ 9.6, the 30 diagonal edges) `→ 96` (÷ 2.5, the 36 off-diagonal). Each admissible `f` keeps exactly **5** partners `g` after the diagonal and exactly **2** after the off-diagonal |
| P6 | `k = 4` gives zero by a theorem | **MET on `ρ₆₃`; met as a measurement on the record** | 288 → **0** at the diagonal stage on both arenas, in both groups of order 4. The theorem covers `ρ₆₃` (`t = 4`) entirely and covers the record (`t = 2`) only for `ℤ/2×ℤ/2`; the record's `ℤ/4` cell is 0 of 144 measured, not derived — §V2(b) |
| P7 | the family is identical above the endpoint bound | **MET** | derived and measured at radius 4.5 and radius 5 |
| P8 | `γ̄` **rises** with radius rather than falling | **MET**, with an amendment | base half: 236.0 · 406.0 · 614.0 · 570.0 · 692.0 · 850.0 at radius 2 · 3 · 4 · 4.0316 · 4.5 · 5; full arena 1,206.0 → 1,118.0 → **1,380.0** → **1,700.0** over the last four. *Amendment:* the rise is **not monotone** — the cut landing exactly on the shell `\|p\|² = 16` costs 44 |
| P9 | every hom has `\|φ(directions)\| = 4`, so `γ` is boundary-carried | **MET** | 96 of 96 at every stage; loose fraction 37.3 % · 15.2 % · 10.3 % at radius 2 · 3 · 4.0316, falling like a perimeter-to-area ratio |
| P10 | the stub's own P2 is **undecidable** on this object | **NOT MET — my error, and the stub's P2 is live here** | I read the clock as starting at the base (family 48, already below 100). The stub's P2 starts at the object being thickened, which is the base-plus-copy stage with family **2,304**, comfortably above 100. So P2 has a real test here, and §S2 scores it |
| P11 | `γ > 0` by at least three digits; no pure unit-distance object rigid | **MET** | `γ = 107,328` over the 96-hom family (26,832 over its 24 partitions); **0 of 960** two-colour subgraphs connected; still no pure unit-distance object with `γ = 0` anywhere in this repository |

### §S2 — The stub's own P2, scored on this field for the first time

> *P2 (FS-6, registered at medium confidence — i.e. its author expected the principle to fail): no
> in-lattice-plus-new-direction thickening reaches `γ̄` below half its value before its family falls
> below 100.*

The thickening available on this object is exactly of the licensed kind — D1-clean, **100 % new-direction**
(§R3). Starting from base-plus-copy: family **2,304**, `γ̄` **1,146.0**.

| step | family | `γ̄` | `γ̄` as a fraction of its starting value |
|---|---|---|---|
| start (base + rotated copy) | 2,304 | 1,146.0 | 1.000 |
| + the 30 diagonal cross edges | 240 | 1,128.4 | 0.985 |
| + the 36 off-diagonal cross edges | **96** — below 100 | 1,118.0 | **0.976** |

> **P2 is MET.** The family crosses below 100 with `γ̄` having fallen **2.4 %**, against the 50 % P2 says
> it will not reach. **This is the first time P2 has been tested on any field other than `K(√247)`, and
> the principle fails here too** — not narrowly, by a factor of about twenty.

And the growth move the coordinator's lever actually names — increasing the radius — does not even start
the clock: the family never falls at all, and `γ̄` moves the **wrong way**.

---

## §V — The verdict, in the stub's own terms

> **`ℚ(√3,√7,√11)` is family-keeping — on the one object we hold over it. The `ρ₆₃` arena keeps 96
> ℤ/5-homomorphisms, exactly, with no unit vector 5-divisible at any radius or any stage, and every
> growth move it has is D1-clean. On the stub's own question — *does the family die* — it is de Grey's
> shape ("the family never dies"), not `F₂₄₇`'s (collapse to 0 at depth one with 500 units in `5Λ`).**
>
> **So the stub's sentence *"the one field we hold that is both 6-open and family-keeping"* is now false
> and should be rewritten.** Two fields hold both properties: de Grey's `ℚ(√3,√5,√7,√11)`, degree 16, on
> his gen-1 half-spindle closure; and **`ℚ(√3,√7,√11)`, degree 8, on the `ρ₆₃` arena** — half the degree,
> and reached by a screen rather than found.

**Four things must travel with that, and the fourth is the one that matters.**

1. **Family-keeping is a property of a CONSTRUCTION, not of a field** (§0, correction 2). One object each,
   and objects over near-identical fields already disagree about the shape of their dial: Heule-510
   (`ℚ(√3,√5,√11)`) **falls 3,456 → 96** across its own radius sweep, while de Grey's gen-1 half-spindle
   closure (`ℚ(√3,√5,√7,√11)`, the same field plus `√7`) is **flat at ≥ 300** across its. Same instrument,
   adjacent fields, opposite shapes.
2. **The two measurements are not like-for-like, and the counts must not be compared.** De Grey's is a
   *closure* — 24,065 points, 358 directions, rank 32, family **≥ 300 at a cap** (a SAT sample, not an
   exact count). Ours is an *arena* — 51,133 points, 63 directions, rank 8, family **96 exact**. Those
   differ in construction, rank, direction count, size and exactness simultaneously. **The only comparable
   thing is the verdict — family survives, or family dies — and on that they agree.** Setting 96 beside
   ≥ 300 would be comparing five things at once.
3. **Un-eliminated is not alive.** A surviving family means D1's one obstruction did not fire. Silence is
   not evidence, and a nonzero family is a *necessary* condition for M57's principle that buys nothing on
   its own.
4. **The slot is filled and the thing the slot was for is still empty.** A family-keeping 6-open field was
   wanted as somewhere to drive the gauge to zero. **The gauge does not go down here.** It **rises** with
   growth (236.0 → 850.0 on the base half from radius 2 to radius 5), and the entire cross structure —
   126 edges of 544,530, 0.023 % of the graph — moves it **2.4 %**. Of the family's 960 two-colour Kempe
   subgraphs, **960 are disconnected and 0 are connected**, the best splitting into 33 pieces. On a
   **pure unit-distance graph, with no cheats**. **No pure unit-distance graph in this repository has
   ever been Kempe-closed, or ever had even one connected two-colour subgraph** — the sole `γ = 0` object
   on record, Exoo–Ismailescu's `G`, is a `{1, 2}`-distance graph gauged *with* its non-unit edges (G42),
   and ours is now the largest pure unit-distance object ever gauged here.

### §V2 — Two structural findings that are worth more than the verdict

**(a) The additive family of a type-M arena FACTORS, and it is the `k = 5` twin of the object's own
refutation certificate.** Because `ρ` moves every `K`-point outside `K²`, the base's ℚ-span and the copy's
meet only at `0`; so the arena's direction lattice is the direct sum, and

> an additive `k`-colouring of the arena **is** a pair `(f, g)` of additive `k`-colourings of the **base**
> with `f(p) ≠ g(q)` at each cross edge `(p, ρq)`

— which is `data/m62/m63-phaseH2-rho63-certificate.json`'s own reduction (*"arena 4-colourable IFF two
proper 4-colourings `f, g` of the base with `f(centre) = g(centre)`, `f(v) ≠ g(v)` at all 30 diagonal
points and `f(i) ≠ g(j)` at the 36 off-diagonal pairs"*) with "proper colouring" replaced by "additive
colouring". Measured exactly: **`2,304 = 48 × 48`**, then `→ 240 = 48 × 5`, then `→ 96 = 48 × 2`. So the
arena's additive question costs a **rank-4** enumeration, never a rank-8 one, and the diagonal condition
has a one-line reading: *`f`, `g` and `f − g` must all be admissible.*

**(b) The circle's multiplier `t` decides the four-colour level and is harmless at five, and that is the
whole gap between `k = 4` and `k = 5` on this family.** The circle is `t·S₁` with `t = 2` for the record
and `t = 4` for `ρ₆₃`, and a diagonal cross edge carries the direction `t·(u − ρu)`, so a hom `φ` gives it
`t·(f(u) − g(u))`. **Stated with its exact scope, because the obvious generalization is false:**

| | `k = 4`, `ℤ/4` | `k = 4`, `ℤ/2×ℤ/2` | `k = 5` |
|---|---|---|---|
| `t ≡ 0 (mod 4)` — `ρ₆₃` | **0 by theorem** (exponent divides 4) | **0 by theorem** | `t` invertible; no obstruction |
| `t = 2` — the record | **not** forced by the exponent: it needs `f(u) − g(u)` **odd** at all 30 unit vectors, which is possible a priori and **measured to fail, 0 of 144** | **0 by theorem** (exponent 2) | `t` invertible; no obstruction |

So at `k = 4` the diagonal stage empties the family on both arenas — **288 → 0**, all four group-and-object
cells — but only three of those four cells are theorems; the fourth is a measurement, and writing it as a
theorem would have been an over-generalization by one case. At `k = 5` every even `t` is invertible and
the same condition becomes the mild requirement that `f − g` be admissible. **G52's "`t` even defeats the
residue certificate for free" is the `k = 4` face of exactly this**, and it has no `k = 5` face.

---

## §N — What would actually move the gauge, and the one obstruction that turns out NOT to exist

`γ` splits into a **loose part** and a **Kempe part**, and on the `ρ₆₃` arena the split per additive
colouring is **1,086 loose against 32 Kempe** — the loose part is **97 %** of the gauge. So "drive `γ` to
0" is, to within 3 %, "make every vertex see all four other colours".

**The obvious impossibility argument fails, and that is the useful finding.** Take the extreme vertex `v`
of any finite object in this family — the one maximising `⟨·, w⟩` for a generic direction `w`. All its
neighbours lie at `v + u` with `⟨u, w⟩ ≤ 0`, so its neighbour colours come from `φ` applied to at most the
**closed half-shell** `H⁻(w)`, 15 of the 30 unit vectors. If `|φ(H⁻(w))| < 4` for every hom and every `w`,
then **every** finite object of this family has a loose vertex and `γ > 0` unconditionally — the growth
lever would be dead by theorem.

**Measured: it is 4 every single time.** Over all 30 generic outward directions × all 96 homs, on the base
half and on the copy half alike, `|φ(H⁻(w))| = 4` in **2,880 of 2,880** cases. **So an extreme vertex of
this family CAN be non-loose**, and the 2,628 loose vertices of the base half are loose because a
*lattice disk* does not give its boundary vertices all fifteen inward neighbours — not because the
geometry forbids it.

> **That converts "the gauge cannot fall" from a suspected theorem into an open design question with a
> cheap decidable core:** *is there a finite subset `S` of this module, and an admissible hom `φ`, with
> **zero** loose vertices — every `v ∈ S` having, among its present neighbours, all four colours other
> than its own?* It is a purely local condition, it needs no solver on the arena, and nothing in this
> repository has ever asked it. A yes removes 97 % of `γ` and leaves only the Kempe part (32 per
> colouring here); a no, proved, kills the growth lever outright. **Either answer is worth more than
> another radius.**

**And the honest ceiling on that, stated now rather than after:** zero loose part is **not** `γ = 0`.
The Kempe part would remain, and `γ = 0` is itself only the **necessary, solver-free half** of additive
rigidity — the other half is that the additive family is the *whole* colouring space, and on a
51,133-vertex 5-chromatic graph whose additive family has **96** members that is not a margin, it is a
different order of object. **Un-eliminated is not alive.**

---

## §A — Addresses

| what | where |
|---|---|
| the arena's certificate (reproduced here, every number) | `data/m62/m63-phaseH2-rho63-certificate.json` |
| `ρ₆₃` dial, `k = 5`, all four stages at the endpoint bound | `data/m63/m63-phaseH4-rho63-k5.json` |
| `ρ₆₃` at `k = 4` — the negative control on the same object | `data/m63/m63-phaseH4-rho63-k4.json` |
| the record's `ρ₁₅` arena, `k = 5` and `k = 4` | `data/m63/m63-phaseH4-control-record-k5.json`, `…-k4.json` |
| D1's classifier on both growth moves | `data/m63/m63-phaseH4-d1-classifier.log` |
| the radius sweep (six radii × four stages) | `data/m63/m63-phaseH4-rho63-sweep.json` |
| the **exact whole-family** gauge census on the full arena (96 homs, uncapped) | `data/m63/m63-phaseH4-rho63-full-exact.json` |
| instruments used unchanged | `tools/additive.py` (`Lattice`, `unit_classes`, `enumerate_homs`, `verify_proper`, `canon`), `tools/additive_rigid.py` (`closure_census`), `tools/typem.py` (`CrossLaw.collinear`, the `K` arithmetic), `tools/m57_richness.py` (control C1) |
| the drivers written for this measurement (scratch, untracked) | `/home/kooshi/.claude/jobs/d4cccfde/tmp/h4dir/` — `h4.py` (arena), `h4_measure.py` (stage dial), `h4_run.py` (driver), `h4_controls.py` (the planted pair), `h4_d1.py` (the classifier) |

---

## §Q — The one thing I would most want checked by someone else

**That the 96 is a count of the right set — specifically, that the arena's direction lattice is not
missing a direction.**

Everything in this file turns on `96 ≠ 0`, and the asymmetry runs the wrong way for comfort: on this
instrument **a missed unit direction removes a constraint and makes the family too LARGE**, so a positive
is the fragile verdict and a zero is the robust one. Three things point at that risk and none of them is a
proof:

* the base's unit edges come from a **shell rule** (a difference of two module points is unit iff it lies
  in the 30-vector norm-1 shell) — checked edge-for-edge against the committed float-proposal/exact-disposal
  path on two bases, and the planted 29-of-30 control goes red (C7). But the shell itself was enumerated
  by me, from `S = 144, P = 0`, over a hand-chosen box;
* the cross edges come from `typem.CrossLaw.collinear(31/32)`, whose completeness is argued in
  `plans/M63-phaseH2-family-screen.md` §9 (`{1, √D}` is a `K`-basis, so both components must vanish) and
  which reproduces the certificate's `126 = 60/30/36` — but I re-used the law rather than re-deriving it;
* the whole arena reproduces its certificate on five independent counts (C2), which is strong evidence the
  **edge set** is right and says nothing directly about the **direction set** derived from it.

The cheapest independent check is not a re-run of mine: **take the 96 homs out of
`data/m63/m63-phaseH4-rho63-k5.json`, rebuild the arena by any route at all, and verify each of the 96 as a
proper colouring on that independently-built edge list.** I verified all 96 against *my* edge list
(0 monochromatic edges in 52,274,880 checks, §R6); a second builder's edge list is what would close it,
because an additive colouring that survives someone else's edges cannot be an artefact of mine.

Second, smaller: **the `γ̄` figures are from `tools/additive_rigid.py`'s `closure_census` driven by a shim
of my own** (it reads only `ch.n`, `fam.k`, `fam.reps` and `fam.is_additive`). The component counting,
swap construction and properness assertions are the committed instrument, unmodified; the family I hand it
is mine. If `γ` matters to a decision, that seam is where I would look.
