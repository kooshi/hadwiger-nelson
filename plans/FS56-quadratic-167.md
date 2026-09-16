# FS-56 — ℚ(√167): the subplan

*Opened 2026-09-16 by Kooshi ("You are go for 167"). The stub `plans/STUB-quadratic-167.md` holds the motivation and every
number it rests on; this file is the execution plan and supersedes the stub's §3–§5 where they differ. Written for a session
with no memory. Read beside: `CLAUDE.md` G55 (chain theorem), G56 (window, 2-adic trichotomy), G59 (the wall and the
conjecture's prediction); `BIBLIOGRAPHY.md` `[MatolcsiEtAl2025]`, `[DuczVarga2026]`, `[AmbrusEtAl2023]`, `[KMOR2016]`,
`[CranstonRabern2015]`, `[Fischer1990b]`.*

**The object.** `F = ℚ(√167)`, and its plane `F²`: the points `(x, y)` with `x, y ∈ F`, two joined when `x² + y² = 1` for their
difference. As a graph it is the Cayley graph of the abelian group `(F(i), +) ≅ ℚ⁴` on the norm-one elements `U_F` of
`F(i)/F`, and its isometry group `F(i) ⋊ (U_F ⋊ ⟨conj⟩)` is solvable. It has no `√3`, hence no unit triangle (G57). Its
places where the unit circle is **compact** (a finite plane or a real circle the residue method can see) are the two real
places, the usable primes 23, 43, 59, 67, 71, 79, 83, … and the ramified prime 167; at 2, 3, 5, 7, 11, 13, 17, 19, … the circle
is split.

---

## §0 What landed at the opening (2026-09-16), before this plan was written

### Q0 — five colours refused at 23, by exact certificate — **LANDED**
* `data/fs54/cert-q23-l3-N105.json` (sha256 `8fe36870…`): **α(UD(𝔽₂₃,2)) ≤ 105**, exact `N = 105.430586566`, from the level-3
  relaxation's calibration iterate (3,500 iterations; float reading 105.430580; rounding loss 6.6·10⁻⁶). Producer
  `tools/fs54_l3_cert_round.py`, 99,481 orbit variables, CERTIFIED in 6 s by the producer's run and **re-run by the PO in a
  fresh process, 24 s single-threaded, CERTIFIED** (`data/fs56/q0/recheck-po.log`). **Planted-fault controls 5/5 as designed**
  (`data/fs56/q0/controls.json`): a flipped multiplier sign, an indefinite dense block, a bumped Gram entry and a lowered N
  each refused for their named reason, and the faithful dense twin passed.
* **Consequences.** `5 · 105 = 525 < 529`, so **χ(UD(𝔽₂₃,2)) ∈ {6, 7, 8}**. The window's floors are now **6, 6, 5, 6, 6** at
  23, 27, 31, 43, 47 (and 6 at U₆₄): five is open only at 31. FS-17's first digit is half-answered (23 is not five-chromatic).
  `L(ℚ(√167)) ≥ 6`, so **the conjecture predicts χ(ℚ(√167)²) ≥ 6** (6 if Γ₂₃ or Γ₄₃ is six-chromatic, else 7 by the bold form).
  The kernel consumer already exists and asks for exactly this hypothesis:
  `six_le_chromaticNumber_finitePlane23_of_indepNum_le` (`Instances/IndependenceThreshold.lean`), whose docstrings still call
  it open (phase E).
* The float reading was 0.57 below the threshold and the certificate lost 7·10⁻⁶ of it: the stub's expectation "Q0
  certifies" is **WON**.

### The prior-art gate turned up the milestone's instrument (§PA)
The fractional side of Hadwiger–Nelson (`[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`, `[DuczVarga2026]`) proves bounds on
`χ_f(ℝ²)` through the **geometric fractional chromatic number** `χ_gf(H)` of a finite graph `H` — a fractional colouring whose
aggregate weight on a point set depends only on its congruence class — and a **blow-up** (MRVZ Theorem 1): finitely many
congruent copies of `H`, indexed by a Følner set of the countable solvable group the congruences generate, carry fractional
chromatic number `≥ χ_gf(H) − ε`. **That proof never leaves the field `H` lives in** (§1). So every finite `H ⊂ F²` with
`χ_gf(H) > k` proves `χ(F²) ≥ k + 1` for any subfield `F ⊆ ℝ`. This is the first instrument this project holds that can see
**non-local, non-residue** obstructions over a field — exactly what ℚ(√167) requires, since every residue plane it has is
≥ 6-chromatic and useless for a lower bound, and the chain theorem needs a forcer nobody knows how to build without triangles.

---

## §1 The derivation the milestone rests on (phase B) — [hand; checked against MRVZ §3 line by line]

**Lemma B1 (congruences are field-rational).** Let `F ⊆ ℝ` be a field and `Y, Y′ ⊂ F²` with `|Y| ≥ 2`. Every Euclidean
isometry `φ` with `φ(Y) = Y′` is `z ↦ u z + t` or `z ↦ u z̄ + t` with `u ∈ F(i)`, `u ū = 1`, `t ∈ F(i)`.
*Proof.* Pick `y₁ ≠ y₂ ∈ Y`. An isometry of `ℂ` is `z ↦ uz + t` or `z ↦ u z̄ + t` with `|u| = 1`. In the first case
`u = (φ(y₂) − φ(y₁))/(y₂ − y₁) ∈ F(i)` and `t = φ(y₁) − u y₁ ∈ F(i)`; in the second `u = (φ(y₂) − φ(y₁))/(ȳ₂ − ȳ₁)`, also in
`F(i)` because conjugation preserves `F(i)` (`F` is real). `|u| = 1` and `u ∈ F(i)` give `u ū = 1` in `F`. ∎

**Lemma B2 (the blow-up over a field).** For every subfield `F ⊆ ℝ`, every finite `H ⊂ F²` and every family `𝒞` of pairs of
congruent subsets of `H` (each of size ≥ 2), write `χ_gf(H; 𝒞)` for the least weight of a regular fractional colouring of `H`
whose aggregate functional agrees on every pair in `𝒞`. Then for every `ε > 0` there is a finite `G ⊂ F²` with
`χ_f(G) ≥ χ_gf(H; 𝒞) − ε`.
*Proof.* MRVZ Theorem 1 verbatim, with three checks. (i) The set `T` of isometries carrying a shape of `𝒞` to its partner is
finite, symmetric, contains the identity, and by B1 consists of isometries of `F²`; the group it generates is a countable
subgroup of `F(i) ⋊ (U_F ⋊ ⟨conj⟩)`, which is solvable (abelian by abelian by order 2), hence amenable, hence Følner. (ii)
`G_k = ⋃_{σ ∈ R_k} σH ⊂ F²`. (iii) The bound on the terms, which MRVZ take from `χ_f(ℝ²) ≤ 4.36`, holds with `χ_f(G_k) ≤ 7`
(any aggregate value is at most the weight). Restricting `𝒞` to a subfamily only removes constraints of the limiting
programme, so the averaged colouring still nearly satisfies the ones kept. ∎

**Corollary B3 (Cranston–Rabern's first question).** `χ_f(ℚ(√3,√11)²) = 4`.
*Proof.* MRVZ's `G27` has Moser coefficients in `ℤ⁴` (their Definition 2), so `G27 ⊂ L_Moser ⊂ K²` with `K = ℚ(√3,√11)`, and
`χ_gf(G27) = 4` (their Theorem 3, a rational dual witness). By B2, `χ_f(K²) ≥ sup χ_f(G) ≥ 4`. By Theorem B
(`chromaticNumber_seamPlane`), `χ_f(K²) ≤ χ(K²) = 4`. ∎ Also: the finitary Hall ratio of `K²` is 4 (MRVZ Theorem 2's proof is
field-internal too — its cube lives in the lattice the vertices span), so finite unit-distance graphs over `K` have independence
ratios tending to exactly `1/4` and never below it. **What `[CranstonRabern2015]` asked** (their conclusion, verbatim in
`BIBLIOGRAPHY.md`): *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`?"* — bracketed `76/21 ≤ · ≤ 4` since
Theorem B; now closed. **Dependency stated plainly:** B3 rests on MRVZ's computer-verified witness. Phase B re-verifies it.

**Corollary B4 (where `[DuczVarga2026]` must leave `K`).** Their `G29 ⊃ G27` has `χ_gf > 4.0007`, so by B2 its field cannot be
four-colourable; its two new points involve `√5` and `η = i√((415 + 79√33)/8)`, outside `K`. Consistent with Theorem B, and
a check that B2 and Theorem B agree. (`BIBLIOGRAPHY.md`'s row saying the augmentation stays "inside the Moser lattice" is wrong
and is corrected in phase B.)

---

## §2 What limits a fractional route, and where the ratio bound stops — [measured; the ratio-bound part a reading, with its killing test]

The instrument's weakest relative is the **ratio (Delsarte–Hoffman) bound** on a finitely generated piece `Cay(Λ, W)` of the
plane, `Λ ≅ ℤ⁴`: `χ_f ≥ 1 − 1/m` with `m` the least mean of a character of `Λ` over `W` (`[BachocEtAl2014]`, the operator
form; a periodic-set proof as in `[KMOR2016]`). A character that factors through a completion `F_v` where the circle is compact
has mean near that completion's own least character mean — measured 2026-09-16 (`data/fs56/local-ratios.out`, phase C):

| place | least character mean over the unit circle | ratio floor `1 − 1/m` |
|---|---|---|
| real (Bessel `J₀`) | **−0.40276** | 3.483 |
| `𝔽₃` plane | −0.5 | 3.000 |
| `𝔽₇` plane | **−0.5617** | 2.780 |
| `𝔽₁₁` | −0.3996 | 3.502 |
| `𝔽₁₉` | −0.3805 | 3.628 |
| `𝔽₂₃` | −0.3317 | 4.015 |
| `𝔽₃₁` | −0.3333 | 4.000 |
| `𝔽₄₃` | −0.2719 | 4.678 |
| `𝔽₄₇` | −0.2676 | 4.736 |
| dyadic ramified in `F(i)/F` | −1 | 2 |

**The hard limit, for every fractional route** [theorem]. A residue homomorphism pulls fractional colourings back, so
`χ_f(F²) ≤ χ_f(target)` at every usable place, and `χ_f(F²) ≤ 4.36` by restricting Croft's measurable colouring (`[MatolcsiEtAl2025]`
(1)). A finite `H ⊂ F²` can therefore certify four colours only if every usable place has `χ_f > 3`, which fails exactly at an `𝔽₃`
plane (`χ_f(Γ₃) = 3`) and a dyadic place ramified in `F(i)/F` (2). For **ℚ(√167)** the limit is `min(4.36, χ_f(Γ₂₃) ≥ 5.03, …) = 4.36`;
for **ℚ(√11)** and **ℚ(√23)** it is `χ_f(Γ₇) = 49/14 = 3.5` (`α(Γ₇) = 14` exactly) — still above 3.

**The ratio-bound reading (R-C)** [reading]. *The ratio bound on pieces `Cay(Λ, W)` can reach above 3 only if no compact place has
least mean ≤ −1/2*: a character at such a place is an obstruction no equidistributed `W` removes, while split places contribute a
Kloosterman-type mean weighted by the share of `W` integral there, which the choice of `W` controls. **ℚ(√167) passes** (least
−0.40276, the real place); **ℚ(√11) and ℚ(√23) fail** at 7 (−0.5617). This is a statement about the ratio bound only: the finite
programme of §4 is stronger (in the whole plane the ratio bound stops at 3.48 while `χ_gf(G27) = 4`), so it does not remove those
fields from the milestone's instrument — they are a registered side target (§5), where a certificate would prove the conjecture's
prediction `χ = 4` outright. *Consistent with every known value*: `ℚ(√3)`, `ℚ(√7)` (χ = 3) have an `𝔽₃` place at −1/2 exactly;
`ℚ(√2)`, `ℚ(√5)` (χ = 2) a dyadic ramified place. *Not a theorem*: split places are handled heuristically, and the product form of
character means across places is an unproved equidistribution statement. *Killing test:* ℚ(√167) pieces whose ratio bound
plateaus at or below 3 under every equidistributing choice of `W`.

**Why the ratio bound is not the certificate.** Probed 2026-09-16 (scratchpad, not kept): unit vectors of `F(i)` with bounded
denominator are sparse (20 at denominator 84, 60 at 420, 324 at 10,920), so an equidistributed `W` has frequencies near 10⁴ on
a 4-torus, and a rigorous minimum there is out of reach. The ℚ(√3) control read exactly −0.50000 (its 3-adic value); ℚ(√167) at
denominator 84 (20 vectors) read −0.98 — too few vectors, as predicted. So the ratio bound names the target; the finite LP
(phase D) certifies.

---

## §3 The phases

| phase | what | output | status |
|---|---|---|---|
| A | Q0 (§0) | `data/fs54/cert-q23-l3-N105.json`, `data/fs56/q0/` | **LANDED** |
| B | the field blow-up (§1): write it up; re-verify MRVZ's `G27` witness with our own exact checker; correct the bibliography; prior-art search on `χ_f(K²)` | `plans/FS56-field-blowup.md`, `tools/fs56_gf_check.py`, `data/fs56/g27/` | open |
| C | the local ratio table (§2) as a committed script | `tools/fs56_local_ratios.py` → `data/fs56/local-ratios.out` | open |
| D | **Q1 — χ(ℚ(√167)²) ≥ 4 by a finite `H` with `χ_gf(H; 𝒞) > 3`** (§4) | `tools/fs56_gf_lp.py`, `tools/fs56_gf_search.py`, `data/fs56/q1/` | open |
| E | kernel: the 23 consumer's docstrings from "open" to "held by certificate" | `Instances/IndependenceThreshold.lean` | open |
| F | the close: ledger row 71, grokkings, re-rank, stubs, sweep | `CLAUDE.md`, `plans/FRONTIER-STUBS.md` | open |

## §4 Phase D in detail — the instrument for Q1

**The field and its points** (domain pass, §M1). `F` is a real multiquadratic field `ℚ(√d₁, …, √d_r)` — radicands squarefree,
pairwise coprime, > 1, embedded with every `√d_j > 0` — so that one checker serves ℚ(√167) (`r = 1`), MRVZ's `G27` in
ℚ(√3,√11) (`r = 2`) and the `ℚ(√7)` control. An element of `F` is an integer vector over the `2^r` basis `√(∏_{j∈S} d_j)` with one
common denominator per file; a point of `F²` is a pair `(x, y)` of such vectors. The **quadrance** of a difference, `dx² + dy²`,
is an element of `F`, compared as an integer vector: two points are adjacent iff it equals 1.

**Shapes.** Two point sets `Y, Y′ ⊂ F²` are congruent iff some isometry maps one onto the other (by B1, an isometry of `F²`).
The checker decides it exactly and without square roots: after a prefilter (equal size and equal sorted multiset of pairwise
quadrances), fix `y₁ ≠ y₂ ∈ Y`; for each ordered pair `(y₁′, y₂′)` in `Y′` with the same quadrance, test the orientation-preserving
map by `(z′ − y₁′)(y₂ − y₁) = (z − y₁)(y₂′ − y₁′)` and the reversing one by `(z′ − y₁′)·conj(y₂ − y₁) = conj(z − y₁)(y₂′ − y₁′)` — for
every `z ∈ Y` some `z′ ∈ Y′` must satisfy it (products in `F(i)`, points read as `x + iy`); the map is injective and `|Y| = |Y′|`, so
it is a bijection. Classes are built by comparing each set with one representative per class; congruence is an equivalence, so a
class is congruent throughout. **Only "grouped together ⇒ congruent" carries soundness**: grouping congruent sets apart leaves
the programme with fewer constraints, which lowers its value and keeps every bound valid. *(The domain pass chose the least
ordering of the labelled quadrance matrix; the obligation pass replaced it: it costs `k!` orderings, and the `G27` control needs
sets of 27 points.)*

**The programme, level k** — a moment relaxation of "a random isometric copy of an independent set of `F²`, restricted to `H`":
variables `γ(S) ≥ 0` for independent sets `S` of `H`; the aggregate `γ̄(Y) = Σ_{S ⊇ Y} γ(S)` must be constant on every congruence
class of sets of size `≤ k` inside `H`, with value 1 on the singletons (one class — every point is congruent to every other, which
is where regularity comes from); minimise `γ̄(∅) = Σ γ(S)`. `k = 1` is the (regular) fractional chromatic number `χ_f(H)`, `k = |H|`
is MRVZ's `χ_gf(H)`, and every `k` is a valid input to B2 (it is a subfamily `𝒞`). Default `k = 3`.

**The certificate — the class-sum dual.** A rational weight `y_Y` on finitely many sets `Y ⊆ H` with `1 ≤ |Y| ≤ k`, such that
(i) on every congruence class of size-≥ 2 sets the weights **sum to zero**; (ii) on the singletons they sum to **`w`**; (iii) for
**every** independent set `S` of `H`, `Σ_{Y ⊆ S} y_Y ≤ 1`. Then every feasible `γ` has `Σ γ(S) ≥ Σ_S γ(S) Σ_{Y⊆S} y_Y =
Σ_Y y_Y γ̄(Y) = Σ_c γ̄_c Σ_{Y∈c} y_Y = w`, so `χ_gf(H; k) ≥ w`, and `w > k₀` proves `χ(F²) ≥ k₀ + 1` through B2. No vertex is
distinguished and no congruence *row* is listed: the checker groups the listed sets by their keys. A set containing an edge is
never inside an independent set, so its weight only balances a class; the checker allows it. (MRVZ's row form converts
mechanically: `y_Y = Σ_{rows (Y, Y′)} y_row − Σ_{rows (Y′, Y)} y_row`, plus the vertex-1 coefficient on the singleton.)
*Validated on the Moser spindle in `ℚ(√3,√11)²`, 2026-09-16 (scratchpad prototype): the programme reads 3.500000 at `k = 1, 2, 3`
— the spindle's known `χ_f = χ_gf` — and HiGHS's duals satisfy (i)–(iii) exactly as written.*

**The checker** (`tools/fs56_gf_check.py`, standard library, `fractions.Fraction`): parses the field (rejecting radicands that are
not squarefree, pairwise coprime and > 1), the points (rejecting duplicates), and the weighted sets (rejecting an index outside `H`,
a repeated set, a size above the declared `k`); recomputes every quadrance and edge from the coordinates alone; groups the sets by
shape key and checks (i) and (ii) exactly; and certifies (iii) by **exhaustive branch-and-bound over the independent sets of `H`**
in exact arithmetic, with the admissible bound "current value plus the positive weights of sets meeting the undecided vertices".
It reports `w` and the verdict `χ_gf(H; k) ≥ w`, and says `χ(F²) ≥ ⌊w⌋ + 1` only when `w` is not an integer or exceeds it. Positive
control: MRVZ's `G27` at `k = 27`, from their published witness (phase B). Negative controls, each with a faithful twin: a
weight moved between two non-congruent sets (class sum breaks); one weight raised so exactly one independent set exceeds 1; a
point moved by a non-unit vector (an edge disappears, so a new independent set violates); `w` equal to an integer (the verdict must
not claim the next colour). **Cost to measure before the search is sized:** the branch-and-bound on `G27` (182,304 independent
sets) and on a 60-point ℚ(√167) piece.

**The search** (`tools/fs56_gf_search.py`): MRVZ Appendix A's backtracking beam search transplanted to `F`. All points lie in the
lattice `Λ = ℤ-span(W)` of a fixed unit-vector set `W`, stored as integer vectors over `W`'s common denominator. Children add a
point at a unit step from `W` off an existing point, or complete a unit rhombus `x₀ + u + v`. Canonical form: the least image under
the 16-element group generated by `z ↦ iz`, conjugation and the Galois group of `F` (`√167 ↦ −√167`), each image translated so its
coordinatewise minimum is zero. The Galois flip is not an isometry of the real picture, but it fixes `i`, so it carries unit edges
to unit edges and (through B1's form `z ↦ uz + t`, `uū = 1`) congruent sets to congruent sets, and the programme for `σH` is the
programme for `H` relabelled. Rotations by `u ∈ W` are symmetries of the plane but not of `Λ`, so congruent copies of `H` can
survive deduplication; that costs time, never correctness. The LP by column generation (pricing: the most negative reduced cost
over independent sets, a pseudo-boolean maximisation with pair and triple terms, OR-Tools CP-SAT), floats; any `H` reading above
`3 + 10⁻³` goes to exact rounding and to the checker. **Rounding cannot fail (iii)**: rationalise the duals, subtract each
size-≥ 2 class's mean from its members (so (i) holds exactly), compute `M = max_S Σ_{Y⊆S} y_Y` exactly by the checker's own
branch-and-bound, and publish `y/M` with `w = (Σ_singletons y)/M`; (iii) then holds with equality at the maximiser, and the only
loss is `w`'s.

**The unit vectors to build from.** `W₀ = {±1, ±i}` ∪ Pythagorean `(3 ± 4i)/5`-family ∪ `ρ₄₂ = (83 + i√167)/84` with its
`⟨i, conj⟩`-orbit, then denominators 168, 420 (60 vectors), 2184 (108), 5460 (180). A graph using only `ℚ(i)` points is bipartite,
so every useful `H` uses `ρ₄₂`-type vectors; `n = 42` is the smallest type-M rotation of this field (G7).

**Registered predictions (2026-09-16, before any search).** Both outcomes of each are reachable.
* **P1.** The checker re-verifies `χ_gf(G27) ≥ 4` from MRVZ's published rational witness. *Reachable failure:* the witness
  does not load, or our congruence enumeration disagrees with theirs (a defect on one side, which is the point of checking).
  Confidence high.
* **P2.** At `ℚ(√7)` (χ = 3, the control where the answer is forced) every `H` the search produces reads `χ_gf ≤ 3`. A reading
  above 3 is a bug in the LP or the congruence code, never a finding. Confidence: certain as mathematics; the prediction is about
  the code.
* **P3.** Pair-only congruences are too weak: on `G27` they read strictly below 4 (the triple rows do real work). Medium.
* **P4.** Q1 lands: some `H ⊂ ℚ(√167)²` with at most 200 points reads `χ_gf(H; pairs ∪ triples) > 3` and certifies. **Low–medium
  (0.35).** The reading of §2 says the limit exceeds 3; the size at which a finite `H` shows it is unknown, and the field has no
  triangles, which is where MRVZ's search started (the spindle already reads 3.5). *Reachable failure:* the best reading
  plateaus below 3 across the budget.
* **P5.** If P4 lands, the certificate's `H` contains a non-3-colourable subgraph small enough for CaDiCaL (≤ 2,000 vertices)
  — **low (0.2)**: the blow-up is enormous and χ_f > 3 on a blown-up graph says nothing about small subgraphs.

**Budget and stop rule.** The search runs checkpointed (the beam's population and every `(H, value)` written per generation to
`data/fs56/q1/beam-gen*.json`; resume = relaunch without `--new`), at most one heavy job at a time. **Stop** when the best
reading has not improved by `10⁻³` over five generations at the largest `W` tried, and report the plateau as the finding.

## §5 What this milestone is not
**Side target, registered not planned:** `χ(ℚ(√11)²) ≥ 4` or `χ(ℚ(√23)²) ≥ 4` by the same instrument would prove the
conjecture's value there (`L = 4`), with a hard fractional ceiling of 3.5 from `Γ₇` — a narrow window, cheaper fields.

Not a search for a six-colouring of any finite plane (FS-57), and not a claim that ℚ(√167)² needs six colours. Q2 (four and five
colours refused by the same instrument) is registered as reachable in principle — `χ_gf > 4` over ℚ(√167) would prove
`χ ≥ 5` — but is not planned until Q1 lands; `[DuczVarga2026]` needed a hand-guided augmentation to cross 4 in the whole plane.

## §M Modeling passes

### M1 — domain (2026-09-16)
| decision | alternative weighed | why this one | confidence |
|---|---|---|---|
| Points as pairs of elements of a real multiquadratic field, integer vectors over one denominator | points of `F(i)` as 4-vectors over `(1, √d, i, i√d)`, specific to quadratics | the checker must also verify MRVZ's `G27` in ℚ(√3,√11) and run the ℚ(√7) control; the quadrance `dx² + dy²` lives in `F` itself, so the pair form states adjacency in the field it is about | high |
| Congruence decided by the checker from coordinates, no isometry stored (**superseded in M2**: prefilter plus an exact isometry test, not the least labelled quadrance matrix) | storing an isometry `(u, t)` per congruent pair and verifying it | witnesses are incidental data a checker would have to parse and trust the pairing of; recomputing congruence from coordinates keeps the file to points and weights | high |
| The programme as a level-`k` moment relaxation with `k` a dial | MRVZ's full congruence family only | every subfamily is valid for B2, `k` trades LP size against strength, and `k = 1, 2, 3` reproduce known values on the spindle | high |
| The class-sum dual as the certificate | MRVZ's `(4, −y)` row form with a distinguished vertex | symmetric in the vertices, no congruence rows to list or check, and the weak-duality line is three equalities; MRVZ's form converts mechanically | high |
| Regularity folded into the singleton class | a separate row per vertex | every point of `F²` is congruent to every other; the separate rows are the singleton class written out | high |
| Galois conjugation in the search's canonical form | canonicalise by isometries only | the programme is invariant under it (it fixes `i`), so it removes true duplicates at no risk | medium — if a future field's Galois group does not fix `i` (a non-real or CM field) the flip must go |
| Branch-and-bound over independent sets in the checker | enumerating them (MRVZ) or a pseudo-boolean proof log | enumeration dies on triangle-free graphs past ~40 points; a proof log adds a trusted checker we do not hold; branch-and-bound keeps the standard-library surface | **medium — the cost is unmeasured; if it cannot finish on the `H` the search needs, the certificate format changes (symmetry-reduced enumeration, or VeriPB)** |

### M2 — obligations (2026-09-16): what is proved, tested, assumed
| claim | status | the local obligation | where it is discharged |
|---|---|---|---|
| **B1** congruences are isometries of `F²` | prove [hand] | `u = (φ(y₂) − φ(y₁))/(y₂ − y₁)` or its conjugate form lies in `F(i)`; `uū ∈ F` equals 1 | §1, three lines |
| **B2** the blow-up over `F`, any subfamily `𝒞` | prove [hand, MRVZ Thm 1 transcribed] | (1) `T` finite (≤ 2 isometries per distance-preserving bijection), symmetric, `∋ id`; (2) `⟨T⟩ ≤ Isom(F²)`, solvable ⟹ amenable ⟹ right Følner; (3) the pulled-back aggregates are aggregates of fractional colourings of `H` (isometries preserve independence), regular, of weight `χ_f(G_k)`; (4) for `τ ∈ T` with `τY = Y′`: `Σ_{σ∈R} γ̄(στY) − Σ_{σ∈R} γ̄(σY)` has at most `2|RT∖R|` unmatched terms, **each defined because `στY = σY′ ⊆ σH ⊆ G_k`**, each ≤ `χ_f(G_k) ≤ 7` (row 33); (5) the approximation property (7) by compactness of regular fractional colourings of weight ≤ 7 | §1; a kernel form is not planned (amenability and Følner sets for countable solvable groups) |
| **B3** `χ_f(K²) = 4` | prove [hand] from B2 + MRVZ Thm 3 + Theorem B | `G27 ⊂ K²` (their Definition 2 in `ℤ⁴`); `χ_f(K²) ≥ χ_f(G)` for finite `G ⊂ K²` (restrict a fractional colouring); `χ_f(K²) ≤ χ(K²) = 4` (`chromaticNumber_seamPlane`) | **test**: phase B re-verifies `χ_gf(G27) ≥ 4` from MRVZ's witness with our checker, on our own recomputed edges and congruences |
| Hall ratio of `K²` is 4 | prove [hand] | MRVZ Thm 2's cube lives in the lattice spanned by `G`'s vertices, inside `K²`; `α₁(K²)` is an infimum over finite subgraphs of `K²` | §1 |
| **weak duality** of the class-sum certificate | prove [hand] | `γ ≥ 0` and (iii) give `Σγ(S) ≥ Σ_S γ(S) Σ_{Y⊆S} y_Y`; swap finite sums; `γ̄` constant on each class kills the size-≥ 2 sums and leaves `w` | §4, one line; **test**: the spindle prototype's duals |
| checker: grouping is sound | prove [hand] + test | equal-orientation map test ⟺ `z ↦ uz + t` with `u = (y₂′−y₁′)/(y₂−y₁)`, `|u| = 1` from equal quadrances; representatives + transitivity | negative control: two non-congruent sets with equal quadrance multisets (a homometric pair) must land in different classes |
| checker: branch-and-bound is exhaustive | prove [hand] + test | branching includes or excludes each vertex; including removes its neighbours; the bound adds every positive `y_Y` over `Y ⊆ I ∪ R′`, `Y ⊄ I` — an upper bound on every completion | control: on `G27` and on random small graphs, B&B's maximum equals full enumeration's |
| checker: multiquadratic arithmetic | prove [hand] + test | square roots of distinct squarefree integers are `ℚ`-independent (Besicovitch), so vector equality is field equality; `√a√b = (∏_{shared} d)·√(∏_{sym. diff.})` for coprime squarefree radicands | control: a non-squarefree radicand is refused; `(√3·√11)² = 33` and `ω₃ ω̄₃ = 1` as spec tests |
| verdict rule `χ(F²) ≥ ⌊w⌋ + 1` only for non-integer `w` | prove [hand] | `χ(G) ≥ χ_f(G) > w − ε > ⌊w⌋` for small `ε` | control: `w = 3` exactly must print `χ_gf ≥ 3` and no colour claim |
| §2 local means | **reading / measured** (floats) | none — a prediction instrument | phase C script, labelled a reading |
| **kernel consumer at 23** | kernel theorem, hypothesis **assumed** (discharged by the exact certificate outside the kernel) | `finitePlane 23 = unitQuadrance (ZMod 23)`: adjacency `dx² + dy² = 1`, the checker's edge rule | phase E rewrites its docstrings; no declaration changes |

**What the pass changed:** §2's claim that ℚ(√11) and ℚ(√23) are out of reach was true of the ratio bound only (corrected; the
hard fractional ceiling is `χ_f(Γ₇) = 3.5 > 3`); the shape key moved from ordering-minimisation to prefilter plus exact isometry
test; rounding became infallible for (iii); the homometric-pair control was added, because it is the one input on which the
prefilter alone would be unsound.

### M3 — experience (2026-09-16): the surfaces and their wording
**Who reads what, holding what.** A reviewer who trusts none of this holds one certificate file, a standard-library checker and
`plans/FS56-field-blowup.md`; a later session holds the search's records and nothing of this conversation; a Lean reader holds
one docstring; Kooshi holds the report.

**The certificate file** (`data/fs56/…/cert-*.json`), everything the checker needs and nothing it recomputes:
`kind` · `field.radicands` (e.g. `[167]`; `F = ℚ(√d₁,…)`, every root positive) · `denominator` · `points` (each `[x, y]`, each a list
of `2^r` integer numerators over the basis `√(∏_{j∈S} d_j)`, `S` read as a bitmask, in bitmask order) · `level` (`k`) ·
`weights` (`[{"set": [indices], "y": "p/q"}]`) · `w` (claimed; the checker recomputes it and refuses a mismatch) · `claim`
(one plain sentence) · `derivation` (the path to the hand proof) · `produced_by`, `provenance` (untrusted, never read by the
checker). No congruence rows, no isometries, no independent sets: the checker derives all three.

**The checker's words.** `python3 tools/fs56_gf_check.py CERT.json` — exit 0 certified, 1 not a certificate, 2 unreadable file;
`--show-points` prints the points as `a + b√167` fractions; `--self-test` runs the arithmetic and grouping controls.
* Success, two lines, the second carrying the consequence and its dependency:
  `CERTIFIED: H = 42 points of Q(√167)², level 3 — every fractional colouring of H whose weight on each point set of at most 3 points
  depends only on the set's congruence class weighs at least w = 1234/411 (≈ 3.00243); exact arithmetic, no solver trusted (12 s)` ·
  `hence, by the field blow-up (plans/FS56-field-blowup.md, Lemma B2), the plane over Q(√167) needs at least 4 colours`.
  The colour count printed is always `⌈w⌉` — the obligation pass's rule `χ(F²) ≥ ⌊w⌋ + 1` for non-integer `w` and `χ ≥ w` for integer
  `w` are one statement — so an integer `w` claims nothing beyond itself and needs no special wording.
* Refusals name the object and the rule, never a line number: `NOT A CERTIFICATE: the congruence class of set #12 [0, 5, 9]
  (4 listed sets: #12, #13, #40, #41) sums to 1/7; a class of sets of two or more points must sum to 0` ·
  `NOT A CERTIFICATE: independent set [0, 4, 11, 17] weighs 1003/1000 > 1 (largest contributions: [0, 11] +1/2, [4] +3/10, …)` ·
  `NOT A CERTIFICATE: the singletons sum to 3 but the file claims w = 31/10` · `NOT A CERTIFICATE: set #5 has 4 points but the file
  declares level 3` · `NOT A CERTIFICATE: radicand 12 is not squarefree`.

**The search's records** (`data/fs56/q1/<run>/`): `progress.jsonl`, one line per completed generation (`generation`, `best`,
`population`, `lp_calls`, `seconds`), the line a waiter can watch; `gen-<g>.json`, the whole beam (canonical points, float
readings, parent key) written atomically; `RESUME.md` written before launch. `run … --new` refuses an existing directory,
`run …` without it refuses a missing one — a wrong path cannot silently restart from zero (the FS-54 D4 convention). Float
readings are labelled `reading` in every record; the word `bound` is reserved for checker output.

**The kernel docstrings** (`Instances/IndependenceThreshold.lean`): the module doc and both consumers at 23 and 83 still say their
hypotheses are open. Both are now held outside the kernel — 83 by `data/fs50/p83-refusal/` (FS-50, `α ≤ 1046`), 23 by
`data/fs54/cert-q23-l3-N105.json` — so the text becomes *"held by an exact certificate checked outside the kernel; the conclusion
rests on that checker, not on anything this module decides"*, naming the file and the checker. Declarations unchanged.

**The report to Kooshi** leads with the three findings in plain words (five colours refused at 23; the fractional chromatic number
of the plane over ℚ(√3,√11) is exactly 4, a published question; a fractional route to four colours over ℚ(√167)), states the
correction to what was said mid-session about ℚ(√11) and ℚ(√23) in one line, and gives Q1's shape and default.

## §PA — prior-art gate (WORKFLOW 3a), 2026-09-16

**Searched, in the disciplines' words:** (i) *chromatic number of the plane over a real quadratic field / unit distance graph
ℚ(√d)²* — nothing beyond `[Johnson1987]` (two-colourings) and `[Fischer1990]`; (ii) *triangle-free 4-chromatic unit distance
graph, coordinate field* — the 17- and 19-vertex Exoo–Ismailescu graphs, whose coordinate fields were certified in
arXiv:2607.19995 (EI19: base `ℚ(√2,√5,√7)` plus a degree-12 angle; EI17: an `S₂₀` degree-20 field) — neither quadratic; and the
ℚ³ scavenger hunt (arXiv:2303.09513), rational 3-space; (iii) *spectral bounds for the independence ratio and chromatic number of
an operator / Cayley graph on a locally compact abelian group* — `[BachocEtAl2014]` (Israel J. Math., arXiv:1301.1054), the
framework of §2; (iv) *fractional chromatic number of the plane / geometric fractional chromatic number* — `[MatolcsiEtAl2025]`,
`[DuczVarga2026]`, `[AmbrusEtAl2023]` (held, read for this gate: MRVZ §2–§4 and Appendix A; Dúcz–Varga in full);
(v) **the question** *"fractional chromatic number of ℚ(√3,√11)²"* and every work citing `[CranstonRabern2015]` (Semantic
Scholar, 11 citing records: none addresses a field plane; OpenAlex reports 8). **Findings:** no field-restricted form of the
blow-up; no value of `χ_f(K²)`; no lower bound above 3 for any real quadratic field's plane. **Negative recorded.** Not yet
reached: `[Johnson2006]` (still not held), "Still Spinning: The Moser Spindle at Sixty" (Math. Mag. 96(2), 2023, cites
Cranston–Rabern; not held).
