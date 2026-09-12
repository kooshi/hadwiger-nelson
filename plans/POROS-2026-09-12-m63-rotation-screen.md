# Poros — M63 phase G, the new-rotation screen (2026-09-12)

*Advising the engineer screening the one new rotation this project has had a reason to try, against
`plans/M63-phaseG-bases-and-rotations.md`. Uncommitted by me; the engineer commits it by path.
Cards are numbered `RS-n` and are stable identifiers — cite them, never renumber.*

**The frame, on its five axes, as I read it before asking anything.**

| axis | as the record states it | address |
|---|---|---|
| object | the type-M arena `L ∪ ρS` on `parts_lattice(r)` at one new rotation `cos = 11/32 + 3/32·√33` | phase G §3.3 rank 3 |
| question | the non-vacuity ask — does that arena refuse four colours at all? | phase G §2 filter 4 |
| discipline | finite graph colouring, decided by SAT — but the wall it stands against is algebraic number theory | §2's own cascade: filters 1–3 are theorems, filter 4 is a solver |
| audience | the coordinator tonight; a stranger at the write-up, answering `[Parts2020a]` §4's sentence | §0 product statement |
| product | *which rotations are alive, and what each verdict proves* — a census with exact quantifiers, not an object | §0, and filter 4's "what it proves" column |

**Where I disagreed with the coordinator, up front, since he asked for it.** His asymmetry — a missing
edge can only make a graph easier to colour, so a refusal is robust and a colourable verdict is not — is
correct as graph theory and correct about the routine he aimed it at. It is aimed at the wrong half of
the graph (RS-2), and the verdict it says to believe immediately is the one with the most ways of being
true-but-uninformative (RS-1, RS-3). And one of the two checks he asked me to audit is forced by an
isomorphism and cannot fail in its headline number (RS-4).

---

## Evidence inventory

- `plans/M63-phaseG-bases-and-rotations.md`, the phase's own subplan, 869 lines — read against: a filter cascade whose filter-4 verdict carries a radius quantifier, and a calibration that can fail — surprised: yes (§4.3 dismisses the exact-arithmetic layer as unneeded by the cascade, in the same paragraph that names why filter 4 needs it; §3.3 lists `−7/8` as an independent live candidate)
- `tools/typem.py:542-556`, `unit_edges_fast` — read against: a float radius that decides an edge, per the coordinator's warning — surprised: no; it is float-propose / exact-dispose (`query_pairs(1.0 + 1e-7)` proposes, `== ONE` in exact K disposes), so its only failure mode is dropping a pair
- `tools/typem.py:460-495`, `Arena.__init__` — read against: a dedup or identification that could merge two plane points into one vertex — surprised: yes, in the safe direction; L and S are two independent index copies with only the S-side centre forbidden, so coincident points are *split* rather than merged, and a split is easier to colour than its quotient
- `tools/typem.py:1118-1153`, `parts_lattice` — read against: a float disk boundary — surprised: no; the cut is exact integer arithmetic (`gap*gap >= 132*P*P`), and the congruences and the cut are both invariant under negation, so the lattice is centrally symmetric
- `tools/typem.py:1234-1341`, `CrossLaw` — read against: a second copy of the law, or a float ray key — surprised: no; `line_key` divides in K and folds antipodes, `joins` is exact. The residual risk is not implementation, it is that the law is *derived* rather than measured (RS-2)
- `data/m62/pl-subtypes.json`, §R20's 32-row subtype census — read against: whether the base-alone case was ever asked — surprised: yes; row 1 is `{'subset': [], 'off_centre_edges': 0, 'verdict': 'sat'}`, so the empty-cross case *was* asked, at radius 2.00
- `data/m62/subtype-census.json`, the 127-subset run — read against: the same question at radius 2.44 — surprised: no; it is on the earlier symmetric-core base, always adds `CENTRE` first (`m62_subtypes.py:9`) and enumerates only non-empty subsets
- `plans/M62-evolutionary-type-m.md` §R20 and §R22 — read against: which radius each conclusion was measured at — surprised: yes; §R22's *"§R20's exhaustive subtype law is therefore untouched by the enlargement"* is sound for the UNSAT rows and unsound for the SAT rows, by the coordinator's own asymmetry
- `tools/residue_colouring.py`, Theorem B's explicit 4-colouring — read against: whether it consumes typem's coordinate form — surprised: yes, usefully; `residue_of_coords(x, y, S)` takes exactly the 4-tuple `(1, √3, √11, √33)` form `parts_lattice` emits, so RS-5 is implementable today with no new arithmetic

---

## RS-1 — the base-alone worry, raised and then closed by a theorem rather than an ask

question: is-a-refusal-attributable-to-the-rotation
  evidence: `Arena.__init__` (typem.py:466) puts the whole `E_int` of `parts_lattice(r)` into both the
    (L,L) and (S,S) blocks, and D6 sets every arena radius to max(1/|sin θ|, 2.44); the only measured
    empty-cross verdict on disk is `data/m62/pl-subtypes.json` row 1, SAT, at radius 2.00
  expected: the L block alone is 4-colourable at every radius the screen uses
  ask: could the L block alone refuse four colours at 2.44, making every filter-4 UNSAT unattributable?
  if it could: one ask on the bare L block precedes every rotation, and an all-UNSAT P-G2 means the base,
    not the tooling and not G35's gate
  if it could not: filter 4's refusal is carried by cross edges by construction, and P-G2's branch table
    is complete as written
  answered by: derivation
  cost: nil — it is a corollary of a theorem already in the kernel
  status: answered — kept in the record because the asking is the reason the answer is on paper
  rank: 4

**Answered, and the answer is a theorem.** `parts_lattice(r)` has coordinates `((a + b√33)/12, (c√3 +
d√11)/12)`, so it lies in `K²` with `K = ℚ(√3,√11)` at **every** radius. Theorem B
(`chromaticNumber_seamPlane`, ledger row 57) gives `χ(K²) = 4`. So the L block is 4-colourable at 2.44,
at 3.0, and at any radius; and `S ≅ L` as a graph, since `ρ` is an isometry. **Every refusal the screen
returns is carried by cross edges, necessarily.** The ask is discharged without spending the call.

**What survives, and it is a correction to the record rather than to the plan.** M62 §R22 writes
*"§R20's exhaustive subtype law is therefore untouched by the enlargement,"* inferring from *the cross
edges are unchanged at 2.00 and 2.44* that the whole 32-row law carries over. The 21 UNSAT rows do carry
over — adding L-side material can only tighten. **The 11 SAT rows do not.** That is the coordinator's own
asymmetry, written backwards, in a sentence a write-up would quote. It costs nothing today because
Theorem B covers the row that mattered; it will cost something the first time §R20's law is quoted at a
radius it was not measured at.

---

## RS-2 — the asymmetry protects the measured half of the graph and not the derived half

question: which-half-of-the-arena-does-the-asymmetry-cover
  evidence: `unit_edges_fast` (typem.py:542) proposes by float and disposes in exact K, so E_int can only
    lose edges; `E_cross` is not measured at all — `CrossLaw.joins` (typem.py:1308) tests `q == Z` and
    `cos·p == (nu+nv−1)/2` against a cosine the census *derived*
  expected: one argument covers the whole arena
  ask: does the edge-dropping asymmetry say anything about a cross-edge law, whose failure direction is
    to invent edges rather than to drop them?
  if it does not: a refusal at a new rotation is exactly the verdict the asymmetry does not protect, and
    A3's independent recount is on the critical path for the headline, not for the certificate
  if it does: the screen may be believed on a positive with no further check
  answered by: derivation
  cost: nil to see; half a day to close (the A2 layer)
  rank: 2

**It does not, and the gap sits precisely under the phase's headline.** A wrong law makes the arena
**denser**, makes UNSAT **cheaper**, and reads as success — which is the plan's own §6.2, stated there
in almost those words. For `ρ₁₅` the law is tied down (control c5.1 against the committed
implementation; 126 = 126 on two bases). For `cos = 11/32 + 3/32·√33` it is tied to nothing.

**Where §4.3 has it backwards, offered as a correction.** It reads: *"Nothing in §2's cascade needs it
[the `K(√r)` layer] — filters 1–3 are computations in `K` alone, and filter 4's graph is built by the law
rather than by distance arithmetic."* Filter 4's graph being built by the law is the **reason** the law
needs an independent check, not the reason it does not. The sentence names the gap and dismisses it in
the same breath.

**And the check is cheaper than §4.3 prices it.** It does not need `ρ` as a number. Expand `|u − ρv|²`
over `K[√D]/(√D² − D)` with `D = 1 − cos²` — one formal symbol, not a general tower — and require the
`√D` coefficient to vanish and the rational part to equal 1, by a code path that never calls `joins`.
That is A2 at its minimum and it is A3's own prerequisite on exactly the inputs that are new.

---

## RS-3 — an elimination's quantifier, and the one place it can be made stronger instead of hedged

The plan states filter 4's scope correctly (*"a SAT at radius 2.44 does not close the rotation — it
closes that arena"*), and filter 3's `one-kind` / `dead` distinction is right. Two additions.

1. **2.44 is warranted at `ρ₁₅` and unwarranted elsewhere.** D6 justifies it as *"the radius at which
   this lattice provably contains a known 5-chromatic object"* — true at `ρ₁₅`, where Heule-510 sits in
   the arena splitting 375 L / 136 ρS (§R22). At another rotation nothing is known about where a refusing
   object would live, so the same radius carries a weaker warrant. Say *"SAT on the arena at 2.44"* and
   not *"comparable with a known positive"*, which is true of one row of the table only.
2. **At ranks 5–6 the seam is 18 pairs inside radius 1.020**, so the arena at 2.44 is two full 3,433-point
   lattices joined through a small core. A SAT there is a weak elimination by construction, and it should
   be reported with the seam size beside the radius. **60 of `ρ₁₅`'s 126 cross edges are the centre
   edges, and those exist for every rotation** (`joins(centre, v)` reduces to `|v|² = 1`, with no
   dependence on `cos`): 48% of the calibration's headline number is a constant of the base.

**The exception, and it runs the other way: RS-5's elimination carries no radius at all.** It is the one
verdict in this phase that can be stated for every base drawn in `K²` and every radius, which is what an
elimination with an exact quantifier looks like when the quantifier is generous rather than narrow.

---

## RS-4 — `cos = −7/8` is Parts's own arena relabelled, so its 126 is forced

question: can-the-minus-seven-eighths-calibration-fail
  evidence: parts_lattice's congruences (typem.py:1136) and its disk cut (1144-1147) are invariant under
    (a,b,c,d) ↦ −(a,b,c,d), and §R22 confirms closure under a group containing ζ₆³ = −1
  expected: an independent second rotation whose cross-edge count is a free measurement
  ask: is the −7/8 arena isomorphic to the +7/8 arena, and is its 126 therefore forced?
  if forced: the total cannot fail and only the decomposition is informative; and §3.3 rank 2 is not a
    candidate, it is the record's own object under a relabelling
  if not forced: 126 = 126 stands as an independent calibration
  answered by: derivation
  cost: nil
  hunch: forced — S = −S makes v ↦ −v an isomorphism
  falsifier: a lattice point whose negative is absent from parts_lattice(r)
  rank: 3
  status: confirmed (by: the congruence and disk-cut invariance above, checked by hand on all four
    conditions and on S = a² + 33b² + 3c² + 11d², P = ab + cd)

`S = −S`, so `|u − (−ρ)v| = |u − ρ(−v)|` and `v ↦ −v` is a graph isomorphism from the `−7/8` arena onto
the `+7/8` arena. **The total must be 126.**

**The decomposition is where the information is, and it is a derived identity rather than an observed
one.** Under that relabelling the 18 unordered off-diagonal pairs stay off-diagonal, and the 30 diagonal
edges `(u,u)` become `(u,−u)`, which are 15 unordered pairs — so

> **33 = 18 + 15**, and `2·33 + 0 + 60 = 2·18 + 30 + 60 = 126`.

A control asserting `len(edges) == 126` cannot fail at `−7/8`. A control asserting `(centre, off, diag)
== (60, 33, 0)` **and** `33 == 18 + 15` against the `+7/8` run can. That is the whole difference between
this being a calibration and being a formality.

**Two consequences beyond the control.** §3.3 rank 2 reads *"LIVE — same field, different adjacency, and
no published construction uses it"*; screening it spends an UNSAT-priced ask to rediscover the record,
and reporting it as *a second rotation refuses* would be a false finding. And the sign-pairing that §11.6
and P-G5 apply at ranks 3–6 (*"one rotation up to base symmetry, 1 ask not 4"*) is the same argument and
must be applied at ranks 1–2 too. The Galois half of that collapse is sound for the same reason: the
disk cut is the **totally-real** one, so `√33 ↦ −√33` preserves the point set and carries rank 3's arena
onto rank 5's.

---

## RS-5 — a residue screen between filters 3 and 4: 18 exact tests, and its elimination is radius-free

question: can-theorem-B-four-colour-the-arena-itself
  evidence: `Arena` gives the S half the same index set and the same `E_int` as the L half
    (typem.py:466-468), so one colouring of the base transports to both halves; `parts_lattice(r) ⊂ K²`
    at every r; `residue_colouring.py::residue_of_coords` already eats typem's 4-tuple coordinates
  expected: filter 4 is a solver question
  ask: is the arena four-coloured by Theorem B's residue colouring on both halves, with the S half
    shifted by a constant?
  if yes for the new rotation: it is dead by a theorem, at every radius, on every base in K², before a
    core is spent
  if no: the filter is silent, the solver runs, and the pairs that blocked it are the ones carrying the
    forcing
  answered by: run — 18 calls to `residue_of_coords`, twice (one per prime above 2)
  cost: microseconds
  hunch: it fires on the new rotation, which has zero diagonal cross edges
  falsifier: an off-diagonal cross pair of ranks 3-6 whose difference has positive 𝔭-adic valuation at
    both primes above 2
  rank: 5
  status: answered — the filter fired, and the rotation is dead

**The construction.** Colour vertex `i` by `φ(p_i)` and vertex `n+j` by `φ(p_j) + δ`, `δ ∈ 𝔽₄`, with φ
Theorem B's residue colouring. Both internal blocks are `E_int`, every one of whose edges is a genuine
unit distance in `K²`, and a constant shift is a relabelling of colours — so both are proper. A cross
edge `(i,j)` is proper iff `φ(p_i) − φ(p_j) ≠ δ`. With `Δ = { φ(p_i) − φ(p_j) : (i,j) ∈ E_cross }`,
**the arena is 4-colourable as soon as some `δ` lies outside `Δ`.**

**It collapses to one test.** The centre cross edges are present for every rotation, the unit hexagon is
in the lattice (`a = 12` and `a = 6, c = 6` both satisfy the congruences), and a unit hexagon's residues
realise all three nonzero classes — so `Δ` always contains them and `δ = 0` is the only candidate:

> **The arena is 4-colourable whenever no cross edge is φ-monochromatic**, i.e. whenever every cross
> pair has `residue_of_coords(p_i − p_j) ≠ (0,0)` at one of the two primes above 2.

A **diagonal** cross edge has difference 0 and is always φ-monochromatic, so the filter is blind to any
rotation carrying one. **Ranks 3–6 carry 18 off-diagonal pairs and zero diagonal**, so for the new
rotation the filter is 18 tests × 2 primes.

**Why the elimination is radius-free.** φ colours all of `K²`, so the argument never mentions a radius:
a rotation eliminated here is eliminated **on every base drawn in `K²` and at every radius** — a strictly
stronger quantifier than filter 4 can return, and the answer to "what would an elimination actually
prove" in its generous form rather than its hedged one.

**Calibration, on a row whose answer is already known.** On `ρ₁₅` the auxiliary pairs sit at squared
radii `(17 ± √33)/6` with product `(8/3)²`, so `(t − s)² = 17/3 − 16/3 = 1/3`; the difference `1/√3` is a
𝔭-adic unit, hence **not** φ-monochromatic. The reference family is exactly the 30 diagonal edges
(`|u|² = 1/(2 − 2·7/8) = 4`, §R20's reference radius). So the filter **fires on auxiliary-only and is
silent on anything containing reference** — and §R20 measured auxiliary-only SAT, reference-only SAT,
both UNSAT. It gets the row it can speak to right and stays silent rather than lying on the other two.
It is also consistent under RS-4's isomorphism: at `−7/8` the 15 antipodal pairs `{u,−u}` at `|u| = 2`
sit at distance 4, which is 𝔭-adically positive, so the filter is silent there too — as it must be.

**Three caveats, so it is priced honestly.**
1. **One-sided.** Firing proves SAT; silence proves nothing. §R20's reference-only row is SAT by a
   colouring outside this family, so the filter is strictly weaker than the truth.
2. **Proof-grade only as far as the tool is faithful.** Its own positive signal is free and should be
   asserted, not assumed: `residue_of_coords` must give **zero** monochromatic unit edges over all 3,433
   base points, and **must** give a zero difference on a distance-2 pair. The second half is the negative
   control; the docstring says the tool already validates both on the Exoo–Ismailescu seed.
3. **Two primes.** `S ≡ ±17 (mod 256)` are different colourings; a pair may be monochromatic at one and
   not the other, and one working prime suffices.

---

## hunch ledger

hunch: the-asymmetry-is-aimed-at-the-wrong-half
  claim: the edge-dropping argument covers `E_int` and says nothing about `E_cross`, whose failure
    direction is to invent edges
  basis: read
  address: typem.py:542 (float propose, exact dispose) against typem.py:1308 (`joins`, exact but
    resting on a derived cosine)
  falsifier: a route by which a wrong `cos` value could only remove cross edges and never add one
  registered: 2026-09-12
  status: open

hunch: minus-seven-eighths-is-the-record-relabelled
  claim: the `−7/8` arena is isomorphic to `ρ₁₅`'s under v ↦ −v, so its 126 cross edges are forced
  basis: derived
  falsifier: a lattice point of `parts_lattice(r)` whose negative is absent
  registered: 2026-09-12
  status: confirmed (by: invariance of all four congruences and of S and P under negation, hand-checked)

hunch: the-residue-screen-fires-on-the-new-rotation
  claim: none of ranks 3-6's 18 off-diagonal cross pairs is φ-monochromatic, so the rotation is dead by
    Theorem B at every radius
  basis: analogy
  address: `ρ₁₅`'s off-diagonal pairs are 𝔭-adic units (difference 1/√3) and the new rotation carries
    only off-diagonal pairs
  falsifier: one of the 18 pairs with `residue_of_coords(p_i − p_j) == (0,0)` at both primes above 2
  registered: 2026-09-12
  status: confirmed (by: derivation — RS-6's formula d² = σ − (σ−1)/cos gives every kind's squared
    difference in closed form, and the engineer's run then found 0 monochromatic cross edges at the
    prime S ≡ 239 for rank 3 and at S ≡ 17 for rank 5, with an explicit 4-colouring checked on every
    arena edge. Registered as analogy and promoted by the derivation, not by the measurement)

hunch: the-R22-carry-over-sentence-is-half-wrong
  claim: §R22's "§R20's exhaustive subtype law is untouched by the enlargement" holds for the 21 UNSAT
    rows and fails for the 11 SAT rows
  basis: derived
  address: monotonicity of χ under adding vertices and edges
  falsifier: a reason the SAT rows' colourings extend to the 1,830 added points on each side
  registered: 2026-09-12
  status: confirmed (by: Theorem B, `chromaticNumber_seamPlane` — `parts_lattice(r) ⊂ K²` at every
    radius, so the empty-subset row holds at 2.44 for a reason §R22 does not give; the other ten SAT
    rows stay open)

---

## What I did not do

1. **I did not run the 18 residue tests.** I am not to launch computation, and the test belongs to the
   engineer's instrument anyway, with its own control attached. RS-5's hunch is therefore open, and its
   basis is recorded as analogy rather than measurement.
2. **I did not audit the census's independence from `CrossLaw`.** The question is put to the engineer:
   whether the `(centre / off-diagonal / diagonal)` counts come from a code path that never calls
   `CrossLaw.edges`. If they do not, the control asks the same question twice — the shape that cost this
   milestone a night already.
3. **I did not check `[PartsOdd2022]`**, which §PA4 records as held and unread and which bears on whether
   a second rotation is unprecedented. It cannot change a verdict; it can change a claim in the write-up.
4. **I did not verify that the 30 norm-1 points realise all three nonzero residue classes** beyond the
   unit hexagon's six, which suffice for the argument. If the hexagon were absent from some future base,
   RS-5's collapse to `δ = 0` would need redoing rather than reusing.


---

## RS-6 — the verdict is one number per kind, and the base drops out

*Written after the engineer's run fired the RS-5 filter. This is the derivation that turns his
certificate on one arena into a statement about the rotation.*

question: what-does-the-residue-elimination-actually-cover
  evidence: the engineer's run reports 0 monochromatic cross edges at the prime S ≡ 239 for
    `cos = 11/32 + 3/32·√33`, at S ≡ 17 for its Galois conjugate, and an explicit 4-colouring verified on
    every edge of the radius-2.44 arena; he asks whether the claim can be pushed past "this lattice"
  expected: the verdict depends on which points the base holds
  ask: does whether a cross kind is φ-monochromatic depend on the base at all, or only on the rotation?
  if only on the rotation: the elimination is base-free and radius-free, and the endpoint bound's whole
    job is to guarantee no new kind appears
  if on the base: the elimination must be re-run on every base, and the census is per-base for ever
  answered by: derivation
  cost: nil
  rank: 1
  status: answered — only on the rotation and the radius sum

**The derivation.** For a collinear cross pair at squared radii `a = |u|²`, `b = |v|²`, the law fixes
`p = Re(conj(u) v) = k/cos` with `k = (a + b − 1)/2`, so

> **d² = |u − v|² = σ − (σ − 1)/cos θ**, with **σ = a + b**.

`φ(u) = φ(v)` iff `v_𝔭(u − v) > 0`, and 𝔭 is conjugation-fixed so `v_𝔭(|z|²) = 2 v_𝔭(z)`. Hence

> **a kind is φ-monochromatic iff `v_𝔭(σ − (σ−1)/cos θ) > 0`** — a condition on the rotation and one
> number, with no reference to the base, the radius, or the points.

`σ` also determines the kind outright: `ab = (k/cos)²` is forced, so `a` and `b` are the roots of
`x² − σx + (k/cos)²` and there is exactly one kind per radius sum.

**Four checks.**

| kind | σ | cos | formula | independently |
|---|---|---|---|---|
| ρ₁₅ diagonal | 8 | 7/8 | **0** | the same point, distance 0 |
| ρ₁₅ auxiliary, `(17±√33)/6` | 17/3 | 7/8 | **1/3** | `(t−s)² = 17/3 − 16/3` |
| centre, any rotation | 1 | any | **1** | `|0 − v| = 1`; so centre edges are never monochromatic, for any rotation |
| `−7/8` antipodal | 8 | −7/8 | **16** | `|2u − (−2u)|² = 16`, and `v_𝔭(16) > 0` — the engineer's "no free δ" row |

**The statement, at the level it is actually true.**

> Let `F` have a conjugation-fixed prime 𝔭 above 2 with residue field 𝔽₄. Let `ρ` have `cos θ ∈ F`,
> `sin θ ∉ F`. If every radius sum `σ` realised by a collinear pair satisfies
> `v_𝔭(σ − (σ−1)/cos θ) = 0`, then `L ∪ ρS` is 4-colourable **for every `L`, `S` drawn in `F²`, at every
> radius**.

It never used `L = S`, group-closure, or the endpoint bound. **The endpoint bound does one job and it
is the right one:** it guarantees that enlarging the radius realises no new `σ`, which is what makes the
claim a statement about the rotation rather than about 2.44.

**A control that fired and was not counted.** The engineer's table is diagonal — rank 3 free at
`S ≡ 239`, rank 5 free at `S ≡ 17`. That is forced. `√3 ↦ −√3` sends `√33 ↦ −√33`, carrying `cos` to its
conjugate; it fixes `parts_lattice` because the disk cut is the **totally-real** one
(typem.py:1138-1147); it preserves squared distances; and it **swaps the two 2-adic embeddings**
`S ≡ ±17 (mod 256)`. So the two rows are one fact seen twice, and both-free-at-one-prime, or
one-free-at-both, would have been a defect. It is a free cross-check on the census, the base's Galois
structure and `sqrt33_2adic` together, and it passed.

**A correction to the attribution, which moves credit toward us.** The filter fires exactly when no
cross pair is φ-monochromatic, so what it proves is *a family containing no φ-monochromatic kind cannot
force*. On ρ₁₅ the φ-monochromatic family is the **diagonal/reference** one at `|u|² = 4` (`d² = 0`);
the auxiliary family at `(17±√33)/6` is not (`d² = 1/3`, a 𝔭-adic unit). So the filter proves
**auxiliary-only ⟹ SAT**, i.e. that the *reference* kind is essential — **M62 §R20's symmetric
addition**, not `[Parts2020a]` §4's own sentence. It is silent on reference-only, which §R20 measured
SAT by a colouring outside this family. State it by radius rather than by his first/second numbering:
`[Parts2020a]` is unread here and the mapping is not mine to assert.

hunch: the-kind-formula-is-the-whole-verdict
  claim: whether a cross kind is φ-monochromatic depends only on cos θ and σ = |u|² + |v|², through
    d² = σ − (σ−1)/cos θ
  basis: derived
  address: p = k/cos from the law, d² = a + b − 2p, and v_𝔭(|z|²) = 2 v_𝔭(z) at a conjugation-fixed 𝔭
  falsifier: two cross pairs on one base with the same cos and the same σ and different v_𝔭(d²)
  registered: 2026-09-12
  status: confirmed (by: four independent checks in the table above — ρ₁₅ diagonal, ρ₁₅ auxiliary, the
    centre kind, and the −7/8 antipodal kind, each recomputed from geometry without the formula)

---

## Rulings — the arbiter, scored

*The card is ruled on by the next move, never at the moment it is asked. All six were ruled the same
night, by the product owner, 2026-09-12. Recorded here so the next context finds the fates attached to
the cards rather than in a chat log.*

| card | ask | ruling | did it change a move? |
|---|---|---|---|
| RS-1 | is a refusal attributable to the rotation? | **answered by a theorem, not an ask** — `parts_lattice(r) ⊂ K²` at every radius, so Theorem B four-colours the L block always. The engineer kept the zero-cross ask anyway as a solver-health check | yes — and it also produced the §R22 correction below |
| RS-2 | does the asymmetry cover the cross-edge law? | **upheld and acted on before any run.** §4.3's sentence that the exact-arithmetic layer is unneeded by the cascade is **reversed** in the plan; the engineer's C6(a)–(d) close the invent direction | yes — the check the headline verdict rests on exists because of it |
| RS-3 | what does an elimination cover? | superseded by RS-6, which makes the quantifier generous rather than narrow | partly |
| RS-4 | can the `−7/8` calibration fail? | **rank 2 struck from the candidate list** rather than screened; the decomposition asserted as the derived identity `66 = 36 + 30` | yes — an ask saved, and a false finding prevented |
| RS-5 | is the arena four-coloured by Theorem B on both halves? | **fired.** `cos = 11/32 + 3/32√33` is 4-colourable at the prime `S ≡ 239`, its Galois conjugate at `S ≡ 17`, with an explicit colouring checked on every arena edge | yes — the rotation died without the solver |
| RS-6 | does the verdict depend on the base? | **promoted into the cascade as a proof-grade filter, ahead of the solver** | yes — it changes the phase's product from six screened rotations to an arithmetic criterion |

**The correction to the record that came out of RS-1**, carried here because it outlives this phase: M62
§R22's *"§R20's exhaustive subtype law is therefore untouched by the enlargement"* is sound on its 21
refusing rows and unsound on its 11 colourable ones. Fixed in place by ruling.

**The unplanned control, named because it is the one worth imitating.** The engineer's results table came
out diagonal — one rotation four-colourable at one prime above 2, its Galois conjugate at the other —
and the pattern is *forced* by `√3 ↦ −√3` swapping the two 2-adic embeddings while fixing the lattice.
Nobody planted it; it could have failed; it cross-checks the census, the base's Galois structure and
`sqrt33_2adic` at once. **An unplanned control that could have failed is worth more than a planted one
that could not**, and this phase's standing rule — *state the uninformative outcome and confirm it is
reachable* — is the reason it was recognised as a control rather than read as a curiosity.

## The attribution, stated as mine so a write-up inherits it

The residue screen proves *a cross-edge family containing no φ-monochromatic kind cannot force*. On ρ₁₅
the φ-monochromatic family is the **reference/diagonal** one at `|u|² = 4` (`d² = 0`); the auxiliary
family at `(17±√33)/6` is a 𝔭-adic unit (`d² = 1/3`). So it proves **auxiliary-only ⟹ SAT** — the
*symmetric* half M62 §R20 added, and **not** `[Parts2020a]` §4's own sentence, on which it is silent.
`[Parts2020a]` is unread here, so state the kinds by radius rather than by his first/second numbering.

---

## RS-7 — the rotation died of a missing lattice point, and the criterion inverts into a design target

*Written after the engineer's closing numbers (eleven classes, radius 2.44; ρ₁₅ UNSAT in 12.2 s, the new
rotation SAT in 6.8 s with an explicit colouring on all 57,228 arena edges; five of eleven classes
certificate-carrying; zero mismatches against the σ form at both primes).*

question: why-is-the-new-rotation-dead-on-this-lattice
  evidence: the engineer reports **zero diagonal kinds** for `cos = 11/32 + 3/32·√33`, and the diagonal
    kind is the one with `d² = 0`, which is φ-monochromatic at every prime and would have silenced the
    filter outright
  expected: the diagonal kind is excluded at this angle by the endpoint bound, i.e. by the rotation
  ask: is the diagonal kind geometrically impossible at this angle, or merely absent from this lattice?
  if impossible: the elimination is about the rotation and §4's new bases cannot revive it
  if merely absent: the elimination is about the base, and the criterion run backwards names the point a
    new base must contain
  answered by: derivation
  cost: nil
  rank: 6
  status: answered — merely absent, and it is the live question the phase inherits

**The diagonal kind needs a base point at squared norm `1/(2 − 2cos θ)`.** At this angle that is
**`(7 + √33)/3 ≈ 4.24819`**, radius **2.0611**, and it is admissible twice over:

| quantity | value | verdict |
|---|---|---|
| spindle squared radius `1/(2 − 2cos θ)` | `(7 + √33)/3` = 4.24819 | — |
| endpoint bound `1/sin²θ` | 4.51382 | **inside** — §1.3 does not exclude it |
| base radius² at 2.44 | 5.9536 | **inside** |
| Galois conjugate `(7 − √33)/3` | 0.41848 > 0 | the totally-real disk cut would admit it |

In the lattice's own integers, `norm² = (S + 2P√33)/144` with `S = a² + 33b² + 3c² + 11d²`,
`P = ab + cd`, so the point exists iff **`S = 336, P = 24`** has a solution under the congruences at
typem.py:1136. The engineer's zero-diagonal count says it does not. **That is the whole reason the
rotation is dead**, and it is a fact about `parts_lattice`, not about the angle.

**So the certificate's scope is exactly what RS-6's σ form says and no more:** every base whose
σ-spectrum is contained in this one. `parts_lattice` misses `σ = (14 + 2√33)/3`, and a base that hits it
is not covered.

**The inversion, which is the deliverable.** Given `cos θ` alone, before any base exists:

> `Σ_live(cos θ) = { σ : v_𝔭(σ − (σ−1)/cos θ) > 0 at **both** primes above 2 }`

— both, because one free prime kills. Each live `σ` names the radius pair a base must contain: `a`, `b`
are the roots of `x² − σx + ((σ−1)/(2cos θ))²`. **§4.2 row 4's "a base designed for a chosen angle — a
day of design per angle" is therefore an arithmetic condition evaluable in microseconds**, and "a good
base for a rotation" stops being §4.1's heuristic (*rich on rays*) and becomes a necessary condition with
a proof behind it: **realises a live σ at both primes.** The diagonal `σ = 1/(1 − cos θ)` is only its
cheapest member.

**A boundary to state before someone else trips on it.** Four of the five certificate-carrying classes
are wall-standing, but the new rotation **breaks** the 2-adic wall and is still certified 4-colourable.
That is not a contradiction with G1 or G35. Wall-breaking is a property of `K(√(sin²θ))`, where the
*rotated* copy lives; the arena is coloured by the residues of the **base** points, which stay in `K`
whatever the rotation does. So:

> **Wall-breaking is necessary and visibly not sufficient, and the diagonal family is the mechanism by
> which a wall-breaking rotation's arena escapes the base's own four-colouring.**

First named mechanism for the gap between *the field breaks the wall* and *the object uses it*.

**On the engineer's self-reported control weakness** (the float-free prefix recount exercised only the
centre edges for most classes; the full 1,706,239-pair sweep ran only for the two wall-breaking ones):
it is bounded, and smaller than he stated. §1.1's split of `Re(ρ·conj(u)v) = k` over the `K`-basis
`{1, s}` is valid precisely because filter 1 guarantees `s ∉ K`, and it **forces** `q = 0` — so a
non-collinear pair *cannot* be a cross edge, as a theorem. Completeness of the edge list therefore
reduces to completeness of the collinear enumeration, which uses exact line keys and is exhaustive over
pairs per line. The sweep is a control on an implementation, not the ground of the claim. Proportionate:
sweep **one** wall-standing class, and record that the collinearity theorem does the work.

hunch: a-live-sigma-is-the-base-design-criterion
  claim: a rotation is alive on a base iff the base realises some σ with v_𝔭(σ − (σ−1)/cos θ) > 0 at both
    primes above 2; the diagonal σ = 1/(1 − cos θ) is the cheapest such σ
  basis: derived
  address: RS-6's d² = σ − (σ−1)/cos θ, plus "one free prime suffices to four-colour"
  falsifier: a base and rotation with no live σ whose arena nonetheless refuses four colours
  registered: 2026-09-12
  status: open — necessary is proved; whether a live σ is ever *sufficient* is untested, and ρ₁₅ is the
    only positive instance anyone holds
