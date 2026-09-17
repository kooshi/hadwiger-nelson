# data/fs58/witness-47 — FS-58 phase B5 (side result): a 169-point witness that the plane over ℚ(√47) needs four colours

Found while calibrating phase B5's search instruments for ℚ(√23) and ℚ(√167) (`data/fs58/search-23/README.md`). ℚ(√47) is not one of
B5's two targets; it is one of G55's named quadratic predictions ("four or five for ℚ(√47)"). Generator: `tools/fs58_search.py
direct-witness` (untrusted). Checker: `tools/fs58_check_witness.py --radicand 47` (standard library only; imports nothing from
`tools/`; the same checker that certifies `witness-11`, generalised by one flag, its ℚ(√11) outputs byte-identical). Regenerate with
`bash data/fs58/witness-47/run-all.sh` (about ten seconds; the rebuild is byte-identical, checked).

## The claim, and who checks what

**`witness.json` lists 169 points of ℚ(√47)² whose unit-distance graph (385 edges) has no proper 3-colouring, so χ(ℚ(√47)²) ≥ 4.**
A point is `(a, b, c, e, m)`, `m > 0`, `gcd = 1`, meaning `((a + b√47)/m, (c + e√47)/m)`. The checker's five steps are exactly those
listed in `data/fs58/witness-11/README.md` with 11 replaced by 47 (the edge test uses only that √47 is irrational; `--radicand`
refuses a perfect square).

| trust level | what | record |
|---|---|---|
| **certified** (exact integer arithmetic + an LRAT check that is not the solver) | no 3-colouring of the 169-point graph | `certified.out` (`CERTIFIED`, 5,054 additions, empty clause at id 6380) |
| planted faults | twelve faults refused for their named reasons, the faithful twin certified, all-pairs edge test = bucketed = file (385) | `controls.out` (`CONTROLS ALL PASS`); plus: the same files under `--radicand 11` and `--radicand 23` refused `EDGE_NOT_UNIT`, `--radicand 16` refused `RADICAND` |
| decorrelated recheck (reviewer-style, shares no code with generator or checker) | all 14,196 pairs in `fractions.Fraction` arithmetic give exactly the file's 385 edges; Lingeling, CaDiCaL 1.5.3 and MapleChrono refuse three colours (with the generator's CaDiCaL 2.1.2, Glucose4 and Minisat22: six refusals from Lingeling, two CaDiCaL versions and three MiniSat descendants) | this README |
| solver claim | 1-minimality: deleting any of 12 sampled vertices leaves a 3-colourable graph (models verified) | `generate.out` |

The graph has no triangle (√3 ∉ ℚ(√47)); 358 of its 385 edges have 3 in their direction's denominator (12 or 60), as D1 requires of
any four-chromatic graph over a field with `d ≡ 2 (mod 3)`.

## How it was built — no forced pair and no chain

The pool is `q1+12+60`: the axis (4), the orbit of `((5 + √47)/12, (5 − √47)/12)` (8) and the orbit of `((35 + √47)/60, (5 − 7√47)/60)`
(16) — 28 unit vectors, **all 3-non-integral except the axis**, generating a lattice `Λ = ℤ[W]` of covolume 0.0058 in the Minkowski
embedding whose reduced coordinates are at most 5, with least odd cycle 7 and no linear form mod 3 nonzero on every generator (so no
affine 3-colouring). The class-12 vectors already lie in `ℤ[axis ∪ class 60]`: the lattice spanned by the axis and class 60 holds
every unit vector of denominator dividing 60 that the pool uses (`tools/fs58_search.py saturate`, `data/fs58/search-47/saturate.jsonl`).
The lattice points within physical radius 1.5 of the origin in both real embeddings — 8,629 points, 41,144 edges — refuse three colours
(CaDiCaL, 0.01 s). At radius 1.2 (3,565 points) the local meter reads 64 of 76 near pairs forced equal and 65 forced different with
12 unknown and the colourability ask itself unknown at a 5 s wall — the signature of a piece at or past refusal; at 1.0 (1,733 points)
it reads none (`data/fs58/search-47/rigidity.jsonl`). A Glucose4 core-guided deletion keeps 169 points; translating an axis edge to
`(0, 0) → (1, 0)` gives the witness, and every unit distance among the 169 points is re-derived exactly: 385 edges, all in 14 of the
pool's direction pairs.

**Why this matters for FS-58.** Over ℚ(√11) the route needed a forced pair at `3u` in a 3-integral piece and a four-copy chain, because
3-integral graphs are 3-colourable (D1). A pool whose directions are 3-non-integral from the start has no such barrier, and here a
coarse one refuses three colours by itself at 8,629 points. The upper bound is the residue plane at 11 (47 ≡ 3 = 5² mod 11, so 11
splits with residue field 𝔽₁₁, and χ(UD(𝔽₁₁, 2)) = 5), so **4 ≤ χ(ℚ(√47)²) ≤ 5** — the upper half is row 52's bound at a usable
prime, at the level row 52 records it (hand), not re-derived here.
