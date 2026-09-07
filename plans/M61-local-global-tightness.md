# FS-15 — The local–global tightness conjecture: is the chromatic number of a field plane its best local bound? (STUB, 2026-09-07; minted on Kooshi's direction after the M59 close)

*A derivation stub. It is written to be read cold: every term is defined where it first appears. Read beside, when
you want the evidence in full: `plans/FIELD-WALL-THEOREM.md` (the 2-adic wall), `plans/M58-field-sieve.md` §S1–§S2 and §R
(the finite-plane bound and the spectra), `plans/M59-finite-plane-lift.md` §S1 and §R (why finite-plane objects do not lift),
`plans/PROGRAMME-ALGEBRAIC-PROOF.md` (the aim this stub serves), `plans/M60-five-colour-residue-obstruction.md` (FS-14, the
conjecture's first compulsion-level instance).*

## 1. The setting, in plain language

The Hadwiger–Nelson problem asks how many colours the real plane needs so that no two points at distance exactly one share a
colour. The answer is 5, 6 or 7. A compactness theorem of de Bruijn and Erdős says the answer is the largest chromatic number
of any FINITE unit-distance graph, and every finite graph has coordinates in some number field F (a finite extension of the
rationals inside the reals). So the problem is the same as: over all real number fields F, what is the largest chromatic
number χ(F²) of the unit-distance graph whose vertices are the points of F² with coordinates in F?

Everything this project has proved about χ(F²) from above is LOCAL: it uses the arithmetic of F at ONE prime number p.

* **At p = 2 (the field-wall theorem, M53).** If −1 is not a square in any completion of F at a prime above 2, colour each
  point by its residue modulo a suitable prime of F(i): four colours (or two), proper on every unit edge. So χ(F²) ≤ 4. For the
  seam field K = ℚ(√3, √11) the bound is exactly attained: the Moser spindle needs four and lives in K.
* **At p = 3 (Fischer).** If some prime of F above 3 has residue field 𝔽₃, three colours suffice. Attained by a unit triangle
  over ℚ(√3).
* **At any prime p ≡ 3 (mod 4) where F has a prime 𝔭 of residue field 𝔽_p (the finite-plane bound, M58).** Reducing
  coordinates modulo 𝔭 sends every unit-distance graph over F homomorphically into the finite Euclidean plane UD(𝔽_p, 2) —
  the graph on the p² points of 𝔽_p² joining two points when their difference has x² + y² = 1 — so χ(F²) ≤ χ(UD(𝔽_p, 2)).
  Such a p is called **usable** for F. The finite planes' chromatic numbers are known exactly at 3, 7, 11 (values 3, 4, 5, the
  last in the kernel) and 19 (value 5), are at least 6 from p = 59 on (their spectra are Kloosterman sums; Hoffman's bound),
  and are at least 7 from p ≈ 100 on.

Call the smallest of these numbers, over all the usable primes of F together with the walls at 2 and 3, the **local bound**
L(F). The one bound that is not local is the classical hexagonal 7-colouring of the real plane, which restricts to every F² at
once, so χ(F²) ≤ min(7, L(F)) for every F.

A field is **sealed at k** when L(F) ≤ k: no unit-distance graph over it can need more than k colours. A field is **6-open**
when L(F) ≥ 6 and the 2-adic wall is broken — the only fields where a 6-chromatic unit-distance graph could live. For fields
containing K this is a congruence: 6-open iff the wall is broken and 11 is inert (M58's theorem).

## 2. What is known about tightness, exactly

At every field where χ(F²) is known exactly, it EQUALS the local bound:

| field F | local bound L(F), from | χ(F²) | attained by |
|---|---|---|---|
| ℚ | 2 (p = 2) | 2 | a unit edge (Woodall) |
| ℚ(√3) | 3 (p = 3) | 3 | a unit triangle |
| K = ℚ(√3, √11) | 4 (p = 2) | 4 | the Moser spindle (Theorem B for ≤) |
| ℚ(√3, √5, √11), Heule's field | 5 (p = 11) | 5 | Heule-510 (both halves in the kernel, M58) |
| K(√247) | 5 (p = 11) | 5 | the T20 witness, 1,175 points (M53) |
| K(√23) | 5 (p = 11) | 5 | the second T20 witness (M53) |

The last two rows are not a selection effect: the field-wall analysis PREDICTED that a 5-forcer needs the 2-adic wall broken,
and the rigidity dial then found forcers in exactly the fields it named (√247 read off the forced distances of K-fabric, §M53
T20). The conjecture below is the statement that this is what always happens.

At the next level nothing is known. De Grey's field ℚ(√3, √5, √7, √11) has L = 8 (its first usable prime is 131, whose plane is
at least 8-chromatic), so the cap gives χ ≤ 7 and the truth is 5, 6 or 7. K(√7) has L ≥ 6 (first usable prime 83, plane ≥ 6);
K(√13), K(√79), K(√127) likewise.

## 3. The conjecture

> **Local–global tightness (T1, the working form).** For every real number field F with L(F) ≤ 6, χ(F²) = L(F): the best local
> bound is attained by a finite unit-distance graph over F.
>
> **The bold form (T2).** For every real number field F, χ(F²) = min(7, L(F)).

T1 is where the evidence is (six fields, two of them predicted before they were built). T2 adds the claim that a field with
no small usable prime is 7-chromatic — which, since de Grey's field has L = 8, is equivalent to **χ(ℝ²) = 7**. T2 is stated
so that it can be pushed back on; it is not believed here, only named: it is exactly what "the local bounds are the whole
truth" would mean, and de Grey's field is its test.

**Why it is the right conjecture to hold.** It says the chromatic number of a field plane is a function of the field's
arithmetic at small primes — the "intrinsic nature" the programme document names — and it turns two open questions into one:

* **The lower bound becomes a target computation.** If T1 holds and some finite plane UD(𝔽_p, 2) has chromatic number EXACTLY 6,
  then every field whose local bound is that plane's (p usable, every smaller usable prime's plane ≥ 6, the wall broken) hosts a
  6-chromatic unit-distance graph — a target field named by congruences, as √247 was named by a forced distance. The first
  digit is therefore: **is any finite Euclidean plane exactly 6-chromatic?** Candidates: 23, 31, 43, 47 (spectral floors
  4.0–4.7, values 5 or 6, undecided at four solver-hours), 59 (floor 5.02, value 6 or 7), 67, 79, 83 (floors 5.5–5.7). If none
  is, T1 says no field is exactly 6-chromatic: the answer to Hadwiger–Nelson is 5 or 7, never 6.
* **The upper bound becomes a gluing question.** Every local colouring is one colouring of one F² at one prime; the hexagonal
  colouring is one colouring of ℝ² that restricts to every F². T2 says nothing global with six colours exists. The obstruction
  to gluing local colourings into a global one is the object the upper-bound side of the programme has to name (§4 (c)).

## 4. Derivations first

**(a) The local bound, stated in full.** L(F) as written above takes primes of residue degree one; M58's argument works at
odd residue degree f, into the plane over 𝔽_{p^f} — whose chromatic numbers are unknown and worth a table — and at ramified
primes for the UPPER bound only (M59: the lift needs unramified). Write L(F) as the minimum over every place where a residue
colouring exists, and prove that every colouring obtained this way is "local at one prime" in a precise sense (constant on
residue classes of that prime).

**(b) The compulsion-level face.** Over a field sealed at k by a prime p, every pair of points forced equal (or forced
distinct) at k colours has residues forced the same way in UD(𝔽_p, 2). This is FS-14 at p = 11, k = 5; T17 is its p = 2,
k = 4 case (already a theorem). Proving it in general is the first theorem of this stub and is cheap (a homomorphism argument).

**(c) Why forcers attain the bound — the mechanism of tightness.** In every attained case the forcer's field is the SMALLEST
field breaking the wall the bound came from: the spindle's twist is the least adjunction that turns off 3 (it lives in K, and
K is 3-adically closed to residue colourings); the 5-forcers' √5 or √7 is the least adjunction turning off 2. Derive the
general statement: a forcer at k + 1 colours is K-fabric plus the least adjunction that removes the prime giving L = k (G37's
"adjoin a root that turns off the next wall", made exact). If the derivation goes through, T1 at the 6-level says which
adjunction to make — the one that turns off 11 while keeping the wall broken — and predicts the forcer's field.

**(d) The gluing obstruction (the upper-bound side).** Two colourings of F² and F'² local at different primes never agree on
F² ∩ F'² in general; ask what invariant of a colouring of a field plane says whether it is the restriction of a colouring of a
larger field's plane. A colouring local at 𝔭 is constant on 𝔭-adic balls of radius 1/p; a colouring of ℝ² restricted to F²
is constant on nothing of the kind. Derive: no colouring of ℝ² with k < 7 colours restricts to a 𝔭-local colouring on any
field (probably easy), and — the real question — whether some measurable/topological invariant of colourings of ℝ² is
forced to vanish on every local colouring. If T2 is true the invariant exists; if a global 6-colouring exists it does not.

## 5. Phases

| phase | what | cost |
|---|---|---|
| 0 | (b) in the kernel in general form (the transfer of compulsions along the reduction); (a) the table of L(F) for the fields held, with the odd-degree planes' floors | 2 days |
| A | the first digit: the exact chromatic numbers of the planes at 23, 31, 43, 47, 59 — by cube-and-conquer over a neighbourhood's colourings (FS-13's D1) or by the exact count of colourings via the torus structure; the first plane with value exactly 6, if any, and the fields it names | days to weeks |
| B | (c): the mechanism of tightness as a derivation on the six attained fields; a design principle for the 6-level, tested on the fields (A) names | weeks |
| C | (d): the gluing obstruction, derivation only | open |

## 6. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the planes at 23, 31, 43, 47 are 5-chromatic; 59 is 6-chromatic; 67, 79, 83 are 6-chromatic | low-medium (Hoffman is loose at small p: 1.5 above the truth at 11 and 19) |
| P2 | (b) is a theorem in general form within a day, and every one of the seed's 148 absolute virtual edges at distances 3 and 4 has residues that every 5-colouring of UD(𝔽₁₁,2) separates | medium-high |
| P3 | T1 fails nowhere among the fields held; its first genuine test is a field whose local bound is 6 | — (this is the conjecture) |

## 7. Failure and pivot clauses

A field with L(F) = 5 and a proof that χ(F²) ≤ 4 (a colouring of some 5-sealed, wall-broken field with four colours that is
NOT local at any prime) refutes T1 below the 6-level and would be a new colouring genre — record it as the finding, it is
larger than the conjecture. A finite plane with chromatic number exactly 6 turns phase B into the hunt's target: HALT and
design in the named field. No plane exactly 6 among those decided: record, and T1's prediction "never 6" becomes the
programme's stated position on the answer.

## 8. Bearing on 6, honestly

High as a FRAME, medium as work: it reorganizes both halves of the problem around one computable quantity, its first digit
(phase A) is exactly the solver question M58 left undecided, and its mechanism half (c) is the derivation the programme asked
for after the lower bound. It produces no object by itself.

## 9. Addresses

`tools/fplane.py` (`chi`, `spectral`, `map`, `usable`), `data/fplane/`, `Proofs/HadwigerNelson/UnitQuadrance.lean`
(`unitQuadrance.map`, the reduction as a functor), `Instances/FinitePlane11.lean`, `plans/M60-five-colour-residue-obstruction.md`,
`plans/STUB-finite-plane-cores.md`, `plans/FIELD-WALL-THEOREM.md`.

---

**Addendum 2026-09-07 (the M60 close).** The compulsion-level face of this conjecture (FS-14) is proved: a sealing plane has no pair
compulsion at its own chromatic number (kernel at 11; measured at 3, 7, 11, 19), so over a sealed field every pair compulsion at five
colours is a congruence on the squared distance (`≡ 0` forced, `≡ 1` separated), and the two hex-shell gadgets are impossible one at a
time. Derivation (d) here — the obstruction to gluing local colourings — now has its finite counterpart: the local colourings at a
sealing prime are so free that they force nothing; what a 6-open field's plane forces at SIX colours (its own compulsion sets at
k = 6 when χ ≥ 6, e.g. at 59 or 131) is the next computable object of this stub.

---

## §H. Handoff for the session that opens M61 (written 2026-09-07 at the M60 close, on Kooshi's "FS-15 next", before his compaction)

**Kooshi's decision, not to be re-decided: the next milestone is M61 = FS-15, this stub.** Open it per WORKFLOW step 3 onward.

**Read, in this order.** (1) `CLAUDE.md` § Frontier — the M58, M59, M60 paragraphs and G43–G47 (the sieve, the lift, the residue
obstruction; the rule G46 and its ranking corollary; G47 the compulsion face of sealing). (2) This stub §1–§9 and the M60 addendum
above. (3) `plans/M60-five-colour-residue-obstruction.md` §S1–§S3 and §R7 — the transfer theorem and the distance law, which are this
stub's derivation (b) DONE (see below). (4) `plans/M58-field-sieve.md` §S1–§S2 (the spectra, the usable primes, the field map) and
§R3 (the undecided planes). (5) `plans/STUB-finite-plane-cores.md` (FS-13's D1, the cube-and-conquer route for a plane's χ). (6)
`data/fplane/README.md` for every record's licence.

**Opening moves.** `git mv plans/M61-local-global-tightness.md plans/M61-local-global-tightness.md`; re-point every reference
(`grep -rn STUB-local-global-tightness CLAUDE.md plans/ tools/` and the memory file); mark the FS-15 row of `plans/FRONTIER-STUBS.md`
"opened as M61"; then the subplan §S with the derivations FIRST (G46), the skeleton, three FRESH modeling passes each committed.

**What M60 already delivered of this stub, so the subplan does not redo it.** Derivation (b), the compulsion-level face, is a
kernel theorem in general form: compulsions map forward along any homomorphism (`Forces.image`, `Separated.image`) and a Cayley
graph coloured by one aperiodic table coinciding at non-edges has no arity-2 compulsion (`ResidueObstruction.lean`); at 11 the
certified table is such a table (`Instances/ResidueObstruction11.lean`), and the distance law says forced ⟹ `d² ≡ 0`, separated ⟹
`d² ≡ 1 (mod 11)`. Measured: the sealing planes at 3, 7, 11, 19 are all pairwise free (`data/fplane/compulsions-p*.json`). So P2's
first half is MET (in one day, at M60). P2's second half is ILL-POSED as written and should be re-registered: the seed's 148 absolute
virtual edges at distances 3 and 4 (M50) are compulsions of the `{1, 2}`-graph, which has no homomorphism into the plane (its cheats
reduce to norm-4 pairs, not edges), so the transfer does not apply to them; on the UNIT part alone, pairs at distances 3 and 4 have
`r = 9, 16 ≢ 1 (mod 11)` and are therefore NEVER virtual edges at five colours over a sealed field — the opposite of the registered
reading. Record that under §6 at opening.

**The first derivation to make at opening (phase A's shape, G46).** The first digit is "is any finite plane exactly 6-chromatic",
and the planes at 23, 31, 43, 47 (values 5 or 6) refused the colouring SAT at four hours (`data/fplane/chi-p{23,31,43,47}-k5.json`,
all `unknown`; 59, 83, 131 at one hour with external cadical, M59). Before another solver hour, name the classical objects:

* **The fractional face.** The planes are vertex-transitive, so their fractional chromatic number is `p²/α` with `α` the
  independence number, and `χ ≥ ⌈p²/α⌉`. A 5-colouring needs a colour class of size `≥ p²/5`, i.e. **`α(UD(𝔽_p, 2)) ≥ ⌈p²/5⌉`
  is a NECESSARY condition for `χ = 5`** — a cardinality-constrained SAT far smaller than the colouring (`build/m61/alpha.py`, an
  opening scratch instrument to promote into `tools/fpcompel.py` if it earns it). Calibrated at the close: it is NOT tight —
  **`α(UD(𝔽₁₁, 2)) = 28` exactly** (size 28 found in 0.1 s, size 29 refused by cadical in 92 s), so the fractional number at 11 is
  `121/28 ≈ 4.32` against the true `χ = 5`; at 19, `α ≥ 76` (> 361/5 = 72.2; size 78 unknown at an 800-s wall, so `α(19) ∈ {76, 77}` or the wall was too short). The
  finite planes share the real plane's pathology (G24: ω = 3, every relaxation low, χ high), so the fractional face will not decide
  the first digit alone; it is a free necessary condition and a calibration of how far below χ every relaxation sits. The decisive instance at 23 (`α ≥ 106?`, 2-hour wall) were running at the compaction — `build/m61/alpha-p*.json`,
  `build/m61/alpha-p23.log`, the jobs ledger (all gitignored; copy any verdict into `data/fplane/` at opening). If 23 returns UNSAT, `χ(UD(𝔽₂₃, 2)) ≥ 6` with no colouring search, and a 6-colouring
  (cheap to find if it exists) makes it exactly 6: the first plane at 6, and a field named by congruences. If SAT (likely, by the
  calibration), the necessary condition is met and the colouring question stands.
* **The symmetry face.** The automorphism group has order `2p²(p + 1)` (translations and the orthogonal group), so a 5-colouring
  is sought up to it: pin a maximal clique (`fplane.py chi --pin-clique`, done) AND break the rotations — colourings invariant under
  a subgroup of the rotation group (order `p + 1`, cyclic) are a much smaller space, and every colouring found at 3, 7, 11, 19 should
  be tested for such invariance first (if the known colourings are all invariant under something, search the invariant space at
  23–47; if none is, that is a finding about the genre). The lower-bound side: a 6-forcing subgraph (a 6-critical core, FS-13's
  object) is what an UNSAT would need to be certified — cube-and-conquer over the neighbourhood's colourings is the route, and
  the certificate size is the M43 lesson (price before running).
* **The odd-degree planes (derivation (a)).** M58's reduction works at residue degree `f` odd into the plane over `𝔽_{p^f}`; its
  chromatic numbers are unknown (`UD(𝔽₉, 2)`, `UD(𝔽₂₇, 2)`, `UD(𝔽₄₉, 2)`… — 𝔽_{p^f} with `p^f ≡ 3 mod 4`): the table of L(F) is
  incomplete without them, and each is one `chi` run on a small graph (81, 729, 2401 vertices).

**Standing rules that bit M59 and M60** (so they are not paid again): pysat's wall is inert on big instances — run the cadical
binary under `timeout` (as `alpha.py` does); `pgrep -f` self-matches a waiter's command line (anchor `^python3`, kill by PID); a
planted control can be wrong (M59: three; M60: the 3-plane's period); every headline names its population and the trust of each
verdict (G21); the M58 seed-frame packer truncates a descent object's coordinates — reduce through `fpcompel.reduce_K`; one heavy job
at a time; checkpoint anything over fifteen minutes; ALWAYS `./scripts/build.sh`; a bare `rw` fails across the
`addCayley`/`unitQuadrance` coercions — use a typed `have`.

**Machine at the close:** the desktop (32 cores, 125 GB). In flight at the compaction: the α loop at 11 and 19 and the 23 instance
(above). Nothing else. Tree clean at the commit that carries this section.

---

## §S. Subplan (M61 opened 2026-09-07, on Kooshi's "You are go for M61"; WORKFLOW step 3)

*Written for a reader with no memory of the session. §1–§9 above are the stub; §H is the handoff it opened from. The rule
this subplan runs under is G46: name the classical object each question lives in and let that theory decide the question's
shape before any solver hour; the search's role is to produce the instances the derivations predict. Every derivation below was
made and MEASURED at opening (scratch `build/m61/derive.py`, gitignored; the records go into `data/fplane/` through the promoted
instrument, §S7). The desktop (32 cores, 125 GB).*

### §S0. The state on disk at opening (read first)

* **Derivation (b) is done** (M60, `ResidueObstruction.lean`): compulsions map forward along homomorphisms; the sealing plane at
  11 has none at five colours (kernel); at 3, 7, 19 likewise (measured). P2's first half MET; its second half is ill-posed
  (§S8 re-registers it).
* **The fractional face at the compaction** (`build/m61/alpha-p*.json`, external cadical): `α(UD(𝔽₁₁,2)) = 28` exactly (29
  refused in 92 s), `α(UD(𝔽₁₉,2)) ≥ 76` (78 unknown at 800 s); `α(UD(𝔽₂₃,2)) ≥ 106?` running under a two-hour wall (pid
  3359887; the verdict lands in §S2 when it finishes).
* **The undecided planes** (`data/fplane/chi-p{23,31,43,47}-k5.json`): no verdict at four hours with a pinned clique; spectral
  floors ≥ 5; 59 is ≥ 6 by its exact spectrum, every p ≥ 67 by Weil + Hoffman.
* Kernel: 630 declarations clean on the standard three axioms; `finitePlane p`, `unitQuadrance.map`, the certificate hom
  `UDCert.drawing_adj`, `Forces.image`, `finitePlane11_forces_iff`, `UDCert.drawing_quad` are the surfaces this milestone builds on.

### §S1. Derivation (a) — the local bound in full, and the odd-degree planes

**The local bound L(F)** of a real number field F is the minimum, over every prime 𝔭 of F at which a residue colouring exists,
of that colouring's number of colours: at 𝔭 | 2 with complex conjugation fixing 𝔭 in F(i), the norm N(𝔭) ∈ {2, 4} (Theorem B;
Fischer's bipartite case when conjugation lies in inertia); at 𝔭 | p ≡ 3 (mod 4) with residue field 𝔽_{p^f}, f odd (so −1 is a
non-square in the residue field), the chromatic number χ(UD(𝔽_{p^f}, 2)) of the finite plane over the residue field, because
the residue map is a graph homomorphism (M58 §S1; `unitQuadrance.map` for the ring-level statement). Primes with an even residue
degree, or above p ≡ 1 (mod 4), give nothing (the residue field contains √−1, so the plane over it is bipartite-degenerate: the
circle contains isotropic-direction points and the hom argument's `u ≠ v` clause fails — M58 §M1). The global cap is 7.

**The residue-degree-three planes matter only outside the multiquadratic world**: a multiquadratic field's primes have residue
degree 1 or 2, so for every field this project has held, L(F) is decided by degree-one primes and the walls at 2 and 3. Cubic
fields are where f = 3 enters — Haugland's heptagonal field ℚ(cos 2π/7) has 3 inert with residue field 𝔽₂₇ (3 has order 6 mod 7;
the cubic subfield sees f = 3), so its 3-adic local bound is χ(UD(𝔽₂₇, 2)). **Measured at opening** (`build/m61/partE.log`; 𝔽₂₇
= 𝔽₃[t]/(t³ − t − 1), the plane 729 vertices, degree 28, the circle's 28 points): **four colours refused in 7 s** (the solver's
claim); five colours pending at a 20-million-conflict budget. So the odd-degree face of the sieve gives Haugland's field no
bound below 5 at 3 — consistent with his 5-chromatic object — and the table of L(F) for cubic fields needs the value at 27 and,
for larger cubic residue fields (343, 1331, …), the spectral floor: Kloosterman over 𝔽_q obeys Weil's |K| ≤ 2√q, so
χ(UD(𝔽_q, 2)) ≥ 1 + (q + 1)/(2√q) exactly as at prime q — ≥ 6 from q = 62, so 𝔽₃₄₃'s plane is ≥ 10-chromatic and only q = 27
needs a solver. (One row; no kernel content — `GaloisField 3 3` does not compute under `decide`.)

### §S2. The fractional face — ϑ is the Hoffman bound by arc-transitivity, so no linear relaxation reaches the first digit

**The classical object.** UD(𝔽_p, 2) is the Cayley graph of the additive group 𝔽_{p²} with connection set the norm-one
subgroup μ_{p+1} ⊂ 𝔽_{p²}^× (for p ≡ 3 (mod 4) the norm form is anisotropic, so the unit circle IS the kernel of the norm
𝔽_{p²}^× → 𝔽_p^×): a **generalized Paley graph** GP(p², p − 1). Its automorphism group contains 𝔽_{p²} ⋊ O(2, 𝔽_p) (order
2p²(p + 1)), whose vertex stabilizer O(2) acts transitively on the circle — the graph is **arc-transitive**. For a vertex- and
edge-transitive graph Lovász's theorem ([Lovasz1979], Theorem 9, as recalled) gives ϑ(G) = n·(−λ_min)/(λ_max − λ_min): the
Lovász number IS the Hoffman ratio bound, and since ϑ(Ḡ) = n/ϑ(G) for vertex-transitive graphs, every bound in the chain
ω ≤ ϑ(Ḡ) ≤ χ_f ≤ χ collapses to Hoffman's. **Measured at opening** (`build/m61/theta.json`; the LP over the p − 1 norm classes
of the translation scheme, whose eigenmatrix is the Kloosterman table of M58, solved by HiGHS for both ϑ and Schrijver's ϑ′
with the nonnegativity constraint):

| p | n | Hoffman α ≤ | ϑ | ϑ′ | ⌈n/ϑ′⌉ | true α | p²/5 |
|---|---|---|---|---|---|---|---|
| 11 | 121 | 34.55 | 34.55 | 34.55 | 4 | **28** (exact) | 24.2 |
| 19 | 361 | 99.50 | 99.50 | 99.50 | 4 | ≥ 76 | 72.2 |
| 23 | 529 | 131.76 | 131.76 | 131.76 | 5 | ≥ 106? (running) | 105.8 |
| 31 | 961 | 240.25 | = | = | 5 | — | 192.2 |
| 43 | 1849 | 395.23 | = | = | 5 | — | 369.8 |
| 47 | 2209 | 466.39 | = | = | 5 | — | 441.8 |
| 59 | 3481 | 693.14 | = | = | 6 | — | 696.2 |
| 67, 71, 79, 83 | | | = | = | 6, 7, 6, 6 | | |

ϑ = ϑ′ = Hoffman to 10⁻⁹ at all eleven primes: the LP is exhausted, exactly as the theorem says. The fractional chromatic number
of a vertex-transitive graph is n/α, so χ ≥ ⌈p²/α⌉ and a 5-colouring needs α ≥ ⌈p²/5⌉; at 11 the truth α = 28 sits 6.5 below
the bound and gives χ_f = 121/28 ≈ 4.32 against χ = 5. **So the first digit is integrality-carried at every prime below 59** —
the finite planes reproduce G24's pathology (ω ≤ 3, every relaxation low, χ higher) exactly, and the only relaxation that could
reach 6 at 23–47 is α itself, by a cardinality refutation (no LP does it). The α instance at 23 (a 1.5-MB CNF) is that
refutation's cost; if it returns UNSAT the plane is ≥ 6 with no colouring search, and if SAT (the calibration says likely) the
fractional face is silent at 23 and the colouring question stands.

**Kernel piece**: the counting bound `Fintype.card V ≤ k · indepNum` for any k-colourable finite graph (each colour class is an
independent set) — general, hypothesis-free, apparently absent from Mathlib (`indepNum` exists, the colouring bound does not),
with the contrapositive as the consumer of any future certified α refusal. No instance today: an α refusal is a solver claim.

### §S3. The periodic quotient — every periodic colouring of the plane is a colouring of one circulant on p vertices

**The classical object.** A colouring of 𝔽_p² with a nonzero period d is constant on the cosets of the line ℓ = 𝔽_p·d (the
period group is a subgroup, and the subgroups of order p of 𝔽_p² are exactly its lines). It is proper only if ℓ misses the unit
circle — ℓ is a **null line**, its direction of non-square norm — and then it is exactly a proper colouring of the quotient
graph on 𝔽_p²/ℓ ≅ 𝔽_p, the **circulant** C_p := Cay(𝔽_p, π(S)) where π projects along ℓ; |π(S)| = (p + 1)/2 (each line parallel
to ℓ meets the circle in 0 or 2 points), symmetric, 0 ∉ π(S). All (p + 1)/2 null lines are one rotation orbit (μ_{p+1} acts on
directions with stabilizer ±1, two orbits by norm class), so C_p is one graph per prime. Hence:

> **χ_per(p) := the least number of colours of a PERIODIC proper colouring of UD(𝔽_p, 2) = χ(C_p); χ(UD(𝔽_p, 2)) ≤ χ(C_p); and
> α(UD(𝔽_p, 2)) ≥ p·α(C_p)** (an independent set of the circulant lifts to a union of parallel null lines).

**Measured at opening** (`build/m61/partA.log`, `circulant.json`; pysat cadical under a 2·10⁶-conflict budget, every lifted
independent set verified in the plane for p ≤ 47):

| p | |π(S)| | χ(C_p) | α(C_p) | so α(UD) ≥ | χ(UD) known | reading |
|---|---|---|---|---|---|---|---|
| 3 | 2 | 3 | 1 | 3 | 3 | periodic attains χ |
| 7 | 4 | 4 | 2 | 14 | 4 | periodic attains χ |
| 11 | 6 | **6** | 2 | 22 | 5 | **no periodic 5-colouring** — the certified table's aperiodicity (M60) was necessary, not the solver's taste |
| 19 | 10 | **5** | 4 | 76 | 5 | a periodic 5-colouring exists; the α = 76 set of §S0 IS four parallel null lines y = 6x + c, c ∈ {0, 5, 10, 14} |
| 23 | 12 | 8 | 3 | 69 | ∈ {5, …, 8} | no periodic colouring below 8 |
| 31 | 16 | 8 | 4 | 124 | ∈ {5, …, 8} | |
| 43 | 22 | 8 | 6 | 258 | ∈ {5, …, 8} | |
| 47 | 24 | [9, 10] | 5 | 235 | ∈ {5, …, 10} | |
| 59 | 30 | [9, 10] | 6 | 354 | ∈ {6, …, 10} | |
| 67, 71 | 34, 36 | [9, 12] | 6 | 402, 426 | ≥ 6, ≥ 7 | |

Three readings, each a derivation with its instance. (i) **The periodic upper bound is the finite analogue of M37's coset
colourings** (lattice colourings of ℝ² need exactly seven): here the "lattice" colourings need χ(C_p), which grows like
p/α(C_p) ~ p/(2 log p) while χ itself grows like √p/2 — the periodic family is the wrong family from 23 on, as the lattice
family was for six. (ii) **At 11 the plane's 5-chromaticity is carried by non-periodic colourings only**, the first prime where
that happens; at 19 both kinds exist. (iii) **The 19-plane's `χ ≤ 5` becomes a 19-entry kernel certificate**: the quotient
homomorphism `addCayley S →g addCayley (π '' S)` for an additive hom π whose kernel misses S (a general Mathlib-shaped lemma),
composed with a decided 5-colouring of C₁₉ — the second finite plane in the kernel, at a hundredth of the 361-entry table's cost.

### §S4. The symmetry face — equivariant colourings, and the half-turn as the surviving genre

A colouring invariant under a nontrivial rotation r about the origin is never proper (col(z) = col(rz) with z ~ rz on the
circle of norm 1/N(r − 1)); the right notion is **equivariance**, col ∘ r = τ ∘ col for a permutation τ of the palette with
τ^{ord r} = 1 (M26's rot6-equivariant colouring of the hexagram is the genre's first instance here; M30's forced central
symmetry and M50's forced central anti-symmetry are its forced forms). Equivariant colourings are colourings of the orbit
quotient, so the search space shrinks by ord r; and translation-equivariance is periodicity (τ^p = 1 forces τ = 1 in S₅).

**Measured at opening** (`build/m61/partF.log`, `equivariant-k5.json`; one rotation per order, τ over the conjugacy classes of
S₅ of compatible order, pysat cadical at 5·10⁶ conflicts):

| p | rotation orders with an equivariant 5-colouring | refused | undecided |
|---|---|---|---|
| 11 | 2 (τ a transposition or a double transposition), 3 (τ a 3-cycle), 6 (τ = 3-cycle × transposition) | 4, 12 — every τ | — |
| 19 | 2 (τ a double transposition only) | 4, 5, 10, 20 — every τ; order 2 with a single transposition (108 s) | — |
| 23 | — | 3, 4, 6, 8, 12, 24 — every τ, all in ≤ 2 s; order 2 with the identity or a transposition | **order 2 with τ a double transposition: unknown at 500 s** |

Also: the solver's own colourings at 11 and 19 (`chi-p11.json`, `chi-p19-k5.json`) have TRIVIAL equivariance groups under the
whole 𝔽_p² ⋊ O(2) (`partC`) — the symmetric colourings exist beside them, unseen. **The reading**: the survivable symmetry
narrows with p to the **half-turn with a colour double-swap** — col(−z) = τ(col z), τ = (ab)(cd), the origin's colour the fixed
one — the exact finite form of M50's forced central anti-symmetry; at 23 that single instance (2,645 variables, 34,915 clauses,
half the plane's freedom) is THE colouring question's best-shaped form and runs under the external cadical at a one-hour wall
(`build/m61/halfturn-chain.sh`, chained behind the α run). Its refusal would say that a 5-colouring at 23, if any, has no
symmetry at all — G31's floppiness turned around: the sealing planes' colourings are structureless.

### §S5. Derivation (c) — the mechanism of tightness: a spindle turns off its own prime

This is the derivation the stub's phase B asked for, made at opening from M60's distance law and one congruence.

**Setting.** F a real field, 𝔭 a usable prime above p ≡ 3 (mod 4) whose plane UD(𝔽_{p^f}, 2) is k-colourable and pairwise
free at k (F_p(k) = {0}: measured at 3, 7, 11, 19 at their χ; kernel at 11). Let G be a unit-distance graph over F forcing a
pair (u, v) equal at k colours, d² := quad(u − v) its squared distance. **M60's law**: d² ≡ 0 (mod 𝔭). The spindle over the
pair — the rotation about u carrying v to a point at unit distance from v — has cos θ = 1 − 1/(2d²) and sin θ = √(4d² − 1)/(2d²),
so the spindled graph G ∪ ρG (χ ≥ k + 1 by the spindle theorem, `OneDefect.lean`) has its coordinates in F′ = F(√(4d² − 1)).

> **Theorem (the spindle escapes its prime).** In F′ every prime above p has EVEN residue degree — p is not usable in F′.
> *Proof.* x := √(4d² − 1) satisfies x² = 4d² − 1 ≡ −1 (mod 𝔭′) for any 𝔭′ | 𝔭 (x is 𝔭′-integral, its square a unit ≡ −1), so the
> residue field of 𝔭′ contains a square root of −1, hence contains 𝔽_{p²}. ∎
> The 2-adic form: v₂(d²) ≥ 2 gives 4d² − 1 ≡ −1 (mod 16), so −(4d² − 1) is a 2-adic square and −1 becomes a square in F′ ⊗ ℚ₂ —
> the wall breaks (this is why every wall-breaking spindle of the record has an even integer or 8/3 as its distance).

**Every attained row of §2 is an instance.** The rhombus forces its far pair (d² = 3) at three colours over ℚ(√3), where 3 is
the sealing prime; the spindle adjoins √11, 11 ≡ −1 (mod 3): the Moser spindle's field K has 3 inert in ℚ(√11) — the 3-adic
bound is gone, L(K) = 4 (the 2-adic wall), attained. K-fabric forces pairs at 2, 4, 2√3, 8/3 (all 𝔭₂-divisible — G36) at four
colours; the spindle at 2 adjoins √15 (15 ≡ −1 mod 16), at 8/3 adjoins √247 (247 ≡ 7 mod 8): the wall breaks, the next local
bound is 11's plane at 5, attained by the forcer itself (Heule's field, K(√247)). **So the local bound is attained one level up
because the forcer's own construction removes exactly the prime that gave the bound it beats — never a coincidence of fields.**

**The consequence at the 6-level, exactly.** Over a 5-sealed field with 11 as the sealing prime (Heule's, K(√247), K(√23)), a
pair forced equal at five colours has 11 | d² (d ∈ {√11, √33, 2√11, √11/2, …}); its spindle adjoins √(4d² − 1) ∈ {√43, √131,
√175 = 5√7, √10, …}, each ≡ √−1 (mod 11), so the spindled graph's field has 11 inert, the wall still broken (inherited), and every
remaining usable prime ≥ 67 (M58 §S1) — it is **6-open by construction**, and T1 at the 6-level reduces to ONE question: *does any
5-sealed field carry a 5-rigid pair?* That is G19's "5-tight fabric", now with its distances named by residue (the FS-16 vocabulary
is the virtual-edge side; this is the forced-equal side: 11 | d²). The stub's "predicts the forcer's field" is therefore exact:
ℚ(√3, √5, √11, √43) for a forced √11-pair over Heule's field, and so on.

**Kernel form.** Two general lemmas and a composition, all ring-level (the field-level statement about residue degrees stays
the hand argument, like M58's integrality): (1) *no isotropic vectors*: in ZMod p with p ≡ 3 (mod 4), `quad w = 0 ↔ w = 0`
(`ZMod.exists_sq_eq_neg_one_iff`); (2) *the radicand lemma*: a ring hom φ : R →+* ZMod p with p ≡ 3 (mod 4) cannot send d to 0
when R holds x, e with x² = (4d − 1)·e² and φ e ≠ 0 (φ(x/e)² = −1) — spec: no hom ℤ[√43] → ZMod 11 and no hom ℤ[√11] → ZMod 3,
against the positive control ℤ[√3] → ZMod 11 (√3 ↦ 5); (3) *the composition*: a graph drawn in R and forcing u, v equal at k
colours, where UD(ZMod p) is forces-free at k, admits no drawing-compatible hom R → ZMod p once R holds the spindle radicand of
the pair — through `Forces.image`, the forces-free hypothesis, (1), `unitQuadrance.map`, and (2). Instantiated at 11, k = 5,
with `finitePlane11_forces_iff`.

### §S6. Derivation (d), notes only — the gluing obstruction

A colouring of F² local at 𝔭 is constant on each coset x + p·𝒪_F², which for [F : ℚ] ≥ 2 is DENSE in ℝ² (𝒪_F is dense in ℝ);
the hexagonal colouring's classes are unions of tiles, so its restriction to any such F² is local at no prime — "no colouring
of ℝ² restricts to a local one" is true for every colouring whose classes are not dense in every open set, and false only for
colourings with every class dense (which measurable colourings with finitely many classes cannot all be... a class of positive
measure has density points; the question is whether a global colouring can have EVERY class dense, which the Lebesgue density
theorem does not forbid). The honest statement for phase C: *the obstruction to gluing local colourings across fields is that
the cosets of F² in ℝ² are joined by unit edges in every direction, so a colouring assembled from local colourings of the cosets
is never proper* — the same reason the finite-plane bound is a bound on F² and not on ℝ². Nothing computable here yet; recorded
so the next session does not re-derive it.

### §S7. The instrument — `tools/fplane.py` gains the plane's own invariants

The scratch `build/m61/derive.py` and `alpha.py` are promoted into `tools/fplane.py` (the module that owns `chi` and
`spectral`; the invariants belong beside them) as four subcommands, each writing a `data/fplane/` record with the M58 licence
column: `alpha --p P [--N N | --ladder]` (the cardinality instance under the external cadical: SAT is a verified independent
set, UNSAT the solver's), `periodic --below B` (the circulant's χ and α with budgets, the lifted colouring VERIFIED in the
plane), `theta --below B` (the LP with the Hoffman column as the control that must agree), `equivariant --p P --k K` (the
rotation/reflection sweep with the M26 genre's τ classes; a SAT is a verified colouring), and `chi --q 27` for the odd-degree
plane. Self-test additions: the 19 lift (four lines), the 11 refusal (χ(C₁₁) = 6 as a control the periodic route must reproduce),
a planted non-null line (must be refused as improper), ϑ = Hoffman at 11.

### §S8. Phases and registered predictions

| phase | what | cost |
|---|---|---|
| 0 | this section; the kernel skeleton (§S5's three lemmas, §S3's quotient hom and the 19 instance, §S2's counting bound); three modeling passes; the instrument | today |
| A | the first digit: the α verdict at 23; the half-turn instance at 23 (1 h); its siblings at 31, 43, 47 (the fast refusals, then the half-turn); if the half-turn refuses everywhere, price cube-and-conquer on the half-turn instance (the origin's four hexagons, up to O(2) and palette) before running it; 59 at six colours in the equivariant family | a day; the cube-and-conquer priced, not promised |
| B | §S5 in the kernel and in the Frontier; the 6-level design vocabulary (forced distances with 11 ∣ d², spindle fields) written into FS-6/FS-16 | half a day |
| C | §S6: notes only | — |

| # | prediction | status / confidence |
|---|---|---|
| P1 | 23, 31, 43, 47 are 5-chromatic; 59 is 6-chromatic | kept, low-medium (Hoffman 1.4 below the truth at 11 and 19) |
| P1a | the half-turn family at 23 is SAT — a centrally anti-symmetric 5-colouring exists | low-medium (unknown at 500 s; every other symmetry refused) |
| P2 | first half MET (M60); second half RE-REGISTERED: on the unit part, pairs at distances 3 and 4 have r ≡ 9, 16 ≢ 1 (mod 11) and are therefore never virtual edges at five colours over a sealed field — the OPPOSITE of the stub's reading, and a theorem, not a measurement; the 148 absolute virtual edges are compulsions of the {1, 2}-graph, outside the transfer's scope | settled by derivation |
| P3 | T1 fails nowhere among the fields held | unchanged |
| P4 | ϑ = Hoffman at every prime (arc-transitivity) | MET at opening, eleven primes |
| P5 | α(23) ≥ 106 — the fractional face does not decide 23 | medium-high; the run decides it |
| P6 | no rotation-equivariant 5-colouring of order ≥ 3 at 23; the same at 31, 43, 47 | 23 MET at opening (solver refusals); the rest medium |
| P7 | χ(C_p) ≥ 6 for every p ≥ 23 — no periodic 5-colouring beyond 19 | measured to 71; high for p ≤ 200 |
| P8 | χ(UD(𝔽₂₇, 2)) = 5 | medium (four refused; five pending) |

**Failure and pivot clauses, carried from §7**: a plane exactly 6-chromatic HALTS phase A and turns phase B into design in the
field §S5 names; a 5-sealed wall-broken field with a 4-colouring local at no prime is the larger finding. Added: if the half-turn
instance at 23 refuses AND cube-and-conquer is priced above a day, phase A closes at "23 undecided, its symmetric colourings
exhausted" and the milestone closes on §S5.

### §S9. Decisions at subplanning

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| kernel module | one new `LocalGlobal.lean` (the quotient hom, the counting bound, the isotropic lemma, the radicand lemma, the composition) + `Instances/LocalGlobal19.lean` (C₁₉'s table, the 19-plane's ≤ 5) and the 11 instance of the composition in `Instances/ResidueObstruction11.lean`'s sibling | spread over `UnitQuadrance.lean`/`ResidueObstruction.lean` (upstream edits — hours of rebuild) | leaves-first; nothing upstream changes | high |
| instrument | extend `fplane.py` | a third module | the invariants belong with `chi`/`spectral`; one self-test | medium (the experience pass may split) |
| ϑ, α refusals, equivariant colourings | tools only; the LP's Hoffman column is its control | LRAT for the α refusal at 23 | no certificate exists yet; priced when one does | high |
| the odd-degree plane | one row, tools only | `GaloisField` in the kernel | does not compute | high |

## §M1. Domain-modeling pass (2026-09-07; fresh Skill invocation)

*Grok: a periodic colouring of a Cayley graph is a colouring of the quotient by its period group; the plane's period groups
are lines; a null line's quotient is a circulant on `p` vertices. The spindle over a pair at squared distance `d` adjoins
`√(4d − 1)`; a hom killing `d` sends it to `√−1`. The counting bound is a partition into independent sets. Each object was
simulated on the 19 instance (four null lines, a ten-element `D`), on the 11 control, and on the rhombus at 3 before the
statements were reshaped.*

| object as skeletoned | what the pass found | reshaped to |
|---|---|---|
| `addCayleyMap π S hS : addCayley S →g addCayley (π '' S)` + `colorable_of_addCayley_image_subset (hD : ∀ s ∈ S, π s ∈ D)` | `Set.image` is incidental — no consumer names the image; the intrinsic data is a target set `D` containing the projected connection set, and the kernel condition `∀ s ∈ S, π s ≠ 0` (`S ∩ ker π = ∅`) IS the null-line condition, elementwise and decidable. The quotient-group form `A ⧸ H` adds Mathlib's `QuotientAddGroup` for nothing: a quotient map is an additive hom, and the concrete projection at 19 never names its kernel | **one def `addCayleyMap π hS hD : addCayley S →g addCayley D`** for any `D ⊇ π '' S`; `colorable_of_addCayley_quotient` its one-line consumer; no `Set.image` anywhere |
| `addCayleyColoring tab (h : ∀ d ∈ D, ∀ x, tab x ≠ tab (x + d))` | the hypothesis is properness along `D`, the negation of M60's coincidence `∃ t, col (t + d) = col t` at every `d ∈ D` — M60 wrote coincidence with `t + d` on the left; naming a shared `Coincides` predicate would be an M60 upstream edit for two uses | kept, oriented as M60 writes it: `tab (x + d) ≠ tab x` |
| the table as `Fin 19 → Fin 5` on a `ZMod 19` domain | `ZMod (n+1)` IS `Fin (n+1)` by definition, so the `![…]` literal elaborates at type `ZMod 19 → Fin 5` directly — the domain's type, no coercion in sight | **tables typed on `ZMod p`** |
| the circle written as `s.1 ^ 2 + s.2 ^ 2 = 1` in every hypothesis | the plane is `addCayley` of a set nobody had named; the quotient theorem is the first statement that quantifies over it | **`abbrev unitCircle R : Set (R × R)`** and **`abbrev quadrance (w : R × R) : R`** — local abbreviations (reducible, so M58's inline forms still match), no upstream edit; `unitQuadrance R = addCayley (unitCircle R)` by `rfl` |
| `nullProj p (x, y) := y − x`, a def for all `p` that is null only when 2 is a non-residue (`p ≡ 3, 5 mod 8`; at 7, `(1,1)` has norm `2 = 3²`) | the intrinsic object is **the projection along a direction `v`**: `w ↦ v.1·w.2 − v.2·w.1` (the 2-D determinant), kernel the line `R·v`; nullness is a hypothesis decided per prime, and at 7 a different `v` serves | **`projAlong (v : R × R) : R × R →+ R`**, general; `projAlong_self : projAlong v v = 0`; the instance uses `projAlong (1, 1)`; a **red at 7** pins that `hS` is load-bearing: `¬ ∀ s ∈ unitCircle (ZMod 7), projAlong (1,1) s ≠ 0` |
| `card_le_mul_indepNum_of_colorable : card ≤ k · indepNum` on `sSup` | the consumer of a certified α-bound supplies an explicit `a` with every independent Finset of card `≤ a`; `indepNum` is that with `a := indepNum` (`IsIndepSet.card_le_indepNum`) — make the explicit form the primitive and `indepNum` its instance; the fractional face's honest statement is on `chromaticNumber` in `ℕ∞` | **`card_le_mul_of_colorable (hα : ∀ s : Finset V, G.IsIndepSet ↑s → s.card ≤ a)`**, then `card_le_mul_indepNum_of_colorable`, `not_colorable_of_mul_lt`, and **`card_le_chromaticNumber_mul_indepNum : (card V : ℕ∞) ≤ χ · α`**; model: the four null lines at 19 as a decided `IsIndepSet` of card 76 (`76 ≤ indepNum`) |
| `sq_add_sq_eq_zero_iff` on scalars only | the plane-level fact is about the quadrance of a vector: `quadrance w = 0 ↔ w = 0` — the "no isotropic vectors" of M59/M60's prose, never stated; the scalar form is its arithmetic | both: the scalar lemma (Mathlib grep first) and **`quadrance_eq_zero_iff`** |
| `quadrance_map` with target `ZMod p` | a ring-hom fact for any target | **`quadrance_map (φ : R →+* S)`** |
| `no_ringHom_of_spindle_radicand … : False` | the mechanism's positive content is "a hom killing `d` makes `−1` a square in the target"; `p ≡ 3 (mod 4)` is the consumer's clause, and the target need only be a field | **`isSquare_neg_one_of_spindle_radicand [Field K] (φ : R →+* K) … : IsSquare (−1 : K)`** as the primitive; `no_ringHom_of_spindle_radicand (hp) … : False` its `ZMod p` corollary via `ZMod.exists_sq_eq_neg_one_iff` |
| `Forces.no_hom_of_spindle_radicand` with the radicand coordinatewise and `False` for a given `φ` | two theorems were fused: (i) a drawing `g` plus `φ` is a hom into the plane, and if it IDENTIFIES the pair then `φ (quadrance (g u − g v)) = 0` — true for any nontrivial target; (ii) forces-freeness turns `Forces` into identification. And the field-level reading "no reduction at `p` exists" is `IsEmpty (R →+* ZMod p)`, which needs the unit `e` to be a unit of `R` rather than nonzero under one `φ` | **`quadrance_sub_eq_zero_of_map_eq`** (i); **`Forces.no_hom_of_spindle_radicand`** (ii, the `φ`-form with `quadrance` in the radicand); **`Forces.isEmpty_ringHom_of_spindle_radicand (he : IsUnit e) : IsEmpty (R →+* ZMod p)`** the consumer's shape |
| `hfree : ∀ u v, Forces (finitePlane p) k u v → u = v` inline | a named `ForcesFree` would earn nothing yet (two instances, one hypothesis site) and M60 states the 11 fact as an `iff`; note it can only hold when the plane IS `k`-colourable (a non-colourable plane forces every pair vacuously), so colourability travels inside it | kept inline |
| the 3-plane forces-free by two tables, composed by hand | a role unnamed: M60's `forces_iff_eq_of_aperiodic` is the singleton case of "a family of colourings with no common nonzero period refutes every forced pair" | **`eq_of_forces_of_forall_exists_not_periodic (cols : List (Coloring)) (h : ∀ d ≠ 0, ∃ c ∈ cols, ¬ Periodic c d)`**; the 11 fact re-derived from the singleton list as an `example`; the 3-plane the two-element instance |
| the rhombus in `UD(𝔽₃, 2)` with `R = ZMod 3, φ = id` as the composition's model | honest as "every hypothesis but the radicand": the radicand equation `x² = −e²` has no solution in `ZMod 3` with `e ≠ 0`, which is exactly the theorem's content; the alternative model (`ZMod 3[√11] = 𝔽₉`) satisfies every hypothesis and would exercise the `IsEmpty` form, but `Adjoin` demands a `NatScalar` instance `ZMod 3` lacks — priced, not done | kept; the `#guard` on the radicand's unsatisfiability stays as the reading's pin |
| not in the skeleton | the converse of the quotient (a periodic proper colouring of the plane is a proper colouring of the circulant, so `χ_per = χ(C_p)`) is needed only to READ a solver refusal of the circulant, whose antecedent is not certified — left out and said; equivariant colourings, the `GaloisField` plane, the circulant's own χ: tools only | — |

**Seams validated.** Models: the 19 instance for the quotient theorem; the 11 six-colouring; the four-line independent set for the
counting bound; the tower examples for the radicand lemma (two empties, two inhabited controls); the rhombus at 3 for the
composition. Adversaries: the non-null direction at 7 (red); the moved-entry table at 11 (red); the composition with a
non-colourable plane (`hfree` false, so no instance — by design). The next lemma the vocabulary earns for free: the 23-plane's
periodic bound `χ ≤ 8` would be one more `projAlong (1,1)` instance with a 23-entry table (2 is a non-residue mod 23) — not
worth a kernel row, but it states.
