# data/fs58/search-167 — FS-58 phase B5: the search over ℚ(√167) (not landed)

Tool: `tools/fs58_search.py` (untrusted; exact edges; solver verdicts are claims, SAT models verified on every edge). Method and
calibration: `data/fs58/search-23/README.md`, whose route landed over ℚ(√23) (`data/fs58/witness-23/`). This directory records what the
same instruments measured over ℚ(√167). **Nothing here refuses three colours; χ(ℚ(√167)²) ≥ 4 is not landed.**

## What was measured

| record | what | result |
|---|---|---|
| `classes-180.out` | orbit classes of unit vectors of ℚ(√167)(i) to least denominator 180 | 43 classes, only 16 non-rational (24, 28, 84, 88, 96, 108, 116, 120, 124, 128, 132, 140, 144.1, 144.2, 168, 171); 355 classes to 1260 |
| `survey.jsonl` | 2,580 unions (bases ∅, axis, axis + (3/5, 4/5), with every single and pair of non-rational classes to 300 and triple to 180): covolume, reduced coordinates, bipartite, forms mod 3, least odd cycle | 106 bipartite; the only pools with a 7-cycle are built on class 140 (the prelude's run-plus-diamonds), and the coarsest (`q1+140`, `q1+28+140`, covolume 7·10⁻⁴) are 3-integral, hence 3-colourable by D1 |
| `saturate.jsonl` | lattices spanned by the axis and one or two classes (lcm ≤ 420), with every unit vector of that denominator they hold | no 3-non-integral lattice with an odd cycle of length ≤ 7 and covolume ≥ 10⁻⁵; to denominator 2520 (`tools/fs58_sat_classes.py 167 2520 1e-5` → `saturate-2520.out`: every 3-non-integral class, with the axis, the (3/5, 4/5) family when 5 divides its denominator and the (5/13, 12/13) family when 13 does, saturated) the 38 distinct lattices of covolume ≥ 10⁻⁵ (39 lines; one listed twice) show **no odd cycle within the breadth-first cap** (20,000 points: length ≤ 7 for the two with 28 and 36 directions, ≤ 9 for the six with 20, ≤ 15 for the 23 with 12), and seven are bipartite |
| `colour-scan.jsonl` | is the ball of physical radius R about the origin 3-colourable? | `q1+q5+24+120` — the one 36-direction analog of ℚ(√23)'s hit (axis, (3/5, 4/5), class 24, class 120; covolume 5.15·10⁻⁵; no odd cycle of length ≤ 9): 3-colourable at R = 1.3 (547,461 points, 99 s) and 1.5 (970,453, 2.4 s); `q1+q13+24` (276,809) and `q1+q17+24` (473,373) 3-colourable at 1.5; see the hand-off for R = 1.8 and the remaining pools |

## Why ℚ(√167) is harder at this height (readings, each with its test)

* **The coarse lattices lack short odd cycles.** Every hit so far (ℚ(√23), ℚ(√47), ℚ(√71), ℚ(√191)) came from a 3-non-integral saturated
  lattice with an odd cycle of length ≤ 9 and covolume ≥ 10⁻⁴; ℚ(√167) has no such lattice to denominator 2520 (no odd cycle within the cap in any 3-non-integral saturated lattice of covolume ≥ 10⁻⁵). *Test:* a ℚ(√167) lattice
  of covolume ≥ 10⁻⁵ with a 7-cycle and a 3-non-integral class, found at larger denominators, probed at R = 1.5.
* **Enlarging kills the covolume.** Adding any one further class (28, 84, 96, 108, 132, 140, 144.1, 168) to `q1+q5+24+120` drops the
  covolume to 2·10⁻⁸–4·10⁻⁹, i.e. 10⁹–10¹⁰ points in a ball of radius 1.5.
* The 2-adic obstruction recorded for ℚ(√23) (no diamond chord of odd rational parity when d ≡ 7 mod 8) holds for 167 as well.
