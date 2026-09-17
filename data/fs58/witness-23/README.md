# data/fs58/witness-23 — FS-58 phase B5: a 475-point witness that the plane over ℚ(√23) needs four colours

Plan: `plans/FS58-four-colours.md` §R-B4 (the search carried to B5), §2 D1 (the 3-adic barrier), §3 phase C (pieces with 3-non-integral
directions). Search record: `data/fs58/search-23/README.md`. Generator: `tools/fs58_search.py extract` (untrusted; checkpointed).
Checker: `tools/fs58_check_witness.py --radicand 23` (standard library only; imports nothing from `tools/`; the checker of `witness-11`,
its ℚ(√11) outputs byte-identical after the flag was added). Second opinion: `tools/fs58_recheck_witness.py`. Regenerate:
`bash data/fs58/witness-23/run-all.sh` (with `steps.jsonl` present, seconds; from empty, about 15 minutes — the checkpoint makes a kill
cost at most one round or one minute of deletion).

## The claim, and who checks what

**`witness.json` lists 475 points of ℚ(√23)² whose unit-distance graph (1,099 edges) has no proper 3-colouring, so χ(ℚ(√23)²) ≥ 4.**
A point is `(a, b, c, e, m)`, `m > 0`, `gcd = 1`, meaning `((a + b√23)/m, (c + e√23)/m)`. The checker's five steps are those of
`data/fs58/witness-11/README.md` with 11 replaced by 23.

| trust level | what | record |
|---|---|---|
| **certified** (exact integer arithmetic + an LRAT check that is not the solver) | no 3-colouring of the 475-point graph | `certified.out`: CERTIFIED, 16,009 LRAT additions, empty clause at id 19,783 |
| planted faults | twelve faults refused for their named reasons, the faithful twin certified, all-pairs = bucketed = file (1,099) | `controls.out`: CONTROLS ALL PASS; the same files under `--radicand 11` and `--radicand 47` refused `EDGE_NOT_UNIT` |
| decorrelated recheck (shares no code with generator or checker) | Fraction arithmetic over all 112,575 pairs gives exactly the file's 1,099 edges; Lingeling, CaDiCaL 1.5.3, MapleChrono refuse three colours; deleting the pinned vertex (1, 0) leaves a 3-colourable graph (model verified) | `recheck.out` |
| solver claims | the 440,077-point ball refuses (pysat CaDiCaL 1.9.5, 130 s under load; again 180 s as round 0 of the extraction); 1-minimality (every vertex tested once by Glucose4); CaDiCaL 2.1.2, Glucose4, Minisat22 refuse the final graph | `extract.out`, `rounds.out` |

**With the upper bound.** 23 ≡ 2 = 3² (mod 7), so 7 splits in ℚ(√23) with residue field 𝔽₇, 7 ≡ 3 (mod 4), and the residue plane
`UD(𝔽₇, 2)` is 4-chromatic; row 52's bound (hand level there, not re-derived here) gives χ(ℚ(√23)²) ≤ 4. **So χ(ℚ(√23)²) = 4**, the
exact value the brief anticipated for this field, at the same trust split as `witness-11` (the lower half certified, the upper half row 52).

The graph is triangle-free (√3 ∉ ℚ(√23)). Its edges use 18 direction pairs: 80 edges on the axis, 345 on the (3/5, 4/5) family, 164 of
denominator 12, 510 of denominator 60 — **674 of 1,099 edges have 3 in the denominator**, as D1 requires. Degrees 3 to 16 (mean 4.63);
the points lie within 2.93 of the origin in the first real embedding and 2.48 in the second.

## How it was built — no forced pair and no chain

**The pool** `q1+q5+12.1+60.2`: the axis (4), the (3/5, 4/5) family (8), the orbit of `((7 + √23)/12, (7 − √23)/12)` (8) and the orbit of
`((49 + √23)/60, (7 − 7√23)/60)` (16) — 36 unit vectors spanning a lattice of covolume 1.14·10⁻⁴ (Minkowski embedding), least odd cycle 9,
no linear form mod 3 nonzero on every generator. It is a **saturated** lattice: the lattice of the axis, class 12.1 and class 60.2 already
contains the (3/5, 4/5) family, and adding that family (same lattice, more edges) is what makes the ball refuse — `q1+12.1+60.2` and
`q1+60.2` on the identical 440,077-point ball are 3-colourable (models verified; `data/fs58/search-23/colour-scan.jsonl`).

**The piece**: every lattice point within physical radius 1.5 of the origin in both real embeddings — 440,077 points, 2,698,324 edges.

**The reduction** (`rounds.out`): CaDiCaL with one selector per vertex refuses the piece and returns its failed assumptions; the induced
graph on them is refused again, 77 rounds to a fixpoint (440,077 → 12,106 → 5,940 → … → 1,241 points, 320 s in all); Glucose4 then tests
every vertex once for deletion (1,241 → 475, two checkpoint records); an axis edge is translated to `(0, 0) → (1, 0)`; every unit distance
among the 475 points is re-derived exactly (1,099, all within the pool's 18 direction pairs); CaDiCaL 2.1.2 writes the LRAT.

**Reproducibility.** Re-emitting from `steps.jsonl` gives the same `witness.json` and LRAT byte for byte (checked twice, the second time
after later edits to the tool), and **a full re-extraction from an empty directory reproduced all 77 rounds and the same points, edges
and proof** (checked by comparing the rounds' kept sets and the proof's sha256).

**Kernel form.** Not attempted and not priced in B5 (the brief excludes `Proofs/`). For scale: `witness-11` (204 points, 461 LRAT
additions) cost 32.8 CPU s in the kernel (R-D2); this one has 475 points and 16,009 additions. R-D2 entered ℚ(√11)'s points through
`Q4` with only the `1` and `√11` slots used, so ℚ(√23) needs a coordinate ring with a `√23` slot — a representation question for D2's
successor, not measured here.
