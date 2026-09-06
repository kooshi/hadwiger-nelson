# FS-7 — The field sieve: which fields can host a 6-chromatic unit-distance graph (STUB, 2026-09-06; opens as M58)

*Minted on the finite-plane pivot of 2026-09-06, at Kooshi's direction ("add stubs for all of them … then you can work on
the field sieve milestone"). Written to the stub rule's standard: everything the deciding session knew, in plain language,
so a session with zero conversation memory can subplan it. Read beside this: `reference/Chat-analysis/analysis.txt`
(Kooshi's web-Claude session — the theorem and the idea), `reference/Chat-analysis/VERIFICATION.md` (this repository's
verification of every claim, and what is NOT verified), `tools/fplane.py` (the instrument, `self-test` green),
`data/fplane/` (the records), `CLAUDE.md` § Frontier's pivot paragraph, ledger row 52, G43, G35/G38 (the walls at 2 and 3,
which this generalizes), `plans/FIELD-WALL-THEOREM.md` (Theorem B — the p = 2 face of the same mechanism),
`Proofs/HadwigerNelson/Instances/Heule510.lean` and `Heule510/` (the certified 5-chromatic 510-point graph the kernel
phase reduces), `BIBLIOGRAPHY.md` [Vinh2005], [Fischer1990].*

## 1. Mission context, in plain language

χ(ℝ²) is the supremum of χ(F²) over real number fields F, because every finite unit-distance graph has its coordinates
in one. Theorem B (M53) showed χ(F²) = 4 for F = ℚ(√3, √11) by colouring the residue plane modulo a prime above 2 with a
LINEAR map; Fischer's additive colourings are the same idea at every prime, and their values jump from 4 to 7 and 11 —
"the arithmetic goes blind above four" (G38). The pivot found the step past that blindness inside Theorem B's own proof:
the residue map at a degree-one prime 𝔭 above a prime p ≡ 3 (mod 4) sends every finite unit-distance graph in F² into the
**finite Euclidean plane** UD(𝔽_p, 2) = Cay(𝔽_p², {(a, b) : a² + b² = 1}) as a graph HOMOMORPHISM, so

    χ(F²) ≤ χ(UD(𝔽_p, 2)),

and the finite plane's own chromatic number is not linear: **χ(UD(𝔽₁₁, 2)) = 5**, where the linear bound is 11.
Consequences already verified here: χ(ℚ(√3, √5, √11)²) = 5 exactly (Heule-510 below, the pulled-back colouring above),
χ(K(√247)²) = 5 exactly (the T20 witness W below), and **every field the descent (M49–M53), the copy-lock family (M52),
the witness and the thickening (M54–M57) ever used — K, K(√5), K(√247), K(√5, √247), Heule's ℚ(√3, √5, √11) — is
5-SEALED: no 6-chromatic unit-distance graph has its coordinates there.** De Grey's field ℚ(√3, √5, √7, √11) has no usable
prime below 131 (√7 makes 11 inert); K(√7) has 83 first; K(√35) has 107 first but never breaks the 2-adic wall, so it is
sealed at FOUR by Theorem B (D3′) — the live candidates are de Grey's field and K(√7), and the single radicals d = 7, 79, 127, …

The milestone: (i) solve the finite planes at the candidate fields' smallest usable primes and map which primes SEAL
(their plane is ≤ 5-chromatic) and which do not; (ii) state the exact values χ(ℚ(√3, √5, √11)²) = χ(K(√247)²) = 5 as
theorems and certify their computable halves in the kernel; (iii) hand every later milestone a table: for each field we
hold or might build in, sealed or open, with the sealing prime. This is a FIELD-SELECTION instrument, not a route to 6 by
itself: it bounds χ(F²) from ABOVE for specific F and can never bound χ(ℝ²) (fields with no small usable prime exist), and
it never produces a 6-object. Its value is that it decides where the hunt may work before any more solver time is spent,
and that its exact planes are the first values of their kind.

## 2. What we know (verified, `reference/Chat-analysis/VERIFICATION.md`)

| fact | status | where |
|---|---|---|
| the theorem: a degree-one prime above p ≡ 3 (mod 4) (or odd residue degree) ⟹ a homomorphism F²-graphs → UD(𝔽_p, 2) | hand proof, re-run here (§3 D1) | VERIFICATION.md §1 |
| χ(UD(𝔽₃,2)) = 3, χ(UD(𝔽₇,2)) = 4, χ(UD(𝔽₁₁,2)) = 5, χ(UD(𝔽₁₃,2)) = 5 | measured (pysat/cadical, k−1 UNSAT, k SAT verified) | `data/fplane/chi-p11.json`; Vinh 2005 for p = 7 |
| the circle has p + 1 points for p ≡ 3 (mod 4), p − 1 for p ≡ 1 | fact | `fplane.py self-test` |
| Heule-510 → UD(𝔽₁₁,2): √3 ↦ 5, √5 ↦ 4, √11 ↦ 0 (denominator 96 ↦ 8, inverse 7): 2,504 / 2,504 edges on the circle, all 121 residues hit, pulled-back 5-colouring proper | measured, exact | `data/fplane/reduce-heule510-p11.json` |
| W → UD(𝔽₁₁,2): √247 ↦ 4 (247 ≡ 5): 5,773 / 5,773; the seed's unit part 1,004 / 1,004 (51 residues) | measured, exact | `data/fplane/reduce-*.json` |
| the sieve (p ≡ 3 mod 4, every radicand a square or 0 mod p): K: 11, 83, 107, 131, 167, 227; Heule's: 11, 131, 239, …; **de Grey's: 131, 479**; K(√247): 11, …; K(√35): 107, 131, …; K(√7): 83, 131, …; K(√5): 11, … | computed | `fplane.py usable` |
| de Grey's 1581 carries √7 (8,092 nonzero coefficients): the 11-bound does not reach it | measured | VERIFICATION.md §2 |
| the planes at p = 17, 19, 23 (k = 4 refused at 17; the rest running) and at p = 83, 107, 131 at k = 5 (running) | in flight at the compaction | `build/m57/fplane-1923.log`, `build/m57/fplane-big.log` (build/ is gitignored; re-run if lost: `fplane.py chi --p P`) |
| Vinh 2005: the plane and its asymptotic bounds; computes only p = 7; no number fields, no reduction | read (full text for this question) | [Vinh2005] |
| novelty of the bound and of χ(UD(𝔽₁₁,2)) = 5: PROVISIONAL (Soifer 2024 unread; the 2022 clique paper paywalled) | — | VERIFICATION.md §4 |
| a planted red: a wrong residue for √3 (4, not a square root of 3 mod 11) breaks the homomorphism (392 of 2,504 on the circle) | control | `fplane.py self-test` |

## 3. The derivations to do first (G30: before any instrument runs — the first two are done, the rest are the subplan's)

**D1 — the theorem, in its general form (done).** F ⊂ ℝ a number field, 𝔭 a prime of F above p with residue field
𝔽_q, q = p^f. If q ≡ 3 (mod 4) — i.e. p ≡ 3 (mod 4) and f odd — then 𝔽_q lacks √−1, so 𝔭 is inert in F(i) (it is odd,
hence unramified in F(i), and it splits iff −1 is a square in 𝔽_q); the unique prime 𝔓 above it is fixed by complex
conjugation, which reduces to the Frobenius of 𝔽_{q²}/𝔽_q. A unit vector z = x + iy (x, y ∈ F, z z̄ = 1) has
v_𝔓(z) = v_𝔓(z̄) = 0, so it is 𝔓-integral; translating a connected component so a vertex is 0 makes every vertex a sum of
unit vectors, hence integral; reduce modulo 𝔓 and write the residue as a + b√−1 with a, b ∈ 𝔽_q. An edge's difference
reduces to r with r · r^q = N(r) = a² + b² = 1, a nonzero point of the circle. So v ↦ (a, b) is a homomorphism into
UD(𝔽_q, 2). **If 𝔭 splits in F(i) (q ≡ 1 mod 4) the argument fails at integrality** — e.g. (3 + 4i)/5 in ℚ(i) at p = 5 —
so p ≡ 1 (mod 4) and even residue degree are never usable. For multiquadratic F = ℚ(√d₁, …, √d_m) the residue degree
at p is 1 or 2, so usable ⟺ p ≡ 3 (mod 4) and every dᵢ is a square or 0 mod p (a ramified √dᵢ reduces to 0; the residue
field stays 𝔽_p): exactly the sieve. For a cubic field (Haugland's), f ∈ {1, 3} both odd — FS-8.

**D2 — the exact-value theorem, its shape (done).** χ(F²) = 5 ⟺ F holds a 5-chromatic unit-distance graph AND some
usable p has χ(UD(𝔽_p, 2)) ≤ 5. Instances now: Heule's field (Heule-510 + p = 11), K(√247) (W + p = 11), and K(√5, √247)
(W ⊂ it + p = 11). K itself: χ = 4 (Theorem B) — the 11-bound is weaker there, consistent.

**D3 — what "6-open" means, and the profile of a 6-hosting field.** A field can host a 6-forcer only if (a) the 2-adic wall
is broken (Theorem B: else χ = 4) and (b) for EVERY usable p, χ(UD(𝔽_p, 2)) ≥ 6. Since Vinh's lower bound (1/2 + o(1))√p
grows, all but finitely many usable primes have planes above 5, so (b) is a finite check per field: its usable primes
below the first prime whose plane is known ≥ 6, each plane solved. Derive the list of "5-sealing primes"
S₅ = {p usable somewhere : χ(UD(𝔽_p,2)) ≤ 5}; so far S₅ ⊇ {3, 7, 11} (3 seals at 3, 7 at 4, 11 at 5). **P4 below: S₅ =
{3, 7, 11}.** If so, for multiquadratic fields "6-open" ⟺ 2-adic wall broken ∧ some radicand is a non-residue mod 11 ∧
(the same at 3 and 7, automatically true once the wall at 3 is broken, G38). Derive this equivalence exactly before
measuring.

**D3′ — the profile for single-radical extensions of K, exactly (added while mining the analysis; one correction).**
For F = K(√d) = ℚ(√3, √11, √d): 3 is never usable (11 is a non-residue mod 3 — the prime above 3 has residue degree 2,
the 3-adic wall of G38); 7 is never usable in any field containing √3 (3 is a non-residue mod 7); 11 is usable iff d is a
square or 0 mod 11; and the 2-adic wall (Theorem B, G35) is broken iff some odd square class of {3, 11, d, 33, 3d, 11d, 33d}
is ≡ 7 (mod 8). So **K(√d) can host a 6-forcer only if d ≡ 7 (mod 8) up to the class arithmetic, d is a non-residue
mod 11, and every usable p ≥ 19 of the field (83, 107, 131, … filtered by d) has χ(UD(𝔽_p,2)) ≥ 6.** Instances: K(√5):
5 is a residue mod 11 — sealed at 5; K(√247): 247 ≡ 5 — sealed at 5; K(√7): 7 ≡ 7 (mod 8) breaks the wall, 7 is a
non-residue mod 11 — open pending 83; de Grey's K(√5, √7): the √7 makes 11 inert — open pending 131. **Correction to the
analysis:** it names √35 as an 11-inert endgame radical "already in the pool"; 35 is indeed a non-residue mod 11, but the
classes {35, 105, 385, 1155} are ≡ {3, 1, 1, 3} (mod 8) — K(√35) does NOT break the 2-adic wall, so χ(K(√35)²) = 4 by
Theorem B and it hosts nothing. The 11-inert AND wall-breaking radicals among the small square-free d ≡ 7 (mod 8): 7, 23,
31, 47, 71, 79, 103, 127, … filtered by "d a non-residue mod 11" — 7 (✓), 23 (23 ≡ 1: residue — sealed), 31 (31 ≡ 9:
residue — sealed), 47 (47 ≡ 3: residue — sealed), 71 (71 ≡ 5: residue — sealed), 79 (79 ≡ 2: non-residue ✓), 103 (103 ≡ 4:
residue — sealed), 127 (127 ≡ 6: non-residue ✓). So the candidate single radicals over K are d = 7, 79, 127, … — derive
the list to a bound in phase 0 and put every candidate through the sieve.

**D7 — the shadow sieve: an object-specific seal (added while mining; measured at minting).** For a unit-distance graph X
in F² and a usable 𝔭, let D_𝔭(X) ⊆ circle(𝔽_p) be the residues of X's unit edge vectors (both signs). The reduction maps X
into Cay(𝔽_p², D_𝔭(X)) ⊆ UD(𝔽_p, 2) — the SHADOW of X — and every subgraph of X, and every unit-distance graph whose
directions reduce into D_𝔭(X), maps there too. So **χ(shadow_𝔭(X)) ≤ 5 seals not only X but every graph built from X's
directions**, in a field whose whole plane may be 6-chromatic; and conversely a 6-forcer built from a direction set D must
have χ(Cay(𝔽_p², D)) ≥ 6 at every usable p — a necessary condition on DIRECTION SETS, checkable before any geometry. The
shadow is vertex-transitive (translations), so its chromatic number is a property of D alone. Measured at minting
(`scratchpad`, to be reproduced by `fplane.py shadow` under controls): at p = 131 the circle has 66 residue pairs up to
sign; **the 1581's 67 directions reduce to 55 of them; its gen-1 half-spindle closure's 358 directions reduce to all 66** —
the closure's shadow at 131 IS the whole plane (only P3 decides it), while the 1581's own shadow is a proper Cayley
subgraph whose χ (≥ 5, since the 1581 maps into it) is a sharper question: if it is 5, no 6-forcer can be built from the
1581's directions alone in de Grey's field. At p = 479: 64 of 240 and 210 of 240. So the direction set is a dial the
closure turns toward the whole circle — FS-6's growth in de Grey's field is watched here at 131 and 479 at once.

**D4 — the kernel route for χ(UD(𝔽₁₁, 2)) = 5 needs NO new refutation.** The plane is a Cayley graph on ZMod 11 × ZMod 11
with a 12-element connection set — definable in a line. Its 5-colouring is a `decide` (121 vertices × 12 neighbours). Its
non-4-colourability follows from the kernel-certified refusal of four colours on Heule-510
(`Instances/Heule510/Bound.lean`) through the reduction homomorphism: define the residue map on the certified table
(`heule510Table : PtTable`, coordinates in the M02 tower ℚ(√3,√5,√7,√11) as nested integer pairs scaled by 96; the √7
parts are identically zero, `Heule510.lean`'s module doc says so) — √3 ↦ 5, √5 ↦ 4, √11 ↦ 0, 96⁻¹ ≡ 7 — prove by `decide`
over the 2,504-edge list that every edge maps to a circle difference (the homomorphism, as data), and `Coloring.comap`
carries a 4-colouring of the plane back to Heule-510, contradiction. So **χ(UD(𝔽₁₁, 2)) = 5 is kernel-checkable on the
standard three axioms with two decides and one comap**, and χ(ℚ(√3,√5,√11)²) ≥ 5 is already in the kernel (Heule-510).

**D5 — the general "≤ 5" half as a kernel theorem (priced, optional).** "Every finite unit-distance graph in
ℚ(√3,√5,√11)² is 5-colourable" quantifies over all finite point sets; its proof is D1, whose one non-trivial step is the
integrality of unit vectors at the inert prime — a valuation argument (Mathlib: `IsDedekindDomain`, valuations at primes,
inertness via the residue field lacking √−1). Estimate: several hundred lines and a week; below the bar unless the exact
plane becomes a write-up. The SPECIFIC-graph form (D4) is what the kernel gets in this milestone; state D5 as a `sorry`-free
statement only if the domain pass finds a short route (e.g. the M02 tower's own integrality: the coordinates' denominators
are prime to 11 for every graph built from unit steps — a statement about the ORDER, not the field).

**D6 — the big planes' cost.** UD(𝔽_p, 2) has p² vertices and degree p + 1: p = 83 → 6,889 vertices, 289,338 edges;
p = 107 → 11,449 / 618,246; p = 131 → 17,161 / 1,132,626. At k = 5 the one-hot CNF has 5p² variables; a dense vertex-transitive
graph refuses quickly when it refuses (a Hoffman-type argument: χ ≥ n/α, and α(UD(𝔽_p,2)) ≤ p·(something) — derive the
Hoffman bound from the eigenvalues, which Vinh computed: they are Kloosterman-type sums; a certified spectral bracket
(M40's `celllat` machinery) gives χ ≥ 6 outright for large p if the bracket is above 5 — DERIVE which p first; it may
settle 131 without SAT). If SAT is needed: cube-and-conquer over the colours of a small clique (the M34/M42 machinery),
`tools/portfolio.sh` for the config race, one heavy job at a time.

## 4. The order of work

| phase | what | cost | reads |
|---|---|---|---|
| 0 | D3, D5's pricing, D6's Hoffman bracket for p = 19 … 131; read the running planes' logs | a day | P1 (partly), P4 |
| A | the map: χ(UD(𝔽_p, 2)) for every usable p ≤ 131 of any field in the sieve list — exact where SAT settles, a bracket where only Hoffman does; the record per p with the colouring (SAT) or the refusal (UNSAT, untrusted) | a day (83/107/131 may need cube-and-conquer) | P1, P2, P3, P4 |
| A′ | the shadow sieve: `fplane.py shadow <stage> --p P` — the residues of the stage's directions, |D|, and χ(Cay(𝔽_p², D)) by SAT (the same size as the plane's problem, sparser); run on the 1581 at 131 (55 directions) and 479 (64), on the gen-1 closure at 479 (210 of 240), on Heule-510 and W at 11 (a control: their shadows must be ≥ 5-chromatic) | hours to a day | P7 |
| B | the field table: for each field we hold (K, K(√5), K(√7), K(√35), K(√247), K(√5,√247), Heule's, de Grey's, the E–I frame, the seam field ℚ(√3,√11) = K) and the fields FS-6/FS-2 would build in: usable primes, the sealing prime if any, verdict sealed/open; `fplane.py map` writes it | hours | P5 |
| C | kernel: `Instances/FPlane11.lean` — the Cayley graph on `ZMod 11 × ZMod 11`, its 5-colouring by `decide`, the residue map on `heule510Table` and the homomorphism by `decide` over the edge list, `χ(UD(𝔽₁₁,2)) = 5` on the standard three axioms; the statement `five_le_chromaticNumber_heule_field` for the ≥ half is already the 510's theorem; the ≤ half stated for the certified 510 as the pulled-back colouring (a `decide`) | a day | P6 |
| D | D5 if the domain pass finds a short route; else priced and deferred with the number | — | — |
| E | close: gate, `data/fplane/` README, the Frontier (the field table into § Paths forward), the re-ranked frontier set (FS-6 restricted to the open fields the table names; FS-2's scope; FS-8), the write-up decision on the exact planes (Kooshi's bar) | | |

## 5. Registered predictions

| # | prediction | basis | confidence |
|---|---|---|---|
| P1 | χ(UD(𝔽₁₇,2)) = 5 (p ≡ 1, not usable; for the map) and χ(UD(𝔽₁₉,2)) = 6 = χ(UD(𝔽₂₃,2)) | the sequence 3, 4, 5, 5 at 3, 7, 11, 13; degree p + 1 growing | medium-low |
| P2 | UD(𝔽₈₃, 2) refuses five colours (K(√7) is open at its first prime) | Hoffman: n/α with α small on a dense circulant-like graph; Vinh's bound ≈ 4.6 is not decisive | medium |
| P3 | UD(𝔽₁₃₁, 2) refuses five colours (de Grey's field is 6-open) | as P2, larger | medium-high |
| P4 | 11 is the last 5-sealing prime: every usable p ≥ 19 has χ(UD(𝔽_p,2)) ≥ 6 | growth of degree and of the Hoffman bound | medium-low |
| P5 | the field table reads: sealed at 4 — K (Theorem B) and K(√35) (the 2-adic wall stands); sealed at 5 — K(√5), K(√247), K(√5,√247), Heule's; open pending their planes — de Grey's (131) and K(√7) (83); among single radicals over K only d ≡ 7 (mod 8) non-residues mod 11 (7, 79, 127, …) can be open | the sieve + Theorem B + P2–P4 | medium (P2/P3-conditional) |
| P6 | `Instances/FPlane11.lean` lands on the standard three axioms with no LRAT: two decides and one comap, under 200 lines | D4 | high |
| P7 | the 1581's 55-direction shadow at 131 is 5-chromatic (no 6-forcer from the 1581's directions in de Grey's field), while the whole plane at 131 refuses five (P3): the shadow sieve separates the object from its field | D7; the 1581's directions are a crystal's, the plane's full circle is richer | medium-low |

## 6. Failure and pivot clauses

* **A usable prime seals de Grey's field** (some p ∈ {131, 479, …} with χ(UD(𝔽_p,2)) ≤ 5): then the 1581, its closures
  and everything built on de Grey's field are ≤ 5-chromatic — no contradiction (they are 5-chromatic), but the hunt must
  LEAVE that field: HALT, report, and re-plan from the field table (the profile of D3: a wall-broken field with no small
  usable prime — e.g. a field whose radicands are non-residues at every small p ≡ 3 mod 4).
* **A plane with χ ≤ 4 at a usable prime of a field holding a certified 5-chromatic graph** — impossible by the theorem:
  an instrument catastrophe (the reduction or the solver is wrong); HALT.
* **P4 refuted** (a 5-sealing prime beyond 11): the sieve's list grows; the field table is recomputed; nothing else changes.
* **P2 or P3 undecided at cap after cube-and-conquer**: the field's status is "open pending p"; recorded as such, never as open.
* **A literature hit** (the bound or the p = 11 value published): the novelty claim is withdrawn in `BIBLIOGRAPHY.md` and
  the Frontier; the field consequences stand regardless.

## 7. Instruments

`tools/fplane.py` (`chi --p P [--k K] [--wall S]`, `usable --rads …`, `reduce <stage> --p P [--colouring FILE]`, `self-test`
— 11 controls, all green at minting); to add: `shadow <stage> --p P` (D7: the direction residues, |D|, χ of the Cayley subgraph by SAT; controls: Heule-510's and W's shadows at 11 must be ≥ 5-chromatic, a planted direction set that is a single pair must be 2-chromatic), `map --fields …` (the table), cube-and-conquer for `chi` at big p (colour
cubes over a clique; the M34 pattern), a Hoffman bracket from the plane's eigenvalues (`celllat`'s certified spectral
bracket), and the Lean emitter for `Instances/FPlane11.lean` (hand-written is fine — 121 points, 12 neighbours). Every
`chi` record carries the colouring (verified) or the refusal (the solver's claim, so marked); every `reduce` record the
residues, the edge check and the pulled-back colouring.

## 8. Costs (desktop)

p ≤ 23: seconds to minutes. p = 83 at k = 5: minutes to hours (unknown; running at the compaction with a 40-minute wall).
p = 107, 131: hours or cube-and-conquer; the Hoffman bracket may settle them for free. The kernel instance: decides over
121 × 12 and 2,504 edges — seconds of kernel time, one build. Nothing here wants the server.

## 9. Addresses

`reference/Chat-analysis/{analysis.txt,VERIFICATION.md,fplane.py,usable.py,d11_five_colouring.txt}`; `tools/fplane.py`;
`data/fplane/{chi-p11,reduce-heule510-p11,reduce-W-core-8over3-p11,reduce-EI-seed-unit-p11}.json`; the certified 510:
`Proofs/HadwigerNelson/Instances/Heule510.lean`, `Heule510/{Table,Edges,Valid,Bound}.lean` (`heule510Table : PtTable`,
`heule510_unit_distances`, `heule510_bound_of_not_colorable`); the tower field and `PtTable`:
`Proofs/HadwigerNelson/Certificate.lean` and M02's field module; the Cayley-graph vocabulary: Mathlib has none (M56 §M1.8
grepped) — define the plane as `SimpleGraph.fromRel` on `ZMod p × ZMod p`; `tools/heule.py` (the 510's exact re-derivation);
`BIBLIOGRAPHY.md` [Vinh2005]; the background logs `build/m57/fplane-1923.log`, `build/m57/fplane-big.log`.

## §B. Decisions at minting

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| what the milestone delivers | the map of sealing primes + the field table + the kernel value at 11 | the general kernel theorem (D5) first | the table changes every later milestone's choice of field; D5 is a week for a statement whose specific instances the kernel already gets | high |
| the kernel route at 11 | the homomorphism from the certified Heule-510 by decide + the 121-point colouring by decide | an LRAT refutation of the 121-point plane at four colours | no new certificate machinery; the lower half is the 510's existing theorem | high |
| the big planes | Hoffman bracket first, SAT second, cube-and-conquer third | SAT only | a certified spectral bound may settle 131 at zero solver cost | medium |
| novelty | stated as provisional until Soifer 2024's number-field chapter is read | claimed | the bibliography rule; the M54 correction (Fischer) is the precedent | high |
| bearing on 6 | HIGH as a selection instrument; none as a construction | — | — | — |

## §H. Handoff for the session that opens M58 (written 2026-09-06 before Kooshi's compaction)

**Kooshi's decision:** M58 = this stub (FS-7, rank 1 of `plans/FRONTIER-STUBS.md`). Do NOT re-decide it. **Mined additions
(2026-09-06, after the first commit of this stub):** D3′ (the exact profile for K(√d), with the √35 correction), D7 and phase A′
(the shadow sieve, measured at 131 and 479), P7 — read them; they are part of the milestone.

**Read, in this order:** (1) `CLAUDE.md` § Frontier — the pivot paragraph (just above the ledger), ledger row 52, G43, and
§ Paths forward's pointer; (2) this stub §1–§B; (3) `reference/Chat-analysis/VERIFICATION.md` (what was verified and how;
what was not); (4) `reference/Chat-analysis/analysis.txt` (the web session's own argument — read it as a source, not as
this repository's claim: its ✓/~ bibliography marks are its own); (5) `tools/fplane.py`'s docstring and `self-test`;
(6) `Proofs/HadwigerNelson/Instances/Heule510.lean`'s module doc and the names in `Heule510/`.

**Then WORKFLOW step 3 onward, no shortcuts:** `git mv plans/STUB-field-sieve.md plans/M58-field-sieve.md` (keep the FS-7 row
in `FRONTIER-STUBS.md` with status "opened as M58"); write the subplan — D3 and D6 derived (the Hoffman bracket per p from
the plane's eigenvalues BEFORE any big SAT), the skeleton of `Instances/FPlane11.lean` (the graph, the colouring, the
residue map on `heule510Table`, the homomorphism statement, `sorry` at the leaves — it must elaborate), the `map`
subcommand's table shape; commit; the three modeling passes as FRESH Skill invocations (`debruijn-domain-modeling`, then
`debruijn-obligation-modeling`, then `debruijn-experience-modeling`), each committed before the next; then implement.
Register P1–P6 as they stand unless a derivation settles one first (say so in the subplan, as M56 and M57 did).

**First things to read from disk:** `build/m57/fplane-1923.log` (p = 17 at k = 5, then 19, 23) and `build/m57/fplane-big.log`
(83, 107, 131 at k = 5 with a 40-minute wall each) — if the processes died with the compaction or the logs are gone, re-run
`python3 tools/fplane.py chi --p P --k 5 --wall 2400` per p (one heavy job at a time). And the M55 108 targeted asks
(pid 839605, `build/m55/ask-depth2.log` → `data/m55/ask-W-plus-cross-depth2-k5.json`, exit 3 = jackpot; ~19 h at the
compaction): read its result if it exists, record it as an M55 §R6 addendum and an FS-3 datum (FS-3 is demoted: K(√247) is
5-sealed, so a hit there would be a virtual edge at five colours inside a 5-colourable plane — consistent, not a 6-event),
then move the untracked `data/m54/critical-W-plus-cross-depth2.json` into `data/m55` and commit.

**Standing rules that bit the last two milestones:** kill by PID (never `pkill -f` a pattern matching the shell; anchor
`^python3`); `build/` is gitignored — scripts go in `tools/`, records in `data/`; ALWAYS `./scripts/build.sh`; one heavy job
at a time; every "sealed" verdict names its prime and the record with the verified colouring; every "open" verdict names the
largest prime checked and is "open pending p" when a plane is undecided; `Chunk.pairs_at` filters to same-component pairs
(use `additive_rigid.unit_pairs` on edgeless stages); the M02 tower's √7 parts are identically zero on Heule-510.

---

## §S. Subplan (M58 opened 2026-09-06, on Kooshi's go after the compaction; WORKFLOW step 3)

*Written by the session that opened M58 from the handoff §H, after reading in the order it prescribes. Everything below
supersedes the stub's phases where it says so; the stub's §1–§B stay as the record of what was known at minting.*

### §S0. The state on disk at opening (read first, as §H said)

| item | what was found | done |
|---|---|---|
| `build/m57/fplane-1923.log` | p = 13: k = 4 UNSAT, k = 5 SAT (3.8 s); p = 17: k = 4 UNSAT (26 s), **k = 5 unfinished after 50 min** (17 ≡ 1 mod 4 is not usable; its plane is triangle-free — 3 is a non-residue mod 17 — which is why five colours are hard to refuse there) | the run KILLED by PID (moot: 17 is for the map only; the map runs the usable primes first) |
| `build/m57/fplane-big.log` | empty; p = 83 at k = 5 past its 2,400-s wall without returning | KILLED by PID; **D6 below settles 83, 107, 131 without a solver** |
| the M55 108 asks (pid 839605) | still running at 13.5 h (one cadical child at a time, 900-s wall each; 108 × 900 s ≤ 27 h); no result file yet | left running; its record is written at the close if it finishes (an M55 §R6 addendum + an FS-3 datum; then `data/m54/critical-W-plus-cross-depth2.json` moves to `data/m55`) |
| twelve orphaned `five_dial.py critical` forkserver workers (+ the resource tracker) from the M55 cross-only census stopped at 04:41 — their parent died with the `pkill` self-match, the workers survived 14 h at 1.7 % CPU each | — | KILLED by PID; ledger row written |
| `data/m54/critical-W-plus-cross-depth2.json` untracked | the input of the running asks | left in place until the asks finish (the process read it at start; moving it mid-run buys nothing) |

### §S1. D3 derived exactly — the profile of a 6-open field, and the theorem for fields containing K

**The usable primes of a field containing K = ℚ(√3, √11).** A usable prime for a multiquadratic field is p ≡ 3 (mod 4)
with every radicand a square or 0 mod p. For √3: 3 is a residue mod p iff p ≡ ±1 (mod 12), so with p ≡ 3 (mod 4) this is
p ≡ 11 (mod 12). For √11: (11/p) = −(p/11) for p ≡ 3 (mod 4) (reciprocity, both ≡ 3 mod 4), so 11 is a residue iff p is a
NON-residue mod 11, i.e. p ≡ 2, 6, 7, 8, 10 (mod 11). Hence the usable primes of every field containing K are a subset of
{p ≡ 11 (mod 12), p mod 11 ∈ {2, 6, 7, 8, 10}} = {11 (ramified), 83, 107, 131, 167, 227, 239, 263, 347, …} — **the only usable
prime below 67 for any field containing K is 11** (23 and 47 fail at 11: 23 ≡ 1, 47 ≡ 3 mod 11; 59 ≡ 4, 71 ≡ 5). Checked
against `fplane.py usable --rads 3,11` (11, 83, 107, 131, 167, 227, 239, 263, 347 below 350).

**With D6 (every plane at p ≥ 67 is ≥ 6-chromatic by Weil + Hoffman, and 59's by its exact spectrum):** for a multiquadratic
field F ⊇ K,

> **F is 6-open in this sieve ⟺ the 2-adic wall is broken (Theorem B) ∧ 11 is inert in F (some radicand is a
> quadratic non-residue mod 11).**

No finite plane needs to be solved for that equivalence: 11 seals at 5 (`chi-p11.json`), every other usable prime of such a
field is ≥ 83, and every plane at p ≥ 67 refuses five colours by the spectral bound. The stub's P4 ("11 is the last
5-sealing prime") was the wrong question for these fields; for the general map (fields without √3 or √11 — Haugland's,
ℚ(√7), ℚ(√5), ℚ(√2), ℚ) the candidate 5-sealing primes are exactly {3, 7, 11, 19, 23, 31, 43, 47}, and those are what SAT
must decide (phase A).

**The 2-adic wall over K, exactly (correcting the stub's D3′ once more).** The square classes of K(√d) are
{d, 3d, 11d, 33d} times squares; the wall breaks iff one of them is ODD and ≡ 7 (mod 8) (an even class never gives −1 in ℚ₂:
the classes of ℚ₂ are ⟨−1, 2, 5⟩ and −1 is the class 7 mod 8). For odd squarefree d: d ≡ 7 works (d itself); **d ≡ 5 works
too** (3d ≡ 15 ≡ 7); d ≡ 1, 3 never; even d never. So the candidate single radicals over K are the odd squarefree d ≡ 5 or 7
(mod 8) that are non-residues mod 11, up to the K-classes {d, 3d, 11d, 33d}: **7, 13, 29, 61, 79, 85, 95, 101, 109, 127, 149,
151, 167, 173, 197, …** (the stub listed only d ≡ 7 mod 8; 13 = 5 mod 8 with (13/11) = (2/11) = −1 is the smallest new one).
Their usable primes are all ≥ 83 by the paragraph above, so **every one of them is 6-open**, as are de Grey's field (usable
131, 479, …) and K(√7) (83, 131, …). Fields containing √5 (Heule's, K(√5), K(√5, √247)) or √247 (247 ≡ 5 mod 11) have 11 usable
and are sealed at 5; K and K(√35) stand at 4 (wall not broken).

### §S2. D6 derived — the spectrum of UD(𝔽_p, 2) is a Kloosterman sum, and Hoffman settles every plane at p ≥ 59

UD(𝔽_p, 2) is the Cayley graph of 𝔽_p² with connection set the circle S = {a² + b² = 1} (p + 1 points for p ≡ 3 mod 4), so its
adjacency eigenvalues are the characters summed over S: λ_m = Σ_{s ∈ S} e(⟨m, s⟩/p), one per m ∈ 𝔽_p², depending only on
Q(m) = m₁² + m₂² (the orthogonal group O(2, 𝔽_p) acts transitively on each nonzero-norm sphere and preserves S); λ_0 = p + 1.
**Identity (checked numerically to 10⁻⁹ at p = 11, 23, 59 — the maximum residual over all classes is 0.0):**

    λ(c) = −K(1, c/4)   where K(u, v) = Σ_{t ∈ 𝔽_p^×} e((u t + v/t)/p) is the Kloosterman sum,  c = Q(m) ≠ 0,

the classical formula for finite Euclidean graphs (Medrano–Myers–Stark–Terras 1996, second-hand; [Vinh2005] cites it).
Weil's bound |K(u, v)| ≤ 2√p then gives |λ(c)| ≤ 2√p for every c ≠ 0, and Hoffman's bound χ ≥ 1 + λ_max/(−λ_min) gives

    χ(UD(𝔽_p, 2)) ≥ 1 + (p + 1)/(2√p) > 5  ⟺  p + 1 > 8√p  ⟺  p ≥ 62,   so every usable p ≥ 67 refuses five colours,

with no computation beyond Weil. Below 67 the exact spectrum (one character sum per norm class, floats; the error is
≤ 10⁻¹² against margins ≥ 0.015) reads:

| p | degree | λ_min | −2√p | Hoffman | verdict |
|---|---|---|---|---|---|
| 3 | 4 | −2.000 | −3.46 | 3.000 | ≥ 3 (χ = 3 measured) |
| 7 | 8 | −4.494 | −5.29 | 2.780 | ≥ 3 (χ = 4 measured) |
| 11 | 12 | −4.796 | −6.63 | 3.502 | ≥ 4 (χ = 5 measured) |
| 19 | 20 | −7.610 | −8.72 | 3.628 | ≥ 4 (**≤ 5 measured 2026-09-06, k = 5 SAT in 18 s**; k = 4 pending) |
| 23 | 24 | −7.961 | −9.59 | 4.015 | ≥ 5 (k = 5 running) |
| 31 | 32 | −10.667 | −11.14 | 4.000 | ≥ 5 (SAT needed) |
| 43 | 44 | −11.962 | −13.12 | 4.678 | ≥ 5 (SAT needed) |
| 47 | 48 | −12.847 | −13.71 | 4.736 | ≥ 5 (SAT needed) |
| 59 | 60 | −14.918 | −15.36 | **5.022** | **≥ 6** by the exact spectrum (the Weil bound alone gives 4.9) |
| 67 | 68 | −15.057 | −16.37 | 5.516 | ≥ 6 |
| 71 | 72 | −14.173 | −16.85 | 6.080 | ≥ 7 |
| 79 | 80 | −17.102 | −17.78 | 5.678 | ≥ 6 |
| **83** | 84 | −17.709 | −18.22 | **5.743** | **≥ 6 — P2 met by derivation: K(√7)'s first usable prime does not seal it** |
| **107** | 108 | −19.050 | −20.69 | **6.669** | **≥ 7** |
| **131** | 132 | −21.108 | −22.89 | **7.253** | **≥ 8 — P3 met by derivation: de Grey's field's first usable prime does not seal it** |
| 479 | 480 | −42.451 | −43.77 | 12.307 | ≥ 13 |

So the big SAT runs the stub planned (83, 107, 131 at k = 5) are unnecessary and were killed; the solver's work is the map's
small planes only. The stub's "the Hoffman bracket may settle them for free" (§B) was right, and stronger than it guessed:
for p ≥ 67 it is a one-line consequence of Weil's bound, and for the fields we hold the whole field table is now a
derivation (§S1). The stub's "usable p ≥ 19 has χ ≥ 6" (P4) is REFUTED at p = 19 (a 5-colouring found and verified) — 19 is a
5-sealing prime, for fields that do not contain √3 (ℚ(√5), ℚ(√11), ℚ, …), all of which Fischer already bounds at ≤ 4.

**The shadow sieve gets the same instrument.** Cay(𝔽_p², D) for D ⊆ S symmetric has eigenvalues the DFT of D's indicator, and
Hoffman applies; measured at opening (`build/m58/shadow-spectral.log`, the scratch reproduction of the minting numbers):

| p | shadow of | |D| pairs | degree | λ_min | Hoffman | verdict |
|---|---|---|---|---|---|---|
| 131 | the 1581 | 55 | 110 | −27.750 | 4.964 | ≥ 5 only — **P7 stays a SAT question** |
| 131 | its gen-1 closure | 66 | 132 | −21.108 | 7.253 | the whole plane: ≥ 8 |
| 479 | the 1581 | 64 | 128 | −38.514 | 4.323 | ≥ 5 only |
| 479 | its gen-1 closure | 210 | 420 | −56.910 | 8.380 | ≥ 9 |

The 1581's own shadow sits right at the spectral bound's edge at both primes; whether five colours suffice on
Cay(𝔽₁₃₁², D₅₅) (17,161 vertices, 110-regular) is the one solver question of phase A′ with a bearing on 6.

### §S3. The kernel: what is stated, and the √7 decision

Two modules. **`Proofs/HadwigerNelson/FPlane.lean`** (general): the finite plane `fplane p := addCayley {v | v.1² + v.2² = 1}`
on `ZMod p × ZMod p` (Mathlib's `SimpleGraph.addCayley` at this pin — the M56 §M1.8 grep missed `Cayley.lean`), with a decidable
adjacency; the residue hom `Q4.resHom` for a root vector (r₃, r₅, r₇, r₁₁) with rᵢ² = dᵢ in `ZMod p`, built by the same
construction as `Adjoin.eval` with the target generalized from ℝ to any commutative ring (`Adjoin.evalHom`); and **the
reduction theorem**: a `Valid` certificate whose denominator is nonzero mod p reduces, through any ring hom φ : Q4 →+* ZMod p,
to a graph homomorphism `edgeGraph n c.edges →g fplane p`, hence `(fplane p).Colorable k → (edgeGraph n c.edges).Colorable k`
(`Colorable.of_hom`). The statement is D1 in the certificate's own vocabulary: the integrality step is the hypothesis
"φ(denom) ≠ 0", which for a certificate is a decidable fact, not a valuation argument. Instantiated at p = 131 with the full
root vector on Heule-510's table (all four radicands are residues mod 131), the theorem yields `χ(UD(𝔽₁₃₁, 2)) ≥ 5` in the
kernel for free — a spec example that the general theorem is used twice.

**`Proofs/HadwigerNelson/Instances/FPlane11.lean`** (the value): 7 is not a square mod 11, so no ring hom Q4 →+* ZMod 11 exists;
the decision is to define the reduction `Q4.res11` with √7 ↦ 0 and prove it multiplicative on the **√7-free** elements
(`Q4.SevenFree x := x.re.im = 0 ∧ x.im.im = 0` — the tower is `Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`, so the √7-part is
the inner `.im`), which the Heule table satisfies (a `decide` over its 510 points — the module doc of `Heule510.lean` says
so; the kernel now checks it). The alternative — a genuine hom into `Adjoin 7 (ZMod 11)` ≅ 𝔽₁₂₁ and a projection — was
weighed and rejected: it moves the same "√7-part is zero" fact one ring over without removing it. Then: the 5-colouring of
𝔽₁₁² as a 121-entry table (`data/fplane/chi-p11.json`), proper by `decide` over the 121 × 12 circle offsets;
`fplane11_not_colorable_four` from `heule510_not_colorable_four` through the homomorphism (comap); `chromaticNumber_fplane11
= 5`; and the two exact values the ledger states: `heule510_colorable_five` (the pulled-back colouring — the kernel's first
UPPER bound on a certified witness) hence `chromaticNumber_heule510 = 5`. Reds: a wrong root (4² = 5 ≠ 3 in ZMod 11) refuses
the root hypothesis; a corrupted colouring table refuses properness. **D5 — the field-level statement χ(ℚ(√3,√5,√11)²) ≤ 5 —
stays priced and deferred**: its content beyond the certificate form is that every finite unit-distance graph in the field
is presentable as a `Valid` tower certificate with 11 ∤ denom after translation (the integrality of unit vectors at the four
ramified primes above 11, plus the index of the order ℤ[√3,√5,√11] in O_F being a power of 2); several hundred lines, no
change to any consequence the hunt uses.

### §S4. The instrument (`tools/fplane.py`, extended)

| subcommand | what | record |
|---|---|---|
| `spectral --p P [--dirs FILE]` | the eigenvalues of UD(𝔽_p, 2) (or of the shadow Cay(𝔽_p², D)) by one character sum per norm class (or the full 2-D DFT), the Kloosterman identity as a self-check, λ_min, the Hoffman bound and its integer consequence, with the float error bound stated | `spectral-p<P>[-<stage>].json` |
| `chi --p P [--k K] [--wall S] [--pin-clique]` | as before; `--pin-clique` pins a maximal clique through the origin (ω = 3 at p ≡ 11 mod 12) to break the palette symmetry the two-vertex pin leaves | `chi-p<P>[-k<K>].json` |
| `shadow <stage> --p P [--k K]` | D7: the residues of the stage's unit directions (up to sign), |D|, the spectral bound of Cay(𝔽_p², D), and χ by SAT when asked | `shadow-<stage>-p<P>.json` |
| `map --fields …` | the field table: for each named field the radicands, the 2-adic wall (Theorem B's criterion, exact), the usable primes, the sealing prime if any with its record, the verdict `sealed at 4 / sealed at 5 (p, record) / 6-open (every usable prime ≥ 67, or its smallest usable prime's plane refuses five: record)` | `map.json` + a Markdown table |
| `self-test` | the 11 controls plus: the Kloosterman identity at 11 and 23 (residual < 10⁻⁶), Hoffman at 59 > 5, the planted shadow that is a single ± pair (2-chromatic), the wall criterion on the eight classes of G35 | — |

### §S5. Phases, re-shaped

| phase | what | cost | status at subplanning |
|---|---|---|---|
| 0 | D3, D6 (above); the logs read; the moot runs killed | done | done |
| A | the map: `chi` at k = 4/5 for p = 19, 23, 31, 43, 47 (the only undecided planes below 67 — 19's k = 4 and 23's k = 5 running); `spectral` records for every p ≡ 3 (mod 4) below 600 | hours (23/47 at k = 5 may need the clique pin or cubes) | 19 ≤ 5 measured; 23 running |
| A′ | the shadow sieve: `shadow --degrey --p 131` (D₅₅: spectral ≥ 5; χ by SAT at k = 5 — the milestone's one hard solve, cube-and-conquer over the origin's neighbours if monolithic caps), `--p 479`; the gen-1 closure at both (spectral only — it is the plane at 131); Heule-510 and W at 11 as controls (≥ 5) | hours to a day | spectral done |
| B | the field table (`map`) for K, K(√5), K(√7), K(√13), K(√35), K(√247), K(√5,√247), Heule's, de Grey's, K(√23), K(√79), K(√127), the E–I frame, ℚ(√3), ℚ(√11), ℚ(√7), ℚ(√5), ℚ(√2), ℚ | an hour | §S1 is the derivation; `map` records it |
| C | the kernel: `FPlane.lean`, `Instances/FPlane11.lean`, the spec at 131; `Proofs.lean`, `scripts/Axioms.lean` (an M58 block); `./scripts/build.sh` | a day | skeleton written at subplanning (elaborates, `sorry` at the leaves) |
| D | D5 priced (above), not done | — | — |
| E | close: gate; `data/fplane/README.md`; the Frontier (the field table into § Paths forward; ledger row; G43 amended with the spectral facts and the K-field theorem; G44 if the derivation earns a grokking); the frontier set re-ranked (FS-6 on de Grey's field AND K(√7) — both 6-open; FS-8; FS-2); T32–T34 answered; the M55 asks' record if finished | half a day | — |

### §S6. Registered predictions, re-registered where a derivation settled them (WORKFLOW: say so)

| # | as registered in the stub | status at subplanning |
|---|---|---|
| P1 | χ(UD(𝔽₁₇,2)) = 5; χ(UD(𝔽₁₉,2)) = χ(UD(𝔽₂₃,2)) = 6 | **19 REFUTED by measurement** (≤ 5, verified colouring); 17 undecided at k = 5 after 50 min (dropped: not usable, triangle-free); 23 open — re-registered: **χ(UD(𝔽₂₃,2)) = 6** (Hoffman 4.015, ω = 3), confidence medium-low |
| P2 | UD(𝔽₈₃,2) refuses five | **MET by derivation** (Hoffman 5.743 ⟹ χ ≥ 6); no solver |
| P3 | UD(𝔽₁₃₁,2) refuses five | **MET by derivation** (Hoffman 7.253 ⟹ χ ≥ 8) |
| P4 | 11 is the last 5-sealing prime | **REFUTED as stated** (19 seals at ≤ 5); re-registered in the form that matters: **for fields containing K the only 5-sealing usable prime is 11** — a theorem (§S1 + Weil), no prediction left; for the general map, re-registered: **{3, 7, 11, 19} ⊆ S₅ and 31, 43, 47 are NOT in S₅** (medium-low) |
| P5 | the field table | sharpened: sealed at 4 — K, K(√35); sealed at 5 — K(√5), K(√247), K(√5,√247), Heule's; **6-open — de Grey's, K(√7), K(√13), K(√79), K(√127), every odd squarefree d ≡ 5, 7 (mod 8) non-residue mod 11 over K** (a theorem now, not a prediction) |
| P6 | `FPlane11.lean` on the standard three axioms, no LRAT, two decides + one comap, < 200 lines | kept; amended: the general reduction theorem lands beside it, and the pulled-back colouring gives χ(Heule-510) = 5 exactly in the kernel (high) |
| P7 | the 1581's 55-direction shadow at 131 is 5-chromatic | kept at medium-low; the spectral bound (4.964) does not decide it; the k = 5 SAT on 17,161 vertices is the test |
| P8 (new) | `heule510Table` is √7-free at every one of its 510 points, decided in the kernel | high (the module doc says so; the kernel has never checked it) |

### §S7. Decisions at subplanning

| decision | choice | alternative | why | confidence |
|---|---|---|---|---|
| the big planes | settled by the spectral bound (Weil + Hoffman), recorded as `spectral` records with the derivation, NOT solved by SAT | run 83/107/131 at k = 5 to a solver verdict | a derivation with a stated error bound against a solver's untrusted UNSAT that did not return in 40 min; the derivation also covers every p ≥ 67 at once | high (the Kloosterman identity is classical and checked; the only float is a sum of p + 1 unit complex numbers) |
| the kernel's general theorem | over a ring hom Q4 →+* ZMod p and a `Valid` certificate with φ(denom) ≠ 0 | the specific 2,504-edge decide only | the general form is the same length, states D1 for every tower certificate, and is instantiated twice (131 with a genuine hom; 11 through the √7-free partial hom) | high |
| √7 at p = 11 | `SevenFree` predicate + partial multiplicativity of `res11` | a hom into `Adjoin 7 (ZMod 11)` and a projection | the same fact, fewer rings | medium — if the partial-hom lemmas exceed ~80 lines the 𝔽₁₂₁ route is tried |
| P4's form | a theorem for K-fields, SAT only for the map | keep the literal "11 is the last" | it was false (19), and the fields the hunt uses never see 19, 23, 47 | high |
| the field-level D5 | priced, deferred | attempt the integrality lemma | a week for a statement whose every consequence the certificate form already delivers | high |
