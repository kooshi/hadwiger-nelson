# Architecture — the Hadwiger–Nelson problem in Lean 4

> How many colours does the plane need so that no two points at distance exactly 1 share one?
> Nelson, 1950. Bounded in `[4,7]` that same year; de Grey moved the floor to 5 in 2018. This
> workspace formalizes the floor and then tries to raise it.

## 1. The statement

Everything aims at one declaration, phrased against Mathlib so it is citable rather than bespoke:

```lean
/-- The unit-distance graph on a metric space: `x ~ y` exactly when `dist x y = 1`. -/
def unitDistanceGraph (V : Type*) [MetricSpace V] : SimpleGraph V :=
  SimpleGraph.fromRel fun x y => dist x y = 1

theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistanceGraph (EuclideanSpace ℝ (Fin 2))).chromaticNumber
```

`SimpleGraph.chromaticNumber : ℕ∞` is `⨅ n ∈ {n | G.Colorable n}, n`, and
`chromaticNumber_le_iff_colorable : G.chromaticNumber ≤ n ↔ G.Colorable n` turns the goal into
`¬ Colorable 4`, i.e. **no function `ℝ² → Fin 4` avoids monochromatic unit-distance pairs**.

Getting this statement right is the highest-stakes decision in the project. The characteristic
failure of machine-written Lean is proving the wrong theorem efficiently, and here the wrong
theorem is easy to write and looks identical: an `≠ 1` where `= 1` belongs, a `≤` for a `<`, a
graph whose `Adj` is vacuous, a quantifier over the empty set. § 6 is the defence.

## 2. The shape of the argument

```
                    chromaticNumber_plane_ge_five
                                │
              ¬ Colorable 4 (unitDistanceGraph ℝ²)
                                │   restrict a plane colouring to a finite witness
                    ¬ Colorable 4 (deGrey.graph)
                    ╱                           ╲
     every listed edge has length 1        the abstract graph has no 4-colouring
     ── exact field arithmetic ──          ── verified LRAT checker ──
     Q(√3,√5,√7,√11) as ℤ-tower           Std.Tactic.BVDecide.LRAT.check_sound
```

Two certified computations, joined by one reduction. Neither computation is trusted on its own
say-so, and the two failure modes are independent: bad geometry means the "graph" is not a
unit-distance graph (caught by the field arithmetic); bad combinatorics means it is 4-colourable
(caught by the checker, which cannot certify a satisfiable formula).

### 2.1 Geometry — why exact arithmetic, and which field

De Grey's coordinates are built from √3 and √11 (the seed points), √15 (rotation by
`2·arcsin(1/4)`: `cos = 7/8`, `sin = √15/8`), and √7 (rotations by `π/2 ± arcsin(1/8)`:
`cos = ∓1/8`, `sin = 3√7/8`). So every vertex lives in the **multiquadratic field
ℚ(√3,√5,√7,√11)** — degree 16 over ℚ, with basis `{√(∏S) : S ⊆ {3,5,7,11}}`.

We represent it as an **iterated quadratic extension with ℤ leaves**, all coordinates carrying one
global denominator `scale`:

```lean
structure Adjoin (d : ℕ) (K : Type) where   -- K[√d]
  re : K
  im : K                                     -- coefficient of √d

abbrev Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))
```

ℤ leaves, not ℚ: the Lean kernel accelerates `Nat`/`Int` with GMP, but `Rat` multiplication routes
through `Nat.gcd`, which it does not. A rational representation would make the geometry check
unreducible in the kernel; an integer one keeps it in reach.

The load-bearing observation, and the reason this stays cheap: **we never need the embedding
`Q4 → ℝ` to be injective.** We only need it to be a *ring homomorphism*. A vertex list that
happened to name one plane point twice would be harmless — the reduction restricts a plane
colouring along the map, so extra edges only make the graph harder to colour, and a spurious
"edge" between two names for the same point would fail the `distSq = 1` check anyway. This deletes
the entire number-theoretic burden (linear independence of the 16 basis monomials over ℚ) from the
proof. One `Real.sq_sqrt` per generator is the whole story.

### 2.2 Combinatorics — why LRAT, and what it costs

`k`-colourability of a graph on `Fin n` becomes a CNF over `n·k` variables (`x_{v,c}` at index
`v*k+c`):

- one **at-least-one-colour** clause per vertex, `⋁_c x_{v,c}`;
- for each edge and colour, `¬x_{u,c} ∨ ¬x_{w,c}`.

At-most-one clauses are deliberately omitted: the edge clauses already force the colour sets of
adjacent vertices to be disjoint, so any satisfying assignment yields a proper colouring by
choosing an arbitrary colour per vertex. Fewer clauses, same theorem — and the direction we must
prove is only `Colorable k → Sat cnf`, whose contrapositive is what we want.

Unsatisfiability comes from `Std.Tactic.BVDecide.LRAT`, shipped **verified** in Lean core:

```lean
def check (lratProof : Array IntAction) (cnf : CNF Nat) : Bool
theorem check_sound : check lratProof cnf → cnf.Unsat
```

CaDiCaL (bundled at `$(lean --print-prefix)/bin/cadical`) is an untrusted oracle proposing the
certificate. The residual trust question is only *how the `Bool` is evaluated* — kernel `decide`
or `native_decide`. See § 5.

#### 2.2.1 The colour-cube split is dead, and so was the native fallback — measured 2026-07-29/30

**§ 2.3 below is superseded.** Everything in it about the split being "mandatory" is about solver
tractability and is still true; everything about the split being a *route to a checked proof* is false,
and so is § 5's long-standing assumption that χ(ℝ²) ≥ 5 would ship carrying a native-evaluation axiom.

Measured in full on the desktop (32 cores), all 1,024 depth-5 cubes solved to UNSAT:

| | |
|---|---|
| hint entries, complete | **3.06 × 10⁹** raw, **1.50 × 10⁹** after backward trimming |
| kernel cost per hint entry, measured on a real cube's real table | **1.35 ms** |
| **projected processor time** | **563 hours**, against a 40-hour abandon threshold |
| the same certificate as embedded Lean data | **~4 GB of packed `Nat` literals** |

`plans/spike-kernel-lrat.md` § 4 recorded the same total as 1.30 × 10⁷ — it sampled and extrapolated,
and it was wrong by 115×.

**And `native_decide` does not rescue it**, which is the correction with teeth. The obstacle is not
trust, it is **data volume**: compiled evaluation checks a certificate the elaborator has to accept
first, and the spike already measured that Lean will not elaborate certificate data at that scale. So
the route this project planned around from M03 to M05 was never open in either form.

Deeper splits are strictly worse (7.16× more total hints per three extra pinned vertices), monolithic
does not finish in six configurations, at-most-one clauses do not help, and enlarging the point set adds
disconnected copies. See `plans/M06-chi-ge-five.md` § 0.

### 2.2.2 What replaced it: de Grey's own decomposition

`deGrey.edges` decomposes **exactly** — two 791-vertex copies of one point set, sharing exactly one
vertex (14) and joined by exactly one edge (11–802), 3938 + 3938 + 1 = 7877 — and SAT confirms the
forcing that makes the construction work:

| vertex 14 pinned to colour 0; its copy's endpoint at | 0 | 1 | 2 | 3 |
|---|---|---|---|---|
| copy A (vertex 11) | **SAT** | UNSAT | UNSAT | UNSAT |
| copy B (vertex 802) | **SAT** | UNSAT | UNSAT | UNSAT |

So every proper 4-colouring gives both ends of the joining edge the shared vertex's colour, which the
joining edge forbids. **Two certificates instead of 1,024**, 34.2 × 10⁶ hint entries instead of
1.50 × 10⁹, and one refutation per copy covers three colour cases because relabelling colours is free.
**~23 hours of processor time and ~410 MB of source** — inside the threshold, 44× cheaper, and the proof
is now de Grey's argument rather than a brute-force search.

The check is split into 2,265 **segments** — each an implication between watermarks, so they elaborate
in parallel. The segment size is set by *memory*: peak ≈ 3.4 GB + 0.81 GB per certificate chunk, and 24
concurrent 57-chunk segments took the machine down before that was measured.

#### 2.2.3 And the second certificate was redundant — M09

The two copies are not merely isomorphic, they are **congruent**: the second is the image of the first
under one rotation about `(−2, 0)`, by `(cos, sin) = (31/32, −3√7/32)`, which fixes the shared vertex
(it *is* the centre) and carries vertex 11 to vertex 802. So the second copy's forcing property is the
first copy's, transported — and so is its geometry.

| | M06 | M09 |
|---|---|---|
| certificates | 2 | **1** |
| hint entries the kernel re-runs | 34,169,571 | **18,441,901** |
| generated modules | 2,265 | **1,222** |
| source | 393 MB | **213 MB** |
| processor time | 27.8 h | **15.0 h** + 95 CPU s for the rotation |

The rotation is checked, not assumed: 791 exact coordinate identities in `ℚ(√3,√5,√7,√11)`. Nothing
is emitted for it — the index map is a closed form, because `dedup` puts the first copy at indices
`0–790`.

**The geometry cost is unchanged, and the table above must not be read as saying otherwise.**
`deGreyRot`'s second half is derived from its first plus the rotation, but the `deGrey_valid` it
sources from still checks all 7,877 distances — that edge list is frozen upstream of the surviving
certificate. What the rotation deleted is the *certificate*. The derivation earns its keep at M11,
where a placed copy's coordinates are defined by the motion rather than listed and the check becomes
`rfl`.

## 2.3 The colour-cube split — mandatory, not an optimization *(superseded: see § 2.2.1)*

**Measured, 2026-07-23, 32-core box.** A monolithic CaDiCaL run on the full 6324-variable /
33089-clause instance (8 configurations raced: `--unsat`, default, `--plain`, `--sat`, two seeds
each) **did not terminate within 10 minutes, and the partial LRAT was already 2.0 GB.** Extrapolating
a certificate of that order into Lean is hopeless for the kernel and painful even for
`native_decide` (LRAT-Catcher reports ~9 GB resident for a 628 MB certificate). So the split below
is load-bearing, not a wall-clock nicety.

CaDiCaL is single-threaded. Rather than race one monolithic run, split the search:

```lean
theorem not_colorable_of_cubes (W : List (Fin n))
    (h : ∀ φ : Fin W.length → Fin k, ¬ ∃ c : Coloring, ∀ i, c W[i] = φ i) : ¬ Colorable k G
```

— trivial to prove (a colouring induces its own cube), `k^|W|` independent CaDiCaL runs, and each
subproblem is much easier.

**What the split does *not* buy, measured 2026-07-27 (M03 de-risk).** An earlier version of this
section hoped that many small certificates might be kernel-reducible where one large one is not.
That is false: `LRAT.check` does not kernel-reduce **at any size** — see § 5. The split's
justification is solver tractability, certificate size, and 32× wall-clock. Two multipliers on top:

- **Colour symmetry.** Max clique in a plane unit-distance graph is 3 (four mutually
  unit-distant points would be a regular tetrahedron), and these graphs are full of unit
  triangles. Fixing one triangle to colours `0,1,2` is sound via a permutation of `Fin 4` and
  cuts the space by `4! = 24`.
- **Certificate trimming.** `Lean.Meta.Tactic.BVDecide.LRAT.Trim` ships in the toolchain.

## 3. Module DAG (leaf-first)

```
Mathlib ─┐
         ├─► HadwigerNelson/UnitDistance.lean      graph on a metric space; χ transfer   [M01]
         │
Std.Sat ─┤
         ├─► HadwigerNelson/Field/Quadratic.lean   Adjoin d K, CommRing, eval : K →+* ℝ  [M02]
         │        └─► HadwigerNelson/Certificate.lean   Pt, distSq, UDCert, Valid, sound [M02]
         │                 ├─► HadwigerNelson/Instances/Spindle.lean  spindle geometry   [M02]
         │                 ├─► HadwigerNelson/Motion.lean   exact plane similarities      [M09/M11]
         │                 │        rotations, reflections, translations; composition; NatCancel
         │                 │        └─► HadwigerNelson/Assembly.lean   many placed copies, one   [M12]
         │                 │                 certificate; intra-copy edges free, seams checked
         │                 │                 └─► HadwigerNelson/AssemblyDiagnose.lean  #eval-only:
         │                 │                          which seam failed, by copy and base vertex
         │                 └─► HadwigerNelson/Packed.lean   digit packing; DiffWitness    [M08]
         │                          └─► HadwigerNelson/PackedDiagnose.lean   #eval-only faults
         │
         ├─► HadwigerNelson/Pattern.lean   port colourings, one per partition       [M11]
         │        (depends on Mathlib alone — a candidate for upstreaming)
         │
         ├─► HadwigerNelson/Sat/Encoding.lean   colouringCNF, Colorable → Sat, cubes     [M03]
         │        ├─► HadwigerNelson/Sat/Lrat.lean   certificate ingestion, trust boundary [M03]
         │        └─► HadwigerNelson/Gadget.lean   colouring constraints, at any number  [M09/M11]
         │                 of colours; composition; the terminal check over partitions
         │
         ├─► HadwigerNelson/Sat/Mask.lean   clauses/assignments as bitmasks; propagate   [M05]
         │        └─► HadwigerNelson/Sat/ClauseTable.lean   literal chunk table; agreement
         │                 └─► HadwigerNelson/Sat/MaskCheck.lean   decoder, checker, segments  [M05/M06]
         │
         │
         └─► HadwigerNelson/Reduction.lean          UDCert + Unsat ⟹ bound on χ          [M03]
                  ├─► Instances/SpindleBound.lean       χ ≥ 4, three routes              [M03]
                  │        └─► Instances/SpindleLrat.lean   certificates — generated     [M03]
                  └─► Instances/DeGrey/Table.lean    1581 points, its OWN module     [M04]
                           └─► Instances/DeGrey/Edges.lean   45 chunks; edges := halfA ++ halfB ++ cross
                                    └─► Instances/DeGrey/Diffs.lean   133 differences, packed   [M08]
                                             └─► Instances/DeGrey/Valid.lean   one decide, one citation
                                             └─► Instances/DeGrey.lean   the claims, the reduction
                                                      └─► Instances/DeGrey/Split.lean   the two copies  [M06]
                                                      │        └─► HalfA/  table + 1222 segments
                                                      └─► Instances/DeGrey/Rotation.lean   791 identities [M09]
                                                               └─► Instances/DeGrey/Rotated.lean
                                                                        │   deGreyRot: half B derived
                                                                        └─► Instances/DeGrey/Forcing.lean
                                                                                 three gadgets
                                                                                 └─► DeGrey/Bound.lean
                                                                                         χ(R^2) >= 5

     Sat/Diagnose.lean   #eval-only fault rendering — deliberately DOWNSTREAM of the        [M07]
                         checker, so rewriting a diagnostic does not re-check 27.8 h
     Instances/Heule510.lean, Heule553.lean   two published witnesses, re-certified         [M07]
              ├─► Heule5xx/{Table,Edges,Diffs,Valid}.lean   geometry, 4 modules each      [M08]
              ├─► Heule5xx/Cnf/{Table00..03,Table,Seg000..081,Cert}.lean   one certificate
              │        (imports Heule5xx/Edges, NOT the aggregate: geometry must never sit
              │         upstream of a certificate, or changing it re-checks every segment)
              └─► Heule5xx/Bound.lean   chromaticNumber_plane_ge_five_510 / _553

Proofs.lean          — flat public surface
tools/               — UNTRUSTED generators (Python): graph construction, DIMACS, cube split
```

## 4. Roadmap

Leaf-first, one milestone at a time, green manifold at every step. Subplans in `plans/`.

| # | Milestone | Terminal test |
|---|---|---|
| **M01** ✅ | **The statement.** `unitDistanceGraph`; transfer from a finite witness to `χ(ℝ²)`. No data, no SAT. | `chromaticNumber_ge_of_not_colorable_finite` green; the statement reads correctly against the informal claim; a concrete model of the hypotheses exhibited. |
| **M02** ✅ | **Exact geometry.** Quadratic tower + `eval` ring hom + `UDCert` and its soundness. | *Landed 2026-07-27.* Moser spindle's 7 points / 11 edges certified by kernel `decide`, axioms `[propext, Quot.sound]`. Measured 0.16 s/edge — no cost from Mathlib's hierarchy. |
| **M03** ✅ | **The SAT bridge, and χ ≥ 4.** `colouringCNF`, `Colorable → Sat`, LRAT ingestion, cube cover. | *Landed 2026-07-28.* Spindle non-3-colourable **three ways** — brute-force `decide +kernel`, one LRAT certificate, and nine cube certificates — all agreeing. `4 ≤ χ(ℝ²)` proved through the brute-force route: axioms exactly `[propext, Classical.choice, Quot.sound]`. The certificate routes carry 10 native axioms across 5 declarations, each named in its docstring and cross-checked by the gate. lean4checker green on all 13 modules. |
| **M04** ✅ | **de Grey's graph as certified data.** 1581 vertices, 7877 edges, geometry verified in Lean. | *Landed 2026-07-28.* `deGrey_valid` — all 7877 edges at exact squared distance `768²`, kernel-decided in 158 chunks, axioms `[propext, Quot.sound]`: **no native evaluation in the geometry at all**. `deGrey_bound_of_not_colorable` leaves exactly one hypothesis between here and `χ(ℝ²) ≥ 5`. lean4checker green on all 33 modules. Lean guards 1581 and 7877; the paper's **397** counts an intermediate set that never reaches Lean and is checked by `tools/degrey.py`'s output only. |
| **M05** ✅ | **The kernel-checkable certificate checker.** Big-integer refutation checker, its soundness proof, and the packed certificate format. | *Landed 2026-07-29 (`plans/M05-kernel-checker.md`).* `maskCheck_sound` — a refutation checker whose two hypotheses are closed `Bool`s the **kernel** decides, axioms exactly `[propext, Classical.choice, Quot.sound]`, zero `sorry`. Soundness is proved for **every** decoder, so the certificate's packing is untrusted as a matter of type. Negative controls committed and *watched to fail*: a satisfiable formula is refused, a clause citing itself is refused, and mutating the conflict test or deleting the watermark guard breaks the soundness proofs rather than the checker's answer. The remaining work is throughput at de Grey's scale, projected at **5.4–9.0 h processor time, ~30–50 min wall over 96 independent cubes**; that measurement belongs to M06, which is where a real certificate first arrives. |
| **M06** ✅ | **χ(ℝ²) ≥ 5.** ~~Cube split at depth 5 (1024 cubes)~~ — **the cube split is dead; see below.** de Grey's own decomposition instead: two forcing lemmas, one certificate each. | *Landed 2026-07-30 (`plans/M06-chi-ge-five.md`).* **`chromaticNumber_plane_ge_five` — the plane needs five colours — depends on axioms exactly `[propext, Classical.choice, Quot.sound]`.** Zero native purchases, zero `sorry`, linters clean. Two kernel-checked refutations, 34.2 × 10⁶ propagation steps across 2,265 segment modules: **27.8 hours of processor time, 2.8 hours of wall clock over twelve jobs**, 396 MB of source and 297 MB of compiled modules. The cube split the roadmap specified was measured dead (§ 2.2.1) and de Grey's own two-copy decomposition replaced it at 44× less cost. `lean4checker` covers everything the geometry and the proof structure rest on; **it does not cover the two certificates**, because replaying them repeats every kernel reduction single-threaded — see § 5. |
| **M07** ✅ | **Shrinking.** Re-verify smaller witnesses on the same infrastructure; automate vertex-deletion search. | *Landed 2026-07-30 (`plans/M07-shrinking.md`).* **`χ(ℝ²) ≥ 5` re-proved from witnesses of 510 and 553 vertices**, against de Grey's 1581 — axioms exactly `[propext, Classical.choice, Quot.sound]`, one certificate each, no decomposition. **1,413,841 and 1,104,106 propagation steps against M06's 34,169,571** — ~1 hour of processor time for both against 27.8 for one, and 23 MB of source against 396 MB. Two levers, both measured: naming one triangle's colours is worth **20×**, racing triangle × configuration × seed on *trimmed hint count* another **10.5×**. de Grey's own graph was measured **not to shrink** — its forcing halves are vertex-critical, so it goes 1581 → 1577 and stops. The smaller certificates are what finally make the independent-kernel replay affordable (§ 5). |
| **M08** ✅ | **Structure-aware geometry.** Difference-vector certificates: one squared length per *distinct edge difference*, and one big-integer subtraction per edge over packed coordinates. | *Landed 2026-07-31 (`plans/M08-structure-aware-geometry.md`).* All three witnesses re-certified through `DiffWitness`; `deGrey_valid`, `heule510_valid`, `heule553_valid` unchanged in statement. de Grey's geometry: **246.2 → 55.9 CPU s and 9 modules → 2**, memory per edge 4.55 → 0.27 MB. The roadmap's premise that the expensive term becomes *flat* in graph size was **measured false** — the difference count doubles when the construction doubles; what is stable is the ratio, ~118 : 1. Two instincts measured wrong and recorded: a flat giant-`Nat` table is free in the kernel and quadratic in the elaborator, and lane width is not free either. The milestone did **not** invalidate M06's certificates — de Grey's reach the vertex table without passing through his geometry — and the emitter now keeps every certificate's import closure free of geometry permanently. |
| **M09** ✅ | **Gadget algebra.** Graphs with designated vertex sets and *proven* colouring properties, plus composition lemmas — so search runs over properties rather than vertices. Colour-permutation symmetry lands here too. | *Landed 2026-07-31 (`plans/M09-gadget-algebra.md`).* A gadget is a `Bool` on port colourings plus the proof every proper colouring satisfies it; gadgets **intersect**, **widen**, **transport** along vertex maps, and arrive from an edge, a refutation, or another gadget. `not_colorable_of_gadget` replaces both `not_colorable_of_forcing` and `not_colorable_of_triangle_pinned`, and all three witnesses now go through it. **de Grey's second copy is derived, not asserted**: `deGrey_rotation` checks 791 exact coordinate identities and the second half's *geometry* and *colouring property* both follow — **half B's certificate deleted, 1,043 modules, 180 MB and 12.8 hours gone**, replaced by 95 CPU s. Colour symmetry is now one lemma at any number of ports, and the plan's claim that "the 4 is load-bearing" was **measured false**: stated relationally it needs no bound on the colour count at all.|
| **M10** ✅ | **Fractional bounds.** Fractional chromatic number machinery, and the best bound a finite dual certificate reaches at a size the kernel can check. ~~the 383/102 record~~ — **that target was measured wrong three ways** (see below). | *Landed 2026-08-01 (`plans/M10-fractional-bounds.md`).* **`χ_f(ℝ²) ≥ 65/18 ≈ 3.6111`**, axioms exactly `[propext, Classical.choice, Quot.sound]`, from a 63-point graph re-derived from Fisher and Ullman's core-and-spindle construction. Better than every *finite-graph* bound in Cranston–Rabern 2015, whose best was 1732/481 ≈ 3.6008 from a linear program with over 25,000 constraints — at a sixth the size, because the dual is separated by a SAT oracle instead of by enumerating maximal independent sets. No new certificate format: weights plus a **pruned kernel-run search**, 390,625 nodes against the graph's 10⁹-odd independent sets, 3.5 CPU min. `χ(ℝ²) ≥ 4` re-derived from the fractional bound alone — a third independent route to M03's rung. **Explicitly not a route to 6.** |
| **M11** ✅ | **The search instrument.** Everything the hunt needs, built before the hunt starts. Inventory in `plans/M11-search-instrument.md`. | *Landed 2026-08-01.* **Eight of ten inventory items; two carried, and one of those as planned.** The gadget algebra is indexed by the colour count — `K₅` refuted at four and surviving at five, both committed — and `Proper` is stated over any colour type at all. The terminal check ranges over **one colouring per colour-partition of the interface**, measured at **53–72×**, which moves the ceiling from seven interface vertices to **ten at five colours (4.3 min)**; at eight it previously did not finish. `Motion` is now a similarity rather than a rotation-about-a-point, so translations and reflections exist at all, compositions are `Motion.trans`, and a copy whose coordinates are *defined* as the image costs **nothing** to certify — against 791 identities and 95 s for de Grey's frozen table. Three tools: `profile.py` (a subgraph's whole port property), `minimise.py`, and `scan.py`, which **recovers de Grey's 791-point split in 3.6 s from the coordinates alone** and hands back both the motion and the vertex map. Axioms exactly `[propext, Classical.choice, Quot.sound]` throughout; 112 clean. **Not built: orbit construction, and a gadget catalogue from the literature** — though the *producer* landed, and with it the first gadget here that is neither an edge nor a certificate. |
| **M12** ✅ | **Candidate construction.** The rest of what the hunt needs. | *Landed 2026-08-01 (`plans/M12-candidate-construction.md`).* **`mycielski47_not_colorable_five` — the first statement in this project about *five*-colourings — on axioms exactly `[propext, Classical.choice, Quot.sound]`**, from a 47-vertex graph **defined in Lean rather than emitted**, refuted in 387,065 propagation steps: the number subplanning predicted before the module existed, to the digit. Its partner `mycielski47_colorable_six` is an existence claim in the opposite direction, derived from Mycielski's construction, guarding that the sixth colour is actually used. `Assembly` certifies many placed copies for the price of their seams — necessary, not optional: computed coordinates cost **0.33 CPU s/edge against 7.1 ms** for emitted ones, so the symbolic route is what makes the representation viable at all. `tools/construct.py` **rebuilds the Moser spindle from primitives**, checked by isomorphism; `tools/field.py` collapses arithmetic that was copy-pasted five times. **One search step: ~17 ms.** Axioms 120 clean. **Not landed: de Grey's seed set from primitives, an orbit primitive in the tool, and any gadget catalogue** — § 0(e) measured that one cannot be *harvested*, and this milestone did not construct one either. |
| **M13** | **The hunt.** Composition search for a 6-chromatic witness. | Honest report — including "not found". |

M01–M06 constitute rung B and are the publishable unit. M07–M12 is rung C, and M13 is rung D.

**M12 was split from the hunt on 2026-08-01**, the day M11 landed, and the reason is worth stating
because it is a rule rather than a scheduling preference. A search that stops to build a tool is a
search that stops — but the sharper problem is that a tool built *during* a stall is shaped by the
stall rather than by the problem, which is how a search comes to find what a bug allowed. So
everything we can name in advance is built in advance, and whatever gets built during the hunt is
then genuinely novel by construction.

Splitting it surfaced two gaps neither M11 nor its three modeling passes had noticed. **Nothing in
this repository constructs a candidate graph** — four generators, four hard-coded constructions, and
an M11 instrument that only ever *consumes* a graph. And **no theorem here has ever been about
five-colourings**: `coloringCNF 5` and `Colorable 5` appear zero times, so the cost of the question
rung D actually asks is unmeasured, in a project where refutation cost has already been measured
*non-monotone* in graph size. That measurement is M12's first item.

**M11's own miss, recorded.** Its terminal test read "every tool in that inventory built and
measured"; eight of ten were. Orbit construction was deferred deliberately (§ 1 of the subplan says
so, before any work started) and a gadget catalogue transcribed from the literature was not built at
all, because the papers whose gadgets we would transcribe do not distribute data — the same wall M10
hit. What ships instead is the catalogue the instrument produces.

**M10's target was wrong, and the roadmap said so for a week.** "The 383/102 record" is Exoo and
Ismailescu's 2017 bound: a 73-vertex graph published in *Geombinatorics*, which does not distribute
data, so the witness cannot be independently re-derived — and it has been overtaken three times
since, most recently by `χ_f(ℝ²) ≥ 4` (Matolcsi–Ruzsa–Varga–Zsámboki, arXiv 2311.10069), which goes
through the *geometric* fractional chromatic number and amenability of the plane's isometry group,
an argument no finite weighted graph can imitate. Certifying 383/102 would therefore have been
certifying neither the record nor anything re-derivable. What M10 ships instead is stated exactly:
the best bound a finite dual certificate reaches at a size the kernel can check.

**M11 was inserted 2026-08-01**, splitting the old M11 in two. The reason is a blocker found while
answering a question about symmetry: **the gadget algebra is written at four colours throughout, and
χ(ℝ²) ≥ 6 requires refuting *five*-colourings.** Everything under it — the encoder, the reduction,
the colour-symmetry lemma — is already general in the colour count; `Gadget.lean` alone is not. A hunt
started before that is a hunt asking the wrong question, and the cost model changes with it: the
composition's terminal check goes from `4^m` to `5^m`, and the colour-symmetry saving that M09
deliberately deferred goes from 24× to 120×.

**Reordered 2026-07-29**, after `plans/spike-kernel-lrat.md` and `plans/spike-geometry-scaling.md`.
Three changes, each forced by a measurement rather than a preference:

* **The checker moved from "tracked open work" to M05, ahead of the headline.** It was written off as
  needing its own soundness proof; core's generic `lratChecker` already kernel-reduces with an
  axiom-clean soundness theorem, so what is missing is throughput, and the big-integer design is
  measured at 430× core's. Ahead of the headline because the packed certificate format is shared work
  either way, so doing it first means rung B ships once and the trust ledger never grows 1024 entries
  only to have them removed.
* **Structure-aware geometry became its own milestone (M08)** rather than an optimisation inside the
  hunt. At 0.045 s/edge a 10⁵–10⁷-edge candidate costs hours to days of geometry *each*, which is
  fatal for a search. **The "flat in graph size" claim this bullet used to make is false** and M08
  measured it so: the distinct-difference count doubles when the construction doubles, and what is
  stable is the *ratio* — ~118 : 1 across de Grey's whole build. The cost stays linear in graph size
  with a constant an order of magnitude smaller, which is the difference between days and hours per
  candidate rather than between linear and constant. It also did not have to change the edge list's
  shape: the difference indices ride alongside as a separate list.
* **Gadget algebra became its own milestone (M09)** rather than a bullet inside the hunt. It is the
  actual bet on rung D: de Grey, Exoo–Ismailescu and Parts all reason over gadgets with colouring
  properties, informally. Making composition a theorem is what turns the search space from vertices
  into properties, and it is the one advantage here that is not shared with everyone who already
  tried and stalled. **It paid before the hunt started**: de Grey's second certificate — 12.8 hours
  and 1,043 modules — turned out to be his first one transported along a rotation.

**One cost of the freeze, recorded rather than paid.** `Instances/DeGrey/Split.lean` sits upstream of
1,222 certificate modules, and its prose still names `not_colorable_of_forcing`, a theorem M09 deleted
in favour of the general composition. Correcting a comment there costs ~15 hours of kernel time, so it
is not corrected. The theorem it should name is `HadwigerNelson.not_colorable_of_gadget`.

## 5. Trust

The de Bruijn criterion, operationalized. Audited by `scripts/Axioms.lean` at every milestone.

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **purchase — recorded below, per declaration** |

**Grep for the right name.** At toolchain v4.32.0, `native_decide` mints a *per-declaration* axiom
and `Lean.ofReduceBool` does **not** appear in `#print axioms` at all:

```
'foo' depends on axioms: [propext, Classical.choice, Quot.sound, foo._native.native_decide.ax_1_1]
axiom foo._native.native_decide.ax_1_1 : decide (…) = true
```

An audit that looks only for `Lean.ofReduceBool` passes a native purchase in silence. Found
2026-07-27; the audit now greps for `native_decide.ax`.

### The purchases, as of M04

Five declarations, all in `Instances/SpindleBound.lean`, all buying the same thing: the evaluation
of `LRAT.check` on a CaDiCaL certificate.

| Declaration | Axioms bought | Why |
|---|---|---|
| `moserSpindle_cnf_unsat` | `ax_1_1` | route B, the monolithic certificate |
| `moserSpindle_not_colorable_three_lrat` | (inherits) | route B's conclusion |
| `moserSpindleCubes_unsat` | `ax_1_1` … `ax_1_9` | route C, one per cube |
| `moserSpindle_not_colorable_three_cubes` | (inherits) | route C's conclusion |
| `four_le_chromaticNumber_plane_certified` | (inherits) | route C composed with the geometry |

**M04 added no purchases.** The geometry of de Grey's 1581-vertex graph — the larger of the two
computations the project rests on — is entirely kernel-checked: `deGrey_valid` reports `[propext,
Quot.sound]`. Every native axiom in the project is still one of the ten below.

**M05 added no purchases either, and it is the milestone that makes the remaining ten removable.**
Nine declarations from `Sat/{Mask,ClauseTable,MaskCheck}.lean` are now in the audit's clean section,
`maskCheck_sound` among them. Nothing above depends on them yet — M06 is where the ten purchases
below are meant to disappear, and until that lands they are still in the ledger.

**M09 added no purchases either, and the one it most mattered for is `deGrey_rotation`** — 791 exact
coordinate identities that are now the sole evidence for de Grey's second copy. A native purchase
there would move the construction's central fact out of the kernel's reach; it reports exactly
`[propext, Classical.choice, Quot.sound]`.

**M06 added no purchases, and the headline has none.** `chromaticNumber_plane_ge_five` depends on
exactly `[propext, Classical.choice, Quot.sound]`. The ten purchases below are still in the ledger
because the Moser spindle's certificate routes still exist as cross-checks of the encoder — they buy a
bound that `four_le_chromaticNumber_plane` also proves without them, which is the point of proving it
three ways.

**And the sentence this section carried from M03 to M05 was wrong.** It said χ(ℝ²) ≥ 5 would ship
carrying one native-evaluation axiom per certificate-backed declaration, as though the choice were
kernel-versus-compiler. It was not: at the scale the cube split needed, the certificate is ~4 GB of
embedded data and **Lean will not elaborate it either way** (§ 2.2.1). Compiled evaluation checks a
term the elaborator has to accept first. What made the milestone possible was not the checker and not
the trust position — it was finding a proof 44× smaller.

**The headline bound buys nothing.** `four_le_chromaticNumber_plane` goes through route A —
`decide +kernel` over all `3 ^ 7` colourings — and reports exactly `propext, Classical.choice,
Quot.sound`. The certificate routes exist beside it as cross-checks, and every one of them is a
theorem route A also proves. That will not be true at M05, where route C is the only route.

**Two ledgers, and the gate compares them.** Each purchasing declaration opens its docstring with
`**Trust purchase: native evaluation.**` (the source-side ledger, `grep -rn "Trust purchase"
Proofs/`), and each is listed under the `PURCHASED` banner in `scripts/Axioms.lean` (the
environment-side ledger). `scripts/axioms.sh` extracts both and fails on any disagreement — a
purchase with no docstring warning, or a docstring warning about a purchase no longer made.

Independently re-checked: `scripts/lean4checker.sh` replays `Proofs` through lean4checker's separate
kernel. Green at M04 — which means de Grey's 7877 exact distance identities have been recomputed by a
second kernel implementation, not just the one that built them.

**Scale is the limit, and M07 is what moves it.** Replaying a certificate repeats every propagation
step, single-threaded, in one process that cannot be split. At M06's **34.2 × 10⁶** steps — **18.4 ×
10⁶ after M09 deleted the second certificate** — that is another ~15 hours, and it has never been run
to completion here — so for the de Grey witness, the
independent-kernel claim covers the geometry, the soundness proofs and the composition, and *not*
those steps. State it that way and no other way. At M07's **1.4 × 10⁶** steps the same replay finishes, and
**it has been run**: 2026-07-31, 214 modules OK — 100 for the 510-vertex witness, 101 for the 553, and
the 13 shared modules beneath them. So for those two witnesses the independent-kernel claim covers
**everything this repository contributes**, propagation steps included. Mathlib is trusted as built,
which is the same scope the M04 claim had. That is the main thing the smaller witnesses buy, and the
reason they are in the repository rather than being a footnote about a smaller number.

**But the independent replay cannot see a native purchase, and the claim must not be stated as if it
could.** `native_decide` records its result as an **axiom**, and an axiom is accepted by every kernel
by definition — that is what an axiom is. So lean4checker verifies everything *except* the native
steps, which it takes on faith. "Replayed through an independent kernel" is therefore a claim about
the kernel-checked part only. Say it that way.

### Why the purchase sits on the worst possible claim

The project rests on two computations, and they are not equally checkable by a human:

* **Every listed edge is exactly one unit long.** If this is wrong it is *detectable* — pick three
  edges, compute them in any computer-algebra system, and the error surfaces. Errors here do not hide.
  This half is kernel-clean anyway.
* **No `k`-colouring of this graph exists.** If this is wrong it is *not* detectable. It quantifies
  over `4^1581` possibilities — a 952-digit number. There is no spot check, no partial verification,
  no eyeball.

A certificate is precisely what makes the second claim checkable at all: it converts "no colouring
exists anywhere in that space" into "here is a finite chain of elementary deductions ending in a
contradiction". Checking that chain with a compiled program rather than the kernel gives back a good
part of what the certificate was for. **The native purchase lands on the one claim no human can
verify by inspection** — which is why it is a footnote for a known theorem and the entire objection
for a new one, and why M05 exists.

### What compiled evaluation actually trusts

Not just "more code" — there is a concrete hole. Lean permits a definition's *compiled* behaviour to
differ from the definition itself (`@[implemented_by]`, `@[extern]`); that is a legitimate feature. It
means native evaluation can return an answer the definition contradicts, anywhere in the dependency
chain. The kernel cannot be misled that way, because it only unfolds definitions. Beyond that hole:
the code generator, the C toolchain, the runtime and its GMP bindings, and the CPU — none written to
be a proof checker.

**The audit can stop auditing, and did.** At M04 `scripts/Axioms.lean` named a declaration that a
regenerated file no longer defined. Under `set -e` the failing command substitution aborted
`axioms.sh` with *no output and no visible failure*, so a piped invocation read as a pass. The
script now captures the status explicitly and reports it. A trust receipt that fails open is worse
than none, and this is the second instance of that failure mode in this project (the first: the
two-ledger comparison at M03, documented above as running when it did not).

Two `Bool`s carry the weight, and each has a kernel route and a native route:

1. **`UDCert.Valid deGrey`** — 7877 edge checks over a 16-dimensional ℤ-algebra. **Measured
   (2026-07-23): kernel-feasible, but only in chunks.** ~0.17 s/edge and memory roughly linear in
   the chunk size; a single `List.all` over all 7877 edges was still running at 5 minutes and 8.5 GB
   when aborted, while 514 edges take 87 s and ~0.85 GB. M04 therefore splits the check into ~16–32
   independent slices, which parallelise. No trust is spent — the chunks' conjunction is the whole
   theorem. Two representation findings fed this: indexed lookup costs the same as pre-resolved
   endpoint pairs (the tower arithmetic dominates, not the lookup), and multiplying by the radicand
   as a *scalar* rather than a ring element is a measured 1.67×.
2. **`LRAT.check π cnf`** — the certificate check. **Settled, 2026-07-27: it does not
   kernel-reduce, and the size of the certificate is irrelevant.** Measured on
   `⟨#[[(0, true)], [(0, false)]]⟩`, the smallest unsatisfiable CNF there is, with a one-action
   certificate: `decide` is stuck immediately (the elaborator will not unfold `@[irreducible]`
   well-founded definitions, and `Array.anyM.loop` is one); `decide +kernel` gets much further —
   it reduces `Array.any`, the `@[no_expose]` `Decidable (∃ v, VarMem v f)` instance, and
   `compactLratChecker` on trivial input — then sticks inside `Formula.performRupAdd` after ~40 s;
   `native_decide` succeeds instantly. Core's own `bv_decide` uses native evaluation for the same
   step, so this is the state of the art rather than a gap in our setup.

   **Superseded at M05, 2026-07-29.** That paragraph said χ(ℝ²) ≥ 5 would carry a native-evaluation
   axiom, because the kernel-only route needed a checker written to reduce plus its own soundness
   proof — "a milestone-sized undertaking, tracked as open work and not attempted". It was a milestone,
   it is M05, and it is done: `HadwigerNelson.maskCheck_sound` reports exactly `[propext,
   Classical.choice, Quot.sound]`, and its two hypotheses are closed `Bool`s the kernel decides. The
   shipped `LRAT.check` is still unreducible for the reason above; the project no longer routes through
   it. **The remaining question is throughput, not trust**, and M06 is where it gets answered.

`lean4checker` (independent kernel, via elan) re-checks at each milestone boundary.

Not trusted, and not on the critical path: `tools/*` (generators), CaDiCaL, the float grid used to
propose candidate edge pairs. Every claim they make is re-derived in Lean from the emitted data.

## 6. Defences against proving the wrong theorem

A green checkmark certifies exactly the statement written. The specific ways this project could
produce a meaningless one, and the specific countermeasure for each:

| Failure | Defence |
|---|---|
| `unitDistanceGraph` has vacuous `Adj` (e.g. `fromRel` collapsing) | `example : (unitDistanceGraph ℂ).Adj 0 1` proved; a non-adjacency proved too |
| CNF encoding subtly wrong, making *any* graph "unsatisfiable" | ✅ M03: spindle proved non-3-colourable by `decide +kernel` **and** by LRAT **and** by nine cube certificates, all agreeing; `exists_sat_coloringCNF_four` shows the same encoder **satisfiable** at four colours, from a real colouring |
| Encoder checked only against itself | ✅ M03: the spec `#guard`s in `Instances/SpindleBound.lean` evaluate the formula on **hand-written** assignments, not ones built by the module's own `ofColoring` |
| Certificate checker that accepts everything | ✅ M03: committed negative controls — a certificate filed against the wrong cube fails, and no certificate refutes the satisfiable four-colour formula. ✅ M05, at the checker we wrote ourselves: a **satisfiable** formula that the clause table genuinely agrees with is refused, with the fault pinned by `#guard_msgs`; so is a clause citing itself as its own justification |
| A hypothesis of the checker's soundness theorem is decorative | ✅ M05: dropping the non-tautology hypothesis makes `propagate_prop_sound` **false**, and the countermodel is committed as an `example : ¬ …`. A build failure cannot establish this; only a countermodel can |
| The checker's answer and its diagnosis drift apart | ✅ M05: the `Bool` is *defined* as "the diagnostic reports no fault", so they are one computation. M04's arrangement — two functions related by a proved lemma — is the weaker version of this |
| The five-colour question is asked at four colours by accident | ✅ M12: `mycielski47_not_colorable_five` is paired with `mycielski47_colorable_six`, an *existence* claim in the opposite direction — and the six-colouring is derived from Mycielski's construction, with a guard that the **sixth colour is actually used**, so a 6-colouring that is secretly a 5-colouring goes red |
| A generated graph is not the graph the construction describes | ✅ M12: the Mycielski witness is *defined* in Lean, not emitted, and every rung of the ladder is pinned (2/1, 5/5, 11/20, 23/71, 47/236); an index-bound guard makes the `Fin` embedding a proved no-op rather than a silent vertex-merge |
| A placed copy is certified for a copy that was never placed there | ✅ M12: `Assembly` derives every copy's coordinates from the base and the motion rather than reading emitted ones, so the geometry and the colouring transport are the *same map*, `Assembly.embed`. The demo assembly's validity is proved twice — by reduction and through `valid_of_cross` — so the payoff theorem is not the only witness to its own claim |
| The seams of an assembled candidate fail silently | ✅ M12: `AssemblyDiagnose` renders which seam failed *by copy and base vertex*, with the squared distance found beside the one a unit edge would have, and both directions are pinned with `#guard_msgs` — an empty report for a good seam, a named copy for a bad one |
| The packed certificate format is silently trusted | ✅ M05: the decoder is a **parameter** of the checker and soundness is proved for every function of its type, so a decoding bug is a failed check by construction, not by review |
| A cube certificate silently attached to the wrong cube | ✅ M03: the cube list is supplied literally and tied to `allCubes` by `rfl`, so a misfile is a type error naming the cube as a readable literal; `#eval badCubes …` reports every wrong *and* every missing index |
| A certificate segment attached at the wrong watermark, so the 2265-segment chain silently skips work | ✅ M06: segment *k* concludes at the watermark segment *k+1* assumes, so the composition **typechecks only if they chain** — the emitter's only arithmetic is checked by the elaborator, and a mismatch names both segments |
| The two forcing lemmas proved about the wrong graph — e.g. a half that is not a subgraph | ✅ M06: the halves are *contiguous segments* of `deGrey.edges` by construction, so the inclusions are `List.mem_append_left`; and the shape of the split (3938 + 3938 + 1, one shared vertex, the joining edge in neither half) is asserted by `#guard` on every build |
| The colour-symmetry step used to "prove" more than it can | ✅ M06: relabelling requires an **injection**, and that hypothesis is what the theorem consumes; a merging relabel does not apply. The SAT-satisfiable case (endpoint at the shared vertex's own colour) is recorded beside the lemma as the reason it is an equality and not something stronger |
| The whole bound rests on one graph, so one systematic error sinks it | ✅ M07: `χ(ℝ²) ≥ 5` is proved from **three** graphs sharing no vertex, no edge and no certificate — de Grey's 1581, and Heule's 510 and 553. What they share is this project's *encoding* and its *checker*, which is precisely what no theorem here can validate; a fault in either would have to certify three unrelated graphs |
| The CNF encoding of "no 4-colouring" is subtly wrong, so every theorem is about the wrong formula | ✅ M07: `coloringCNF 4 553 E` is **clause-for-clause identical** to Heule's independently authored `553-4.cnf`. Two encoders written without reference to each other, agreeing exactly |
| A certificate silently attached to the wrong witness | ✅ M07: was a *procedure* (regenerate and watch it go red), now an obligation — `halfA_table_refuses_halfB_cnf : halfATable.agreesWithCNF halfBCnf = false`, kernel-decided on every build. `agreesWithCNF` alone is consistent with a table that matches everything, which would certify anything; the pair is what makes either mean something |
| A negative control that perturbs nothing, and therefore guards nothing | ✅ M07: the geometry control moves a vertex and demands the check name its edges. Written first as "move vertex 0 to the origin", it silently *passed* — in both new witnesses vertex 0 **is** the origin. Now vertex 1 is collapsed onto vertex 0, and the failure of the first version is recorded beside it |
| The difference table's *keys* are wrong, so the geometry certifies a different graph | ✅ M08: the key list is walked **against the certificate's own edge list**, in lockstep, and a length disagreement is a `false` with a named position — never a `zip` that truncates. The committed control puts a key on a unit-length difference that is not that edge's, and the check names the edge |
| The packing collapses two distinct points, so the geometry check proves nothing | ✅ M08: `Packable.pack_inj` is proved, and its digit bound is *known load-bearing* — the two counterexamples that break it at `M = 4` are committed as `#guard`s beside the lemma. Every certificate check re-verifies the bound for every vertex |
| The Python generator and Lean silently disagree about the packing convention | ✅ M08: both assert the same 301-digit constant — the packing of the point whose thirty-two digits are `1 … 32` in lane order. Lane width, lane order inside the tower, and `x`-before-`y` are fixed by that one number, and a generator that disagrees fails before it writes any data |
| The two tables are the same length but a different shape, so an index means two things | ✅ M08: `packOk` compares the split pivots node by node; a reshape is a `shape` fault, and the control that reshapes the packed table is committed |
| The rotation is asserted rather than checked, so the "second copy" is a different graph | ✅ M09: `deGrey_rotation` decides 791 exact coordinate identities in `ℚ(√3,√5,√7,√11)` — every point of the first copy against its claimed partner. The index map is a closed form, so there is no emitted table to be wrong; and `31² + (3√7)² = 32²` is checked as a field of `Motion`, without which `Motion.distSq_eq` is *false* and the committed countermodel says so |
| The transported gadget is attached to the wrong ports, so it constrains the wrong vertices | ✅ M09: `Gadget.transport` takes the port images as **pointwise equations** — for de Grey, `φ 14 = 14` and `φ 11 = 802`. A wrong image is a type error at the composition, not a silently different theorem |
| The composition "refutes" whatever it is handed | ✅ M09, sharpened at M11: dropping the joining edge leaves exactly one surviving pattern — *vertex 14, vertex 11 and vertex 802 all one colour* — and `deGrey_forcing_alone_admits` is that as a **theorem**, kernel-decided on every build. The same control at spec scale is `K₅` minus an edge, with the rendered survivor list pinned by `#guard_msgs` |
| A transported gadget collapses an edge, making a colouring "proper" that is not | ✅ M09: `Gadget.transport`'s hypothesis is `Adj`, which carries distinctness, so a collapsing map cannot satisfy it. For de Grey that distinctness is `deGreyPhiNat_inj`, proved by `omega` from the closed form — no data to check |
| The scale factor is cancelled unsoundly, since `Q4` is not known to be a domain | ✅ M09: it is cancelled as a **natural number** via `NatCancel`, true of the tower because its leaves are `ℤ` and every level is componentwise. Nothing anywhere assumes `Q4` has no zero divisors |
| The pruned search skips a subtree it has not bounded, so a heavy independent set is never seen | ✅ M10: the prune's own hypothesis is what the PRUNE case of `noHeavy_sound` consumes. Weakening it from `wt + rem ≤ D` to `wt ≤ D` makes the soundness proof **stop compiling**, at that one step and no other; removing either remaining hypothesis also fails |
| The weights are certified against a mask that invents edges, so genuinely independent sets are skipped | ✅ M10: `nbrMask_and_two_pow_eq_zero` proves fidelity in the one direction that matters — a set bit is a listed pair. An *under*-reporting mask is sound (the search explores sets that are not independent and answers `false` more often); an over-reporting one cannot pass |
| The weight bound's diagnosis disagrees with the bound itself | ✅ M10: `findHeavy_isNone` is a **theorem** — the diagnostic reports nothing exactly when the check says `true`. And the set it reports is re-checked for independence and weight by `#guard`s that have never heard of the search |
| The fractional chromatic number silently defined as the ordinary one | ✅ M10: `C5_fractional` pins `χ_f(C₅) = 5/2` — **not an integer** — proved in both directions, the upper one by an explicit 2-fold 5-colouring that is also the model showing nothing above is vacuous. Its negative control is that the independence bound `2` is attained, so a certificate at `1` would be false |
| The terminal check ranges over one colouring per partition, so a colouring it never enumerated slips through | ✅ M11: soundness is *not* a property of the enumeration alone — it needs a proper colouring to stay proper when its colours are renamed. `not_colorable_of_gadget` relabels the colouring by `σ⁻¹` and hands *that* to `sound`; deleting the relabelling breaks the proof at exactly that step, watched |
| The enumeration of colour-partitions silently skips one | ✅ M11: pinned in **both** directions at four ports and five colours — no two representatives are the same partition, and `∀ q, (canonPatterns 5 4).any (samePattern · q)` is decided over all 625 patterns. Making the enumeration unable to open a fresh colour breaks the proof in both branches *and* both rendered-output controls |
| A "motion" that is not one, so a placed copy is a different graph | ✅ M11: three similarity laws, and **each has its own countermodel** — a stretch (`col₁`), a projection onto a line (`col₂`), a shear (`orth`) — each an `example : ¬ ∀ …` stating the theorem with exactly that law deleted. A build failure could not establish any of this |
| A placed copy's geometry asserted rather than derived | ✅ M11: `UDCert.validOn_map_of_scaling` derives it from *one* hypothesis about the map — that it multiplies every squared distance by a constant — with **no per-vertex and no per-edge check**. The copy's coordinates are `rfl`-equal to the image, so there is nothing to assert |
| Vertex list degenerate (all points equal / empty) | vertex count and edge count asserted by `#guard`; a `#eval` of several distances |
| Wrong direction of the bridge (proving `Sat → Colorable`) | the reduction only ever consumes `Colorable → Sat`; stated with `¬` on the outside and read aloud |
| `χ ≥ 5` stated as `χ > 5`, `≤`, or over `ℕ` with truncation | statement in `ℕ∞`, cross-checked against `chromaticNumber_le_iff_colorable`, plus a deliberately-failing variant kept in a comment |
| Certificate from a *different* CNF than the one we reason about | the CNF is defined once in Lean; the DIMACS handed to CaDiCaL is printed **from that Lean definition** via `Std.Sat.CNF.dimacs`, not re-derived in Python |

That last row is a hard rule: **the Python side never authors the CNF.** It authors candidate
geometry only.

## 7. Honest failure modes

Stated up front, per doctrine, and to be reported as-is:

- **The search re-finds rung A's witness and cannot reach rung B's.** Measured at M12 after landing:
  blind breadth-first search over the constructor's moves finds the **Moser spindle at depth 1 in
  under a second** (verified isomorphic), and in 358 s over 1,961 distinct graphs finds **nothing
  needing five colours** — then *exhausts*, frontier empty. Spindle-from-seeds is a small closed
  family, not a space wanting more budget. Since de Grey's witness is itself an orbit construction,
  the missing move is plausibly the orbit primitive, which `construct.py` does not have.
- **Nothing this project owns forces any port property at five colours — measured at M12, and it is
  the hardest thing on this list.** Zero of 48 non-adjacent port sets across four graphs, and of
  16,657 exact distance classes the only one that constrains a pair is the unit distance itself.
  The four-colour control fires (5 of 5 patterns refuted on a graph with no 4-colouring), so this is
  a fact and not a broken probe. The cause is structural: a graph comfortably `k`-colourable imposes
  nothing on scattered points, and every graph here is comfortably 5-colourable — de Grey's included,
  which is exactly 5-chromatic. **So a five-colour gadget catalogue cannot be harvested, only
  constructed**, and how tight a configuration must be before it forces anything at five colours is
  unmeasured. If it is beyond what a constructor reaches, M12 lands its instrument and says so.
- **Five colours costs one to two orders of magnitude more than four**, measured at M12: 227× on one
  fixed 47-vertex graph, 10–30× at matched size and matched criticality. The levers survive —
  naming a triangle's colours is worth 8.5–53×, and a triangle is the largest clique the plane
  permits — but M07's configuration race does **not** reproduce at gadget scale (1.00×). And all of
  this is measured on *proxies*: no 6-chromatic unit-distance graph exists to measure, structure
  buys orders of magnitude, so the figures are probably pessimistic for real candidates. That is a
  belief, not a measurement, and it is written here as one.
- **The 6-chromatic witness may not exist, or may be astronomically large.** χ could be 5, 6, or 7.
  Polymath16 and strong SAT researchers stalled at exactly this point. Rung D is a genuine gamble;
  rungs A–C are not, which is why the ratchet is built the way it is.
- **~~The witness is de Grey's 1581-vertex graph, and a smaller one would not obviously be cheaper.~~**
  **Measured at M07, and the doubt was right in kind and wrong in size.** Both effects are real:
  a smaller graph *is* less constrained and harder per vertex — Heule's 510-vertex witness costs
  **28% more** propagation steps than his 553-vertex one — but that is swamped by the effect of
  leaving de Grey's construction at all. His graph has **no monolithic refutation** (six solver
  configurations with proof logging, six without, and a 64-cube split: none terminate), because two
  loosely-coupled copies joined at one vertex is exactly the shape that defeats a CDCL solver while
  handing a human a two-line argument. Heule's minimised graphs refute in **two seconds**. Net:
  1,413,841 steps against 34,169,571, so **smaller was 24× cheaper**, for reasons that have little to
  do with size. What remains true, and is the part to carry to rung D: **refutation cost is not
  monotone in graph size**, and optimising for "a solver can chew through it" optimises a route that
  is already dead one rung up.
- **The certificate check is not kernel-reducible *as shipped*, and M05 replaced it.** The shipped
  `LRAT.check` is blocked by exactly one thing — `Std.HashMap` inside `DefaultClause.ofArray`, whose
  bucket indexing computes on `USize`, whose width is an `@[extern] opaque` the kernel cannot unfold.
  `Sat/MaskCheck.lean` is the replacement: proved sound, kernel-decidable, axiom-clean. **What remains
  is a cost risk, not a trust risk.** The projection is 5.4–9.0 hours of processor time across 96
  independent cubes; it is a *projection*, from a per-step cost model measured on synthetic data, and
  the two numbers it rests on that are still unmeasured are the real distribution of learned-clause
  lengths and whether a better cube split exists. Both push the total, and only one direction is
  bounded: if the split is worse than greedy-by-degree suggests, this grows. The abandon threshold is
  restated in `plans/M05-kernel-checker.md` § 1 — projected processor time over ~40 hours, or a
  re-checker on 4 cores that cannot finish overnight.
  **An earlier version of this bullet quoted 0.35 ms/step and 1.26 hours. Both were wrong** — measured
  without the clause-table lookup, which is where the time actually goes. Do not quote them again.
- **~~The gadget algebra is written at four colours, and rung D needs five.~~** **Fixed at M11.** The
  colour count is now the first index of `Gadget`, `Proper` is stated over an arbitrary colour type,
  and `K₆` at five colours is a committed spec witness. Recorded as a **miss**, because it was not
  noticed during M09's three modeling passes: every witness in this repository refutes 4-colourings,
  so nothing in the milestone's own work pushed on the number, and a design nobody exercises at the
  next value is a design nobody has checked.
- **The gadget algebra has been exercised on constructions that already existed, not on a search.**
  M09's composition theorem covers de Grey's two-copy argument and Heule's triangle argument, and it
  deleted a certificate. That is evidence it is the right shape, not evidence it scales. **The cost is
  now measured rather than projected** (`plans/M11-search-instrument.md` § 0): the terminal check runs
  over one colouring per colour-partition of the interface, at ~2–3 ms each, which puts the ceiling at
  **ten interface vertices at five colours — 4.3 minutes.** Without that restriction the ceiling is
  seven, and eight does not finish at all. Ten is enough for the compositions we can currently
  imagine and it is not obviously enough for the ones a search will propose; that gap is the honest
  statement of the risk.
- **No theorem in this project has ever been about a five-colouring, so the cost of rung D's actual
  question is unmeasured.** Found 2026-08-01 while splitting M12 out of the hunt: `coloringCNF 5`
  and `Colorable 5` appear **zero** times across the repository. M11 made the question askable and
  committed one spec witness that exercises the colour index — the complete graph on five vertices,
  refuted at four colours and surviving at five — but nothing has been refuted at five. Every step
  count, certificate size and processor-hour figure recorded here is a four-colour figure, and the
  one thing already established about this cost is that it is **not monotone in graph size** (M07:
  Heule's 510-vertex witness costs 28% more than his 553-vertex one). At five colours the regime
  changes again in a direction nobody here has sampled, and the satisfiable direction — which is a
  search's inner loop — is equally unmeasured. It is M12's first item for that reason.
- **Our marginal edge at rung D is unproven at this scale.** Persistence, verified modular
  composition, and no fatigue in a gadget search are real advantages, but nobody has demonstrated
  they are enough here.
