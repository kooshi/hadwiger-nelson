# FS-73 phase P2b — ℚ(√167)'s lattice `L3e1c94c6`: a denser ball, or a colouring with no short period

*Implementer C (Opus 5.5), 2026-09-23, desktop (16 physical cores / 32 threads, 128 GB). Brief: the PO's
message of 2026-09-23 (FS-73, after phase P2's table). Tools: `tools/fs73_q167.py` (the driver) and `tools/fs73_q167_check.py`
(the standalone checker: standard library only, imports nothing from `tools/`). Data: `data/fs73/q167/`.*

## Headline

- **Neither (A) nor aperiodic (B). `L3e1c94c6` has a gapped periodic 3-colouring of period 23.** It is a residue colouring at
  𝔭 = (23, √167 − 11), the field's first usable prime, restricted to the part of the residue circle the lattice reaches:
  - the lattice's 36 unit vectors reduce to only **12 of the 24** points of the circle mod 𝔭;
  - the linear form ψ(X, Y) = 14X + 9Y sends all 12 into [8, 15];
  - so c(x) = ⌊3·ψ(red x)/23⌋ is a proper 3-colouring.

  **Phase P2's search stopped at N = 20; the least period is 23.** P2's "no periodic colouring" measured the periods it searched
  (G21). The colouring has a fan gap at the origin, so by row 66 **every pair is free at three colours (F = 0)**, and **every ball
  of this lattice three-colours, by theorem.** The standalone checker says CERTIFIED and refuses nine planted faults, each for its
  named reason. The PO checked the argument independently and accepted the certificate.
- **The same mechanism explains FS-61's whole null at 167.**
  - **52 of FS-61's 57 lattices** at 167 carry a certified, gapped, periodic 3-colouring: 51 by a residue target at one prime
    (23, 29, 43, 59, 67, 79 or the ramified 167), and one by a linear form mod 24.
  - **3 more are 3-integral**, so the kernel's 3-adic barrier (row 72) colours them.
  - **Only 2 survive every screen: `Ld14c588b` (44 unit vectors) and `L21cc6506` (60)**, P2's other two lattices. A degree-18 ball
    of either costs 4–5·10⁸ points (about 10¹⁰ clauses), far past the stop rule.
- **A design rule for FS-59, at 23.** The residue sets at 23 that allow a 3-colouring are classified exactly (224 orbits).
  - The smallest refusing set is **a coset of the sixth roots of unity**: 3 antipodal pairs, a hexagon.
  - **Every colourable set has a gapped colouring**, so a lattice whose residues at either prime above 23 miss every refusing set
    is **loose by theorem**, not merely colourable.
  - At 43 the smallest refusing sets have 5 pairs, and every colourable set up to 6 pairs is gapped.
- **The dense ball was not asked.** A verified theorem answers it. The PO agreed on 2026-09-23. The price is recorded below.

## Theorems this phase proved

*(Grades per `CLAUDE.md` § Notation.)*

1. **[cert — `tools/fs73_q167_check.py`, CERTIFIED; nine planted faults refused by name, the faithful twin passes] `Cay(L3e1c94c6, U)` has a gapped periodic proper
   3-colouring.**
   - *The lattice:* Λ = (1/120)·ℤ⟨(1,1,1,3), (0,2,0,2), (0,0,2,2), (0,0,0,4)⟩, where (a, b, c, e) ↦ ((a + b√167)/120,
     (c + e√167)/120). U is its 36 unit vectors, which are **all** 36 unit vectors of ℚ(√167)² with denominator dividing 120.
   - *The colouring:* c(x) = ⌊3·ψ(red x)/23⌋, with red the reduction mod (23, √167 − 11) and ψ(X, Y) = 14X + 9Y. ψ(red u) takes
     the values {8, 9, 11, 12, 14, 15} over U.
   - *Periodicity:* the kernel of ψ∘red has index 23 and contains 23Λ. In the reduced basis the colouring is the circular form
     φ = (0, 2, 11, 1)/23.
   - *The gap:* every neighbour of the origin has colour 1, so colour 2 is missing from its closed neighbourhood.
   - *Consequence:* F = 0 at three colours (row 66, colour-generic), and every finite ball is 3-colourable.
   - *Where:* `data/fs73/q167/witness-L3e1c94c6-p23.json`.
   - *Completeness of U is proved by the checker itself.* It enumerates every integer solution of a² + 167b² + c² + 167e² = 120²
     with ab + ce = 0, twice, by two loops over different variable pairs, and requires the two sets to be equal. A planted
     enumerator that drops one vector is caught (`UNIT_ENUMERATION_DISAGREES`). The ℤ-span of U must equal H in Hermite normal
     form, and |U| = 36.
2. **[tools, exact] The least period of a circular 3-colouring of `L3e1c94c6` is 23.** Every φ ∈ (1/N)ℤ⁴ with 3(φ·u mod 1) ∈ [1, 2]
   for every u was enumerated.
   - Solutions exist at N = 23 (8 forms), 36 (4), 46 (12) and 47 (8).
   - There are none at any other N ≤ 60, and in particular none at N ≤ 20, which agrees with P2's refusals.
   - *Where:* `circular.jsonl`. The full quotient Λ/23Λ (279,841 classes), asked through P2's own code, is SAT in 3.9 s, which is
     the positive control (`quotients.jsonl`).
3. **[cert: 52 witnesses, standalone checker] 52 of FS-61's 57 lattices at 167 are 3-colourable, with a gap, periodically.**
   - The census (`census.jsonl`) asked the residue target Cay(𝔽_q², U mod 𝔭) at every prime 𝔭 | q with q ∈ {23, 43, 59, 67, 71,
     79, 83}. 46 lattices are coloured, gapped every time. By least colouring prime: 23 at 23, 3 at 43, 15 at 59, 3 at 67, 2 at 79.
   - The extended screen (`extend.jsonl`) covered every prime ≤ 300 with residue field 𝔽_q, including q ≡ 1 (mod 4) and the ramified
     167, plus circular forms with N ≤ 60. It colours 6 of the census's 8 non-3-integral survivors:
     - `L48438d86`: at 167, and circularly at N = 23 through the joint quotient. Neither prime above 23 colours it alone.
     - `L977c2e3e`: at 167 and 233; circularly at N = 25.
     - `Laef50b1a`: only circularly, at N = 24.
     - `L20f3b99d`: at 167.
     - `L9c2627ce`: at 167; circularly at N = 46.
     - `L06c3a821`: at 29, 167 and 293; circularly at N = 9.
   - Every colouring is re-proved by the standalone checker from a witness in `data/fs73/q167/witnesses/`: a residue colouring as an
     explicit table of 𝔽_q² (checked edge by edge on the Cayley graph, with the reduction proved onto), or the form mod 24 on the
     Hermite rows.
   - The **3 unclaimed 3-integral** lattices are coloured by the kernel's 3-adic barrier (row 72).
   - **Not coloured by anything: `Ld14c588b` and `L21cc6506`.** This is a typed null: no residue target at q ≤ 300, no circular form
     at N ≤ 60, and the full quotients at the N recorded in `quotients.jsonl`.
4. **[tools, exact; refusals replicated] The residue-set classification at 23.** Symmetric subsets of the 24-point circle mod 23 (a
   cyclic group; 12 antipodal pairs) were asked up to rotation and reflection: 224 orbits.
   - **98 colourable, 126 refusing**, and the verdict is monotone under adding pairs (0 violations).
   - **Every colourable orbit has a gapped colouring.**
   - Every refusal was re-asked by Glucose 4 with no pins and no symmetry break: 0 disagreements.
   - **Minimal refusing sets (7 orbits):** {0, 4, 8}, a coset of μ₆, the hexagon, where 3 is a square mod 23; {0,1,2,3,4};
     {0,1,4,6,9}; {0,2,4,6,9}; {0,1,2,4,5,10}; {0,1,3,5,8,10}; {0,1,3,6,7,9}. Here pair k = {g^k, g^(k+12)} with g = (4, 10).
   - **The largest colourable set has 8 pairs:** {0,1,2,3,5,6,7,8}.
   - *Where:* `classify-23.jsonl`.
5. **[tools, exact; refusals replicated] The classification at 43, up to 6 pairs** (22 pairs; 2,651 orbits).
   - The smallest refusing sets have **5 pairs** (23 orbits). There are no triangles at 43, where 3 is a non-square.
   - 631 orbits refuse and 2,020 colour. Every colourable orbit has a gapped colouring; Glucose disagreements 0.
   - The "maximal colourable" list is not computed on a size-capped run.
   - *Where:* `classify-43.jsonl`.
6. **[tools] FS-61's colouring of the degree-14 ball is a noisy circular colouring, not a residue colouring with boundary damage.**
   - The rebuild is exact: 1,474,541 points, 10,324,022 edges, sha256 `ea65e4e3…` as recorded, proper.
   - The 4-D Fourier transform of ω^c has one dominant character: amplitude 0.74 at θ ≈ (−0.086, 0, 0.047, 1/2) in the reduced basis.
   - The best circular fit is φ = (4, 0, 44, 23)/46, the 23-form shifted by half a period on one coordinate. It agrees on 86.37 % of
     points.
   - Defects are uniform: 13–15 % at every radius band and every degree band.
   - *Where:* `fourier.jsonl`, `agree.jsonl`.
7. **[tools, exact on U_M; G65 prices] The denominator sweep, M ≤ 420.** U_M is every unit vector over M. The sweep asks which
   U_M are rank 4, contain a 3-pole, and have residue sets that refuse at **both** primes above 23 **and both** above 43.
   - Answer: M = 96, 108, 144, 192, 216, 231, 261, 264, 288, 312, 324, 348, 363, 384, 396, 420.
   - Their G65 prices at degree 14 run from **3.4·10⁷ points** (M = 144) upward. M = 108, 231 and 363 hold 12 unit vectors and
     never reach degree 14.
   - A refusing residue set is a fact about ℤ⟨U_M⟩; a colourable one is a fact about U_M only.
   - *Where:* `cover.jsonl`.
8. **[hand, one line; Theorem A's residue map] The lattice-level residue lemma.** Let Λ be generated by unit vectors, with
   denominators prime to q, and let 𝔭 be a prime of F with residue field 𝔽_q. Then any (gapped) k-colouring of Cay(𝔽_q², U mod 𝔭)
   pulls back to a (gapped) periodic k-colouring of Cay(Λ, U), provided red(Λ) is onto for the gap.
   - The target is the *sub-circle the lattice reaches*, not the whole circle. At 23 the whole circle is Γ₂₃, which refuses five
     colours; the sub-circle of `L3e1c94c6`'s units is 3-colourable.
   - This is P2's fixed-prime gap lemma, with the circle replaced by the image of U.

## Predictions scored

| id | prediction (registered `3807b9f5`, before any solver or stored colouring) | outcome |
|---|---|---|
| P-C1 (0.75) | (B): the dense ball three-colours | **won, by theorem.** The ball was not asked, because a certified periodic colouring colours every ball. The rationale ("the quotient refusals are what a local artefact of reduction mod N looks like") was half right: N ≤ 20 simply has no colouring, and the true period is 23 |
| P-C1b (0.55) | if (B), there is a periodic colouring at a longer period, circular with rational φ | **won exactly.** The least period is 23, a circular form, and it is Theorem A's residue map at the field's first usable prime |

## Asks: price and verdict

| ask | price (G65, g = 36, covolume 5.154·10⁻⁵) | verdict |
|---|---|---|
| `L3e1c94c6`, degree 18 | R = 2.154, 4.12 M points, 37.1 M edges, 115 M clauses; memory about 3 GB (kissat) to 8 GB (cadical), by a model, not measured | **not asked**: every ball three-colours, by theorem 1. The PO agreed |
| `L3e1c94c6`, degree 20 | R = 2.483, 7.28 M points, 226 M clauses, about 5–16 GB (model) | not asked (same reason) |
| `Ld14c588b`, degree 18 | R = 1.742, 5.0·10⁸ points, 1.4·10¹⁰ clauses | **over the stop rule**; not asked |
| `L21cc6506`, degree 18 | R = 1.376, 4.1·10⁸ points, 1.15·10¹⁰ clauses | **over the stop rule**; not asked |
| full quotients Λ/NΛ, N = 23–30, `L3e1c94c6`, `Ld14c588b`, `L21cc6506` | 279,841–810,000 classes; seconds each | see `quotients.jsonl` (the section below) |

Solver time spent: under 0.3 core-hours in total (census about 2 min; extended screen about 15 min; classifications about 4 min;
quotients about 10 min).

## Decisions (four parts)

| choice | alternative | why this one won | confidence |
|---|---|---|---|
| Not asking the degree-18 ball | ask it anyway, at 3–8 GB (priced) | the certified periodic colouring answers it: an ask would measure nothing (G1's rule: never run a null a theorem predicts). The PO agreed | high |
| Read FS-61's stored colouring first, with a Fourier transform | a pairwise P_same(δ) sweep over hand-picked δ | one 4-D FFT (2.5 s) names the dominant character over every δ at once; its θ led straight to the circular search | high |
| A new standalone checker (`tools/fs73_q167_check.py`) | FS-58's frozen `fs58_check_witness.py` | FS-58's checks a *refusal* (a graph plus an LRAT); a colourability claim needs completeness of U, a colouring rule and a gap instead | high |
| Single-prime residue targets (q² vertices) plus the exact circular search as the screens | P2's full quotient Λ/NΛ at every N (N⁴ classes) | 529 against 279,841 vertices at 23, and the circular search also covers linear forms through the joint quotient (it found `L48438d86`'s). The full quotient is still run on the two survivors, where the cheap screens are exhausted | medium: a lattice uncoloured by all of these may have a non-linear periodic colouring at a composite N |
| Certify every census colouring by a witness | leave the census at [tools] | 52 witnesses, each checked in under a second; it turns "FS-61's null is explained" from a solver claim into a checked one | high |

## Defects found in this phase's own work (G21: each silent or flattering until caught)

1. **The checker's first corroboration was vacuous.** A coordinate box in the Hermite basis held 28,561 points and **0 edges**,
   because unit vectors have large Hermite coordinates, so it could not have failed. It now uses the word ball of radius 3 (8,353
   points, 23,364 edges), refuses when there are no edges, and has a control showing it can fire.
2. **The wrong-root control used 12 ≡ −11 (mod 23)**, the other genuine square root, so CERTIFIED was the correct verdict. It now
   uses a non-square.
3. **The sublattice control planted a lattice that is itself unit-generated** (30 unit vectors). UNIT_COUNT fired, correctly. The
   control now plants a superlattice, and the checker requires H in canonical form (with a control).
4. **A capped classification printed a meaningless "maximal colourable" list**: every size-6 set whose supersets were never asked.
   It is now recorded only on an uncapped run.
5. **The denominator sweep reported rank −1 for every M.** `reduce_pool` needs tuples; the rank is now computed directly. The sweep
   also wrote its candidate flag after the record. Both are fixed, and the sweep was re-run.
6. **A framing error of my own: a residue target refusing is not the lattice refusing.** Rational U_M refuse at 23, yet rational
   lattices are bipartite. The screens are one-sided: a colourable target colours the lattice, and a refusing one says nothing.
   The design rule below is stated that way.
7. **A self-deadlock.** P2's quotient ask takes the shared lock itself, and my outer `flock` already held it. The job slept holding
   two descriptors on the lock. It was killed by process group, verified by effect, and relaunched without the outer lock. The
   forfeit was about 2 minutes.
8. **The extended screen's first run looked hung** because its output went through `| tail`. It was killed after 4 minutes, with one
   lattice's record already written; the rerun resumed from it.

## The residue-set rule for FS-59 (a design rule, not a theorem about the field)

A lattice Λ over ℚ(√167) can refuse three colours, or even carry a forced pair, only if **every** screen fails to colour it:
- **(i)** some unit vector has a 3-pole (row 72);
- **(ii)** at each prime 𝔭 of F with residue field 𝔽_q and q ∤ M, the unit vectors' residue set refuses 3 colours. The primes are
  23, 29, 43, 59, 61, 67, 71, 79, 83, … and the ramified (√167);
- **(iii)** no circular form colours it at any N;
- **(iv)** no quotient Λ/NΛ colours it.

At 23, (ii) means the residues at **both** primes above 23 contain one of the seven minimal refusing sets. The cheapest is three
unit vectors whose residues form a hexagon z·μ₆: an equilateral triangle mod 𝔭, which exists because 3 is a square mod 23, while F
itself has no √3. At 43 it takes at least 5 antipodal pairs. **Failing (ii) at 23 or 43 is looseness, not just colourability:**
every colourable residue set there has a gap.

**What the rule says about FS-61's lattices:**
- 36 unit vectors are not "supply" if they reduce to half a circle, as `L3e1c94c6`'s do.
- Of the 57 lattices, only the two richest pass every screen, and both are priced beyond any ask.
- The cheapest lattice at M ≤ 420 that passes the screens at 23 and at 43 costs 3.4·10⁷ points at degree 14.

This is G69's three-colour instance at 167: **supply is what covers the residue circles**, and every periodic colouring found here is
a residue colouring prime by prime, or a linear form through a joint quotient.

## Proposed edits (for the PO; not made)

- **P2's table** (`data/fs73/table/TABLE.md`, `rows.jsonl`): the ℚ(√167) rows' "REFUSING at every N ≤ 12 searched (C3-aper case)"
  should read, for `L3e1c94c6`, "loose by theorem: a gapped residue colouring at 23 (N = 23)". The informative-instance paragraph of
  `phase-P2.md` should say that the C3-aper candidate dissolved at N = 23. For `Ld14c588b` and `L21cc6506` the label stands, now
  with the typed null of theorem 3.
- **FS-59's stub:** R5's "167's 3-non-integral lattices hold too few unit vectors" has a mechanism. Too few means too few *residues*
  at 23, 43 and 59. The rule above should head R2 (the lattice search beyond denominator 2520): screen U_M's residue sets before
  pricing any ball.
- **A method line (for G21 or G65):** Fourier-transform a solver's colouring of a large ball before searching periods. A dominant
  character names the period, here 23, three periods past where the search stopped.

## Regenerate

```
python3 tools/fs73_q167.py selftest
python3 tools/fs73_q167.py rebuild14 ; python3 tools/fs73_q167.py fourier ; python3 tools/fs73_q167.py agree
python3 tools/fs73_q167.py circular --nmax 60
python3 tools/fs73_q167.py residue
python3 tools/fs73_q167.py census --qs 23,43,59,67,71,79,83     # resumes: a key present is skipped
python3 tools/fs73_q167.py extend --qmax 300 --nmax 60          # resumes
python3 tools/fs73_q167.py classify --q 23 ; python3 tools/fs73_q167.py classify --q 43 --maxsize 6
python3 tools/fs73_q167.py cover --mmax 420                    # resumes
python3 tools/fs73_q167.py quotients --ids L3e1c94c6,Ld14c588b,L21cc6506 --nmin 23 --nmax 30   # P2's ask; takes the lock itself
python3 tools/fs73_q167.py witnesses
python3 tools/fs73_q167_check.py data/fs73/q167/witness-L3e1c94c6-p23.json --controls
python3 tools/fs73_q167_check.py data/fs73/q167/witnesses/<id>.json [--controls]
python3 tools/fs73_q167.py price
```
