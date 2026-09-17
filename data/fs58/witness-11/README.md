# data/fs58/witness-11 — FS-58 phase B3: a 204-point witness that the plane over ℚ(√11) needs four colours

Plan: `plans/FS58-four-colours.md` §R-B2 (the solver claim this phase turns into a certificate), §2 D3 (the chain), §M3 and §G
(tool conventions and gate). Generator: `tools/fs58_witness.py` (untrusted). Checker: `tools/fs58_check_witness.py` (standard
library only; imports nothing from `tools/`). Regenerate everything with `bash data/fs58/witness-11/run-all.sh`.

## The claim, and who checks what

**`witness.json` lists 204 points of ℚ(√11)² whose unit-distance graph (455 edges) has no proper 3-colouring. So the plane over
ℚ(√11) needs at least four colours.** A point is five integers `(a, b, c, e, m)`, `m > 0`, `gcd = 1`, meaning
`((a + b√11)/m, (c + e√11)/m)`, so every point lies in ℚ(√11)² by the way it is written.

`tools/fs58_check_witness.py data/fs58/witness-11/witness.json` prints `CERTIFIED` (`certified.out`) after it has:

1. checked every point is such a reduced tuple and no point repeats;
2. found every pair of points at distance exactly 1 again, in integer arithmetic. Cell keys computed with `isqrt`, with no floats,
   propose the pairs; two points at distance ≤ 1 have keys at most 3 apart, so offsets up to 3 are searched. It then checked that
   this set equals the file's edge list;
3. checked that (0, 0) and (1, 0) are points and adjacent, and that the pinned pair is one of the edges it found;
4. built the CNF itself, from its own edges. The variable `3v + k + 1` means "vertex v has colour k". Clauses: an at-least-one
   clause per vertex, three clauses per edge, then the pin `c(0,0) = 0`, `c(1,0) = 1`. The pin loses nothing, because the pair is
   adjacent and colours can be renamed;
5. checked CaDiCaL's LRAT proof (`witness.lrat.gz`) against that CNF with its own checker. Each added clause has to follow by unit
   propagation from exactly its listed hints, in order: every hint unit, the last one falsified. Deletions are honoured, RAT hints
   are refused, and the proof must derive the empty clause.

| trust level | what |
|---|---|
| **certified** (exact arithmetic + an LRAT check that is not the solver) | `witness.json` + `witness.lrat.gz`: no 3-colouring |
| solver claims, two codebases, plus a solver-free search | the forcer in `forcer.json` (below); the four copies inside G* |
| measurement | the scan over directions and box shapes (`scan.out`), the 1-minimal shrinking (`forcer.out`) |

## How the witness was built

**The forcer.** `W₀` is the 36 unit vectors of ℚ(√11)(i) with denominator dividing 10 (`data/fs58/chain-11/pool-10.json`; the
generator re-checks that list against a brute force and against `fs58_local.units_d`). The scan tried every direction u ∈ W₀ (18
up to sign) on box pieces of `Cay(ℤ[W₀], W₀)`, in the pool's basis. The shapes were: centred boxes `R = 4, 5, 6`, used only when
they contain the target, and "span" boxes, the smallest box holding 0 and the target, widened by 1, 2 or 3. Two queries were asked:

* *separate* `(0, 3u)`: pins `c(0) = 0`, a neighbour `(−1, 0)` of 0 at colour 1, and `c(3u) ≠ 0`. The neighbour pin loses nothing:
  given `c(0) = 0`, swapping colours 1 and 2 keeps `c(3u) ≠ c(0)` and makes `c(nb) = 1`;
* *identify* `(0, 2u)`: the same pins, with `c(2u) = 0`.

Each refusal came from the CaDiCaL binary (2.1.2, `--lrat=true --binary=false`). The core is the set of vertices of the formula
clauses reached backwards from the empty clause through the LRAT hints, plus 0 and the target. It was induced and re-solved until
it stopped shrinking (`scan.out`).

Cell format below: piece size → fixpoint core → 1-minimal forcer of `(0, 3u)` (no single vertex can be removed; Glucose4 with one
selector per vertex). `col.` means a colouring was found and verified; `—` means the box does not contain the target. For
*identify*, the last number is the forcer grown from D3.8's gadget: the core, its translate by u, and the run 0, u, 2u, 3u.

| u (over 10) | separate: R6 | span1 | span2 | span3 | identify: R4 | R5 | R6 | span2 | span3 |
|---|---|---|---|---|---|---|---|---|---|
| (−1,0,0,−3) | — | col. | 2800→409→202 | 7840→286→139 | — | — | 28561→295→146 | 1925→375→184 | 5733→262→117 |
| (−1,0,0,3) | — | col. | 3850→161→99 | 10192→217→109 | — | — | 28561→82→79 | 2475→188→118 | 7007→148→79 |
| (−10,0,0,0) | — | col. | 2500→235→146 | 7546→163→120 | — | — | — | 1875→158→109 | 5831→77→98 |
| (−3,−2,−6,1) | 28561→313→171 | 4374→243→126 | 10648→293→118 | 21970→167→65 | 6561→266→166 | 14641→235→163 | 28561→382→207 | 5103→86→73 | 11979→290→141 |
| (−3,−2,6,−1) | — | 4860→167→101 | 11968→218→153 | 24700→154→100 | — | — | — | 5733→65→60 | 13365→117→134 |
| (−3,2,−6,−1) | — | 4860→146→105 | 11968→249→119 | 24700→312→109 | — | — | — | 5733→143→**57** | 13365→135→158 |
| (−3,2,6,1) | 28561→227→106 | 4374→329→176 | 10648→263→147 | 21970→259→121 | 6561→109→81 | 14641→214→91 | 28561→121→84 | 5103→85→83 | 11979→87→93 |
| (−6,−1,−3,2) | — | 4860→293→115 | 11968→150→89 | 24700→237→96 | — | — | — | 5733→79→100 | 13365→69→81 |
| (−6,−1,3,−2) | 28561→341→153 | 4374→281→156 | 10648→234→124 | 21970→167→117 | 6561→321→206 | 14641→341→186 | 28561→289→173 | 5103→184→112 | 11979→120→115 |
| (−6,0,−8,0) | — | col. | 5950→200→84 | 14896→152→93 | — | — | — | 3575→68→64 | 9555→82→82 |
| **(−6,0,8,0)** | — | col. | 5950→58→**52** | 14896→194→93 | — | — | — | 3575→82→70 | 9555→116→91 |
| (−6,1,−3,−2) | 28561→384→168 | 4374→269→141 | 10648→113→91 | 21970→204→142 | 6561→439→132 | 14641→81→113 | 28561→296→163 | 5103→72→93 | 11979→282→130 |
| (−6,1,3,2) | — | 4860→94→75 | 11968→107→73 | 24700→149→126 | — | — | — | 5733→102→71 | 13365→120→130 |
| (−8,0,−6,0) | — | col. | 5950→192→115 | 14896→142→107 | — | — | — | 3575→135→90 | 9555→78→82 |
| (−8,0,6,0) | — | col. | 5950→87→67 | 14896→118→66 | — | — | — | 3575→107→140 | 9555→76→89 |
| (0,−3,−1,0) | — | col. | 2800→274→162 | 7840→357→123 | — | — | 28561→277→142 | 1925→383→188 | 5733→228→106 |
| (0,−3,1,0) | — | col. | 3850→263→154 | 10192→258→132 | — | — | 28561→262→146 | 2475→311→115 | 7007→243→88 |
| (0,0,−10,0) | — | col. | 2500→227→135 | 7546→157→120 | — | — | — | 1875→185→136 | 5831→127→121 |

Separate: 48 of 58 pieces refuse; identify: 60 of 70. The twenty pieces that admit a colouring (each verified) are all span-1
boxes, for the same ten directions in both queries: the six in ℚ(i) and `(−1,0,0,±3)`, `(0,−3,±1,0)`. The identify span-1 column is
left out of the table; its other eight entries refuse. Centred boxes `R = 4, 5` never contain `3u`: every direction has a basis coordinate of absolute value at least 2. **Every
direction forces `(0, 3u)` in a span-2 box, and every direction has a virtual edge at `(0, 2u)`.** The smallest forcer, 52 points and
111 edges, comes from the separation query. The smallest forcer grown from a virtual edge has 57 points.

`forcer.json`: `u = (−6, 0, 8, 0)/10 = (−3/5, 4/5)` (a direction in ℚ(i)), 52 points, 111 edges. It was re-verified from a fresh
build. Separation: CaDiCaL exit 20, and the LRAT core touches all 52 points; Glucose4 UNSAT. Identification `c(0) = c(3u)`: SAT on
both solvers, both models checked proper. Plain 3-colourability: SAT, both models checked.

**The chain (G55; D3.1).** `1/3 = 1 + 1 + v + v̄` with `v = (−5 + i√11)/6`. Every copy uses `T_k(z) = t_k + r_k·z` with
`r = (ū, ū, ūv, ūv̄)` and `t_{k+1} = t_k + 3u·r_k`, so `T_k(0) = t_k` and `T_k(3u) = t_{k+1}`, with `t = 0, 3, 6, 6 + 3v, 1`. The
generator checks, in exact arithmetic over ℚ(√11, i), that these identities hold for **every one of the 36 directions** in W₀
(`identities.out`). G* is the union of the four copies, with every exact unit distance among its points as an edge. The float grid
proposes pairs, integer arithmetic decides, and the generator asserts that every transported forcer edge is among the result. G* has
204 points (4 × 52, minus the three shared chain points and `T₁(u) = 1 = T₄(3u)`, since u is a forcer point) and 455 edges
(4 × 111 transported, plus 11 more). Refutation: CaDiCaL exit 20 in 0.03 s, 461 additions, and its core touches all 204 points;
Glucose4 UNSAT. 227 of the 455 edges have a 3 in their direction's denominator, as phase D's barrier requires: the edges whose
directions are 3-integral form a 3-colourable graph.

**A solver-free second route** (`chain.out`, recorded in `steps.jsonl`). Take each copy as an induced subgraph of G*. An exhaustive
search, with smallest-domain branching, singleton propagation, no learning and no solver, finds no 3-colouring with its two ends
different. It took 445, 231, 201 and 189 search nodes. Making the ends equal gives a colouring, which was checked. So
`c(0) = c(3) = c(6) = c(6 + 3v) = c(1)`, while 0 and 1 are adjacent. A search of the same kind on the whole of G* did not finish in
about two minutes (a scratch run, stopped). That is expected: without learning, the four copies' subtrees multiply. The chain route is the search argument that
works.

## The checker's controls (`controls.out`: `CONTROLS ALL PASS`)

Every plant must change the files' content, and the checker must refuse it for the named reason. The positive twin is the
faithful files re-serialised.

| plant | expected | refusal line (abridged) |
|---|---|---|
| positive twin | `CERTIFIED` | `CERTIFIED: 204 points …` |
| a point moved (vertex 20, degree 9, `a → a + 1`) | `EDGE_NOT_UNIT` | the file lists edge [3, 20] … not at distance 1 |
| a non-unit pair [0, 2] inserted as an edge | `EDGE_NOT_UNIT` | the file lists edge [0, 2] … not at distance 1 |
| the proof truncated to 280 of 560 lines | `NO_EMPTY_CLAUSE` | the proof ends after 255 additions without deriving the empty clause |
| one hint corrupted (line 281: first hint 1297 → 1) | `PROOF_STEP` | line 281: hint 1 has 3 unassigned literals, so it is not unit |
| a derivation's last hint dropped (line 187) | `PROOF_STEP` | line 187: clause 1743: its hints propagate to no conflict |
| the pin reversed, (0, 1) → (1, 0) | `PROOF_STEP` | line 1: hint 1570 is already satisfied. The reversed pin would also be a valid symmetry reduction; it is refused because the proof refutes the formula the checker builds, not a formula the file names |
| the pinned edge removed from the edge list | `EDGE_MISSING` | points 0 and 1 … are at distance 1 but the file omits the edge |
| the pin moved to the non-adjacent pair (0, 2) | `PIN_NOT_EDGE` | the pinned pair [0, 2] is not at distance 1 |
| a vertex deleted, the file renumbered to stay self-consistent | `PROOF_STEP` | line 1: hint 1570 names no clause in the database |
| a point listed twice | `DUPLICATE_POINT` | points 0 and 203 are both [0, 0, 0, 0, 1] |
| a point not reduced | `POINT_FORMAT` | point 203 … is not reduced (gcd 2) |
| bucketing completeness | all-pairs = bucketed = file | 20,706 pairs: 455 = 455 = 455 |

**Mutation audit of the checker** (scratch copies; the committed checker's sha256 was confirmed unchanged afterwards). Each of
these unsound mutations turns at least one control red. Accepting a derivation that reaches no conflict: caught by the dropped-hint
plant. Treating a satisfied hint as a conflict: crash. Not assigning a unit literal: the twin goes red. Skipping the unit-length
test on file edges: two plants go red. Skipping the missing-edge test: one. Skipping the pin-adjacency test: the pin plant is refused
for the wrong reason (`PROOF_STEP`), which the named-reason rule catches. Accepting a proof with no empty clause: the truncation
plant is certified. Narrowing the bucketing neighbourhood: the completeness control goes red, and so does everything downstream.
Two **sound** relaxations are *not* caught, as expected, since neither can certify a false claim: skipping a non-unit hint
instead of refusing it, and not honouring deletions.

## The kernel route (priced, not built)

* **The certificate format fits as it is.** `UDCert 204` over `Q4`, `denom = 150` (the lcm of the witness's denominators). Every
  coordinate uses only the `1` and `√11` slots (mask 0 and mask 8 of `tools/emit_cert.py`'s 16), with |coefficient| ≤ 900.
* **The CNF is already the pipeline's.** `tools/coloring.py` builds `coloringCNF 3 n edges` as the at-least-one clauses, then each
  listed edge's three clauses, with variable `k·v + c + 1`, and `cubeCNF` appends one unit clause per pin. With the edge list sorted
  and pins `[(0, 0), (1, 1)]`, that is exactly the formula `witness.lrat.gz` refutes. Not yet run through `emit_mask.py`;
  re-solving takes 0.03 s anyway.
* **Lemmas owed** (about 60 lines, mirroring `Instances/CompositumFive.lean` §`UDCert`):
  1. `Q4.elevenOnly : Subring Q4`, with the six inner components `.re.im`, `.im.im`, `.re.re.im`, `.im.re.im`, `.re.re.re.im`,
     `.im.re.re.im` zero, plus a `DecidablePred`;
  2. `Q4.eval_mem_of_mem_elevenOnly (h11 : √11 ∈ F)`;
  3. `UDCert.point_mem_planeOver_of_elevenOnly`;
  4. `UDCert.chromaticNumber_le_planeOver_of_elevenOnly`, with `h11` from `sqrt_mem_fieldOfRadicands (D := {11}) (d := 11)`.

  `Q4.seamFree` is not enough, because it evaluates into ℚ(√3, √11). The better API is one generic pair: `c.CoordsIn S` together
  with `∀ x ∈ S, Q4.eval x ∈ F`.
* **The statement.** `4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber`. It follows from the SAT
  side, `Gadget 3 204 2 edges ![0, 1]` (Mycielski's two-port shape, `Gadget.edge 0 1` with `Gadget.ofUnsat`), then
  `not_colorable_of_gadget` and `add_one_le_chromaticNumber_iff_not_colorable`.
* **Cost, estimated from recorded figures** (not measured):

  | part | estimate | basis |
  |---|---|---|
  | geometry | ≈ 25 s, ≈ 0.8 GB | 455 edges × 0.054 s and 1.8 MB per edge (`emit_cert.py`, de Grey's dense coordinates; these sparse ones are likely cheaper) |
  | point table | ≈ 4 s | 204 points against de Grey's 1,581 (32 s, 3.8 GB) |
  | LRAT | ≈ 10 s | 1,571 clauses; backward trimming keeps 289 additions and 6,261 hint entries. Mycielski's 387,065 entries took about 10 min (≈ 1.5 ms each); TwoAdicFive's 3,240-clause table and 182 trimmed lines took 5.9 s |

  Total: well under a minute of kernel time, a few GB at peak, on the standard three axioms with no native purchase.

## Files

| path | what | produced by | trust |
|---|---|---|---|
| `witness.json` | G*: points, edges, the pinned edge, the CNF convention, the proof's sha256, the transport data (u, v, `r_k`, `t_k`, images of 0 and 3u) | `fs58_witness.py chain` | certified with the proof |
| `witness.lrat.gz` | CaDiCaL 2.1.2 text LRAT for exactly that CNF, 52,365 bytes uncompressed, sha256 `33798ce1…0234`; gzip header mtime 0, so a rebuild is byte-identical | same | checked by `fs58_check_witness.py` |
| `forcer.json` | the 52-point forcer (points over 10, edges, the fresh verification record) | `fs58_witness.py forcer 1000` | solver claims + the solver-free search in `chain.out` |
| `identities.out`, `scan.out`, `forcer.out`, `chain.out` | the command outputs | `run-all.sh` | measurement / record |
| `certified.out`, `controls.out` | the checker's verdict and its planted faults | `run-all.sh` | — |
| `run-all.sh` | regenerates all of the above; resumable | — | — |
| `steps.jsonl` | the resume record (one JSON object per solver step: sizes, pins, verdicts, cores; 2.6 MB), **not committed** (`.gitignore` here). A clean clone regenerates it in about two minutes on the desktop, and `scan.out` / `forcer.out` carry every number in this README | `fs58_witness.py` | resume state, not evidence |

**Reproducibility, measured.** `steps.jsonl` was moved aside, the scratch directory deleted and `run-all.sh` run from empty (82 s scan
plus the forcer and chain steps). `witness.json` and `witness.lrat.gz` came out byte-identical (sha256 `ec8cd702…210d` and
`41c58a36…dc1b`), and `forcer.json` came out identical apart from its solver timings.

## Deviation from the brief, recorded

The brief put `w = (0, 3, −1, 0)/10 = (3√11/10, −1/10)` in the R = 6 box. In the pool basis, which `fs58_box.py`'s float LLL leaves
unchanged, w has coordinates `(0, 2, 0, −3)`, so `3w = (0, 6, 0, −9)` lies outside `|x_i| ≤ 6`. R-B2's R = 6 separation lines are
for `u = (−6,−1,3,−2), (−6,1,−3,−2), (−3,−2,−6,1)`; w itself was asked only at R = 9, by `fs58_box_indep.py`. The chain closes for
every u, so the witness uses the direction with the smallest forcer. For w (rows `(0,−3,±1,0)` up to sign) the scan finds forcing
from the span-2 box (3,850 points), with a 1-minimal forcer of 154 points.
