# The field-to-prime map

*Table regenerated 2026-09-17 by `python3 tools/fplane.py map --bound 600` (its plane floors now include every committed exact
certificate and its ceilings the verified periodic colourings — per-plane values and their sources in `data/fplane/map.json`,
`planes`); notes rewritten the same day for FS-56's and FS-58's results. The row for 27 is hand-added (the tool is prime-only).
Read the notes before the table. **The verdict column is about upper bounds only; proven lower bounds are in the last section.***

**What the planes now say** (`data/fplane/map.json`, `planes`, each value with its record): χ(UD(𝔽_q,2)) is 3, 4, 5, 5 at
q = 3, 7, 11, 19; **between 6 and 8 at 23** (five refused by `data/fs54/cert-q23-l3-N105.json`, α ≤ 105 < 106, FS-56; eight by
the verified periodic colouring in `data/fplane/periodic-below-71.json`, and in the kernel as `colorable_finitePlane23_eight`);
between 5 and 8 at 31 (spectral floor; periodic ceiling); **between 6 and 8 at 43 and between 6 and 10 at 47** (five refused by
`data/fs53/cert-q43-N365.json` and `cert-q47-N371.json`); **at least 7 at 59, 67, 79, 83** (six refused by
`data/fs53/cert-q59-N575.json`, `cert-q67-N745.json`, `cert-q79-N1023.json`, `data/fs50/p83-refusal/cert-p83-N1046-polish-208500.json`),
at 71 (exact spectrum), and from 98 by Weil. At 27 (not in the generated table): between 6 and 7 (`data/fs54/cert-q27-l3-N141.json`;
`data/fs53/colour-q27-k7-quotient.json`).

**The `6-open` label now states its floor.** It means no usable plane is five-colourable, and the verdict gives the least usable
floor, a lower bound on the local bound L(F). For the fields containing ℚ(√3,√11) (K(√7), K(√13), K(√79), K(√127), de Grey's field,
K(√5,√7,√247)) every usable plane is at 83 or above and the floor is ≥ 7, so the residue method yields **7 and never 6** there:
L(K(√7)) = 7 is the sharp statement. For the quadratic and biquadratic window fields below it is ≥ 6, decided by the planes at 23,
43 and 47.

**Consequently no field that this project has ever built in can have local bound 6** — each is 4-sealed, 5-sealed, or ≥ 7 — which is
G56's reciprocity exclusion seen from the field side: every one of them contains ℚ(√3,√11), and 3 or 11 is a non-square at every
window member.

**Which field would a six-colouring at q buy?** The smallest field whose FIRST usable residue plane is a window member *and* whose
2-adic wall is broken — **every prime above 2 splits in F(i)**. A prime above 2 ramified in F(i)/F two-colours the plane at any norm
(so every odd-degree field is 2-colourable), and an inert one gives a 4-colourable residue graph at every size checked. Found by
`tools/fs54_fields.gp` (complete for degree ≤ 4, |disc| ≤ 20,000; FS-54): **23 → ℚ(√167); 31 → ℚ(√1055); 43 → ℚ(√4703);
47 → ℚ(√2351); 27 needs even degree ≥ 6, the smallest found being the disc-316 cubic x³ + 2x² − 3x − 2 joined with √79.** The rows
tagged `[smallest, sees q]` are those; the rows tagged `[sees q]` are biquadratic fields that also see their member first but are
not the smallest.

**Quadratic fields whose local bound is at least 6** (`tools/fs54_quadratic_fields.gp` → `data/fs54/quadratic-fields.out`, rerun
2026-09-17): with d ≤ 30,000, **44** real quadratic fields have the wall broken and no usable plane in {3, 7, 11, 19, 31}; every one
has 23, 43 or 47 usable and every other usable plane is ≥ 7. Their local bound is **6 exactly when a usable one of 23, 43, 47 is
six-chromatic**, and ≥ 7 otherwise. The smallest: ℚ(√167) (decided by 23 or 43), ℚ(√1319) (23 or 47), ℚ(√2351) (47 alone),
ℚ(√3527) (23, 43 or 47), ℚ(√4703) (43 or 47). *Correction record: until 2026-09-17 this note read "sixteen … no usable plane in
{3, 7, 11, 19, 23, 31} … 43 or 47"; 23's floor was then 5, and FS-56's certificate raised it to 6.*

**What is at stake at the three decisive planes.** Five is refused by certificate at 23, 43 and 47, so a verified six-colouring at
any of them is that plane's exact chromatic number, and makes a quadratic field's χ ≤ 6 a theorem: at 23 **χ(ℚ(√167)²) ≤ 6**, at 43
χ(ℚ(√4703)²) ≤ 6, at 47 χ(ℚ(√2351)²) ≤ 6 — the first number fields with local bound exactly 6, predicted 6 by the conjecture.
**All three are implausible on the measurements** (`data/fs53/CLOSE.md`, `data/fs53/README.md`): six at 23 needs an independent
set of 89 and the best found is 87 (`data/fs53/alpha-q23-ge87.json`, about 96,000 restarts); six at 47 needs the certificate to be
99.4 % tight, a tightness seen only at q = 7; at 43 the independent set stuck at 258 against the 309 six needs through over three
hours, the six-colour search stalled at 1,016 monochromatic edges for 2 h 52 m, the equivariant sweep 0 of 21. These are nulls at a
budget, not refusals; but they mean these fields most likely have local bound ≥ 7, where the conjecture's bold form predicts seven.

| field | radicands | 2-adic wall | usable primes | verdict |
|---|---|---|---|---|
| Q | [] | stands | [3, 7, 11, 19, 23, 31, 43, 47] | sealed-at-3 (p = 3, chi-p3); Theorem B: ≤ 4 as well |
| Q(√2) | [2] | stands | [7, 23, 31, 47, 71, 79, 103, 127] | sealed-at-4 (Theorem B: the 2-adic wall stands); the sieve agrees at p = 7 |
| Q(√3) | [3] | stands | [3, 11, 23, 47, 59, 71, 83, 107] | sealed-at-3 (p = 3, chi-p3); Theorem B: ≤ 4 as well |
| Q(√5) | [5] | stands | [11, 19, 31, 59, 71, 79, 131, 139] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| Q(√7) | [7] | broken | [3, 7, 19, 31, 47, 59, 83, 103] | sealed-at-3 (p = 3, chi-p3) |
| Q(√11) | [11] | stands | [7, 11, 19, 43, 79, 83, 107, 127] | sealed-at-4 (Theorem B: the 2-adic wall stands); the sieve agrees at p = 7 |
| K = Q(√3,√11) | [3, 11] | stands | [11, 83, 107, 131, 167, 227, 239, 263] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| K(√5) | [3, 5, 11] | broken | [11, 131, 239, 359, 431, 479, 491] | sealed-at-5 (p = 11, chi-p11) |
| K(√7) | [3, 7, 11] | broken | [83, 131, 167, 227, 479, 503, 563] | 6-open: local bound ≥ 7 (every usable plane refuses five; see the planes table) |
| K(√13) | [3, 11, 13] | broken | [107, 131, 263, 347, 491, 503, 563] | 6-open: local bound ≥ 7 (every usable plane refuses five; see the planes table) |
| K(√23) [T20b] | [3, 11, 23] | broken | [11, 83, 107, 227, 263, 359, 431, 479] | sealed-at-5 (p = 11, chi-p11) |
| K(√35) | [3, 11, 35] | stands | [107, 131, 263, 347, 479] | sealed-at-4 (Theorem B: the 2-adic wall stands) |
| K(√79) | [3, 11, 79] | broken | [107, 227, 359, 491, 503] | 6-open: local bound ≥ 7 (every usable plane refuses five; see the planes table) |
| K(√127) | [3, 11, 127] | broken | [83, 167, 239, 347, 359, 491, 563] | 6-open: local bound ≥ 7 (every usable plane refuses five; see the planes table) |
| K(√247) [T20, W] | [3, 11, 247] | broken | [11, 83, 107, 239, 359, 479, 563] | sealed-at-5 (p = 11, chi-p11) |
| K(√5,√247) | [3, 5, 11, 247] | broken | [11, 239, 359, 479] | sealed-at-5 (p = 11, chi-p11) |
| Heule Q(√3,√5,√11) | [3, 5, 11] | broken | [11, 131, 239, 359, 431, 479, 491] | sealed-at-5 (p = 11, chi-p11) |
| de Grey Q(√3,√5,√7,√11) | [3, 5, 7, 11] | broken | [131, 479] | 6-open: local bound ≥ 8 (every usable plane refuses five; see the planes table) |
| K(√5,√7,√247) | [3, 5, 7, 11, 247] | broken | [479] | 6-open: local bound ≥ 13 (every usable plane refuses five; see the planes table) |
| Q(√23) | [23] | broken | [7, 11, 19, 23, 43, 67, 79, 83] | sealed-at-4 (p = 7, chi-p7) |
| Q(√47) | [47] | broken | [11, 19, 23, 31, 43, 47, 67, 107] | sealed-at-5 (p = 11, chi-p11) |
| Q(√71) | [71] | broken | [7, 11, 23, 31, 47, 59, 67, 71] | sealed-at-4 (p = 7, chi-p7) |
| Q(√95) | [95] | broken | [7, 19, 23, 31, 43, 47, 59, 71] | sealed-at-4 (p = 7, chi-p7) |
| Q(√191) | [191] | broken | [7, 11, 19, 31, 47, 71, 83, 127] | sealed-at-4 (p = 7, chi-p7) |
| Q(√2,√31) [sees 23] | [2, 31] | broken | [23, 31, 79, 127, 151, 167, 199, 223] | open-pending (p = 31: its plane's floor is 5, undecided) |
| Q(√5,√51) [sees 31] | [5, 51] | broken | [31, 59, 79, 139, 179, 191, 199, 211] | open-pending (p = 31: its plane's floor is 5, undecided) |
| Q(√10,√23) [sees 43] | [10, 23] | broken | [43, 67, 79, 83, 107, 191, 199, 227] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√7,√89) [sees 47] | [7, 89] | broken | [47, 131, 139, 167, 199, 223, 227, 251] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√2,√3,√7) [sees 47] | [2, 3, 7] | broken | [47, 167, 311, 383, 479, 503] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√2,√3,√31) [sees 23] | [2, 3, 31] | broken | [23, 167, 239, 263, 383] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√167) [smallest, sees 23] | [167] | broken | [23, 43, 59, 67, 71, 79, 83, 103] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√1055) [smallest, sees 31] | [1055] | broken | [31, 43, 47, 83, 103, 107, 131, 163] | open-pending (p = 31: its plane's floor is 5, undecided) |
| Q(√2351) [smallest, sees 47] | [2351] | broken | [47, 67, 71, 83, 139, 151, 163, 191] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| Q(√4703) [smallest, sees 43] | [4703] | broken | [43, 47, 79, 103, 107, 127, 139, 151] | 6-open: local bound ≥ 6 (every usable plane refuses five; see the planes table) |
| cubic x³ + 2x² − 3x − 2 (disc 316) · Q(√79), disc 31,554,496 [smallest found, sees 27] | not multiquadratic | broken (every prime above 2 splits in F(i)) | [27, 43, 79] (below 100) | open-pending (q = 27: its plane is undecided) |

## Proven lower bounds on χ(F²) for fields in this table (FS-58)

The table's verdicts bound χ(F²) from above. These fields also have a proven lower bound of four, from a finite unit-distance graph
with coordinates in the field that admits no proper 3-colouring:

| field | χ(F²) | lower bound: witness and trust | upper bound (the verdict above) |
|---|---|---|---|
| Q(√11) | **4** | 204 points; **kernel**, `four_le_chromaticNumber_planeOver_eleven` (`Proofs/HadwigerNelson/Instances/SqrtEleven.lean`, commit `05aee38`); witness `data/fs58/witness-11/` | 4, the 2-adic wall and the plane at 7 (`[Fischer1990]` Thm 9, `[Moorhouse2010]` Thm 8.1) |
| Q(√23) | **4** | 297 points; certified by `tools/fs58_check_witness.py --radicand 23` (`data/fs58/witness-23/minimal/certified.out`) | 4, the plane at 7 |
| Q(√71) | **4** | 148 points; certified (`data/fs58/witness-71/certified.out`) | 4, the plane at 7 |
| Q(√95) | **4** | 1,068 points; certified (`data/fs58/witness-95/certified.out`) | 4, the plane at 7 |
| Q(√191) | **4** | 483 points; certified (`data/fs58/witness-191/certified.out`) | 4, the plane at 7 |
| Q(√47) | **4 or 5** | 169 points; certified (`data/fs58/witness-47/certified.out`) | 5, the plane at 11 (the plane at 19 is also 5, its refusal of four a solver claim: `data/fplane/chi-p19-k4.json`) |
| Q(√167) [smallest, sees 23] | **3 to 7** | an odd cycle (`[Moorhouse2010]` Thm 8.6); four **not** landed (`data/fs58/search-167/README.md`) | ≤ 7 in general (χ(ℝ²) ≤ 7); no usable plane is below 6 |

"Certified" means an exact edge check and an LRAT refutation re-checked by a standard-library checker that shares no code with the
generator, planted faults refused, and a decorrelated recheck with two further solvers (`plans/FS58-four-colours.md` §R-B3, §R-B5).
Lower bounds for the other rows (ℚ, ℚ(√3), K, Heule's field, K(√23), K(√247)) are recorded in `plans/M61-local-global-tightness.md`
§2 and `CLAUDE.md`'s ledger.
