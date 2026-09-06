# FS-11 — Lift a 6-critical subgraph of a finite plane to the field (STUB, 2026-09-06; minted at the M58 close)

*The constructive face of the finite-plane bound. Read beside this: `plans/M58-field-sieve.md` (the reduction theorem, the
spectral table, the field map), `CLAUDE.md` G43/G44, `Proofs/HadwigerNelson/UnitQuadrance.lean` (`UDCert.drawing_adj` —
the reduction as a graph hom), `data/fplane/spectral-below-600.json` (χ(UD(𝔽₁₃₁,2)) ≥ 8), `reference/Chat-analysis/analysis.txt`
("design in the finite plane, lift to the field" — the web session's speculative paragraph, here made precise).*

## 1. Mission context, in plain language

The reduction sends a unit-distance graph G in F² to a subgraph of the finite plane UD(𝔽_p, 2), and homs run the wrong way
for lower bounds: χ(G) ≤ χ(image). But a **lift** runs the right way. Let H be a subgraph of UD(𝔽_p, 2) — say a 6-critical
one, which exists at every p ≥ 59 because the plane there is ≥ 6-chromatic (≥ 8 at 131). A lift of H is a choice, for each
vertex v of H, of a point x_v ∈ F² in the residue class of v (with respect to the degree-one prime 𝔭 above p) such that every
edge uv of H is a unit edge: |x_u − x_v| = 1. Then the x_v are distinct (their residues are), H is isomorphic to a subgraph of
the unit-distance graph on {x_v}, and **χ(F²) ≥ χ(H) ≥ 6**. A lifted 6-critical subgraph of UD(𝔽₁₃₁, 2) into de Grey's field
would be a 6-chromatic unit-distance graph — the object of the whole hunt — found by solving a diophantine system whose
combinatorial part (which edges) is decided in the finite plane first, with no geometry.

The honest difficulty is in the count: a 6-critical graph has |E| ≥ (5/2)|V| edges and the lift has 2|V| unknowns in F
(each x_v is free within its residue class — the class is a coset of 𝔭 × 𝔭, an infinite set), so the unit-edge system is
overdetermined by a factor 5/4 and generically has no solution; a solution needs the finite plane's structure to be the
shadow of real structure (the residues of a genuine unit-distance configuration). The place to look is therefore not an
arbitrary 6-critical subgraph but one INSIDE the shadow of a known object (D7: the 1581's directions cover 55 of the 66
residue pairs at 131; its gen-1 closure all 66): the shadow's vertices that are residues of actual closure points already
lift, and the question becomes whether the closure's points contain a 6-critical subgraph of the plane — which is exactly
"is the closure 6-chromatic", decidable by the M31 machinery, and known NO for the gen-1 closure (k = 5 SAT in 1.14 s). So the
lift problem is the question of which NEW points, in which residue classes, a closure would need — a design vocabulary.

## 2. What we know

| fact | where |
|---|---|
| χ(UD(𝔽_p,2)) ≥ 6 for p ≥ 59; ≥ 8 at 131; the plane at 131 has 17,161 vertices, degree 132 | `data/fplane/spectral-below-600.json` |
| the reduction is a graph hom for every valid certificate (kernel) — a lift's edges reduce to the plane's edges by construction | `UnitQuadrance.lean` |
| the 1581's shadow at 131 covers 55 of 66 direction classes; the gen-1 closure's all 66, but the closure is 5-colourable | M58 §R3; M31 |
| a unit-distance graph's lift into a fixed residue class per vertex: each vertex free in 𝔭² (a 2-dimensional 𝔭-adic ball); each edge one quadratic equation | derivation §1 |

## 3. Derivations first

**D1 — the smallest 6-critical subgraphs of UD(𝔽₅₉,2) and UD(𝔽₁₃₁,2).** The plane at 59 is ≥ 6 by Hoffman with margin
0.022 — its 6-critical subgraphs may be large (Hoffman is tight only for very regular objects). Compute: the 1-minimal
5-refusing subgraphs by the M42/M43 shrink machinery on the plane (vertex-transitive, so start from balls in the Cayley
metric). Size, symmetry, and whether they are contained in a shadow of any object we hold.

**D2 — the lift as a system.** For H with vertices in 𝔽_p², unknowns x_v ∈ F² with x_v ≡ v (mod 𝔭): write x_v = v̂ + p·y_v
with v̂ a fixed lift and y_v ∈ O_𝔭²; the unit condition |x_u − x_v|² = 1 becomes a quadratic in y. Count solutions in the
𝔭-adic completion first (Hensel: a solution mod 𝔭² that is nonsingular lifts) — the LOCAL obstruction is decidable and
cheap, and a system with no 𝔭-adic solution has no global one. Register: most 6-critical H fail already locally.

**D3 — which H are shadows of real unit-distance graphs.** Necessary: H's edge directions (residues) must be liftable to
unit vectors of F² — every direction of UD(𝔽_p,2) is (the circle residues are exactly the residues of unit vectors, by
the theorem's own argument at p where the field has enough unit vectors — check which of the 66 classes at 131 are hit by
directions of the closure: all 66). Sufficient conditions are the content.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 at 59 and 131 (the plane's 6-critical cores); D2's local test implemented | days |
| A | the local (𝔭-adic) lift test on every core found; a global lift attempt on any core that passes locally (a polynomial system over the field — sympy/Gröbner at small |V|, or the M49 descent's machinery: fix the edges, search points) | days to weeks |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the smallest 6-critical subgraph of UD(𝔽₁₃₁,2) has > 100 vertices | medium |
| P2 | no 6-critical subgraph of UD(𝔽₁₃₁,2) passes the local lift test into de Grey's field | medium-low |

## 6. Failure and pivot clauses

A core that lifts globally: HALT AND VERIFY — it is a 6-chromatic unit-distance graph (the jackpot clause verbatim).
All cores failing locally: the finite planes' 6-forcing is not the shadow of any unit-distance forcing at that prime — record,
and the shadow sieve (D7) becomes the only bridge left between the planes and the hunt.

## 7. Bearing on 6, honestly

Medium. It is the one route the pivot opens that could PRODUCE a 6-object rather than exclude fields; its odds are set by an
overdetermined diophantine system, and D2's local test says early whether there is anything to search.

## 8. Addresses

`tools/fplane.py` (`shadow`, `chi`), `tools/celllat.py` (the 1-minimal shrink, the ball machinery), `tools/closure.py`,
`Proofs/HadwigerNelson/UnitQuadrance.lean`, `plans/M58-field-sieve.md`.

## §H. Handoff for the session that opens M59 (written 2026-09-06 at the M58 close, before Kooshi's compaction)

**Kooshi's decision:** M59 = this stub (FS-11, rank 1 of `plans/FRONTIER-STUBS.md`). Do NOT re-decide it. **And the goalposts
moved the same evening** (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §1, §6): a lifted 6-forcer, if one lands, is a stepping stone —
the milestone continues until the algebraic reason it forces six is a derivation for a class; the write-up is the derivation.

**Read, in this order:** (1) `CLAUDE.md` § The mission (the trigger as amended 2026-09-06) and § Frontier — the M58 paragraph,
ledger row 53, G43's amendment, G44; (2) `plans/PROGRAMME-ALGEBRAIC-PROOF.md` (the programme and the honest assessment);
(3) this stub §1–§8; (4) `plans/M58-field-sieve.md` §S1–§S2 (the spectral facts and the K-field theorem), §M1 (the kernel's
shape: `UDCert.drawing_adj` is the reduction any lift inverts), §R; (5) `tools/fplane.py`'s docstring, `self-test`, and the
`shadow` subcommand (the direction residues the lift must respect); (6) `tools/celllat.py`'s ball/shrink machinery (M42/M43:
the 1-minimal core extraction the finite plane's 6-critical subgraphs need).

**Then WORKFLOW step 3 onward, no shortcuts:** `git mv plans/STUB-finite-plane-lift.md plans/M59-finite-plane-lift.md` (keep the
FS-11 row in `FRONTIER-STUBS.md` with status "opened as M59"); write the subplan — **D2 derived first** (the lift as a system:
x_v = v̂ + p·y_v, the unit condition as a quadratic in y, the local Hensel test stated exactly, and the COUNT: |E| ≥ 5|V|/2 equations
in 2|V| unknowns — say what structure a solvable instance must have before searching for one), D1's cost priced (the plane at 59
has 3,481 vertices, degree 60; at 131, 17,161 vertices, degree 132 — a 1-minimal 5-refusing subgraph by the M43 ball ladder, with
the vertex-transitivity used to centre balls at the origin), the shadow constraint stated (a liftable H into de Grey's field must
have its edge directions among the 66 classes the closure hits — all of them at 131, so no constraint there; at 479 only 210 of
240), the kernel skeleton (the lift as a `UDCert` whose `drawing` reduces to H: `UDCert.drawing_adj` gives the hom for free, and
"H ≅ a subgraph of the lift" is `edgeGraph` inclusion — sorry at the leaves), the instrument (`tools/fplane.py lift` or a new
`tools/fplift.py`: `cores --p P --k 5` (the 1-minimal cores), `local --core FILE --field …` (Hensel), `lift --core FILE` (the
global search)); commit; the three modeling passes as FRESH Skill invocations, each committed; then implement. Register P1–P2
as they stand unless a derivation settles one first.

**First things to read from disk:** the M58 solves left running — `build/m58/chi-p{23,31,43,47}-k5.log` (UD(𝔽_p,2) at five
colours; walls 14,000 s; re-run `python3 tools/fplane.py chi --p P --k 5 --pin-clique --wall 14000` if lost) and
`build/m58/shadow-1581-p131-k5.log` (the 1581's 55-direction shadow at five colours, a scratch runner; the record is written by
`python3 tools/fplane.py shadow --degrey --p 131 --k 5 --wall 14000` — run it if the scratch died); record each in
`data/fplane/` and in `plans/M58-field-sieve.md` §R3 as an addendum (P1 at 23, P4's re-registration at 31/43/47, P7); and the M55
108 asks (pid 839605, `build/m55/ask-depth2.log` → `data/m55/ask-W-plus-cross-depth2-k5.json`, exit 3 = jackpot; ~15 h at the
close): record as an M55 §R6 addendum and an FS-3 datum, then move `data/m54/critical-W-plus-cross-depth2.json` into `data/m55`
and commit.

**Standing rules that bit M58:** kill by PID (anchor `^python3`, never `pkill -f` a pattern matching the shell); `build/` is
gitignored — scripts in `tools/`, records in `data/`; ALWAYS `./scripts/build.sh`; one heavy job at a time; instantiating a
`∀ e ∈ es` fact against tower arithmetic needs the pair written out (`hval (i, j) hij`, never `hval _ hij` — a 400k-heartbeat
unification otherwise); pysat's wall does not interrupt big instances — use the `cadical` binary under `timeout`; a planted
control can itself be wrong (M58's odd-cycle shadow) — read a RED self-test as information before "fixing" the code; every
"sealed"/"open" verdict names its prime and its record; the M02 tower's √7 parts are zero on Heule-510 (`heule510_coordsIn_sevenFree`).

## §S. Subplan (M59 opened 2026-09-06, on Kooshi's go after his compaction; WORKFLOW step 3)

### §S0. The state on disk at opening (read first, as §H said)

* The four planes at five colours (23, 31, 43, 47; pids 1617655, 1645642/44/43) and the 1581's 55-direction shadow at 131
  (pid 1645673) were still running at opening — 1.5–2 h into 14,000-s walls; their records land in `data/fplane/` when they
  finish and go into `plans/M58-field-sieve.md` §R3 as an addendum. The M55 108 asks (pid 839605) at 15.6 h. Nothing to record yet.
* The stub renamed; the FS-11 row marked "OPENED as M59"; the references in the programme document, the roadmap and
  `CLAUDE.md` § Paths forward repointed.
* Two grokking probes run before anything was written (`build/m59/`, scratch): (i) the 1581's reduction at 131 is
  infinitesimally rigid — rank of its rigidity matrix mod 131 is 3,159 = 2·1581 − 3, stress space of dimension 4,718 — and
  NOT injective: the 1,581 points fall on **1,547** residue classes (34 collisions: pairs of vertices whose difference lies in
  𝔭 × 𝔭); (ii) torus-symmetric sphere-set subgraphs of UD(𝔽₁₃₁,2) (the origin plus whole spheres of chosen quadrances — the
  finite-plane form of the ring vocabulary G4) have Hoffman floors of only 2.0–2.8 at up to eight spheres, 2.26 for the
  seam-like set {1, 3, 4, 9, 12, 1/3, 4/3, 5/3}: the plane's six-forcing is a large-scale effect, not a small-core one.
  Both change the registrations below (§S6).

### §S1. D2 derived — the lift as a system, the obstruction tower, and the dichotomy for rigid frameworks

**The setting.** 𝔭 a degree-one prime of a real number field F above p ≡ 3 (mod 4), so F_𝔭 = ℚ_p and O_𝔭 = ℤ_p; the reduction
of an integral point of F² is its image in 𝔽_p². A **lift** of a subgraph H ⊆ UD(𝔽_p, 2) is a map v ↦ x_v ∈ ℤ_p² (local) or
∈ O_𝔭² ⊂ F² (global) with x_v ≡ v (mod p) and |x_u − x_v|² = 1 for every edge uv of H. A global lift is a local lift; a lifted H
is a copy of H in F² (residues distinct ⟹ points distinct), so χ(F²) ≥ χ(H).

**The unit vectors.** 𝔽_p² ≅ 𝔽_{p²} = 𝔽_p(i) (−1 is a non-residue), quadrance = norm, and the circle C = {N = 1} is the cyclic
norm-one group of order p + 1. Over ℤ_p the same: ℤ_p[i] is the unramified quadratic extension's integers, its norm-one group
T(ℤ_p) reduces ONTO C (Hensel on the smooth group scheme), with kernel the pro-p group T(1 + pℤ_p[i]) ≅ ℤ_p. So every circle
residue is the reduction of p-adic unit vectors, a ℤ_p-torsor of them — the per-edge freedom of the lift — and a lift is a
choice of unit vector z_e ≡ D̄_e per edge such that the chosen vectors sum to zero around every cycle of H (positions exist iff
the 1-cochain is a coboundary). The vertex-variable form is the one the instrument uses:

**The system.** Fix integer reference positions x₀ : V → ℤ² reducing to H (coordinates in [0, p)), and write a candidate lift as
x_v = x₀(v) + p·y_v with y_v ∈ ℤ_p². For an edge e = uv let D_e = x₀(u) − x₀(v) ∈ ℤ² (so D̄_e = u − v ∈ C) and
w_e = y_u − y_v. Then

    |x_u − x_v|² − 1 = (|D_e|² − 1) + 2p⟨D_e, w_e⟩ + p²|w_e|²,   with |D_e|² − 1 = p·m_e, m_e ∈ ℤ.

*Level p² (the linear obstruction).* The lift exists mod p² iff for every edge ⟨D̄_e, w̄_e⟩ ≡ −m_e/2 (mod p), i.e. iff
**R(H)·ȳ = b** over 𝔽_p, where R(H) is the **rigidity matrix** of the framework H in 𝔽_p² (rows = edges, row uv carries D̄_e at
the u-block and −D̄_e at the v-block; |E| × 2|V|) and b_e = −m_e/2 = (1 − |D_e|²)/(2p) mod p is the **defect**. Changing the
reference lift x₀ by p·t changes b by R(H)·t̄, so the class of b in coker R(H) is canonical. By the Fredholm alternative over 𝔽_p:

> **Level-p² theorem.** H lifts mod p² ⟺ b ∈ im R(H) ⟺ ⟨λ, b⟩ = 0 for every **self-stress** λ ∈ ker R(H)ᵀ — every assignment
> of scalars to the edges whose weighted edge-vector sum vanishes at every vertex.

The kernel form (`Lift.lean`, `stressPairing_dvd_of_lift`): over ℤ, a stress mod p and a lift mod p² force
p² ∣ Σ_e λ_e (|D_e|² − 1); the contrapositive `no_lift_of_stressPairing` is what an instance cites — a stress with a nonzero
pairing refutes every candidate lift at once. **The count.** ker R(H) always contains the three infinitesimal isometries
(two translations, the rotation v ↦ Jv, since ⟨D̄, J D̄⟩ = 0), so rank R(H) ≤ 2|V| − 3 and dim(stresses) ≥ |E| − 2|V| + 3. A
6-critical H has minimum degree ≥ 5, so |E| ≥ 5|V|/2 and **the level-p² test imposes at least |V|/2 + 3 independent linear
conditions on b**; for a "random" H each fails with probability 1 − 1/p, so a 6-critical H with 100 vertices passes by chance
with probability ~ p^{−53}. A liftable H is not random: it is a shadow, and the conditions hold because a lift exists. This is
the exact sense in which the stub's "overdetermined by 5/4" is a theorem: the overdetermination is the stress space, and the
obstruction is its pairing with the defect.

*Higher levels, and the dichotomy.* Given a solution mod p^k, the next digit solves R(H)·ȳ' = b' with the SAME matrix and a new
defect depending on the digits chosen so far; the choices at each level form an affine space over ker R(H). Two cases:

> **The rigid case (rank R(H) = 2|V| − 3 — "infinitesimally rigid at its residue positions").** Choose a row basis E′ ⊆ E
> (2|V| − 3 edges, a Laman basis at these positions), gauge-fix the three isometries (pin one vertex and one edge direction), and
> the E′-system is square with an invertible Jacobian mod p: **Hensel lifts the residue positions to a UNIQUE ℤ_p-solution of
> E′ in the residue class, up to p-adic isometry.** The remaining edges E ∖ E′ are then determined: either some edge e has
> |x_u − x_v|² − 1 = c_e ≠ 0 in ℤ_p — detected at the finite level v_p(c_e) + 1 — and H has NO lift; or every remaining edge is
> unit and H lifts, uniquely up to isometry. In the second case the lift is an isolated nonsingular ℚ_p-point of a variety
> defined over ℚ (the realization variety of the abstract graph H, gauge-fixed), hence **algebraic**: its coordinates generate a
> number field F_H ⊂ ℚ_p, which therefore has a degree-one unramified prime above p, and H is a unit-distance graph in F_H².
> It is a unit-distance graph in ℝ² — a 6-forcer if χ(H) ≥ 6 — iff F_H has a real place (under a real embedding σ the point
> σ(x) is a real realization with the same unit edges, the equations being rational).

So for rigid H the whole question is decided by one Newton iteration plus one algebraic recognition: **local lift ⟹ global
algebraic lift, and the only remaining question is a real place.** (The M43/M44-era question "which field" is answered by the
lift itself: F_H is whatever the coordinates generate, and the sieve then says whether it is 6-open — it must be, if χ(H) ≥ 6
and F_H is real, by the finite-plane bound at every usable prime; a consistency check the instrument runs.)

> **The flexible case (rank < 2|V| − 3).** The E′-solutions form a manifold of dimension 3 + f (f the infinitesimal-flex
> dimension), the remaining edges cut it, and the Hensel tree branches p^f ways per level. Decidable in principle (Greenberg);
> the instrument reports f, runs the level-p² test, and stops. A 6-critical H is over-braced by |V|/2 edges beyond Laman and is
> expected rigid at its residues (P5); the flexible case is recorded, not searched.

**Two consequences worth stating before any instrument runs.**
(a) *The adding-a-vertex form.* For a lifted H₀ (rigid) and a residue point w with d neighbours in H₀, the framework H₀ + w has
stress dimension larger by exactly d − 2, so the level-p² test on H₀ + w is d − 2 new linear conditions — a degree-2 residue
point always lifts (the glue point, in whatever field the discriminant names — M22's classification, reduced), a degree-3 point
lifts mod p² with probability 1/p unless it is a shadow. In a dense reduction (the 1581 at 131: every residue class has ≈ 12
neighbours among the 1,547 residues) EVERY residue point is a degree-≥3 candidate, and the level-p² test with Newton behind it
enumerates, over all fields with a degree-one prime above p at once, the residue classes that carry a real point at unit
distance from ≥ 3 points of H₀ — the depth-one partner space of M49–M50 (9,485 points in 59 quadratic extensions for the seed)
seen from the finite side, with the field read off the lift rather than adjoined by hand. That is the constructive instrument
the stub gestured at ("a design vocabulary"), and it is phase B.
(b) *What the finite plane's own 6-critical subgraphs are.* By the count, a 6-critical H found by search is obstructed at
level p² unless it is a shadow, and nothing in "6-critical in UD(𝔽_p, 2)" makes it one — the plane's high chromatic number is
Kloosterman-controlled (G44), a global counting fact carried by the whole connection set, while liftability is a local rigidity
fact. The registered expectation (P2) is that every core fails at level 2, and the derivation says why: the plane's forcing is
made of edges that are unit modulo p and not modulo p², and a critical subgraph uses ≥ |V|/2 of them beyond what any rigid
lift could absorb.

### §S2. The finite plane's geometry, derived (the vocabulary D1 and the autopsy use)

All from 𝔽_p² ≅ 𝔽_p(i) with quadrance = norm and C the cyclic norm-one group of order p + 1 (p > 3):

* **Triangles.** A unit triangle 0, a, b is a, b ∈ C with a − b ∈ C: N(1 − b/a) = 2 − Tr(b/a) = 1 ⟺ b/a is a primitive sixth
  root of unity in C ⟺ 6 ∣ p + 1 ⟺ **p ≡ 11 (mod 12)**. So ω(UD(𝔽_p,2)) = 3 iff p ≡ 11 (mod 12), else 2 — which is exactly
  M58's measured ω (3 at 11, 23, 47, 59; 2 at 19, 31, 43), and the induced graph on the circle is a union of (p+1)/6 hexagons.
  Checked at every p ≡ 3 (mod 4) below 132 (p = 3 is degenerate: 2·(1,0) is on the circle).
* **The Moser spindle.** Its rhombus tips sit at quadrance 3 (N(a + b) = 2 + Tr(ω) = 3), and the rotation ρ carrying one tip to
  the other at unit distance satisfies Tr(ρ) = 5/3, N(ρ) = 1 — the roots of x² − (5/3)x + 1, discriminant −11/9 — which lie on
  the torus iff −11 is a non-residue or zero mod p, i.e. iff **11 is a residue or zero mod p**. So the spindle embeds in
  UD(𝔽_p,2) iff p ≡ 11 (mod 12) and (11/p) ≠ −1: **exactly the usable primes of K = ℚ(√3, √11)** (at 11 through the antipodal
  copy ρ = −1). Checked: present at 11, 83, 107, 131; absent at 23, 47, 59, 71. The finite plane knows which real objects it
  is the shadow of — the reduction theorem read from the finite side.
* **Spheres and their chords (the ring vocabulary, reduced).** Spheres about a point are torsors for C. Two spheres of quadrances
  c, c′ carry unit chords iff the triangle with squared sides c, c′, 1 has square "area": 4cc′ − (c + c′ − 1)² a nonzero
  square (then every point of one sphere has exactly TWO unit neighbours on the other — the glue point and its mirror,
  `Glue.sphere_inter_sphere` mod p) or zero (one neighbour, the tangent case); a sphere carries chords within itself iff
  **4c − 1 is a square** — the spindle-distance condition 4d² − 1 of G12/G37, verbatim. The induced subgraph on a set S of
  spheres about the origin is therefore a 2-regular-per-pair lift of the "sphere graph" Γ_p[S], a circulant-coupled structure
  of the M20 strip-automaton genre — and its Hoffman floor is small (§S0: ≤ 2.8 at eight spheres) because it is sparse.

### §S3. D1 priced — where a 6-critical subgraph of a finite plane can be found, and what it costs

The planes: 59 (3,481 vertices, degree 60, Hoffman 5.022 — the smallest ≥ 6 plane, tight), 83 (6,889, degree 84, 5.74 —
K(√7)'s first usable prime), 131 (17,161, degree 132, 7.25 → ≥ 8 — de Grey's field's first usable prime). Cayley balls jump
from 1 + (p + 1) vertices (the origin plus the circle: χ = 3, a wheel of hexagons) to the whole plane at radius 2 (C + C is
everything), so the M43 ball ladder does not apply; the growth orders available are (i) the whole plane shrunk, (ii) unions of
spheres about the origin shrunk sphere-by-sphere (torus-symmetric, |S| asks per pass instead of |V|), (iii) direction subsets
Cay(𝔽_p², D) with D ⊂ C/± (vertex-transitive, spectral floor by FFT — the 1581's 55 at 131 give 4.96; which of the 11 missing
directions lifts the floor past 5 is one FFT each). Costs: a k = 5 SAT on the whole plane at 131 is 85,805 variables and
5.7 M binary clauses — far above the threshold (χ ≥ 8), so CDCL may refute it fast, or not at all (Hoffman-tight refutations
are resolution-hard; 59 is the tight one). The external `cadical` binary under `timeout`, one plane at a time, one hour each,
in the order 131, 83, 59, decides which planes are searchable (P3). A refuting plane is shrunk by spheres first (130 spheres,
~ 8 passes × 130 asks), then by vertices inside the sphere-minimal object (the M42/M43 discipline: batched destructive pass
outside-in, every deletion re-asked, the core re-certified with per-vertex necessity witnesses, a second encoding on the final
core). The shadow constraint: a liftable H into de Grey's field needs its edge directions among the residues of the field's
unit vectors — all 66 classes at 131 (the gen-1 closure hits every one), 210 of 240 at 479 — no constraint at 131.

### §S4. The kernel skeleton (`Proofs/HadwigerNelson/Lift.lean`, elaborating, six `sorry` leaves)

* `Colorable.of_le_map` / `chromaticNumber_le_of_le_map`: for an injective `f : V → W`, `H ≤ G.map f` gives `χ(H) ≤ χ(G)`
  (`[Nonempty V]` — the colour for vertices outside the image; the empty-`V` case is the one adversary of the statement).
* `UDCert.chromaticNumber_le_of_drawing`: the certificate form (an injective drawing covering `H`), and
  `UDCert.add_one_le_chromaticNumber_plane_of_lift`: `H` refuses `k` colours ⟹ χ(ℝ²) ≥ k + 1 through
  `add_one_le_chromaticNumber_of_valid` — the composite a lifted core would consume; its `¬ H.Colorable k` hypothesis is where
  an LRAT refutation of the finite graph enters (the M05 chain on `H` presented as an edge list — not this milestone unless a
  core lifts).
* `netStress`, `IsStressMod`, `stressPairing`, **`stressPairing_dvd_of_lift`** (the level-p² theorem over ℤ) and
  `no_lift_of_stressPairing` (its contrapositive, the instance form). Spec: the collinear triangle of UD(𝔽₃,2) as the
  three-point frame (its edges are unit mod 3 by `decide`); the pairing instance on a real core is phase C.

### §S5. The instrument (`tools/fplift.py`, new; `tools/fplane.py` untouched except a `cores` hook if convenient)

| subcommand | what | record |
|---|---|---|
| `local --core FILE [--prec N]` | rank of R(H) mod p (dense elimination, numpy int64 — 8 s at 1,581 vertices), stress dimension, the defect b from the canonical [0, p) lifts, the level-p² pairing on a stress basis (how many of dim Σ conditions fail — the **obstruction count**); if rigid: a Laman basis, the gauge-fixed digit-by-digit Hensel lift to precision p^N, and for every remaining edge the first level at which it fails; verdict `obstructed-at-level-k (count)` / `passes-to-precision-N` / `flexible (f)` | `lift-<core>-p<P>.json` |
| `cores --p P --k 5 [--method plane\|spheres\|dirs] [--wall S]` | the whole-plane refutation attempt (external cadical), the sphere-shrink, the vertex-shrink with certification | `core-p<P>-k5-<method>.json` |
| `hubs --stage … --p P` | phase B: every residue point with ≥ 3 neighbours in a stage's injective reduction, the level-p² test on each, Newton on the survivors, the recognized field of each survivor (LLL against the tower basis, then minimal polynomials to degree 16) | `hubs-<stage>-p<P>.json` |
| `recognize --lift FILE` | the algebraic recognition of a passing lift's coordinates (sympy `DomainMatrix.lll`), exact verification of every edge in the recognized field, the real-place check | `lift-<core>-p<P>-field.json` |
| `self-test` | the controls below | — |

Controls (each seen red or green before any measurement): the Moser spindle's residues at 11, 83, 131 lift (rigid, Newton
reproduces its K-coordinates to precision N, F_H = K recognized); Heule-510's injective reduction at 11 passes every level;
the 1581's injective sub-reduction at 131 (one vertex per residue class) passes and its Newton lift equals the tower
coordinates embedded in ℤ₁₃₁ (the roots of 3, 5, 7, 11 Hensel-lifted); the 1581's MERGED image (34 identified pairs, the
union of neighbourhoods) is the adversarial member — ≥ 5-chromatic as a hom image and expected obstructed; a planted false
edge on the spindle fails at level 2; a 4-cycle reports `flexible (1)`; a planted corruption of the Newton residual is caught
by the exact re-check; the collinear triangle at p = 3.

### §S6. Phases and registered predictions

| phase | what | cost |
|---|---|---|
| 0 | D2 written (§S1–§S2); `fplift.py local` + self-test; the whole-plane refutation attempts at 131, 83, 59 (external cadical, 1 h each, sequential) | a day |
| A | cores: sphere-shrink then vertex-shrink of every refuting plane; `local` on each core (obstruction level and count); the finite-plane autopsy of a core (ω, floor, sphere structure, class avoidance at k = 5) | days |
| B | `hubs` on the 1581's injective reduction at 131 (and Heule-510's at 11 as the calibrated bed: its hubs are the K-lattice's) | a day |
| C | the kernel: `Lift.lean` proved; an instance `Instances/LiftObstruction<P>.lean` — a core, a stress, the pairing decided nonzero (only if phase A yields a core failing at level 2) | a day |
| D | gate, §R, Frontier, re-rank, close | — |

Predictions, registered before any instrument runs (the two probes of §S0 are grokking, not measurements — their numbers
are re-derived by the instrument):

| # | prediction | confidence |
|---|---|---|
| P1 | the smallest 6-critical subgraph of UD(𝔽₁₃₁,2) found by the sphere-then-vertex shrink has > 1,000 vertices (the stub said > 100; sharpened by §S0 (ii)) | medium |
| P2 | every 6-critical core found fails the level-p² test, with an obstruction count above (1 − 2/p)·dim Σ | high |
| P3 | the external cadical refutes five colours on the whole plane at 131 within one hour; at 59 it does not | medium |
| P4 | the 1581's injective sub-reduction at 131 passes the local test to precision 131²⁰ and its Newton lift equals the tower coordinates; the merged image (34 identifications) is obstructed at level 2 | high / medium |
| P5 | every core found is infinitesimally rigid at its residue positions | medium-high |
| P6 | the sphere-minimal ≥ 6 object at 131 has between 20 and 60 spheres | low |
| P7 | among the 17,161 residue points at 131, those with ≥ 3 neighbours in the 1581's injective reduction that pass level 2 are fewer than 50, every one passes Newton to precision 20, and they are residues of gen-1 closure points | medium-low |
| P8 | `Lift.lean` lands on the standard three axioms, the obstruction theorem under 250 lines | medium |
| P9 | (M58's P7, carried) the 1581's shadow at 131 is 5-colourable | medium |

Failure and pivot clauses stand as the stub wrote them (§6): a core that lifts globally is HALT AND VERIFY, and under the
programme (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §6) the milestone then continues into the derivation of why it forces six;
all cores obstructed is a recorded negative with its count, and the shadow sieve plus the hub instrument are what the
finite planes still offer the hunt.

### §S7. Decisions at subplanning

| decision | alternative | why | confidence |
|---|---|---|---|
| D2 before D1, with the level-p² theorem in the kernel skeleton | search for cores first, test later | the count says what a search can find (nothing liftable by chance); the theorem is the milestone's derivation and the receipt for every negative | high |
| the local test as rank + Newton (rigid case), flex dimension reported and not searched | a Hensel tree with branching | 6-critical H is over-braced by |V|/2; the tree is exponential and buys nothing a rigid core does not | high |
| the whole-plane refutation with the external `cadical` binary under `timeout` | pysat (M58's wall did not interrupt) | the M58 incident | high |
| sphere-shrink before vertex-shrink | vertex ddmin from the whole plane | 130 asks per pass against 17,161, and a torus-symmetric object is the finite plane's analogue of the rot6 cores (M40/M42), autopsy-friendly | medium — if the sphere-minimal object is nearly the whole plane, vertex ddmin runs anyway |
| phase B (hubs) inside this milestone | a separate stub | it is D2 (a) applied, it reuses `local`, and it is the constructive reading the programme ranks first | medium |

## §M1. Domain-modeling pass (2026-09-06; fresh Skill invocation)

**The true shape found: the level-p² obstruction is first-order rigidity in a ring with a square-zero element, and
the Hensel tower is that one theorem at every level.** The skeleton had stated the obstruction over ℤ with
componentwise divisibility by p and p², a stress as a separate function `V × V → ℤ` with a mod-p predicate, and the
positions as integer lifts. Three pieces of incidental structure were in it:

1. **The prime, the integers, and the divisibility.** The proof of "a lift mod p² forces the stress pairing to vanish"
   uses exactly two facts — `π² = 0` and `π • netStress = 0` at every vertex — and never that π is a prime, that the ring is
   ℤ/p², or that the residue class is all of x₀ + (p). The intrinsic statement is over ANY commutative ring R with an
   element π of square zero: a deformation `x = x₀ + π • y` of a stressed framework along which every edge has quadrance 1
   forces `Σ λ_e (quad (x₀ e) − 1) = 0`. Instantiated at `R = ZMod (p²)`, `π = p` it is the level-p² obstruction (the residue
   class of x₀ IS `x₀ + p • y`); at `R = ZMod (p^(k+1))`, `π = p^k` with x₀ a level-k solution it is the level-(k+1)
   obstruction — the whole tower with no new statement (π² = p^{2k} = 0 for k ≥ 1; π • netStress = 0 is the same mod-p
   stress condition at every level). This is classical first-order rigidity read in the dual numbers R[π]/π²; `PadicInt`
   is not needed, because the certificate side reaches ZMod (p²) directly: `Q4.lift` with mod-p² roots and the M58 theorem
   `drawing_adj`, which already holds over every ring. The ℤ × ℤ componentwise divisibility (two conditions) became the
   parametrization `x₀ + π • y` (none), and `quadZ` became `quad` on `R × R` for any ring, with `quad_eq_one_of_adj` the
   bridge to `unitQuadrance_adj`.
2. **A stress lives with its edges.** A stressed framework is a list of weighted edges `List (V × V × R)`
   (`StressedEdges`): the sums need an orientation and tolerate multiplicity, a list gives both, and the kernel instance
   is one literal — the stress as a function on `V × V` was the wrong carrier for the theorem (which quantifies over
   constraints) and for the instance (a table lookup on a product type). `Finset` was rejected on kernel cost (literal
   insertion is quadratic in `decide`); the house shape is the certificate's own `List` with a fold. The `SimpleGraph` H
   appears only on the χ side, where the covering is `H ≤ G.map f` with `Injective f` as a hypothesis (Mathlib's `map`
   at this pin takes a plain function): the natural statement of "H sits inside the lift", and `Colorable.of_hom` on the
   inverse map is its proof. `Nonempty V` is intrinsic — empty V with nonempty W makes H = ⊥ on W 1-chromatic above
   χ(G) = 0 — and comes free from `0 < n` in the certificate form. No Fredholm alternative, no `Matrix`, no linear-map
   kernel enters the kernel: only the ⟹ direction is load-bearing (an instance is a NEGATIVE), and it is one identity plus
   a summation by parts along the edge list; the ⟺ (b ⊥ stresses ⟹ a mod-p² lift exists) is the instrument's completeness
   statement and the Newton lift's business.
3. **The drawing is natural in the ring** (`UDCert.drawing_map`: a ring hom applied coordinatewise to a drawing is the
   drawing through the composite hom, by `map_mul`). This is the bridge between the two consumers, which live at different
   levels: the χ-consumer at level p (`H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)` with `φ : S →+* ZMod p`) and
   the obstruction consumer at level p² (a certificate drawn through `S →+* ZMod (p²)` agreeing with x₀ modulo p is a
   deformation `x₀ + p • y`, by `ZMod.exists_smul_of_castHom_eq`). M58's "the plane is a functor of the coordinate ring"
   extends to "the drawing is a natural transformation".

**Seams checked.** Non-vacuity: the closed hex shell (a point and its six unit neighbours: 7 vertices, 12 edges, one
self-stress) is a real configuration reducing at every p ≡ 11 (mod 12), so its pairing is zero — the model of the
hypotheses, to be pinned at 11 once the theorems are proved. Adversarial member: the collinear triangle `0, (1,0), (2,0)`
of UD(𝔽₃, 2) — pairwise unit mod 3, no real unit triangle reduces to it — with stress `(2, 2, −1)`: `IsStress 3` decides
true and the pairing decides to `6 = −3 ≠ 0` in `ZMod 9` (three `decide`s in the skeleton, already green), so it has no lift
even modulo 9. Unsampled members: a loop `(v, v, λ)` makes the unit hypothesis false (quad 0 = 1) and the theorem vacuous;
an empty list has pairing 0; `p = 0` (ZMod 0 = ℤ, π = 0) reduces the theorem to "unit edges at x₀ give pairing 0", true;
`p = 1` collapses everything — the theorem needs no positivity or primality anywhere. A "stress" with weights all in (π)
pairs to zero trivially, so an informative instance has a weight outside (π) — the theorem does not need to say so.

**Next-lemma test.** "The 1581 at level 131² is a deformation of its residue framework" states in the vocabulary
(`Q4.lift` with roots mod 131², `drawing_adj` at `R = ZMod (131²)`, `drawing_map` to level 131); "the merged image of the
1581 is obstructed" states (a `StressedEdges` literal over `ZMod (131²)`, one `decide`); "the level-p³ obstruction of a
core passing level p²" states with π = p² over ZMod (p³) and x₀ the level-p² solution. The finite plane's geometry of
§S2 (triangles iff p ≡ 11 mod 12; the spindle iff p usable for K; sphere chords iff the Heron quantity is a square) stays
derived-and-measured this milestone: its kernel form wants 𝔽_p(i) as the norm-one group, a module of its own; two `decide`
pins of ω at 11 and 19 are the honest kernel trace and go in the instance module. Kernel-cost note for the obligation
pass: `netStress` as a selector sum over the list is O(|V|·|L|) in `decide` (~10⁶–10⁷ steps on a thousand-vertex core —
minutes); an accumulate-form evaluator with a soundness lemma (the M04 pattern) is the fallback if the instance balks.

## §M2. Obligation-modeling pass (2026-09-06; fresh Skill invocation) — every leaf discharged in the probe

**The statement from which the proof derives, found by two computations before any tactic.** (i) The derivation was
tested on a real object first: the closed hex shell reduced at 11 has twelve edge defects `(Q(x₀ e) − 1)/11 =
0, 3, 4, 0, 3, 3, 9, 8, 8, 0, 9, 8`, individually nonzero, and its self-stress (rim +1, spokes −1) pairs them to exactly
−121 ≡ 0 (mod 121) — the cancellation the theorem demands of every real configuration, and not a trivial one. (ii) The
collinear triangle of UD(𝔽₃, 2) with stress (2, 2, −1) pairs to 6 = −3 ≠ 0 in ZMod 9 (three `decide`s green in the
skeleton since §M1). The theorem is therefore neither vacuous nor over-hedged before its proof exists.

**The space, characterized.** Every obligation of `Lift.lean` is one of three kinds:

| kind | obligations | the local obligation |
|---|---|---|
| a `linear_combination`/`ring` identity | `quad_add_smul` (the per-edge expansion `quad (a + π•b) = quad a + 2π·dot a b + π²·quad b`), the five `dot` lemmas, the per-edge step of the crux (`e.2.2 * (quad D − 1) = −2π · e.2.2 · dot D Y` from `hunit`, `hπ`) | `simp only [quad, dot, Prod.fst_add, …]; ring` and `linear_combination e.2.2 * h` — each closed first try |
| one induction on the edge list | **`sum_dot_eq_sum_netStress`** — the summation by parts — the hardest lemma and the module's only induction; `nil` by `simp`, `cons` by `rw [ih]` FIRST (the induction hypothesis must be rewritten before `simp` normalizes the map's body under `dot_sub_right`, or it never matches — the one stuck case of the pass), then `simp only [netStress_cons, dot_add_left, Finset.sum_add_distrib, dot_sub_left, dot_smul_left, Finset.sum_sub_distrib, ite_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true, dot_sub_right]; ring` | the recursor is the list's; `netStress_cons` (`rfl`-adjacent) is the equation lemma that makes the step local |
| a bridge to the environment | `Colorable.of_le_map` (a hom `H →g G` built on `Function.invFun` with `Function.leftInverse_invFun`; adjacency by `map_adj'` at this pin — `(G.map f).Adj u v ↔ u ≠ v ∧ ∃ u' v', G.Adj u' v' ∧ f u' = u ∧ f v' = v`, `Iff.rfl`); `quad_eq_one_of_adj` (`simpa [quad] using h.2`); `drawing_map` (`simp only [drawing, Prod.map_apply, map_mul, RingHom.comp_apply]`); the plane composite (`add_one_le_chromaticNumber_of_valid hd hv` with the contrapositive of `Colorable.of_le_map`, `Nonempty (Fin n)` from `0 < n`); `ZMod.exists_smul_of_castHom_eq` (`castHom_apply`, `← intCast_cast (R := ZMod p) a` — the explicit arguments matter: without them the second `←` rewrite re-matches the ℤ-cast just introduced — `intCast_eq_intCast_iff_dvd_sub`, then `intCast_zmod_cast` and `push_cast; ring`; conclusion restated with the ring scalar `(p : ZMod (p²)) * t`, so the consumer needs no ℕ-smul cast lemma); `ZMod.natCast_sq_eq_zero` (`← Nat.cast_pow, natCast_self`); the consumer `UDCert.stressPairing_eq_zero_of_drawing` (`choose` the deformation from the residue agreement componentwise; `drawing_adj` at `R = ZMod (p²)` + `quad_eq_one_of_adj`; the two `Prod.ext` leaves close by `rw [Prod.fst_add, Prod.smul_fst, smul_eq_mul]; exact h₁` — `exact`, not `simpa`, because `(c.drawing …).1` and `u * φ …` are equal only under the default transparency) | each a citation found by query (`grep` of the pinned Mathlib and core), not recalled |

Everything closed in `build/m59/probe_obl.lean` (zero `sorry`); the proofs port verbatim at implementation.

**Partition.** *Prove:* the eleven theorems above. *Test:* the tri3 reds (three `decide`s), the hex-shell green at 11
(a `decide` over ZMod 121 once the residues are in the module — the model of the hypotheses), the two ω pins.
*Assume* (hypotheses the caller discharges): `π² = 0` (at ZMod (p²): `natCast_sq_eq_zero`), `IsStress` (decided per
instance), the residue agreement `hres` and the edge covering `hE` (per instance, from the drawing).

**The instance-scale cost, measured, and the design it forces.** A synthetic stressed framework of 100 vertices and 300
weighted edges over ZMod (131²): `IsStress` plus the pairing by `decide +kernel` in **20.5 s of type checking**
(`build/m59/probe_time.lean`) — 0.7 ms per (vertex, edge) pair, i.e. ~20 kernel steps per selector step (a `Fin`
equality, a `ZMod` product on a pair, a subtraction) against the 33-µs model. Extrapolated: a 1,000-vertex, 3,000-edge
core is ~35 min (acceptable once; the certificate segments of M06 were larger), a 3,000 × 10,000 core ~6 h (not). The
selector form of `netStress` is O(|V|·|L|) and no kernel representation makes it linear without the M04 Nat-packed
tables (~200 lines of evaluator plus soundness — priced, not built). **The design that removes the question: an
obstruction is certified by a stress of small support.** A self-stress of a sub-framework, extended by zero, is a
self-stress of the whole (the net stress at a vertex sees only the edges carrying weight), and a lift of the whole
restricts to a lift of the sub-framework — so ONE small over-braced sub-framework whose stress pairs nontrivially with
the defect refutes every lift of the core, and the kernel instance is that sub-framework alone (tens of edges, a second
of `decide`). Since a random over-braced sub-framework of a finite-plane core is obstructed with probability 1 − 1/p,
such a witness exists in every obstructed core unless the obstruction is genuinely global; the instrument's `local`
therefore reports a **minimal-support obstructing stress** (search over closed vertex neighbourhoods and small balls of
the core, smallest support first), and the instance module consumes it. No new theorem is needed — the instance takes
`V = Fin m` for the sub-framework's vertices; a docstring says why that suffices. P8 stands at < 250 lines for the
general module; the instance's kernel time is now seconds.

**Mutation audit (run at implementation, each expected to break the proof exactly where named).** Drop `hπ`: the π²·quad
term survives in `h` and `linear_combination e.2.2 * h` fails — and the theorem is genuinely false without it (R = ℤ,
π = 1, x₀ ≡ 0 with any weights, y a unit path: pairing −Σλ ≠ 0). Drop `hs`: the final `Finset.sum_eq_zero` leaf cannot
close (any weights would qualify — false). Replace `x₀ + π • y` by arbitrary `x`: `hre` has no statement — the whole
content is the deformation shape. Drop `Nonempty V` in `Colorable.of_le_map`: `Function.invFun` fails to elaborate, and
the theorem is false (empty V, nonempty W). The three `decide` reds and the hex-shell green are the spec's adversaries.

## §M3. Experience-modeling pass (2026-09-06; fresh Skill invocation)

**The consumers, and what each holds.** (a) A reader of `Lift.lean` with a subgraph `H` of `finitePlane p` that refuses
five colours, asking how it becomes χ(ℝ²) ≥ 6: they hold `H`, a refutation of `H` (an LRAT chain on `H` presented as an
edge list, transported along the isomorphism), and — if the lift exists — a tower certificate `c` and a residue hom `φ`.
The path is ONE theorem, `UDCert.add_one_le_chromaticNumber_plane_of_lift`, whose docstring is the recipe, and every
hypothesis it takes is something the reader can produce (`Injective (c.drawing φ hS u)` and `H ≤ (edgeGraph …).map
(drawing)` decide on a concrete certificate). (b) A reader with a framework and a stress, asking whether the framework
lifts: the headline must be a statement about LIFTS, so the deformation predicate is named — `IsLift π x₀ L y` ("along
`y`, every listed edge of `x₀ + π • y` has quadrance one") — and the negative reads `¬ ∃ y, IsLift π x₀ L y`
(`not_exists_lift_of_stressPairing_ne_zero`), with `stressPairing_eq_zero_of_lift (hy : IsLift π x₀ L y)` its positive
form. The consumer's residue hypothesis is written with a named `residue p : ZMod (p²) × ZMod (p²) → ZMod p × ZMod p`
("the drawing's residue is `x₀`'s residue"), decidable on an instance, instead of a `Prod.map castHom castHom` pair. (c)
`exact?` and `simp`: `drawing_map` is `@[simp]` (toward one drawing through the composite hom — the shape a consumer holds
after mapping coordinatewise), `netStress_nil`/`netStress_cons` are `@[simp]` (the equation lemmas; terminating on a
literal), `dot_zero_left` is `@[simp]`; the four distributing `dot` lemmas stay cited (`simp only`) — the module's proofs
are their only users and a global outward-distribution rule is an unrequested byte. `Colorable.of_le_map` /
`chromaticNumber_le_of_le_map` follow `Colorable.of_hom` / `Colorable.mono_left`; the hom on `Function.invFun` stays
inside the proof (no consumer asked for it). (d) The instance author: `e.2.2` for a weight and `e.2.1` for a head are the
implementation across the wire — a stressed edge is a `structure StressedEdge V R` with `src`, `dst`, `wt`, the literal
`⟨0, 1, 2⟩` costs nothing, and the abbrev `StressedEdges` is dropped (`List (StressedEdge V R)` already reads). The
framework's positions name the object, so `x₀` is the FIRST argument of `netStress`, `IsStress`, `stressPairing`,
`IsLift`, `sum_dot_eq_sum_netStress` alike. `quad` keeps its name (Mathlib has no `quadrance` at this pin) with
`quad_eq_one_of_adj` the single bridge from `unitQuadrance_adj`. `ZMod.exists_smul_of_castHom_eq` becomes
`ZMod.exists_eq_add_mul_of_castHom_eq` (it concludes `a = b + p * t`); its home is `HadwigerNelson.ZMod`, no collision.

**The docstrings' contract.** `stressPairing_eq_zero_of_lift` says what a nonzero pairing licenses and on what: the
framework has no lift `x₀ + π • y` in the ring; at `ZMod (p²)` no lift modulo `p²`; a stress supported on a sub-framework
is a stress of the whole, and a lift restricts, so a nonzero pairing on a SUB-framework refutes every lift of the whole
core (§M2's design). `UDCert.stressPairing_eq_zero_of_drawing` says exactly what an instance certifies — no valid tower
certificate, drawn at level `p²` through any hom out of any subring with an inverse of its denominator, covers the
framework with matching residues — and what it does not: other number fields, configurations not presentable as tower
certificates; the ℤ_p statement ("no lift at any level, hence none in any number field with a degree-one prime above
`p`") is the hand derivation §S1, of which the kernel theorem is the level-`p²` face. `add_one_le_chromaticNumber_plane_of_lift`
names its one unstated cost: `¬ H.Colorable k` is where a refutation certificate of the finite graph enters.

**Placement and receipts.** `Proofs.lean`: `Lift` after `UnitQuadrance` in the general block; the instance module (when a
core exists) after `Instances.FinitePlane11`. `scripts/Axioms.lean` M59 block: `chromaticNumber_le_of_le_map`,
`UDCert.add_one_le_chromaticNumber_plane_of_lift`, `stressPairing_eq_zero_of_lift`, `not_exists_lift_of_stressPairing_ne_zero`,
`UDCert.stressPairing_eq_zero_of_drawing`, and the instance's headline. Spec: the three `tri3` reds stay; the hex shell at
11 is the green (`IsStress (11 : ZMod 121)` and `stressPairing … = 0` by `decide`, residues `(0,0), (1,0), (6,3), (5,3),
(10,0), (5,8), (6,8)`, rim weights 1, spoke weights 120) — the same numbers the instrument's self-test reproduces, so the
two evaluators are checked against each other; the ω pins (a triangle exists at 11; none at 19, a `decide` over 361²
pairs) live in the instance module with the other `p`-specific data.

**The instrument (`tools/fplift.py`).** The conversation: a session holding a core asks "does it lift?" and gets one
command, one line, one record —

    python3 tools/fplift.py local --core data/fplane/core-p131-k5-spheres.json
    [fplift] core-p131-k5-spheres (n=1,204, m=3,612, p=131): rigid (rank 2,405 = 2n − 3), stress dim 1,207;
             OBSTRUCTED at level 2 — 1,198 of 1,207 stress-basis conditions fail; minimal-support witness: 9 edges on
             6 vertices, pairing 57 ≠ 0 (mod 131²)   → wrote data/fplane/lift-core-p131-k5-spheres.json

— the verdict vocabulary `obstructed-at-level-k`, `passes-to-precision-N`, `flexible (f)`, `undecided` (a cap was hit;
never a word meaning "clean"), the population in the same sentence as the verdict (G21's headline rule), and the witness
in the record as the kernel instance's literal (`vertices`, `x0` as residues in [0, p), `edges` as `[u, v, λ]` triples,
`pairing`). Records and what each licenses (the README row): `core-p<P>-k<K>-<method>.json` — the solver's refusal
(untrusted) plus per-vertex necessity witnesses (verified colourings) and the second encoding's verdict; `lift-<core>.json` —
`obstructed-at-level-2` with a witness is a certificate re-checkable by the kernel instance, `obstructed-at-level-k > 2` a
certificate re-checkable by exact arithmetic (the level-(k−1) solution and the failing digit are in the record),
`passes-to-precision-N` the coordinates modulo p^N with every edge unit modulo p^N (anyone re-checks with integer
arithmetic; no solver, no float); `hubs-<stage>-p<P>.json` — per residue point its degree, its level-2 verdict with the
count, its Newton verdict, and for the passers the recognized coordinates and field. Errors that must not be silent: a
core whose listed edges are not all unit modulo p is refused by an `INSTRUMENT CATASTROPHE` assert naming the first
offending edge; a stage reduced at a prime where a radicand is a non-residue is refused naming the radicand; a Newton
step whose Jacobian is singular modulo p reports `flexible` rather than dividing. The self-test is the user's first
experience: each control's line names the object, the expected reading, and what a red would mean — the spindle at 11,
83, 131 lifts (rigid; Newton reproduces its K-coordinates; K recognized), the hex shell at 11 passes level 2 with the
kernel's own numbers, the collinear triangle at 3 is obstructed with pairing 6 (mod 9) (the kernel's number), a 4-cycle
reports `flexible (1)`, a planted false edge on the spindle at 83 is obstructed at level 2 (its pairing pinned once
computed), a planted corruption of a Newton residual is caught by the exact re-check, Heule-510's injective sub-reduction
at 11 passes every level to the registered precision. The M58 conventions kept: records in `data/fplane/`, `--out`, the
claim-scope field in every record.

## §R-notes. Findings during implementation (running list; folded into §R at the close)

* **The lift theory is for UNRAMIFIED degree-one primes, and the instrument found it.** The self-test's first run read three
  reds: the Moser spindle's residue framework at 11 "obstructed at level 2" (its degenerate antipodal copy carries a stress
  whose pairing is nonzero), Heule-510's injective sub-reduction at 11 obstructed, and a vacuous false-hub control. The first
  two are the instrument being right and the controls wrong: 11 is RAMIFIED in ℚ(√11), so the spindle's and Heule-510's
  coordinates live in ℤ₁₁[√11] with uniformizer √11, not in ℤ₁₁ — their residue frameworks are shadows of ℤ₁₁[√11]-
  configurations and are provably not ℤ₁₁-lifts (a ℤ₁₁-lift of the spindle would put √11 in ℚ₁₁). The hex shell (ℚ(√3),
  11 unramified) passes, the spindle passes at 83 and 131. So §S1's "𝔭 a degree-one prime" must read "unramified": M58's
  reduction (a hom, the upper bound) is fine at ramified primes, the LIFT (the lower bound) is not — the 11-sealing of the
  K-fields, which uses the ramified prime above 11, says nothing about lifts at 11; the unramified usable primes of K
  (83, 107, 131, …) are the lift's primes. Controls re-registered: obstructed at 11 (ramified) is the planted red.
* **P4 measured (2026-09-06, `data/fplane/lift-degrey1581-p131{,-merged}.json`).** The 1581's injective sub-reduction at 131
  (1,547 residues, 7,541 kept edges): rigid (rank 3,091 = 2n − 3), stress dimension 4,450, level 2 passes all 4,450
  conditions, and the gauge-fixed Hensel lift of a 3,091-edge Laman basis has EVERY one of the 7,541 edges unit to precision
  131²⁰ (24 s) — the p-adic configuration recovered from residues alone. The merged image (the 34 collision pairs identified,
  7,876 edges, ≥ 5-chromatic as a hom image): OBSTRUCTED at level 2 — 2,406 of 4,785 stress-basis conditions fail; the
  minimal-support witness is 48 edges on 26 vertices with pairing 7205 ≢ 0 (mod 131²): a kernel-instance-sized certificate
  that a ≥ 5-chromatic subgraph of the plane is not a shadow.
* **Instrument incident.** `hensel_sqrt` squared its modulus at every Newton step (p^(2^20)); the `hubs` step and the
  isometry check stalled on seven-megabit arithmetic. Fixed (fixed modulus, ⌈log₂ prec⌉ + 1 steps, convergence asserted).
* **P4, the isometry half.** The Newton lift of the injective sub-reduction and the tower embedding (the 1581's actual
  coordinates through the Hensel-lifted roots of 3, 5, 7, 11 mod 131²⁰) agree on all 20,000 sampled pairwise quadrances
  mod 131²⁰ — the same configuration up to a p-adic isometry, as the rigid dichotomy says; the embedding has all 7,877
  stage edges unit mod 131²⁰.
* **The hub test's flaw, found by its own control, and the corrected scan.** The first `hubs` run on the 1581 at 131 read
  0 passers among 15,596 candidates; the positive control (delete a vertex of the 1581, rescan, expect its residue back)
  read RED. Cause: at 131 a candidate residue class sees on its unit residue-circle, by mod-p coincidence, ≈ |stage
  residues|·(p+1)/p² classes that are NOT true neighbours (≈ 12 for the 1581's 1,547 classes, ≈ 4 for Heule-510's 507),
  and the strict test demanded unit p-adic distance to all of them. The scan now lifts each residue-neighbour PAIR's glue
  point in the class and reports the largest subset it fits (`hub_best`); the strict form survives as `hub_test`. The 64
  Heule-510 passers of the strict run were the hubs with no false neighbour by luck — all 64 verified EXACT (the
  unit-circumcentre of three neighbours in ℚ(√3,√5,√7,√11) is at unit distance from every claimed neighbour, sympy), 11 of
  them Heule-553's discarded vertices to the p-adic digit — and the corrected scan on Heule-510 minus its centre finds
  1,171 (the centre back with support 36 of 36). The corrected scans on the full Heule-510 and on the 1581 are in flight.
* **The calibration core at 11 (`data/fplane/core-p11-k4-spheres.json`).** The 5-critical subgraph of UD(𝔽₁₁, 2) found by
  the sphere-then-vertex shrink: **63 vertices, 246 edges, six quadrances about the origin, 1-minimal with all 63
  necessity witnesses**, 12 s. Its local test follows the 19-core's shrink in the chain.

## §R. Results (M59, 2026-09-06 — the finite-plane lift)

### §R0. What shipped

* **Derivation** (§S1–§S2): the lift as a system; the level-p² obstruction as the rigidity matrix against the defect,
  solvable iff every self-stress pairs to zero; the dichotomy for rigid frameworks (a Laman basis Hensel-lifts uniquely up
  to isometry; the remaining edges decide at a finite level; a local lift is algebraic with a degree-one prime above p,
  real iff its field has a real place); the adding-a-vertex form; the finite plane's geometry (triangles iff p ≡ 11 mod 12;
  the spindle iff p is usable for K; sphere chords iff the Heron quantity is a square; self-chords iff 4c − 1 is). Found by
  the instrument's own controls: the theory is for UNRAMIFIED degree-one primes (§R1).
* **Kernel** (`Proofs/HadwigerNelson/Lift.lean`, `Instances/LiftObstruction131.lean`; the gate in §R6): the lift theorem
  `χ(H) ≤ χ(G)` along an injective covering and its plane composite `add_one_le_chromaticNumber_plane_of_lift` (the recipe a
  lifted 6-forcer consumes); the naturality `drawing_map`; **the first-order obstruction** `stressPairing_eq_zero_of_lift`
  over any commutative ring with a square-zero element and its headline `not_exists_lift_of_stressPairing_ne_zero`; the
  certificate consumer `stressPairing_eq_zero_of_drawing` at `ZMod (p²)`; the spec (the hex shell at 11 passes with twelve
  nonzero defects cancelling, the collinear triangle at 3 obstructed — all decided); **the first instance**: the 1581's merged
  image at 131 is not a shadow — a 26-vertex, 48-edge witness stress, `IsStress` and pairing `7205 ≠ 0` decided, no lift
  modulo 131² and no covering tower certificate; **the second instance** (`Instances/LiftObstruction11.lean`): the 5-critical core of
  UD(𝔽₁₁,2) — a 9-vertex, 12-edge witness, pairing `33 ≠ 0` — has no lift modulo 121; the plane's clique number pinned (a
  triangle at 11, none at 19).
* **Instrument** (`tools/fplift.py`, 16 self-test controls green): `local` (rank, stresses, level-2 pairing with counts, a
  minimal-support witness, the gauge-fixed digit-by-digit Hensel lift of a Laman basis, per-edge first failing levels),
  `cores` (external cadical under `timeout`, sphere shrink, vertex shrink with necessity witnesses), `hubs` (the residue-point
  scan against a stage's own p-adic embedding, corrected to the largest consistent neighbour subset). Records in
  `data/fplane/` (`lift-*`, `core-*`, `hubs-*`; README rows with the licence column).

### §R1. The derivation, and what the controls taught it

The level-p² theorem is first-order rigidity in the dual numbers, and its kernel form uses only π² = 0 and π·netStress = 0 —
so the whole Hensel tower is that one theorem at π = p^k (§M1). Tested before any tactic: the closed hex shell at 11 has edge
defects 0, 3, 4, 0, 3, 3, 9, 8, 8, 0, 9, 8 and its self-stress pairs them to exactly −121 ≡ 0 (mod 121). Tested after: the
1581's injective sub-reduction at 131 passes all 4,450 stress conditions and the Laman-basis Newton lift has every one of its
7,541 edges unit to precision 131²⁰ with 3,091 fitted — and that configuration agrees with the 1581's tower coordinates
(embedded through Hensel-lifted roots) on 20,000 sampled pairwise quadrances: the residues determine the 1581 up to a
p-adic isometry, as the dichotomy says. **The controls corrected the derivation's scope:** the Moser spindle and Heule-510
at 11 read obstructed, and rightly — 11 is ramified in ℚ(√11), their coordinates live in ℤ₁₁[√11], and a ℤ₁₁-lift would put
√11 in ℚ₁₁. The lift needs an unramified degree-one prime; the reduction (M58's upper bound) does not. For fields over K the
lift's primes are 83, 107, 131, … — never 11, the prime that seals them.

### §R2. The kernel, read aloud against the claims

*"No choice of one point per residue class makes all 48 edges of this sub-framework unit modulo 131²"* —
`merged131_no_lift : ¬ ∃ y, IsLift 131 merged131x y merged131`, where `IsLift π x₀ y L` says every listed edge of `x₀ + π • y`
has quadrance one and, at `ZMod (131²)`, `x₀ + 131 • y` ranges over exactly the configurations with `x₀`'s residues
(`ZMod.exists_eq_add_mul_of_castHom_eq`). *"No valid tower certificate, drawn at level 131² through any hom out of any subring
with an inverse of its denominator, covers it with matching residues"* — `merged131_no_drawing`. What the kernel does NOT
say: that the merged image has no lift in ℤ₁₃₁² or in other number fields (the hand dichotomy, §S1), nor anything about
configurations not presentable as tower certificates. *"χ(H) ≤ χ(G) when H ≤ G.map f for injective f"* needs `Nonempty V`
and is false without it. The lift theorem's plane composite has one hypothesis no certificate decides, `¬ H.Colorable k` —
the refutation of the finite graph — and says so in its docstring.
* **Heule-510's hubs at 131, corrected scan (`data/fplane/hubs-heule510-p131.json`, 65 s):** 12,339 candidate residue
  classes; **1,171 carry a p-adic point at unit distance from ≥ 3 of the 510's points** to precision 131²⁰ (support 3: 511,
  4: 264, 5: 201, 6: 121, 7: 37, 8: 25, 9: 10, 10: 2) — each the unit-circumcentre of three of its neighbours, an exact point
  of Heule's field; the 11,168 others fit no three (false hubs of the finite plane). Missed by construction: hubs whose
  residue class a 510 vertex occupies (≈ 3 %).
* **The hubs are exact.** 100 random passers of the 1,171 verified in exact arithmetic (sympy over ℚ(√3,√5,√7,√11)): the
  unit-circumcentre of three supporting neighbours is at unit distance from EVERY supporting neighbour, 100 of 100.
* **P3, first half REFUTED (`build/m59/plane-p131-k5.log`).** The whole plane UD(𝔽₁₃₁, 2) at five colours — 85,805 variables,
  5,851,904 clauses, the origin and a unit triangle pinned — is UNDECIDED by the external cadical at the one-hour wall
  (exit 124, 59 min 37 s of CPU), although its spectrum proves ≥ 8. A Hoffman-carried refusal is not a CDCL-sized one at
  this scale (the M43 genre: "integrality-carried", resolution-hard). M58's k = 5 run on the 1581's 55-direction shadow at
  131 (17,161 vertices, degree 110) was likewise undecided at 3 h when this was written. The 6-critical core at 131 is
  therefore NOT produced this milestone; the calibration cores (5-critical at 11: 63 vertices; at 19: in flight) and the
  merged-image witness are the milestone's finite-plane objects, and P2 (every such core obstructed) stands untested at 131 —
  its derivation (§S1 (b)) says what the search would find. 83 and 59 follow in the chain, one hour each.
* **Gate (2026-09-06 22:28 and 22:40 UTC, `build/m59/gate-{build,axioms,lint}.log`):** `scripts/build.sh` OK; `scripts/axioms.sh`
  OK — 616 clean, 5 declared purchases (all M59 declarations on exactly `[propext, Classical.choice, Quot.sound]`: the lift
  theorem, the plane composite, the obstruction and its headline, the certificate consumer, the two instances' theorems);
  `lake lint` passed (after three field docstrings); zero `sorry`.
* **P7 measured, corrected scan (`data/fplane/hubs-degrey1581-p131.json`, 602 s):** of the 15,596 residue classes at 131 with
  ≥ 3 residue-neighbours among the 1581's 1,547, **3,739 carry a p-adic point at unit distance from ≥ 3 of the 1581's vertices**
  to precision 131²⁰ — support 3: 1,277; 4: 1,269; 5: 442; 6: 372; 7: 115; 8: 114; 9: 80; 10: 2; 11: 12; 12: 36; 13: 20 — each
  the exact unit-circumcentre of three of its neighbours in ℚ(√3, √5, √7, √11); the other 11,857 fit no three. None of these is in
  the gen-1 half-spindle closure (which has no point with ≥ 3 neighbours in the 1581): they are partner-lattice points with
  coincidences — the finite side's reading of de Grey's construction as a shrunk piece of a larger configuration, as Heule-553's
  discarded vertices are of the 510's. P7's "fewer than 50, all gen-1" is REFUTED in both halves.

### §R3. The measurements

| object | result | population / conditioning | record |
|---|---|---|---|
| the 1581's injective sub-reduction at 131 (1,547 residues, 7,541 edges) | rigid; 4,450 stress conditions all pass; the Laman-basis Newton lift has every edge unit mod 131²⁰; equal to the tower configuration on 20,000 pairwise quadrances | 3,091 edges fitted, 4,450 checked; 24 s | `lift-degrey1581-p131.json` |
| the 1581's merged image at 131 (34 identifications, 7,876 edges; ≥ 5-chromatic) | **OBSTRUCTED at level 2**: 2,406 of 4,785 stress conditions fail; witness 48 edges on 26 vertices, pairing 7205 | the kernel instance `Instances/LiftObstruction131.lean` decides it | `lift-degrey1581-p131-merged.json` |
| Heule-510's injective sub-reduction at 131 (507 residues, 2,483 edges) | passes 1,472 stress conditions and Newton to precision 131⁶ | self-test control | — |
| the Moser spindle at 83, 131 / at 11 | lifts (rigid, no stress, precision 12) / OBSTRUCTED — 11 is ramified in ℚ(√11) | self-test | — |
| Heule-510 at 11 (ramified) | OBSTRUCTED at level 2 | self-test | — |
| the hex shell at 11; the collinear triangle at 3 | passes (pairing 0 in ZMod 121, twelve nonzero defects cancelling) / obstructed (pairing 6 in ZMod 9) | decided in the kernel AND by the instrument (the two evaluators agree) | `Lift.lean` spec |
| hubs of Heule-510 at 131 | **1,171** residue classes carry an exact point at unit distance from ≥ 3 of the 510's vertices (support 3–10); 11 of the strict scan's 64 are Heule-553's discarded vertices; 100 of 100 sampled verified exactly | 12,339 candidates; missed: classes a vertex occupies | `hubs-heule510-p131.json` |
| hubs of the 1581 at 131 | **3,739** (support 3–13); none in the gen-1 closure; 60 random + the 5 of highest support verified exactly in the tower (65 of 65) | 15,596 candidates; 602 s | `hubs-degrey1581-p131.json` |
| UD(𝔽₁₃₁,2) at k = 5, whole plane | UNDECIDED at the one-hour wall (external cadical; spectrum says ≥ 8) | P3 refuted in this half | `build/m59/plane-p131-k5.log` |
| UD(𝔽₈₃,2) at k = 5, whole plane | UNDECIDED at the one-hour wall (6,889 vertices, 1,522,472 clauses) | — | `build/m59/plane-p83-k5.log` |
| UD(𝔽₅₉,2) at k = 5, whole plane | in flight (one hour; ends 00:25 UTC) | — | `build/m59/plane-p59-k5.log` |
| the 5-critical core of UD(𝔽₁₁,2) | **63 vertices, 246 edges**, six quadrances about the origin, 1-minimal (63 necessity witnesses); **rigid (rank 123 = 2n − 3), OBSTRUCTED at level 2 — 98 of 123 stress conditions fail; witness 12 edges on 9 vertices, pairing 33** — the plane's own 5-critical core is not a shadow (P2's analogue one level down; kernel instance `Instances/LiftObstruction11.lean`) | the solver's refusal (untrusted) + verified colourings; the obstruction decided | `core-p11-k4-spheres.json`, `lift-core-p11-k4-spheres.json` |
| the 5-critical core of UD(𝔽₁₉,2) | in flight (the sphere shrink; near-threshold asks at the 600-s wall) | — | `build/m59/cores-p19-k4.log` |

### §R4. Registered predictions, scored

| # | prediction | verdict |
|---|---|---|
| P1 | the smallest 6-critical subgraph of UD(𝔽₁₃₁,2) found has > 1,000 vertices | NOT TESTED — no 6-critical core at 131 was reached (P3) |
| P2 | every 6-critical core fails level 2 with a high obstruction count | NOT TESTED at 131; stands by derivation (§S1 (b)); its analogue one level down MEASURED — the 5-critical core of UD(𝔽₁₁,2) fails with 98 of 123; the merged image (a ≥ 5-chromatic subgraph) with 2,406 of 4,785 |
| P3 | cadical refutes five colours on the whole plane at 131 within an hour; at 59 it does not | **first half REFUTED** (undecided at 1 h); 59 in flight |
| P4 | the injective sub-reduction passes to 131²⁰ and equals the tower coordinates; the merged image is obstructed at level 2 | **MET, all three parts** |
| P5 | every core found is infinitesimally rigid at its residues | **MET on the 11-core** (rank 123 = 2n − 3); the 19-core in flight |
| P6 | the sphere-minimal ≥ 6 object at 131 has 20–60 spheres | NOT TESTED |
| P7 | fewer than 50 hub passers on the 1581, all gen-1 residues | **REFUTED in both halves**: 3,739, none in gen-1 |
| P8 | `Lift.lean` on the standard three, the obstruction theorem under 250 lines | **MET** (the module is 320 lines with its spec; the obstruction section is 90) |
| P9 | the 1581's shadow at 131 is 5-colourable (M58's P7) | UNDECIDED at four hours (the external timeout killed the run; M58 §R3 addendum) |

### §R5. Incidents and instrument facts

* Three self-test controls were wrong and the instrument right (the Moser spindle and Heule-510 at the RAMIFIED prime 11;
  a degree-2 hub can never be inconsistent) — G21 on controls, three times in one milestone; each corrected control now
  states the derivation it rests on.
* The strict hub test was wrong on every dense reduction (false residue-neighbours; found by the deleted-vertex control
  reading RED on the 1581, though GREEN on Heule-510's centre by luck); corrected to the largest consistent subset.
* `hensel_sqrt` squared its modulus per step (p^(2^20)); found by a 600-s stall; fixed with a convergence assert.
* The sphere shrink protected the origin and then found it deletable — an assert fired as designed; the shrink now tries
  protected vertices last.
* A killed chain step let its parent chain move on to the next step, doubling a run — killed by PID; the stub rule for
  chains: kill the chain's shell first.
* The `netStress` selector form costs 0.7 ms per vertex–edge pair in `decide`; a thousand-vertex instance would be 35 min
  — the minimal-support witness design (§M2) made the instance 48 edges and seconds.

### §R6. The kernel, and what the milestone did not do

Kernel: §R0, §R2, the gate in §R-notes. Not done: a 6-critical core of any finite plane (FS-13); the algebraic recognition of
a passing Newton lift by LLL (`recognize` — unneeded: every passing object was either a real object whose tower coordinates
were the check, or a hub, exact by circumcentre); the level-p³ instance of the tower (one theorem, never instantiated); the
kernel form of the rigid dichotomy (hand derivation, §S1).

### §R7. What this changes for the hunt

* **The lift question is answered structurally, not by search.** A subgraph of a finite plane lifts only if it is a shadow,
  and being 6-critical in the plane is no evidence of that: the obstruction is ≥ |V|/2 + 3 independent linear conditions,
  and the finite plane's 6-forcing is Kloosterman-carried, global, and made of edges unit modulo p only. The route "design in
  the finite plane, lift to the field" is closed as a way to FIND a 6-forcer; what survives is its converse — the finite plane
  as an exact, cheap FILTER on designs made in the field.
* **The filter has teeth and a new instrument.** The level-p² test decides in seconds whether a residue configuration is any
  configuration's shadow; the hub scan enumerates, over every field with an unramified degree-one prime above p at once, the
  points at unit distance from ≥ 3 vertices of an object — 3,739 for the 1581, 1,171 for Heule-510 — recovering discarded
  construction points (Heule-553's) and exposing the objects as shrunk pieces of larger configurations (FS-12).
* **The lift's primes are the unramified ones.** For fields over K: 83, 107, 131, …; the prime that seals (11) is never a
  lift's prime — the upper bound and the lower bound use different primes of the same field.
* **The finite planes' 6-critical cores are for autopsy** (FS-13), not for lifting; and CDCL does not see a spectral refusal
  at 17,161 vertices in an hour.
* **The corrected scan's positive control on the 1581 (`build/m59/hubs-degrey-recover.log`):** deleting vertex 0 (degree 60),
  vertex 100 (degree 12) and vertex 700 (degree 8) in turn, the scan recovers each deleted residue as a passer with support
  exactly its degree — 60 of 66, 12 of 16, 8 of 17 residue-neighbours, the false ones excluded — among 3,740 / 3,737 / 3,734
  passers (hubs whose third neighbour was the deleted vertex drop out). The scan is sound on the dense object; the strict
  form's zero was the instrument, not the 1581.
