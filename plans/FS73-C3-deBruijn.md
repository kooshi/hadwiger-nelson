# FS-73 C3-inherit — de Bruijn's working file

*Competitor: de Bruijn (Opus 5.5). One writer. Started 2026-09-23. Retractions are kept and marked `RETRACTED`.*

## §1. First route (written before any message to Poros)

### 1.0 What the two instances actually test

In both proved instances `P` has finite index. There (FS-73 §0, consequence 3) C3 at Λ ⟺ `F` has finite index ⟺ the colouring
shift `X` is **finite** (every colouring periodic). So both instances are *rigidity* results, and neither tests inheritance: `H1`
was never known there except as a corollary of forcing. Any class theorem that implies `P ≤ F` for a class containing them must,
applied to them, prove that every colouring is periodic — it must re-derive the certificates. So the prize is a **derivation of
rigidity**, and the challenge's "class containing both" is satisfied tautologically by `{F of finite index}`. I take the prize to
be: a *checkable arithmetic condition* on `(Λ, U)` that implies every colouring is periodic with a named period, and that holds at
both instances.

### 1.1 Route A (three colours): heights and the rotation set Θ

- `Cay(ℤ^m, ±e_j) → Cay(Λ, U)` (m = |U|/2) is a graph covering with deck group the relation lattice `R`.
- A proper 3-colouring `c` has steps `c(x+u) − c(x) ∈ {±1} ⊂ ℤ/3`. Every commutation square has winding 0 (four ±1's summing to a
  multiple of 3 sum to 0), so `c` lifts to a **height function** `h: ℤ^m → ℤ` (steps ±1) with
  `h(n + r) = h(n) + 3W(r)` for a homomorphism `W: R → ℤ`.
- Lipschitz + Hahn–Banach + parity ⟹ `W` is realised by a point of the **rotation set**
  `Θ₃(Λ,U) = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(u) ∈ [1/3, 2/3] for all u ∈ U}` — the circular-colouring region.
- Every θ ∈ Θ₃ gives a proper colouring `c_{θ,β}(x) = ⌊3{θ(x)+β}⌋` (circular colouring); periodic iff θ rational.
- **Candidate Theorem 1.** If Θ₃ consists only of points of order 3 (θ(U) ⊆ {1/3, 2/3}), every proper 3-colouring is affine
  (`c = φ + const`, φ: Λ → 𝔽₃ additive), so `F = P = ⋂ ker φ`. Proof idea: the fibre of `W` is convex and maps into the finite
  Θ₃, so it is a point; a point fibre at a cube vertex means the oriented vectors `{φ(u)u}` positively span, which gives a
  strictly positive relation, which is *tight* (`|3W(r)| = |r|₁`), which freezes every step.
- **Prediction:** at ℚ(√11)'s Λ₁₀, Θ₃ is exactly the 16 affine points, so Theorem 1 derives `F = P = 3Λ` with no forcer.

### 1.2 Route B (four colours at K): circular + residue

- Guess to test: the 12 colourings of de Grey's lattice are 2 residue colourings (𝔽₄-valued, G70) plus **circular** colourings
  `⌊4{θ(x)+β}⌋` at points θ of order 8 of `Θ₄ = {θ(U) ⊆ [1/4, 3/4]}` — which would explain the period 8 = 2k.
- A rigidity theorem at 4 colours needs a substitute for the height lift (K₄ has none). Open.

### 1.3 Route C (counterexample, abstract class)

- In rank 1 the question is decidable (window graph, SCC poset): a counterexample is a one-way domain wall between rigid phases.
  Symmetries (colour permutations preserve direction, reversal reverses it) constrain which phases can be joined. Kept as the
  fallback line.

## §2. Claims and retractions

### C1 [hand] — the height lift and the rotation set (three colours, every lattice)

Setting (the class every C1–C2 statement is proved on): Λ a **finitely generated torsion-free** abelian group of rank r, U = −U ⊂ Λ finite spanning, `u₁..u_m` one per ± pair, `π: ℤ^m → Λ`, `e_j ↦ u_j`,
`R = ker π` (saturated: ℤ^m/R ≅ Λ is torsion-free). `Θ₃ = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(u) ∈ [1/3, 2/3] ∀u ∈ U}`.

**Lemma L1 (lift).** Every proper 3-colouring `c: Λ → ℤ/3` has a height `h: ℤ^m → ℤ`, `h ≡ c∘π (mod 3)`,
`|h(n+e_j) − h(n)| = 1`, and a homomorphism `W: R → ℤ` with `h(n + ρ) = h(n) + 3W(ρ)` for all n, ρ ∈ R.
*Proof.* `c∘π` properly 3-colours the grid `Cay(ℤ^m, ±e_j)`. Lift each step to ±1; a unit square's four lifted steps sum to a
multiple of 3 in {−4,…,4} and are even, so to 0; squares generate the grid's cycle space, so `h` exists. `h(n+ρ) − h(n)` is
≡ 0 (mod 3), and moving n by e_j changes it by the difference of two lifted steps with the same residue, i.e. by 0. ∎

**Lemma L2 (the rotation set).** For every proper 3-colouring, `W` is realised by some θ ∈ Θ₃: there are z ∈ ℤ^m and a real
linear ψ on Λ⊗ℝ with `y_j := z_j + ψ(u_j) ∈ [1/3, 2/3]` for all j and `W(ρ) = ⟨2y − 𝟙, ρ⟩` for ρ ∈ R; θ = ψ mod Hom(Λ,ℤ).
*Proof.* `|3W(ρ)| = |h(n+ρ)−h(n)| ≤ |ρ|₁` and `3W(ρ) ≡ Σρ_j (mod 2)` (a path of |ρ|₁ steps of ±1). Hahn–Banach for the ℓ¹
norm: `W = ⟨s, ·⟩/3` on R with `‖s‖_∞ ≤ 1`. Put `y = (s + 3𝟙)/6 ∈ [1/3,2/3]^m`; parity gives `⟨y, ρ⟩ = (W(ρ)+Σρ_j)/2 ∈ ℤ`.
R is a direct summand, so `y|_R = z|_R` for some `z ∈ ℤ^m`, and `y − z` vanishes on R, i.e. is `ψ∘π`. ∎
*Second route, no Hahn–Banach (Poros, 2026-09-23):* the lifted step `s_j(x)` depends only on x = π(n); its average `a_j ∈ [−1,1]`
under an invariant mean on Λ satisfies `⟨a, ρ⟩ = 3W(ρ)` exactly (average the path sum along ρ), so the colouring's own mean
slope is a point of its fibre.

**Lemma L3 (circular colourings).** For θ ∈ Θ₃ and β ∈ ℝ/ℤ, `c_{θ,β}(x) = ⌊3{θ(x) + β}⌋` is a proper 3-colouring (two points
of ℝ/ℤ at circular distance ≥ 1/3 lie in different half-open thirds). It is `ker θ`-periodic, hence periodic iff θ is rational.

**Theorem T0 (three colours: colourable ⟺ Θ₃ ≠ ∅ ⟺ periodically colourable).** `Cay(Λ, U)` is 3-colourable iff Θ₃ ≠ ∅, and
then it has a periodic 3-colouring. *Proof.* L2 gives ⟹; Θ₃ is a finite union of polytopes cut out by integer forms with bounds
in (1/3)ℤ, so nonempty ⟹ it has a rational vertex, and L3 colours periodically. ∎ So **C3-aper holds at k = 3 for every
lattice** (the question `[AbrishamiEtAl2025]` Problem 4.6 asks for ℤ^d, here answered at three colours for abelian Cayley graphs).

**Theorem T1 (three-colour rigidity).** If every point of Θ₃ has order 3 (θ(U) ⊆ {1/3, 2/3}), then every proper 3-colouring of
`Cay(Λ, U)` is affine, `c = φ + const` with `φ = −3θ: Λ → 𝔽₃` additive, and `F = P = ⋂_{θ ∈ Θ₃} ker θ ⊇ 3Λ`.
*Proof.* Fix c, its W, and the fibre `Φ = {y ∈ [1/3,2/3]^m : y ∈ y₀ + (R^⊥)}` (all y as in L2 for this W; convex). Its image in
the torus lies in Θ₃, which is finite; Φ is connected and `y ↦ θ` is a local homeomorphism onto its image, so Φ is one point
y₀, a cube vertex (order 3). Put `σ_j = +1` if `y₀_j = 1/3`, `−1` if `2/3`. Uniqueness of y₀ means no nonzero real ψ has
`ψ(σ_j u_j) ≥ 0` for all j, so (**Stiemke's** alternative — U spans; Gordan's would only give a ≥ 0, a ≠ 0; name corrected on Poros's reading) there are integers `a_j > 0` with `Σ a_j σ_j u_j = 0`: a relation `ρ = Σ a_j σ_j e_j`.
Then `W(ρ) = ⟨2y₀ − 𝟙, ρ⟩ = −(1/3)Σ a_j`, so `|3W(ρ)| = |ρ|₁`: along any monotone path from n to n+ρ every lifted step
equals −1 in the oriented sense, so `h(n + σ_j e_j) − h(n) = −1` for every n and every j. Hence h is linear and c is affine
with `φ(u_j) = −σ_j`. Every affine colouring is `ker φ`-periodic, so `F = P = ⋂ ker φ`. ∎

**Instance, ℚ(√11)'s Λ₁₀ [tools, exact].** Θ₃(Λ₁₀) computed exactly (own two-phase simplex with Bland's rule over
Fractions, DFS over integer shifts, 1,803 nodes, 24 leaves): **exactly 16 points, every one of order 3.** T1 then gives: every
3-colouring is affine (16 functionals × 3 constants = 48, the census's count), and F = P = 3Λ once the 16 functionals span
the dual of Λ/3Λ (they are `(±1,±1,±1,±1)` in the dual basis of the four residue directions; the census's separators confirm
`P ⊆ 3Λ`). **This derives the ℚ(√11) instance with no forcer and no solver.** Script: `data/fs73/c3-debruijn/theta_x.py`, `data/fs73/c3-debruijn/xlp.py`,
`data/fs73/c3-debruijn/q11_theta_x.py`.

### C2 [hand] — frozen coordinates, and C3 at three colours outside a torsion case

For a colouring c with winding W, let Φ be its fibre (C1) and **J(c)** its *frozen* coordinates: the j with y_j constant on Φ
(Φ's implicit equalities). Let `Λ_J = span_ℤ{u_j : j ∈ J}` and `sat(Λ_J) = (Λ_J ⊗ ℚ) ∩ Λ`.

**Lemma L4 (frozen = tight).** j ∈ J ⟺ some relation `μ ∈ R` with `μ_j ≠ 0` is W-tight (`|3W(μ)| = |μ|₁`) with signs matching
y₀ (μ_j > 0 only where y₀_j = 2/3, < 0 only where 1/3). Then every step of h along `±e_j`, j ∈ J, is the same at every n, so
**c is affine along Λ_J**: `c(x + λ) = c(x) + φ_J(λ)` for λ ∈ Λ_J, with φ_J additive. *Proof.* LP duality for implicit
equalities of `{1/3 ≤ y ≤ 2/3} ∩ (y₀ + R^⊥)`, then the monotone-path argument of T1. ∎

**Theorem T2 (three colours).** Let δ ∈ P (every periodic 3-colouring identifies 0 and δ). Then for every proper 3-colouring c:
(i) θ(δ) = 0 for every θ in c's fibre; (ii) δ ∈ sat(Λ_J(c)); (iii) if q is the order of δ in `sat(Λ_J)/Λ_J`, then qδ is a period
of c, and `g(x) = c(x+δ) − c(x)` is Λ_J-periodic. **Hence C3-inherit holds at k = 3 for every lattice all of whose colourings have
saturated frozen sublattices** (in particular whenever J(c) is empty — then δ = 0 — or everything — T1).
*Proof.* (i) The fibre is a rational polytope; its rational points θ give periodic circular colourings, which identify 0 and δ
for every phase β only if θ(δ) = 0; closedness extends this to the whole fibre. (ii) (i) says ψ(δ) is constant on Φ, so ψ'(δ) = 0
for every ψ' in the direction space of Φ's affine hull, which is `{ψ' : ψ'(u_j) = 0 ∀ j ∈ J}`; so δ ∈ span_ℝ(u_J). (iii) c is
affine along Λ_J (L4), and the circular colourings in the fibre have the same frozen steps, so `φ_J(qδ) = 0` because they
identify qδ. ∎

**The residual case, named (fallback (d) at k = 3).** A counterexample to C3 at three colours must have a colouring whose frozen
sublattice Λ_J has rank < r (else c is periodic) **and is not saturated**, with δ ∈ sat(Λ_J) \ Λ_J and g ≢ 0. Not constructed;
not excluded. (Coxeter's hint suggests he may close it; I have not.)

### R1 — RETRACTED (a labelled guess, failed; Poros counts it as a failed guess, not a retraction — I keep it here anyway) (Route B): "the 10 non-residue classes at K are circular colourings of order 8"

Refuted from the record (Poros card 1, `data/fs73/records/phase-P1.md` Task 3): a circular colouring's period group is `ker θ`, so
its `Λ/Per` is cyclic; 10 of the 12 classes have non-cyclic `Λ/Per` (ℤ/2 × ℤ/8 ×8, ℤ/2 × ℤ/4, and the residue pair (ℤ/2)²,
which Route B already assigned to G70), so the guess **misses 9 of 12** (Poros's count). At most the ℤ/8 and ℤ/4
classes can be circular (the ℤ/4 one is Fischer's additive colouring = the order-4 circular colouring). The shape that fits the
ℤ/2 × ℤ/8 classes is a **two-character** colouring, `c(x) = ⌊4{θ(x) + ψ(x)/8 + β}⌋` with θ of order 8 and ψ: Λ → ℤ/2 (proper iff
`θ(u) ∈ [1/4, 3/4]` where ψ(u) = 0 and `θ(u) ∈ [3/8, 5/8]` where ψ(u) = 1) — written down, **not tested**.

### C3 [tools, exact] — known-answer controls for Θ₃ (Poros card 2)

| lattice | field | |U| | known answer | Θ₃ computed exactly | agrees |
|---|---|---|---|---|---|
| Λ₁₀ | ℚ(√11) | 36 | 3-colourable, all 48 colourings affine (census, verified) | 16 points, all of order 3 | yes |
| `Ld65c8ee8` (M = 30) | ℚ(√59) | 36 | periodically 3-colourable (FS-61 `shapes.md` l. 36) | 4 points, order 9 (nonempty; T1 does not apply) | yes |
| `Ld65c8ee8` | ℚ(√35) | 36 | periodically 3-colourable | 8 leaves, none a point — positive-dimensional pieces (flexible) | yes |
| `Ld65c8ee8` | ℚ(√11) | 108 | **refuses** 3 colours (FS-61, ball of 45,521 points) | withdrawn for lock time — **not run** | — |
| de Grey's lattice (K, rank 4, 54 vectors) | ℚ(√3,√11) | 54 | **refuses** 3 colours (Moser spindle) | **EMPTY** (7,215 nodes, 0 leaves) | yes |

Instrument: `data/fs73/c3-debruijn/theta_x.py` (DFS over the integer shifts `n_j` with `θ(u_j) ∈ [n_j + 1/3, n_j + 2/3]`, pruned by an exact
two-phase simplex, Bland's rule, over Fractions, `data/fs73/c3-debruijn/xlp.py`); fundamental domain `[0,1]^r` closed, points identified mod ℤ^r.

## §3. Outcome (for the product owner)

**Classification: not landed** — for the challenge as posed (a class containing *both* instances). What did land, each as
exactly what it is:

- **(c) A sufficient condition, with one instance derived — T1.** At three colours, if the rotation set Θ₃(Λ, U) consists of
  points of order 3, every proper 3-colouring is affine and `F = P`. Θ₃ is a finite, exact polyhedral computation on the torus
  `Hom(Λ, ℝ/ℤ)`. At ℚ(√11)'s Λ₁₀ it is exactly 16 points of order 3, so **`F = P = 3Λ` is derived with no forcer and no solver**
  — the prize for one of the two instances. The class does not contain K (four colours).
- **(c′) A wider class at three colours — T2.** C3-inherit holds at k = 3 for every lattice all of whose colourings have
  saturated frozen sublattices.
- **(a) Sharpened reductions.**
  - *T0:* at k = 3, `Cay(Λ, U)` is 3-colourable ⟺ Θ₃ ≠ ∅ ⟹ it has a periodic (circular) 3-colouring. So **C3-aper holds at
    k = 3** for every f.g. torsion-free abelian Cayley graph, and 3-colourability of a lattice is a finite exact computation.
  - *The challenge is subtly about rigidity.* In the finite-index regime, C3 at Λ ⟺ the colouring shift is finite. So the two
    proved instances never tested inheritance; any class theorem covering them must re-derive rigidity. T1 is such a
    derivation at k = 3.
- **(b) K not explained.** The three-colour mechanism is a height lift through the covering `Cay(ℤ^m) → Cay(Λ, U)`. It needs the
  target K₃ = C₃, whose universal cover is a line, so that a colouring becomes an integer height. K₄ contains 4-cycles and its
  clique complex is simply connected, so four-colourings carry no winding homomorphism. Nothing replaces W at k = 4 here. Route B
  (circular colourings) can reach at most 2 of K's 12 classes (R1).
- **(d) Candidate counterexample shape at k = 3.** A colouring whose frozen sublattice has rank < r and is not saturated, with
  δ ∈ sat(Λ_J) \ Λ_J. Deciding it: build a height function on ℤ^m whose W-fibre has such a J, and test whether δ ∈ P. Not attempted.

**Prior art (WORKFLOW 3.2; zbMATH API, 2026-09-23).** Queries run: circular chromatic number × distance graph (9 hits: Zhu,
Liu–Zhu, Chang–Liu–Zhu, Liu's 2008 lonely-runner survey); hom-shifts (Chandgotia–Marcus 2018; Gangloff–de Menibus–Oprocha 2026);
3-colourings × height (Chandgotia–Peled–Sheffield 2021); uniquely colourable Cayley graphs (Klotz–Sander 2017 and a 2026
sequel); distance graphs × 3-colourable, × lonely runner. **Held as known in spirit:** the 3-colouring height lift on grids (the
square-ice / six-vertex correspondence, and Chandgotia's hom-shift heights for four-cycle-free targets); circular colourings
and κ(D) for distance graphs. **Not found:** T0 in rank r ≥ 2 for an arbitrary finite generating set, i.e. the covering from
a general U to the standard grid; T1's order-3 criterion. T0's rank-1 case, "G(ℤ, D) is 3-colourable ⟺ κ(D) ≥ 1/3", was **not
found stated** in the searches listed, so it is claimed only as "not found in the literature searched". Reading status: every
item above is **title or summary only**. The review texts behind the Chandgotia hits are licence-blocked in zbMATH.

**Instrument control (exact simplex).** `data/fs73/c3-debruijn/xlp.py` against HiGHS on 400 random LPs (4 variables, 2–12 rows, bounds
[0,1]): 116 feasible, with the returned point re-checked exactly and the optimum matched within 1e−7; 284 infeasible, and
HiGHS agrees on every one. 0 mismatches.

### C4 [tools, capped] — the ℚ(√167) survivors (outside the scoring; the PO's conditions)

- `Ld14c588b` (M = 348, |U| = 44): my run was stopped by the PO at about 20 s. The lattice is already settled: it is
  3-colourable by an exact periodic colouring of index 1,080, verified by the PO. Consistent with T0: Θ₃ ≠ ∅ there.
- `L21cc6506` (M = 420, |U| = 60, complete, 30 ± pairs): exact Θ₃ DFS **stopped at the 20-CPU-minute cap, undecided**. No leaf
  had been reported and no verdict was reached; nothing is claimed. The run is not checkpointed, so a relaunch redoes all of it.
  Post-competition item. Tool: `data/fs73/c3-debruijn/q167.py`, `data/fs73/c3-debruijn/theta_x.py`, `data/fs73/c3-debruijn/xlp.py`. Command:
  `flock -w 7200 <lock> python3 -u q167.py 420 L21cc6506`. The obvious speed-up is to prune in floating point with HiGHS and
  re-check every pruned node exactly, via the phase-1 dual as a Farkas certificate. The pure-Fractions simplex is the
  bottleneck.
- On certificate form (the PO's standard): my emptiness verdicts come from exact arithmetic end to end, since the simplex runs over
  Fractions. They are **not** stored as Farkas vectors per leaf. To meet the standard a reviewer re-checks without the tool, the
  pruned nodes' phase-1 duals must be exported. That is not done.

### C5 [tools, running] — negative control: de Grey's lattice at k = 3

It contains the Moser spindle, so it is not 3-colourable, and T0 says Θ₃ must be EMPTY. **Result: EMPTY.** The exact DFS
visited 7,215 nodes and found 0 leaves, in 97 s (`k_theta3.out`). So the instrument has now been seen to give both answers: nonempty at Λ₁₀,
`Ld65c8ee8`/59 and `Ld65c8ee8`/35, and empty at de Grey's lattice. The FS-61 control over d = 11 (108 vectors) was withdrawn in
its place for lock time. **Not run.**

## §4. Four colours: where T0 breaks, and the nearest certificate (for Kooshi's question)

**Where it breaks, exactly.** Three steps of C1 are generic: the covering `Cay(ℤ^m) → Cay(Λ, U)`, Lipschitz, and Hahn–Banach.
The one step that uses three colours is **L1's lift**. A proper colouring is a homomorphism to K₃ = C₃, whose universal cover is
the line ℤ. A commutation square maps to a closed 4-walk in C₃, and every such walk is null-homotopic, because C₃ has no 4-cycle.
So every colouring becomes an integer height with a winding homomorphism W: R → ℤ, and W is a point in a finite-dimensional
space. Hence a finite polyhedral set Θ₃ contains a trace of *every* colouring, and T0 is two-sided. **K₄ contains 4-cycles.** A
commutation square can map onto a non-contractible 4-cycle of K₄, so there is no winding homomorphism and no finite-dimensional
set that every 4-colouring must visit. This is Chandgotia's dividing line for hom-shifts (four-cycle-free targets have heights).
T0 survives exactly for targets without 4-cycles:
- **T0 generalised [hand, same proof]:** `Cay(Λ, U) → C_{2l+1}` exists ⟺ some θ has `θ(U) ⊆ [l/(2l+1), (l+1)/(2l+1)]`.
- So χ_c ≤ 2 + 1/l is decided by characters. **χ ≤ 4 is not of this form.**

**The nearest four-colour certificates, each one-sided.**
1. *Θ₄ ≠ ∅ ⟹ periodically 4-colourable* (L3 with k = 4). This direction proves colourability, not a need for five colours.
   Emptiness proves nothing: de Grey's two residue colourings are not circular, since `Λ/Per = (ℤ/2)²` is not cyclic.
2. *Given a finite-index forced group F* (a finite forcing certificate, as at K), 4-colourability ⟺ 4-colourability of the finite
   quotient `Cay(Λ/F, Ū)`. So refusing the quotient (exhaustively, or by its Hoffman bound where it is tight: G54) proves five
   colours with no search on Λ. Conditional on F.
3. *Fractional:* every colouring's colour classes have invariant-mean densities, so `χ ≥ 1/α_Λ`, where α_Λ is the largest density
   of an independent set. That density is bounded by a torus LP (Delsarte/Hoffman on `Hom(Λ, ℝ/ℤ)`). This is a genuine
   solver-free certificate, but it proves `χ ≥ 5` only when `χ_f > 4`. Where the obstruction is integrality (G24, G38), no such
   certificate exists.
(Θ₄ at K was launched to test which census classes are circular, and **stopped by me after about 4 CPU minutes, undecided**,
to free the lock for ℚ(√167). Script `data/fs73/c3-debruijn/k_theta4.py`. Not run to completion.)
4. *Two-character family (untested).* `c = ⌊4{θ + ψ/8 + β}⌋` with ψ of order 2 has a finite-dimensional parameter set. It is a
   sufficient-colourability family again, never a refutation.

**What two-sidedness would take.** An invariant carried by *every* 4-colouring, living in a finite-dimensional or compact space,
such that a finite polyhedral condition on it is necessary for existence. The height/winding plays that role at three colours.
Candidates at four colours:
- a winding through a four-cycle-free graph that every 4-colouring of *this* lattice factors through (true only if the lattice
  forbids the colourings that use a 4-cycle of K₄ around a commutation square; checkable per lattice, never generic);
- the 𝔽₄-difference labels on triangles, the Tait / Kondev–Henley 3-edge-colouring heights (2-dimensional heights), available
  when U ⊃ μ₆ and triangles generate enough of the cycle space.

Neither is shown. **I cannot claim that no certificate exists.** Such a claim would need a 4-colourable lattice with no periodic
4-colouring, and C3-aper at k = 4 is open.

## §5. Theorems this phase proved (WORKFLOW step 7 heading)

| id | statement (one line) | grade | where |
|---|---|---|---|
| dB-L1 | every proper 3-colouring of `Cay(Λ,U)` (Λ f.g. torsion-free) lifts to a height on ℤ^m with winding `W: R → ℤ` | hand | §2 C1 |
| dB-L2 | W is realised by a point of `Θ₃ = {θ(U) ⊆ [1/3,2/3]}` (Hahn–Banach, or the invariant-mean slope, Poros's route) | hand; second reading Poros | §2 C1 |
| dB-L3 | every θ ∈ Θ₃ gives the proper circular colouring `⌊3{θ+β}⌋`, periodic iff θ is rational | hand | §2 C1 |
| dB-T0 | 3-colourable ⟺ Θ₃ ≠ ∅ ⟹ periodically 3-colourable (C3-aper at k = 3); same for `C_{2l+1}` with band `[l, l+1]/(2l+1)` | hand | §2 C1, §4 |
| dB-T1 | Θ₃ ⊆ points of order 3 ⟹ every 3-colouring is affine and `F = P` | hand | §2 C1 |
| dB-T1-Q11 | Θ₃(Λ₁₀) = 16 points of order 3, so `F = P = 3Λ` at ℚ(√11), with no forcer | tools, exact + hand | §2 C1 |
| dB-L4 | frozen coordinates are the supports of W-tight relations; c is affine along Λ_J | hand | §2 C2 |
| dB-T2 | at k = 3, δ ∈ P ⟹ δ ∈ sat(Λ_J(c)) for every colouring c; C3 holds when every Λ_J is saturated | hand | §2 C2 |
| dB-C | controls: Θ₃ nonempty at `Ld65c8ee8`/59 (order 9) and /35 (positive-dimensional); empty at de Grey's lattice | tools, exact | §2 C3, C5 |

Retractions: 1 (R1, a labelled guess that failed; Poros counts 0). Poros's precision notes (Stiemke, not Gordan; torsion-free;
9, not 10) are applied in place above.
