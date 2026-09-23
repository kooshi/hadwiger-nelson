# FS-73 census: the subgroup sandwich of each lattice, and how to check it

*Phase P1 of FS-73, the rigidity dichotomy (`plans/FS73-rigidity-dichotomy.md` §0 and §S.2, rows P1d, P1d′, P1e and P1f). Written
by implementer D, 2026-09-23, for a reviewer who trusts nothing in `tools/`. The desktop is an the desktop's processor (16 physical cores,
32 threads, 128 GB). Every group below is given by integer generators in the stated basis of its lattice file, so a reviewer can
re-derive it by hand or in PARI.*

## What a sandwich is

For a lattice Λ (a finitely generated group of plane vectors, here of rank 4 or 8) and a finite symmetric set U of unit vectors in
it, look at the proper four-colourings of the Cayley graph Cay(Λ, U), where two points are joined when they differ by an element of U.
Four subgroups of Λ are compared.

| group | what it is | how the census gets it |
|---|---|---|
| **F** | the **forced group**: every δ such that every proper four-colouring gives 0 and δ one colour | unknown in general |
| **P** | every δ such that every *periodic* proper four-colouring gives 0 and δ one colour | unknown in general |
| **F_known** | the span of the orbits of **certified** forced vectors | F_known ⊆ F, by the certificates |
| **P_found** | the intersection, over every periodic colouring the census exhibited, of its Kempe period group | P ⊆ P_found, by the colourings |

So F_known ⊆ F ⊆ P ⊆ P_found. The question the milestone asks, C3-inherit, is whether P = F. **F_known = P_found proves it for that
lattice.**

**The soundness split for generator graphs (G31).** When U is only a generating set S rather than every unit vector of Λ,
Cay(Λ, S) is a spanning subgraph of the full unit-distance graph on Λ.
- A forcing refusal on a generator-graph ball carries up to the full graph (forcing is monotone upward in the graph).
- A colouring, a period, a gap or an escape does not.

Every rich-lattice row below is labelled "generator graph" for this reason. Its sandwich is a sandwich for Cay(Λ, S) as its own
unit-distance Cayley graph.

## Headline: one sandwich per lattice

| lattice | graph | rank | Λ/F_known | Λ/P_found | P_found / F_known | periods searched | verdict |
|---|---|---|---|---|---|---|---|
| de Grey's lattice over K = ℚ(√3,√11) (`lattice-degrey.json`) | saturated: all 54 unit vectors | 4 | (ℤ/8)⁴, i.e. F_known = 8Λ | (ℤ/8)⁴, i.e. P_found = 8Λ | **0** | NΛ for N = 2, 4, 6, 8, 10, 12, 14, 16, 20, 22, 24, 32; N = 15 and 21 not colourable | **F = P = 8Λ: C3-inherit holds** |
| `twounits:14` over ℚ(√3,√5) (`lattice-tu14.json`) | **generators**: 212 | 8 | ℤ⁸ (F_known = 0) | ℤ/10² × ℤ/20² × ℤ/5460⁴ | ℤ⁸ | 2Λ, 4Λ; 2Λ ∩ W₁₁ for each of the four fixed primes above 11; W₁₁ alone; W₁₁ ∩ W₁₁′ for three pairs (not colourable); 6Λ gap-aimed only | **rigid-found at 4/3, 8/3, 4, 4/7, 4/√3; forcing undecided** |
| `twounits:30` (`lattice-tu30.json`) | **generators**: 660 | 8 | ℤ⁸ | ℤ/9690² × ℤ/222870² × ℤ/193896900⁴ | ℤ⁸ | the same eleven period groups | **rigid-found at the same five targets; forcing undecided** |
| `twounits:42` (`lattice-tu42.json`) | **generators**: 1,220 | 8 | ℤ⁸ | ℤ/310² × ℤ/7130² × ℤ/122331335100⁴ | ℤ⁸ | the same eleven period groups | **rigid-found at the same five targets; forcing undecided** |

**Every number in the table measures the colourings found at the periods searched** (G21). It never measures "all colourings".
"Rigid-found at δ" means δ ∈ P_found ∖ F_known: every exhibited periodic colouring keeps 0 and δ in one Kempe period class, and no
certificate says δ is forced.

## De Grey's lattice over K (phases P1d and P1d′)

**The lattice.** Λ is the ℤ-span of the 30 unit vectors ζ₆^m ρ^n (0 ≤ m < 6, |n| ≤ 2), with ρ = (5 + i√11)/6. That gives rank 4
and denominator M = 36. The basis H and the 54 unit vectors are in `lattice-degrey.json`, as integer 8-vectors over 36 on the basis
(1, √3, √11, √33) for x and then for y. U is **complete**: the checker re-enumerates it by an independent box search. Λ = (1/9)·O_E
for E = ℚ(√−3, √−11).

**F_known = 8Λ, certified.**
- The pair (0, v), with v = −(4/9)(1 + √−11), lattice coordinates (−16, 8, 8, 0), is forced at four colours. The certificate is a
  2,044-point graph plus the edge {0, v} that is not four-colourable, with an LRAT proof. It lives in `cert/t-16_8_8_0-R1.5/` and is
  checked by the frozen standalone `tools/fs73_cert_check.py`, which is not repeated here.
- The orbit of v under the ζ₆-rotation and complex conjugation has 12 elements, and its span is 8Λ.
- Harder's 8/3 (Polymath16, 2018) and 8/9 are corroborating solver refusals (the rows `force:96,-48,-48,-24:R1.5` and
  `force:32,-16,-16,-8:R1.5`), and both lie in 8Λ.
- **F_known used to be Harder's 8/3 alone** (rank 2), and the rows written before the certificate (K-rows.jsonl's first two sandwich
  rows, and every row of K-periods.jsonl) print P_found / F_known ≅ ℤ² × (ℤ/3)². That quotient is **superseded**: with the
  certificate it is 0. `K-sandwich.json` and the tool's `census_state` now take F_known from the certificate (`K_FORCED` in
  `tools/fs73_screen.py`).

**P_found = 8Λ, from 48 exhibited colourings** at the periods listed in the headline. Each one's period group and Kempe period group
are recomputed by the checker. The negative controls: 2 and 4 lie outside P_found, both separated by FS-70's period-2 seed colouring
(`colourings/degrey-N2-fs70seed-4dcc74d0b3b87b16.json.gz`).

**P1d′'s stabilisation series** (`K-periods.jsonl`):

| N | 16 | 14 | 15 | 20 | 21 | 22 | 24 | 32 |
|---|---|---|---|---|---|---|---|---|
| colourable | yes | yes | no | yes | no | yes | yes | yes |
| P_N (exact) | 8Λ | 2Λ | — | 4Λ | — | 2Λ | 8Λ | 8Λ |
| P_found after | 8Λ | 8Λ | — | 8Λ | — | 8Λ | 8Λ | 8Λ |

Given F = 8Λ, the plateau is a theorem: 8Λ = F ⊆ P ⊆ P_32 ⊆ P_8 = 8Λ. **So there is no counterexample at K, and C3-inherit holds at
de Grey's lattice**; P-C5 is decided. Every proper four-colouring of de Grey's lattice graph is 8Λ-periodic. The 380 pinned colourings
of Λ/8Λ, in 12 classes (`K-8Lambda-classes.json`), are all of them.

## The rich 2-unit lattices over ℚ(√3,√5) (phase P1e): generator graphs

**The lattices.** `twounits:D` (FS-70's `tools/fs70_fabric.py`) is the ℤ-span of every unit vector of ℚ(√3,√5)(i) that has
denominator at most D and is a unit at 2:

| D | generators | rank | M |
|---|---|---|---|
| 14 | 212 | 8 | 16,380 = 2²·3²·5·7·13 |
| 30 | 660 | 8 | 5.3·10¹⁰ |
| 42 | 1,220 | 8 | 2.5·10¹⁵ |

**Saturation, priced: unaffordable.** At D = 14, the trace-form enumeration would visit about 10^22.6 vectors (Gaussian heuristic),
and the box method about 10^15.7 candidates per coordinate. At D = 30 and D = 42 the trace figures are 10^63 and 10^92. So every row
is a **generator graph**. The price is in each lattice's `…|setup` row.

**P1e's first step, the gap-aimed finder at N = 5 and 7, has no instance.**
- On all three lattices, the real unit vector −1 lies in 3Λ, 5Λ, 7Λ, 9Λ and 13Λ, because 1/3, 1/5, 1/7, 1/9 and 1/13 are in Λ
  (exact; the lattice coordinates of each −1/N are in the record).
- So no 5Λ- or 7Λ-periodic colouring exists of any graph with the edge {0, 1}. This is the mechanism behind FS-70's "N = 3
  inadmissible".
- Measured for every prime p ≤ 41: **1/p ∈ Λ exactly when p is an odd prime dividing M.** Those primes are 3, 5, 7 and 13 for D = 14;
  D = 30 adds 17, 19, 23 and 29; D = 42 adds 31, 37 and 41. And 1/11 ∉ Λ on all three.
- Why: a unit vector is a unit at every conjugation-stable prime, so the odd primes in M are exactly odd primes with no
  conjugation-stable prime of E = ℚ(√3,√5)(i). At such primes G55's prime inversion puts 1/p in the ring ℤ[U]; here it is in the
  additive span itself. The prime 11 splits completely in ℚ(√3,√5) and each prime above it is inert in E, so 11 has stable primes.
- **P-C3(a) is therefore void, not lost.** Its informative outcome was unreachable when it was registered.

**The period groups asked instead** (each priced before it ran; `…|price:*` rows):

| period group W | classes | colourable at 4? | gap-aimed finder | P_W, exact (cold re-run agrees) |
|---|---|---|---|---|
| 2Λ | 256 | yes | UNSAT | 2Λ |
| 4Λ | 65,536 | yes | UNSAT | tu14: Λ/P₄ ≅ (ℤ/2)²×(ℤ/4)⁶; tu30 and tu42: (ℤ/2)⁴×(ℤ/4)⁴ |
| W₁₁ (one fixed prime above 11: target Γ₁₁) | 121 | no | UNSAT | — |
| 2Λ ∩ W₁₁, for each of the four fixed primes | 30,976 | yes | UNSAT | 2Λ: the 11-part adds no period |
| W₁₁ ∩ W₁₁′, for the three pairs of fixed primes | 14,641 | no | UNSAT | — |
| 6Λ | 1,679,616 | not asked (the plain ask) | UNSAT (25–36 s kissat; 190–244 million clauses; 3.6–4.2 GB) | not computed |

**No gapped colouring exists at any period group asked, 6Λ included.** This is exact for these period groups only. P-C3(b) predicted that the
depth-4 targets escape under some odd or composite period, and it **lost** at every composite period asked.

**Targets.** The targets are FS70-T1/T7's depth classes, as vectors: 4/3, 8/3, 4, 4/7 and 4/√3 (real points, the last (4√3/3, 0)),
and 2, 2/3 and i√3.
- 4/3, 8/3, 4, 4/7 and 4/√3 **lie in P_found** on all three lattices.
- 2, 2/3 and i√3 **lie outside** P_found on all three.
- This is FS70-T8's rigidity join, now in subgroup form and at full rank.

**Forcing asks, priced and not run.** A Minkowski ball here holds about 10^20 points, so balls are word balls.
- The union of the radius-2 word balls about 0 and about 4/3 on tu14 has 44,630 points and average degree 6.94. Its outermost
  shell is 99% of the points, with mean degree 4.97. The 8-core is empty (only the two pinned points survive).
- A forcing ask on it would measure the ball's shape, not the lattice (G65's second half), so it was not run.
- Radius 3 is about 3·10⁶ points and has not been priced.

## Informative instances (for the competition's brief, §C)

1. **twounits:14, generator graph: F_known = 0; P_found has rank 8 and contains 4/3, 8/3, 4, 4/7 and 4/√3; forcing undecided.**
   - This is the first census instance where H1 is found by colourings while no forcing is known. So it is informative, unlike K's
     8/3, where H1 was known only because the conclusion holds.
   - It is **about the generator graph**. The saturated lattice's periodic colourings are a subset of the generator graph's, so
     its P contains the generator graph's P (fewer colourings to intersect over), and its F contains the generator graph's F.
     Neither sandwich bounds the other's gap.
   - Consequence 3 of §0 applies to the generator graph: if its P has finite index, C3 there holds exactly when F has full rank.
2. twounits:30 and twounits:42 (as the headline states): the same picture.
3. De Grey's lattice over K is **closed**: F = P = 8Λ. It is no longer a counterexample candidate.

## How to check this directory

```
python3 tools/fs73_census_check.py --controls        # planted faults, each refused for its named reason; under a second
python3 tools/fs73_census_check.py --no-solver       # steps (0)-(iii): the sandwiches, no solver trusted
python3 tools/fs73_census_check.py --cert            # also runs tools/fs73_cert_check.py on v's certificate (about 21 s)
python3 tools/fs73_census_check.py                   # adds step (iv): every UNSAT claim of at most 100,000 classes re-asked on
                                                     # the checker's own encoding by kissat
```

`tools/fs73_census_check.py` uses the standard library only and imports nothing from `tools/`. It is frozen once committed. Its steps,
in order of marginal value:

| step | what it checks | what that establishes |
|---|---|---|
| (0) | Every u in U is a unit vector (exact arithmetic in the field) and lies in Λ; U = −U; span(U) = Λ. For de Grey's lattice, U is re-enumerated by an independent box search. | The graph is the one stated |
| (i) | Every analysed colouring: its W has finite index and contains no u; its class map is a bijection; its stated periods are periods; its stated period group is exact; it is proper | P ⊆ each Per(c) |
| (ii) | Every Kempe period group is recomputed from the colouring alone, and P_found is recomputed as their intersection and compared with the stated one | P ⊆ P_found |
| (iii) | F_known is re-derived from the certificate witness's pair difference (at K) | F_known ⊆ F, given the certificate |
| (iv) | Last, and the only step that trusts a solver: the UNSATs behind "P_N exact" | the exactness of each P_N. The sandwich does not use it |

The controls (`--controls`) plant seven faults, and each is refused for its own reason:
- an improper colouring (a whole period coset recoloured) is refused as IMPROPER;
- a false period, as PERIOD_FALSE;
- a hidden period, as PER_NOT_EXACT;
- a wrong Kempe period group, as KPER_MISMATCH;
- a moved unit vector, as NOT_UNIT;
- a doubled F_known, as F_KNOWN_MISMATCH;
- the faithful twin passes.

**Files.**
- `lattice-*.json`: the lattices.
- `K-rows.jsonl`, `K-periods.jsonl`, `rich-rows.jsonl`: every verdict, one row each. They are rendered one line per row in `ROWS.md`
  by `python3 tools/fs73_screen.py rows-table`.
- `K-sandwich.json`: the K sandwich.
- `colourings/*.json.gz`: every analysed colouring. The class index is the big-endian mixed radix of (x C) mod d. C = I and d = N
  when W = NΛ; otherwise the file carries `smith_C`, `smith_Cinv` and `smith_d`, which the checker verifies against W.
- `cert/`: v's certificate.

**Regenerate.**
```
python3 tools/fs73_screen.py census K --resume       # P1d (every ask cached by key; rewrites K-sandwich.json)
python3 tools/fs73_screen.py periods K --resume      # P1d'
python3 tools/fs73_screen.py census RICH             # P1e stage 1 (resumes; a key present is never re-asked)
python3 tools/fs73_screen.py census RICH --six       # P1e stage 2: the 6 Lambda gap asks, heavy, under the shared lock
python3 tools/fs73_screen.py export                  # the lattice files, the FS-70 seed colourings, the Smith data
python3 tools/fs73_screen.py rows-table              # ROWS.md
```
