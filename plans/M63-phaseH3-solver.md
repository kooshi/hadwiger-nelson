# M63 phase H3 — the four-colourability verdict on the shape-free `n = 2` arena

*Solver engineer, 2026-09-12. Answers the brief's §6 step 5 and the product owner's steps 1–4
(`plans/M63-phaseH3-drop-the-shape.md`, `plans/M63-phaseH3-plan.md`). Working code and evidence:
`build/m63-phaseH3-solver/`. Nothing here is committed or staged by me.*

---

## §0 — THE VERDICT

> ## The shape-free `n = 2` arena IS four-colourable.
>
> Not at one radius — **at every radius**, by derivation, with an explicit colouring exhibited and
> checked at three of them (32,617, 83,905 and 301,537 vertices).

**No solver was used, and none is needed.** The verdict is a positive claim carrying its own
certificate: an explicit proper four-colouring, re-checkable in 47 KB of JSON by code that shares
nothing with the code that found it.

**The route in one paragraph.** A proper four-colouring of the arena is exactly a pair `(f, g)` of
proper four-colourings of the *base* with `f(0) = g(0)`, `f(v) ≠ g(v)` on the 60 diagonal circle
points and `f(u) ≠ g(v)` on the 72 off-diagonal cross edges — 132 constraints on 121 vertices. The
**additive** four-colourings (homomorphisms from the base lattice to the Klein four-group, nonzero on
every unit vector; ledger row 50, G41) are proper on the *whole infinite lattice*, so they are
available at every radius, and the cross edges are fixed at 252 at every radius by the endpoint
bound. Searching `f` and `g` **independently** over that family — **124,416 combinations, under two
seconds** — returns **576** that clear all 132 constraints.

**Why the advisor's search missed it, and it is the third instance of this shape in this milestone.**
PH3-17 searched **twists** — `g = π ∘ f`, one base colouring re-permuted. **Zero of the 576 passing
combinations is a twist.** The colouring needs `f` and `g` to be *different* additive colourings, and
the twist family cannot represent that. *Before believing any zero over a family, write down the
generator's image and check the target is inside it* — the generator's image here excluded the
target, with the positive control passing.

---

## §1 — The object, rebuilt from scratch

Everything below was rebuilt from the mathematical description alone. No code is shared with
`tools/shapefree.py`, `tools/typem.py`, `build/m63-phaseH3-crossedge/` or the advisor's instrument.
Exact integer arithmetic throughout; `√7` is never evaluated; floats appear only as prefilters whose
every decision is then retaken exactly.

| quantity | mine | the phase's record | agree |
|---|---|---|---|
| unit vectors (`\|z\|² = 1`, denominator 12) | **60** | 60 | ✓ |
| …of them in Parts's shape | **30** | 30 | ✓ |
| index of their ℤ-span in ℤ⁸ | **256** (HNF diagonal `1,1,2,2,2,2,4,4`) | 256 | ✓ |
| base points inside `R = 4/√7` | **16,309** | 16,309 | ✓ |
| base points inside `R = 1.7` | **41,953** | 41,953 | ✓ |
| base points inside `R = 2.0` | **150,769** | 150,769 | ✓ |
| unit shell / `\|z\|² = 2` circle, inside the cut | **60 / 60** | 60 / 60 | ✓ |
| unit edges at the bound | **60,084**, mean degree **7.3682**, **264** isolated | 7.37, 264 | ✓ |
| cross edges at `cos θ = 3/4` | **252 = 120 centre / 60 diagonal / 72 off-diagonal** | same | ✓ |
| 4-core of the base at the bound | **12,601** (arena `2·12,601 − 1 = 25,201`) | arena 25,201 | ✓ |

**The base is connected but for its tail:** 265 components — one of 16,045 points and **264
isolated vertices**. All 121 interface vertices and all 60 circle points lie in the big component.

**Two completeness controls on the point set**, because a four-colourability verdict is exactly the
verdict a *missing* point or edge manufactures:
- **Group closure.** The base is closed under `ζ₁₂` (bijectively) and under all three nontrivial
  Galois maps, at both radii — the order-48 group. *Plant, two-sided:* delete one point and the
  closure check reports exactly one violation (`0 < 1 < n+1`).
- **Field-blind brute force.** Every ordered pair of arena points, distance measured in floating
  point with no field theory anywhere: at the bound, **1,063,868,689 pairs → 120,300 unit-distance
  pairs, identical to the constructed set, 0 in brute-not-constructed**; at radius 1.7,
  **7,040,049,025 pairs → 399,852, identical, 0 missed.**
  *(The constructed edge lists read 120,420 and 399,972; the excess is exactly the 120 centre cross
  edges, which duplicate base and copy unit edges — the same bookkeeping as phase H2 §8a.)*

### §1a — The cross-edge law, and a near-miss that had to be explained

Derived independently by the split over `{1, √7}` — `q = det(u,v) = 0` and
`(2n−1)·dot(u,v) = n·(|u|²+|v|²−1)` at denominator 12 — and confirmed a second way by evaluating the
distance directly in `K(√7)`: **252 of 252, 0 invented.**

The brute force at tolerance `1e-7` first returned **300**, i.e. **48 pairs the law does not
produce.** They are not edges: all 48 have `det(u,v) ≠ 0` exactly, and their `|d²−1|` lies between
**1.7×10⁻⁸ and 8.9×10⁻⁸**, while the 252 true edges sit at `|d²−1| ≤ 5.6×10⁻¹⁶`. **A seven-order
gap**, so the edge set is the same at every tolerance from `1e-15` to `1.7e-8`; verified at `1e-9`,
`1e-10` and `1e-12` — **252, 0 missed, 0 invented** each time. The 48 are recorded rather than
silently re-thresholded, because "tighten the tolerance until it agrees" is how a check stops being
one.

*Negative control, repaired.* Perturbing the rotation and counting surviving hits first read 144 —
because **the 120 centre cross edges are rotation-invariant by construction** (rotating the shared
centre fixes it), so they can never fire and a control including them is untestable. Excluding them:
132 non-centre hits at the true angle, **0** at `1e-4` and `1e-6` rad, 24 at `1e-8` rad, with the
faithful partner (unperturbed) returning exactly the guarded 132.

---

## §2 — The verdict, and the theorem behind it

### §2a — The reduction (exact, no approximation)

The arena is the base `B` together with `ρB`, sharing the centre. Because `ρB` is isometric to `B`
and carries the same internal edge list, any proper colouring `C` of the arena gives two proper
colourings of the **base**, `f(v) = C(v)` and `g(v) = C(ρv)`, and conversely. The coupling is:

- `f(0) = g(0)` (the shared centre);
- `f(v) ≠ g(v)` for the **60** diagonal cross edges (the circle `|z|² = 2`);
- `f(u) ≠ g(v)` for the **72** off-diagonal cross edges;
- the **120 centre cross edges are redundant**: `(0, ρi)` forces `f(0) ≠ g(i)`, which follows from
  `g` proper and `(0,i)` a base unit edge. Verified, not assumed — the diagonal cross edges are
  exactly the 60 circle points, asserted in code.

**132 constraints on an interface of 121 vertices** (centre + 60 circle + 60 off-diagonal endpoints;
the off-diagonal endpoints are **disjoint** from the circle, and `W` is an **independent set** in the
base — 0 induced unit edges).

### §2b — The search, and what it found

| family searched | combinations | clearing the 60 diagonal | clearing all 132 |
|---|---|---|---|
| additive `f` × additive `g` × 6 permutations | **124,416** | 14,400 | **576** |

Every count carries its population. Runtime **1.7 s**.

### §2c — The theorem: this holds at every radius

> **An additive colouring is a homomorphism on the whole lattice, so it is proper on every base;
> and the cross edges are fixed by the endpoint bound. Therefore the passing combinations are
> radius-independent.**
>
> Precisely: let `L` be the ℤ-span of the 60 unit vectors, and let `φ, ψ : L → (ℤ/2)²` be
> homomorphisms nonzero on every unit vector, `π` a permutation of the colours fixing `0`. Define
> `C(z) = φ(z)` on the base and `C(ρz) = π(ψ(z))` on the copy. Base and copy edges are proper
> automatically, for **any** `B ⊆ L` at **any** radius. Every cross edge has both endpoints inside
> the disk `σ_k(|z|²) ≤ 1/sin²θ` at all four embeddings (the endpoint bound, itself a consequence of
> `r·Q(t) = 1` with `Q(t) = (t−c)² + s² ≥ s²` at every embedding, `s²` rational), so the cross-edge
> set is **exactly the same 252** for every base containing that disk. Hence the 132 constraints are
> the same finite check, and any of the 576 passing `(φ, ψ, π)` four-colours the arena over **any**
> such base. ∎

**Exercised rather than asserted.** The identical search was run at three radii and returned the
identical `144 / 124,416 / 14,400 / 576` at each, and the cross-edge derivation returned
`252 = 120/60/72` at each:

| radius | base | arena | constructed arena edges | monochromatic | brute-force check |
|---|---|---|---|---|---|
| **1.5119** (the endpoint bound) | 16,309 | **32,617** | 120,420 | **0** | 1.06e9 pairs, exact match |
| **1.7** | 41,953 | **83,905** | 399,972 | **0** | 7.04e9 pairs, exact match |
| **2.0** | 150,769 | **301,537** | 1,993,956 | **0** | not run (11 min); edge set complete by §1 |

*(83,905 and 301,537, not 83,906 and 301,538: the centre is shared, so the arena is `2N − 1`.)*

**So the monotonicity lever cannot save this object.** Growing the base shrinks the set of base
colourings, but the additive ones survive **every** amount of growth, because properness for them is
a statement about the 60 unit vectors and not about the disk.

### §2d — The known-answer controls, which are what make the verdict believable

The identical code, on the two objects in this family whose answer is already known:

| object | lattice rank | additive colourings | clearing the diagonal | clearing all | known answer |
|---|---|---|---|---|---|
| **`ρ₆₃`, phase H2's verified object** (`n = 16`, shaped, 25,567 pts) | 4 | 12 | **0 of 864** | **0** | NOT four-colourable ✓ |
| **the record's lattice** (`n = 4`, shaped, 1,771 pts) | 4 | 12 | **0 of 864** | **0** | contains a 5-chromatic graph ✓ |
| **phase H3's candidate** (`n = 2`, shape-free, 16,309 pts) | 8 | **144** | 14,400 of 124,416 | **576** | — |

Phase H2's object was rebuilt here from scratch and reproduced its record exactly: **25,567 points,
272,232 unit edges, mean degree 21.296, 30 circle points, 126 = 60/30/36 cross edges.** The record's
lattice likewise: 1,771 points, 30 circle points, 126 = 60/30/36.

**Both outcomes are reachable and both were reached by the same code in the same minute.** A zero
here is not an artifact of the apparatus, and a 576 is not either.

### §2e — The mechanism, stated so it can be pushed back on

**Dropping the shape multiplies the additive four-colouring family from 12 to 144, and it is the
extra colourings that glue the arena.** Parts's shaped lattice has rank 4 and 30 unit vectors, giving
12 additive four-colourings, *all* of which put every circle point on the centre's colour (0 of 864
combinations clear even the diagonal — the valuation law, ledger row 59, at `t` even). The shape-free
lattice has rank 8 and 60 unit vectors, giving **144**, whose circle behaviour is spread across
`{0: 24, 12: 12, 20: 72, 24: 24, 60: 12}` — only 12 of the 144 are residue-type.

> **The shape is not merely a device for making the disk cut cheaper (which the arithmetic side
> established). It is also what starves the base of four-colourings — and a base starved of
> four-colourings is what a type-M refusal runs on.**

**RETRACTED by §4.** The registered `n = 4` shape-free run refutes it: the family there is the *same*
144 and **0 of 124,416** combinations clear even the diagonal. Family size is not the cause. The
mechanism that is — a divisibility property of the circle, holding for the shaped and shape-free
lattices alike — is §4a, and it is a theorem rather than a reading. This paragraph is left standing,
struck, because it was the registered hypothesis and the run that killed it was registered against it.

---

## §3 — The interface pricing the product owner asked for, and it is the transferable instrument

The question was: *how many colour patterns can the base present on the interface, and what does the
phase-H2 reduction cost here?* It is answerable **without a solver**, from one colouring, because the
interface `W` is an independent set: fix any proper colouring of `V ∖ W`, and each `w ∈ W`
independently takes any colour outside `c(N(w))`. So

> **#(achievable interface patterns) ≥ ∏_{w ∈ W} (4 − |c(N(w))|)** — a certified lower bound,
> computable in milliseconds, requiring one colouring and no search.

| object | `\|W\|` | interface degrees | free colours per vertex | **patterns ≥** |
|---|---|---|---|---|
| **phase H2's `ρ₆₃`** | 67 | `5:6, 6:12, 7:12, 14:12, 15:6, 16:12, 30:7` | `1: 67` | **1** — *no local freedom; see §3a, its true count is 552* |
| **the record's lattice, `n = 4`** | 67 | `5:6, 6:12, 7:12, 10:36, 30:1` | `1: 67` | **1** — *same caveat* |
| **phase H3 at the endpoint bound** | 121 | `2:60, 6:36, 12:24, 60:1` | `1:61, 2:40, 3:20` | **3.83 × 10²¹** |
| **phase H3 at radius 1.7** | 121 | `4:48, 6:12, 10:36, 14:24, 60:1` | `1:105, 2:16` | **6.55 × 10⁴** |

### §3a — Reconciling the "1" against phase H2's recorded 552, and the instrument is ONE-SIDED

**The product owner's guess was that 552 is a superset and my 1 is an achievable count. That is not
it, and the real distinction is sharper.** Measured rather than adopted:

| quantity | definition | `ρ₆₃` | record | H3 bound | H3 at 1.7 | H3 `n = 4` shape-free |
|---|---|---|---|---|---|---|
| **(a)** local-freedom product | hold the base fixed **outside** `W` at one colouring and recolour interface vertices independently (legal: `W` is an independent set) — a **lower bound** | **1** | **1** | **≥ 3.83e21** | **≥ 6.55e4** | **≥ 4.1e3** |
| **(b)** additive-family patterns | distinct interface patterns realised **across** the additive family, centre pinned — a lower bound from **global** recolourings | **12** | **12** | 132 | 132 | 144 |
| **true count** | over **all** proper base four-colourings | **552** (phase H2, enumerated) | — | — | — | — |

**Known-answer check:** (b) must be `≤ 552` on `ρ₆₃`, and it is — **12 ≤ 552**.

> **So (a) and 552 are not the same quantity, and the difference is LOCAL versus GLOBAL freedom, not
> superset versus achievable.** My instrument asks *"can an interface vertex be recoloured on its
> own?"*; phase H2's 552 counts *whole-base colourings*. On `ρ₆₃` no interface vertex has any local
> freedom — every one has three colours in its neighbourhood — and yet 552 whole-base colourings
> present 552 distinct interface patterns.

**The consequence, and it is a demotion I am making against my own §3.** The instrument is
**one-sided**: it can certify that the pattern count is astronomically large, and it can **never**
certify that it is small. **A value of 1 is the instrument saying nothing — it is not evidence of
rigidity.** The comparison that survives is between quantities of the same kind:

> **phase H2's object: 552 achievable interface patterns, exactly, enumerated. Phase H3 at the
> endpoint bound: at least 3.83 × 10²¹.** Nineteen orders, a true count against a valid lower bound
> on the same quantity — that comparison is sound, and it is the one that says the phase-H2 reduction
> was never affordable here.

**Do not promote it to a criterion, and here is the measurement that stops you.** The `n = 4`
shape-free object has (a) `≥ 4.1 × 10³` — also far past 552, so also unaffordable by the phase-H2
route — and it is **not** killed by the additive pair (0 of 124,416). **So "large interface pattern
count" and "four-colourable by an additive pair" are independent properties**, and neither implies
the other. A quantity separating two positives from one negative was a hypothesis; a third object now
separates the two properties from each other.

**What it is good for, stated at its real size:** a cheap one-sided **kill test** for the phase-H2
reduction — compute (a) from a single base colouring in milliseconds, and if it exceeds the solver
budget, do not build the arena. It rules candidates out. It cannot rule any candidate in.

**Read three things off that table.**

1. **The reduction was never affordable at the endpoint bound**, by nineteen orders of magnitude
   against phase H2's 552. The instrument says so in milliseconds, before any solver is launched.
2. **It returns exactly 1 on phase H2 and on the record** — every interface vertex's colour is
   forced by its neighbourhood *locally*. **That is the instrument going silent, not a measurement of
   rigidity**: their true counts are 552 and unmeasured. §3a is the reconciliation and the demotion.
3. **The monotonicity lever is real and enormous.** `3.83 × 10²¹ → 6.55 × 10⁴` for a **2.6×** base —
   a collapse of **seventeen orders of magnitude**. The product owner's note said the lever was
   *"derived and never exercised; direction known, magnitude unknown."* **The magnitude is now
   measured and it is very large.** It is the right lever, aimed at the wrong object: on this arena
   there is nothing left to refute at any radius.

**The instrument generalises and costs nothing.** *Price phase H2's reduction on any future candidate
by computing this product from a single base colouring, before committing solver time.* The
qualification it travels with: it is a **lower** bound, it is computed against **one** colouring, and
it is valid **only** while `W` is an independent set in the base — which was checked (0 induced
edges) on all four objects here and must be re-checked on any new one.

---

## §4 — `n = 4` shape-free: registered before it ran

Prediction registered in `build/m63-phaseH3-solver/REGISTER.md` before the run, with both outcomes
named and reachable: **the shape-free arena is four-colourable by an additive pair at every member,
including `n = 4`, whose shaped version carries a five-chromatic graph.** Informative outcome: 0
passing at `n = 4`, refuting §2e's mechanism and making `n = 2` special. Uninformative: > 0 passing.

**`n = 3` is not a usable control and was not run.** `4n − 1 = 11` is a square class of `K`, so
`sin θ ∈ K`, the whole arena lies in `K²`, and `chromaticNumber_seamPlane` four-colours it outright
— the answer is a theorem, not a measurement. *(A first attempt at it was launched at the wrong
radius — `R² = 99/11` instead of `36/11`, a 3.9-million-point object — and was killed by PID within
five minutes. Recorded because an input error caught late is a different animal from one caught
early.)*

### RESULT: the prediction is **NOT MET**, and the informative outcome fired

| `n = 4`, shape-free (built here: 195,961 points, 1,370,724 unit edges) | |
|---|---|
| cross edges | **492 = 120 centre / 60 diagonal / 312 off-diagonal** (492/492 confirmed, 0 invented) |
| additive four-colourings of the base | **144** — the *same* 144, since the lattice `L` does not depend on `n` |
| interface | `\|W\| = 361` |
| combinations clearing the 60 diagonal constraints | **0 of 124,416** |

**So §2e's mechanism is REFUTED as stated.** The family is still 144 at `n = 4`; the supply of base
colourings is *identical*; and yet not one pair clears even the diagonal. "Dropping the shape
multiplies the colourings" is true and is **not** why `n = 2` four-colours.

### §4a — The mechanism that actually does it, and it is a theorem

The colour group is **2-torsion**, so `φ(2w) = 0` for every `w` and every additive `φ`. Measured
across all four objects:

| object | circle points | largest `k` with `p/k` in the lattice | circle points on the centre's colour, over all additive colourings |
|---|---|---|---|
| `n = 2`, shape-free | 60 | `{1: 48, 3: 12}` — all **odd** | `{0:24, 12:12, 20:72, 24:24, 60:12}` — spread |
| `n = 4`, shape-free | 60 | `{2: 48, 6: 12}` — all **even**; the circle **is** `2 ×` the unit shell | **`{60: 144}`** — all, always |
| `n = 4`, the record's shaped lattice | 30 | `{2: 24, 6: 6}`; circle **is** `2 ×` the shell | **`{30: 12}`** |
| `n = 16`, phase H2's `ρ₆₃` | 30 | `{4: 24, 6: 6}`; circle **is** `4 ×` the shell | **`{30: 12}`** |

> **Theorem (the free-circle kill).** If every point of the diagonal circle `|p|² = n` lies in `2L`,
> then every additive four-colouring sends it to the centre's colour, every one of the `n`-circle's
> diagonal constraints `f(v) ≠ g(v)` fails, and **no additive pair can four-colour the arena.** ∎

This is the colouring-side face of G52's *"the certificate's defeat is automatic whenever `t` is
even"*, arrived at here from the other direction: G52 reads the residue map, this reads the whole
additive family, and they are one fact.

### §4b — The base-free family screen it defines

The test needs **no base, no radius and no solver** — only the shell `|p|² = n` and a divisibility
check in `L`. Run over the shape-free lattice (`build/m63-phaseH3-solver/screen.py`, 85 s for
`n ≤ 20`; every count carries its population):

| `n` | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| circle points | 60 | 84 | 60 | 240 | 84 | 240 | 60 | 108 | 240 | 60 | 84 | 240 | 240 | 336 | 60 | 240 | 108 | 240 | 240 |
| all in `2L`? | no | no | **yes** | no | no | no | **yes** | no | no | no | **yes** | no | no | no | **yes** | no | no | no | **yes** |

> **The additive-pair route is open exactly when `4 ∤ n`, and killed exactly when `4 \| n`** — because
> `4 \| n` makes the circle exactly `2 ×` the shell at `n/4`. Clean on all 19 members, with the circle
> count varying from 60 to 336 and the verdict never varying with it.

**What this does and does not do to the programme.** The wall-breaking screen needs `n` **even**, so
the live members split:

- **`n ≡ 0 (mod 4)`** — `16, 20, 44, 60, 64, 76, 108, 112`, i.e. **every 6-open member FS-30 lists** —
  are **immune** to this route. Phase H2's verified object is one of them. *Nothing here touches the
  standing programme.*
- **`n ≡ 2 (mod 4)`** — `2, 6, 10, 14, 18, 22, …` — are exactly where the route is open, and at
  `n = 2` it succeeds. **Phase H3 picked the cheapest member of precisely the congruence class this
  route can kill.**

**Un-eliminated is not alive:** `4 ∤ n` means only that this one route is *not blocked*, never that
such an arena is four-colourable. It was checked and found so at `n = 2`; `n = 6, 10, 14, 18` are
untested, and each needs its own off-diagonal check. The cheapest untested 6-open one is **`n = 10`**
(`4n − 1 = 39`, `K(√39) = K(√13)`, 6-open by G43); `n = 6` is `K(√23)` and `n = 14` is `K(√55) =
K(√5)`, both 5-sealed.

---

## §5 — Produced or inherited: the question is vacuous here, and the field derivation is recorded anyway

**A four-colourable graph contains no five-chromatic subgraph, at any position or orientation.** So
the produced-or-inherited question does not arise for this object. The derivation asked for is
recorded because it is cheap, reusable, and bears on future members:

> **If a witness's coordinate field is not a subfield of the arena's, it cannot embed** — pairwise
> squared distances are isometry-invariant, and every squared distance between points of `F²` lies in
> `F`. The arena's field is `ℚ(√3,√7,√11)`, whose ℚ-basis `{1,√3,√7,√21,√11,√33,√77,√231}` contains
> **no √5**.

| witness | field it needs | excluded by field? |
|---|---|---|
| Heule-510, Heule-553 | `ℚ(√3,√5,√11)` | **yes** (√5) — phase H2 measured 49,727/129,795 and 54,990/152,628 distances carrying √5 or √165 |
| de Grey 1581 | `ℚ(√3,√5,√7,√11)` | **yes** (√5) |
| **`[Parts2020a]`'s 509-vertex record** | measured here: its `v509e2442.vtx` carries **√5 (153), √15 (78), √55 (91), √165 (73)**; its 374-vertex **base** carries only √3, √11, √33 | **yes** (√5) |
| M53 witnesses | `K(√247)`, `K(√23)` | **yes** |
| **phase H2's `ρ₆₃` object** | **`ℚ(√3,√7,√11)` — the same field** | **no**; excluded instead by the four-colouring |

**The one witness the field argument does not cover is phase H2's own object**, which is worth
stating: had this arena refused four colours, that is the embedding test that would have had to be
run geometrically.

---

## §6 — Two discrepancies against the phase's existing record, reported rather than reconciled away

**1. I count 144 additive four-colourings where PH3-17 counts 72 — exactly double in every bucket.**

| | mine | advisor's |
|---|---|---|
| Klein-four homomorphisms proper on the base | **144** | 72 |
| circle points on the centre's colour | `{0:24, 12:12, 20:72, 24:24, 60:12}` | `{0:12, 12:6, 20:36, 24:12, 60:6}` |

**All 144 of mine were checked against the full 60,084-edge base list: 0 monochromatic edges.** All
144 have image the full Klein group, and they fall into **24 orbits of size 6** under the group's
automorphisms (72 would be 12 orbits). I cannot see the advisor's code and do not know which of us is
right about the *count*. **The verdict does not depend on it**: the four-colouring is an explicit
object verified edge-by-edge against a brute-force-complete edge list, and a family of 72 or of 144
does not change whether that object exists.

**One correlation I checked rather than assumed, because it would have been fatal:** a base graph
*missing edges* would inflate the hom count **and** manufacture a four-colouring — the two errors
would agree. It is ruled out by the field-blind brute force (§1), which found exactly the constructed
edge set on 1.06 billion pairs, and by group closure, which a missing point breaks.

**2. The circle-degree figures in `plans/M63-phaseH2-solver.md` §1** — *"unit shell 30 vectors, so the
base is a Cayley graph on the exact norm-1 shell and every interior point has degree exactly 30"* —
are reproduced here as a **mean degree of 21.296**, with circle points at `5:6, 6:12, 7:12`. The
statement is true with "interior" carrying the weight; the coordinator has already flagged it.

---

## §7 — What a reviewer who trusts none of this must check

**Three things, and nothing else.** No solver, no proof log, no Python of ours.

1. **That the 60 listed unit vectors really have `|z|² = 1`.** Sixty integer identities in
   `ℚ(√3,√11)`, each checkable by hand.
2. **That the 252 listed cross edges really are at distance 1 under `ρ₂ = (3 + i√7)/4`, and that no
   pair outside the list is** — the first is 252 integer identities; the second is the endpoint-bound
   argument plus an enumeration inside a disk of radius `4/√7`.
3. **That the two listed homomorphisms, read as a colouring, put no edge monochromatic.** Base and
   copy edges are free — a homomorphism nonzero on every unit vector cannot fail on a unit edge — so
   this reduces to the **132 non-redundant cross-edge constraints on 121 interface points**, a finite
   table scan with no solver in it.

`build/m63-phaseH3-solver/certificate-h3-fourcolouring.json` (47 KB) carries all three: the lattice
basis, the 60 unit vectors, the two homomorphisms' eight basis images each, the permutation, the 252
cross edges **as coordinates** (not as indices into any list of ours), and the 121 interface points.
`recheck.py` reads that file and nothing else of ours, rebuilds the base and its unit edges from
scratch at any radius, and reports. **Proven to discriminate, as a pair:** with one basis image of
`ψ` flipped it reports **7,980 monochromatic edges / NOT PROPER**; with the certificate restored it
reports **0 / proper four-colouring**.

**What is NOT claimed.** Nothing here is kernel-checked. No Lean module was built and none is needed
for a four-colouring — but the statement *"χ ≤ 4 for this arena"* is a tools-side result until
someone writes it down in Lean. No LRAT, no DRAT, no proof log exists, because no solver produced
anything.

---

## §8 — Artifacts

`build/m63-phaseH3-solver/` (regenerable; total 120 KB of code plus the certificate):

| file | what it is |
|---|---|
| `kk.py` | exact arithmetic in `K`, written independently; controls in §1 |
| `build_base.py`, `enum_base.py` | the unit shell, the span lattice, the four-conjugate disk cut |
| `cross.py` | the cross-edge split law and its second derivation in `K(√D)` |
| `brute.py` | the field-blind brute force and its repaired negative control |
| `structure.py` | components, `k`-cores, the interface |
| `additive.py`, `pair2.py` | the additive family and the independent-pair search |
| `shaped.py` | Parts's shaped lattice — phase H2's and the record's objects, as controls |
| `verify4.py` | end-to-end verification with the billion-pair completeness check |
| **`certificate-h3-fourcolouring.json`** | **the reviewer's artifact, 47 KB** |
| **`recheck.py`** | **standalone re-checker; reads only the certificate** |
| `screen.py` | the base-free family screen over `n` (§4b) |
| `reconcile.py` | quantities (a) and (b) of §3a, with the `≤ 552` known-answer check |
| `REGISTER.md` | the `n = 4` prediction, registered before the run |

Runtimes, desktop, uncontended: base at the bound **2.4 s**; cross edges **0.3 s**; pair search
**1.7 s**; billion-pair brute force **8.2 s**; the radius-1.7 seven-billion-pair check **54 s**. The
entire phase-H3 solver question cost **under two minutes of compute**, against phase H2's 20.03
core-hours — because the answer was a derivation and not a search.
