# M11 — The search instrument (carry-forward capture)

*Opened 2026-08-01 as the pre-search tooling milestone. **Not subplanned** — this is the complete
inventory of what the hunt needs, so that nothing is discovered mid-search. Full subplanning, with
its own measurements and skeleton, is a separate step.*

The hunt is M12. This milestone exists because a search that stops to build a tool is a search that
stops. Everything below is either a **blocker** (the hunt cannot start without it), an
**optimisation** (the hunt gets stuck without it), or an **instrument** (the hunt has nothing to look
at without it).

---

## 0. The blocker nobody had noticed

### The entire gadget algebra is fixed at four colours, and rung D needs five

`χ(ℝ²) ≥ 5` means *no 4-colouring*. **`χ(ℝ²) ≥ 6` means no 5-colouring** — a different question, and
`Proofs/HadwigerNelson/Gadget.lean` cannot ask it:

```lean
admits : (Fin m → Fin 4) → Bool
sound  : ∀ f : Fin n → Fin 4, Proper n E f → …
```

Measured against the rest of the stack, this is a *local* problem, and that is the good news:

| | already general in the colour count |
|---|---|
| `coloringCNF k n E`, `cubeCNF`, `not_colorable_of_unsat`, `not_pinned` | ✅ |
| `exists_perm_comp_eq` — colour symmetry | ✅ any target type at all, which is what the M09 obligation pass established |
| the reduction from a finite graph to the plane | ✅ |
| **`Gadget`, `Proper`, `samePattern`, `pinCube`, `allPatterns`, `survivors`** | ❌ **fixed at 4** |

So the generalisation is mechanical — one index threaded through one module. **It must happen first,
because everything else here is calibrated against the wrong number until it does.**

**And it reprices § 1.1.** The terminal check goes from `4^m` to `5^m`: at eight interface vertices,
65,536 → 390,625 cases, and the colour-symmetry saving goes from 24× to **120×**. What is an
optimisation at four colours is close to mandatory at five.

---

## 1. Optimisations — the hunt gets stuck without these

### 1.1 Restrict the terminal check to canonical colour patterns — 24× at four colours, **120× at five**

The composition's last step enumerates every colouring of the `m` interface vertices, measured at
**~0.2 ms per (colouring × gadget)**.

Every gadget's admitted set is closed under permuting colours — that is *why* one certificate covers
up to 24 patterns — so the enumeration only ever needs one representative per colour-partition.
`Gadget` gains a closure field, the seven constructors supply it (all are three-liners), and
`survivors` ranges over partitions.

**Trigger:** immediately after § 0. At five colours it is no longer optional.

### 1.2 `Motion` cannot express a translation or a reflection

`Motion.Maps` is `M·(image − centre) = [[a, −b], [b, a]]·(point − centre)`. That matrix has
determinant `a² + b² = M² > 0`, so **every motion it admits is a rotation about a point**: a pure
translation would force the shift to zero, and a reflection would need negative determinant.

Enough for de Grey — his construction is rotations about points, and M09 needed exactly one. **Not
enough for a search:** lattice-style constructions translate constantly, and the scanner in § 2.3
searches reflections as a matter of course.

Cost: a `det : Int` field (or the `[[a, b], [b, −a]]` sibling), plus one extra case in `distSq_eq`,
which is the same `ring` identity.

### 1.3 `Motion.comp` — motions compose, and de Grey's was a composite

The rotation M09 exploits was *derived* as one rotation after another's inverse — by hand, in Python,
outside Lean. A layered construction (de Grey's own `H → J → K → L`) composes constantly. The
structure was chosen so `comp` is a field-wise definition plus one `ring` identity.

### 1.4 Placement should be definitional, not checked

de Grey's copy costs 791 coordinate identities **only because his vertex table is frozen data**
upstream of 1,222 certificate modules. A new construction can define a placed copy's coordinates *as*
the motion applied to the original, at which point `Motion.Maps` holds by `rfl` and placing a gadget
costs nothing at all. Never tried.

### 1.5 Build graphs as orbits, so the transport saving is structural

M09's saving was *discovered* — the second copy happened to be a rotation of the first, found by
measuring the generator's output. If a candidate is **constructed** as the orbit of a seed under a
motion group, one certificate per orbit representative is true by construction, and the `|orbit|`-fold
saving is guaranteed rather than hoped for.

---

## 2. Instruments — the hunt has nothing to look at without these

### 2.1 Compute a gadget's *whole* property, not one refuted pattern

**Probably the single most valuable missing tool.** `Gadget.ofUnsat` refutes one colour pattern of the
ports. A search wants the **full profile**: for a subgraph and a port tuple, which canonical patterns
are achievable and which are refuted — one solver call per pattern, each far cheaper than a
whole-graph refutation.

That is what turns "a subgraph" into "a gadget" automatically, and it is what a library is made of.

### 2.2 Gadget minimisation

M07 built vertex-deletion search against the target "still not 4-colourable". Retarget it to "still
has this port property". A smaller gadget is a cheaper certificate *and* a cheaper placement.

### 2.3 The isometric sub-copy scanner

**Prototyped 2026-08-01 and validated.** Map a reference unit pair onto every other unit pair, both
orientations, count how many points land back in the set. It recovers de Grey's split exactly —
**791 of 1581 points, his two copies** — without reading his paper. Belongs in `tools/`, because it
detects *how a graph was built* and hands back the generating motion `Motion` consumes.

### 2.4 A candidate scorer, which already exists

`Gadget.survivors` returns the port colourings a composition has not ruled out. Its **length** is a
distance-to-refutation — exactly the objective a greedy or beam search descends. Free.

### 2.5 A gadget library

Spindles, de Grey's own `H`/`J`/`K`/`L` layers, Exoo–Ismailescu's and Parts' gadgets. M09 built the
algebra and demonstrated it on what was already in the repository; there is no catalogue.

---

## 3. What was measured on 2026-08-01, and what it killed

### The near-symmetry of Heule's witnesses is real, exact, and *not* where the forcing lives

| | best non-trivial isometry | covers | misses |
|---|---|---|---|
| Heule 510 | **rotation by exactly 120°** | 482 of 510 (95%) | 28 |
| Heule 553 | **rotation by exactly −60°** | 451 of 553 (82%) | 102 |
| de Grey | rotation by `arccos(31/32)` | 791 of 1581 (50%) | — |

Exact hexagonal-lattice angles, so this is construction structure, not numerical coincidence.

**The hypothesis that the forcing lives in the points the symmetry misses is false**, and the test was
decisive:

| | Heule 510 | Heule 553 |
|---|---|---|
| whole graph 4-colourable | no | no |
| the points the rotation covers, alone | **yes** | **yes** |
| the whole graph minus *the same number of random* points | **yes** | **yes** |
| deleting **one covered** point makes it colourable | **25 / 25** | **25 / 25** |
| deleting **one missed** point makes it colourable | **25 / 25** | **25 / 25** |

**These graphs are vertex-critical.** Every vertex is essential, so there is no sub-region where the
forcing lives: deleting the missed points works, but so does deleting any equally sized set, and so
does deleting a *single* vertex from anywhere at all. The missed points do have lower degree (7.0
against 9.8) and the pinned triangle is *not* among them — but the near-symmetry is a fossil of how
the graph was **built and then minimised**, not a feature of why it forces. Consistent with M07's
finding that de Grey's forcing halves are vertex-critical.

**What it does buy:** the scanner detects a construction's generating motions from its output alone
(§ 2.3) — the tool that would have found M09's saving unaided.

### Rotational symmetry carries no colouring information whatsoever

**A rotationally symmetric unit-distance graph need not be 4-colourable**, and the counterexample is
one line: take any graph `G`, rotate it 180° about a point far from it, take the union. The copies are
disjoint, no cross pair is at unit distance, the union has an exact order-2 rotational automorphism,
and its chromatic number is `χ(G)`. **Symmetrising is free**, so symmetry per se says nothing. The
measured data says it more directly: Heule's 510-point graph is 95% invariant under a 120° rotation
and is not 4-colourable.

**The useful residue, stated as the question actually worth asking.** If `ρ` is an automorphism of
order `k`, a *`ρ`-invariant* colouring is a colouring of a quotient graph on `|V|/k` vertices — a
`k`-fold cheaper question. "No invariant colouring" does **not** imply "no colouring", so it can never
*reject* a candidate. It can **promote** one: a cheap test on a `k`-times-smaller graph that says
*look here first*. Worth building as a search filter, worthless as a proof step, and the distinction
must stay written down, because getting it backwards would be unsound.

---

## 4. Why none of this was built during M09

**Measured, 2026-08-01:** `Gadget.lean` and `Motion.lean` sit upstream of **5 modules and zero
generated certificate modules**. Editing them costs seconds, not hours. The freeze pressure that
justified front-loading work in M06–M08 — where touching a byte upstream of a certificate costs 27.8
hours — does not exist here, so there was no reason to add anything before a use demanded it.

That reasoning is now spent: this milestone *is* the demanded use.
