# FS-62 §2a — the two measurements at `q = 19`, and what they decided

*Run 2026-09-18 on the desktop, at Kooshi's instruction, to test the reading in `CLAUDE.md` G59 that `c = α/q^{3/2}`
is bounded by about 0.92 across the family. The falsifiers were committed to git BEFORE these ran (commit `b2beeef`,
G59 and `plans/STUB-six-is-not-a-value.md` §2a(3)), which is why they could be run ad hoc rather than under a
milestone.*

## The verdict, in one line

**`α(19) ∈ [76, 80]`, so `c(19) ∈ [0.918, 0.966]`, and the deciding threshold 0.933 lies inside.** The reading
survived its cheapest falsifier and was not confirmed.

## What was run

| # | instrument | asked | answered | file |
|---|---|---|---|---|
| 1 | `plane-independent` (Rust, 24 threads, 1 h) | an independent set of **78** | **not found**; best 76, verified | `alpha-q19-target78.json` |
| 2 | `fs54_d4_quad.py solve`, GLV level 3 | an upper bound on `α(19)` | **80.59** (converging; ratio bound is 99.50) | `l3.log`, `l3-q19-solve.json` |
| 3 | KaMIS `weighted_branch_reduce` (exact) | `α(19)` exactly | **failed** — 70 at its limit, no optimality proof | (stdout only) |
| 4 | KaMIS `struction` (exact, `--struction_degree=20`) | `α(19)` exactly | **failed** — 66 | `struction.log`, `struction-q19.set` |

**Run 1 is a null at a budget and never a refusal** (G21), and the record says so in its own words: *"it can exhibit
a set but it cannot bound alpha from above."* 521,874 restarts, 104.4 billion cycles, 24 threads, the full hour,
seeded from the verified 76-set. The instrument's positive control was run first: it attains the true `α(11) = 28`
in 0.05 s.

**Run 2 is the first time the level-3 relaxation has been pointed at 19.** It converges to `80.588…`, i.e.
**`α(19) ≤ 80`**, against 99 from the ratio bound. That is ~6 % above the best known set — against **exact** at
`q = 7` (14.000) and `q = 11` (28.07), and ~20 % loose at 23. **So 19 is where this instrument stops being exact**,
which is worth more to the certificate programme than it was to the question it was run for.

## Why runs 3 and 4 failed, which is a fact about the graphs and not about the solvers

`UD(𝔽₁₉,2)` is 361 vertices, 20-regular, 3,610 edges, 5.6 % density — which *looks* easy for branch-and-reduce.

1. **No reduction can ever fire.** Every rule these solvers own (degree-1, degree-2 folding, domination, twins,
   unconfined) works by finding a vertex that differs from its neighbours. A **vertex-transitive** graph has none.
   Measured directly: branch-and-reduce reported `reduction_time 0.003`, `struction` finished its reduction phase in
   26 ms, both having removed nothing, then fell through to blind branching on 361 undifferentiated vertices.
2. **The pruning bound is destroyed by triangle-freeness, and that is arithmetic.** At `q = 19`, 3 is a non-residue,
   so the graph is triangle-free (G57) and its only cliques are single edges. The clique-cover bound is then at best a
   matching: `n/2 = 180` against a truth `≤ 80`, off by 2.3×, so nothing prunes.
3. **Symmetry multiplies the tree.** `|Aut| ≥ 361 · 40 = 14,440` and no off-the-shelf MIS solver breaks it.

*Untried and the only live class: a symmetry-aware exact method — orbital branching, or Schreier–Sims cuts in a MIP.*

## The backend measurement, which was the real defect found

The level-3 solve was first launched on the **GPU** backend, because that was 10× faster on the FS-50 certificate at
`q = 83`. Measured here on one chunk each, resumed from the same 500-iteration checkpoint:

| backend | s/iteration | |
|---|---:|---|
| `gpu_indirect` | 2.750 | what was launched |
| **`cpu_indirect`** | **0.773** | **3.6× faster**; what it was moved to |
| `qdldl` | — | no chunk in 240 s; the fill-in is hopeless at this shape |
| `cudss` | — | not built in this venv |

Controls: the GPU figure agrees with the 2.52 s/it inferred independently from the first run's checkpoint timestamps,
and the two backends that completed agree on the objective to six figures (81.332703 / 81.332712), so they are
solving the same programme. **`q = 83` level 2 has 43 blocks; `q = 19` level 3 has 182 blocks and a 1.17-million-row
cone — the number did not travel across that gap, and carrying it cost a day's projected runtime.** Logs in `probe/`.

A second defect, found the same way: the solve's progress is written with plain `print`, which Python block-buffers to
a file, so **31 minutes produced an empty log while the job was healthy**. Relaunched under `python3 -u`. A monitor
armed on that log reported nothing for 30 minutes and the silence was indistinguishable from a hang.

## The decision problem in SAT (FS-65 D1), run 2026-09-18 — a characterised negative

Asked at Kooshi's instruction: *is there an independent set of 78?* — one yes/no question, because a
refutation puts `α(19) ≤ 77`, `c(19) ≤ 0.930` under the 0.933 threshold, and the reading survives with a
proof instead of a null. **It did not resolve.** What is worth keeping is *why*, which is measured.

**The instrument is correct and controlled.** `tools/fs65_indep_sat.py` encodes the question with two
symmetry breaks, each argued and verified in code: the origin pinned in (translations act simply
transitively) and the lex-least member of each orbit of the 40 maps fixing the origin. At `q = 11`, where
the value is known exactly and kernel-checked, it reproduces it **from both sides** — `k = 28` SAT with a
verified set in 0.2 s, `k = 29` UNSAT in 22.1 s. `tools/fs65_indep_cube.py` passes the same two-sided
control (18 s / 0.08 s).

**At `q = 19` the positive control returned UNKNOWN, and that was not the alarm it looked like.** Breaking
symmetry keeps one set per orbit of 14,440, so it makes SATISFIABLE instances much harder while making
refutations easier — the solver was hunting a needle the encoding had deliberately shrunk. The soundness
question was then settled **without a solver**: the known 76-set, translated to contain the origin and
mapped to the lex-least member of its orbit, is *accepted* by the encoding. So the encoding admits a
genuine 76-set and no refutation it produced could have been an artifact of the symmetry break.

**Why the route fails, in two measurements.**

| level | cubes | split rate | multiplier `2f` | |
|---|---:|---:|---:|---|
| 1 | 1,024 | 23.3 % | 0.47 | converging |
| 2 | 478 | 49.2 % | 0.98 | on the line |
| 3 | 470 | 62 %+ | **1.25** | **diverging** |

1. **Splitting stops paying.** Difficulty concentrates with depth: level 1 clears the easy space and what
   remains resists division, so by level 3 a split produces more work than it removes and the frontier grows.
2. **And a bigger budget is not the fix.** Three of the 239 level-1 cubes that survived 90 s were re-run at
   **420 s each: 0 of 3 resolved.** So the cap was never the binding constraint — those cubes are hard, not
   marginal, and restarting at a higher cap would have bought nothing for about half an hour of re-work.

**Standing result: undecided.** 1,109 cubes refuted and **no set of 78 found anywhere**, which is weak
evidence in the reading's direction and nothing more — a refutation needs *every* cube. `α(19) ∈ [76, 80]`
and `c(19) ∈ [0.918, 0.966]` are unchanged, with the deciding 0.933 still inside.

The single undivided run is the calibration: **UNKNOWN after a full hour**, holding nothing. The cube run
banked 1,109 durable refutations in the same period, survived a kill and a code change mid-flight, and its
785 top-level cubes are reusable by any future attempt. That durability, not the 28× in cores, is what
parallelising actually bought.

## The line case split (FS-65 D1b), 2026-09-18 — from an external review

An external review of the section above supplied a geometric decomposition, three corrections and an
algebraic explanation of the 76-point set. **Every checkable claim was verified here and all of them hold.**

**The 76-point set has a closed form.** `S = {(x,y) : y − x ∈ {0,3,8,11}}` — four parallel lines in the
direction `(1,1)`. Two points of `S` differ by `(t, t+d)` and a unit distance needs `(2t+d)² = 2 − d²`; the
offset differences give `d ∈ {0,±3,±5,±8}` and `2 − d² ∈ {2,12,15,14}`, **every one a non-residue mod 19**,
so no unit distance occurs. Verified: 76 points, 0 violations. `(1,1)` is not a unit direction (`1/2 = 10`
is not a square), and `S` meets **every one of the 190 unit-direction lines in exactly 4 points** —
measured occupancy set is literally `{4}`. The set we found by search has the same maximum occupancy 4.

**The decomposition.** Each of the `(q+1)/2 = 10` unit directions gives 19 parallel lines, each inducing a
19-cycle, so a line carries at most 9 points. A 78-point set over 19 parallel lines has a line with ≥ 5.
Rotations act transitively on the directions and translations move any line to `y = 0`, and the line's own
stabiliser acts dihedrally, so its pattern may be taken canonical: **204 cases (79 + 76 + 38 + 10 + 1 for
r = 5..9), reproduced here exactly.** Refuting all 204 proves `α < 78`. `tools/fs65_lines.py`.

**Soundness note:** the lex break of `fs65_indep_sat.py` is NOT applied on top. Anchoring the line already
spends the translations and most of the orthogonal group, and the full 40-map constraint could discard the
representative a case exists to keep — an unsound break, i.e. a false refutation. The case split replaces
that break rather than adding to it.

**Control, and it passes:** at `k = 76, r = 4` the enumeration gives **51 refuted and 5 satisfiable**, so it
admits the sets that exist. (Only 5 of 56 patterns admit one — the structure is rigid.)

**Measured so far at `k = 78`:** `r = 9` (the single case) **UNSAT in 589 s**; `r = 8` cases 0 and 1 and all
24 completed `r = 5` cases **undecided at a 600 s cap**. Difficulty runs *opposite* to occupancy: fixing `r`
points also excludes their neighbours, so `r = 9` determines far more of the graph than `r = 5`. All 204
cases relaunched hardest-first at a 5400 s cap.

**Two readings of mine that the control refuted, both from extrapolating a control at different parameters.**
I predicted low occupancy would be easy, from the `k = 76, r = 4` control running in 5–8 s. That speed was an
artifact: at `k = 76` the cap `19 × 4 = 76` is *exactly binding*, forcing every line to hold exactly 4. At
`k = 78` no cap binds (`r = 5` permits 95 against 78 needed), so none of the real cases inherit it.

## Correction: the origin pin is worth 4.63, not 361

**My symmetry accounting was wrong by a factor of 78.** A 78-point set has trivial translation stabiliser
(19 ∤ 78), so its orbit has 361 members — of which **78 contain the origin**. Pinning the origin therefore
keeps 78 representatives per orbit, a reduction of `361/78 = 4.63`, not 361. With the 40-map lex break the
total was about **185, not 14,440**.

**So D1's conclusion — "the hardness is in the instance, not the encoding" — was not earned:** a factor of 78
of the symmetry was never broken. The exact fix is the **centroid**: `c(S) = 78⁻¹ Σ v = 10 Σ v` over `𝔽₁₉²`
translates with the set (`c(S+t) = c(S)+t`), so exactly one translate has `c = 0`, and the two modular
equations `Σ a·x ≡ Σ b·x ≡ 0 (mod 19)` select one representative per orbit — the full 361. The 40 orthogonal
maps fix the condition, so a lex break still composes with it. **Implemented 2026-09-19 — and it does not
pay; see the next section.**

## The symmetry breaks, measured (2026-09-19) — the fix costs more than it buys

The correction above is arithmetic and it stands. What did not follow from it is the recommendation, and
the only way to find that out was to build the thing and time it. `tools/fs65_indep_sat.py --break` now
carries three sound normalisations of the 361 translations, and they were run against each other with one
thing differing:

| break | what it keeps per translation orbit | how it is encoded |
|---|---|---|
| `none` | all 361 | — |
| `origin` | the 78 translates containing the origin — **4.63** | 13 unit clauses (`x₀`, and its 12 neighbours false) |
| `centroid` | exactly 1 — **361** | two modular sums `Σa·x ≡ Σb·x ≡ 0 (mod 19)`, a residue chain, +12,958 vars |
| `lex` | exactly 1 — **361** | `x ≤ t(x)` for all 360 translations, Crawford chains, +130,000 vars |

Two runs each, sequential on a quiet machine, at two field sizes — `q = 11, k = 29` (UNSAT, `α = 28`
known exactly) and `q = 19, k = 115` (UNSAT). **The two runs of each cell agree to within 0.5 %, so the
ratios below are not noise:**

| break | `q = 11, k = 29` | | `q = 19, k = 115` | | CNF at 19 |
|---|---|---|---|---|---|
| `origin` | **22.4, 22.5 s** | 1.0× | **97.2, 96.8 s** | 1.0× | 49,001 vars / 114,231 clauses |
| `centroid` | 238.0, 244.5 s | 10.7× | 466.5, 464.8 s | 4.8× | 61,959 / 140,126 |
| `lex` | 46.7, 46.4 s | 2.1× | 1112.7, 1107.6 s | 11.5× | 178,961 / 504,090 |
| `none` | 286.6, 320.4 s | 13.5× | 408.9, 407.5 s | 4.2× | 49,001 / 114,210 |

**The origin pin's power was never its symmetry reduction.** It is the twenty-two unit clauses it puts in
the instance — the origin true and its twenty neighbours false — and that propagation is worth more to
CDCL than a 78× larger quotient. The exact breaks fix no variable at all: the centroid is a pair of
modular sums, the constraint family CDCL is worst at (the same reason XOR constraints need a dedicated
engine), and `lex` pays `q⁴` clauses for its chains — 58k at 11, 504k at 19.

**And at `q = 19` both exact breaks are a net loss against no translation break at all.** The centroid
takes 466 s where doing nothing takes 409. So the correction and its fix are wrong in opposite directions:
the symmetry accounting was off by a factor of 78, and correcting it makes the solve slower than leaving
the symmetry entirely unbroken.

**Neither ordering is a law** — `lex` is second-best at 11 and worst at 19, because its encoding grows like
`q⁴` while the graph grows like `q²`. What reproduces across both field sizes is only this: **the
propagating break wins and the exact ones do not.** The default in the tool is therefore `origin`, the
mathematically weakest of the three, with the measurement in its docstring so the "improvement" is not
made a second time.

**How far SAT is from this question at all** (`--break origin`, the fastest, single solver):

| `k` | 170 | 150 | 130 | 120 | 115 | 110 | 105 | 100 | 95 | 90 | 86 | 83 | **78** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| seconds | 1.9 | 3.4 | 15.7 | 50.2 | 114.6 | 383.4 | >900 | >900 | >600 | >600 | >600 | >600 | **>3,600** |

**The wall is between 110 and 105**, and it is vertical: 383 s one side, nothing in 900 s the other. So the
solver's frontier sits about **thirty** above the answer, and each step of 5 down costs roughly 3×.

*These were run four at a time, so they carry a contention penalty: `k = 115` reads 114.6 s here and
**97.2 s** on the quiet machine, a factor of 1.18. The undecided rows are unaffected — they are caps, not
timings — and the ratio between steps is what the table is for.* That is
the honest form of D1's conclusion: it is not that this encoding is bad, it is that CDCL is not within reach
of this graph at the size that matters, and three sound encodings do not move it.

**The controls, all passing** (`python3 tools/fs65_indep_sat.py --selftest`):

- the modular-sum encoding against brute force on **every** assignment of a small instance — two-sided, so
  an encoding that forbids too much fails as loudly as one that forbids too little;
- `q = 11`: `k = 28` SAT with the model re-verified independent and its centroid checked, `k = 29` UNSAT;
- **the normalisation itself, on 200 random sets per size**: for `gcd(k, q) = 1` exactly one of the `q²`
  translates satisfies both equations, and for `q | k` the count is 0 or `q²` — the degenerate case, which
  the encoder **refuses** rather than answers. That case is not hypothetical: **`k = 76`, the size of the
  best set we have, is `4 × 19`**, and every translate of it has identical coordinate sums.

## The line case split is resumable (2026-09-19)

`tools/fs65_lines.py --state DIR` keeps one record per case and writes it atomically as it lands, so a kill
costs one case per worker rather than the run; `--status` prints the tally, `--plan` prints what is left,
`--jobs N` runs them in a pool (no `xargs`, which is where this repository's `pkill -f` trap keeps biting).
The 149 records already on disk are read unchanged — the store is the per-case files `--out` was always
writing.

**An UNKNOWN is credited with the time it actually SPENT, never the cap it was launched with.** A case
whose solver was killed — a stopped batch, an OOM, a machine going down — lands as UNKNOWN too, and
crediting it with its nominal cap would drop it silently out of every future queue while nothing had
decided it. Three faults were planted to check this and each fired: a killed case at 100 s wearing a
5,400 s cap is re-queued, a genuine 5,400 s timeout is not, and a truncated record is re-queued rather
than crashing the run.

**And the split now has an end-to-end control it never had.** At `q = 11`, where `α = 28` is known: `k = 29`
refutes in **all 10** cases, and `k = 28` comes back **satisfiable in 2 of 10**. Both outcomes reachable,
both correct — the exhaustiveness argument checked against a known answer instead of argued.

## Three further corrections accepted

1. **"Finding 78 kills the uniform route" was overstated.** It refutes that constant *at 19*; a bound stated
   for `q ≥ 31`, or carrying a lower-order correction, is untouched — and `q ≥ 31` is all the wall needs.
2. **"No reduction can ever fire" holds at the root only.** After branching the residual graph is not
   vertex-transitive and reductions can bite; vertex-transitivity also does not by itself exclude twins.
3. **The proven fractional interval is `[361/99, 361/76] = [3.646, 4.75]`**, not the narrower `[4.51, 4.75]`
   quoted earlier, which used the uncertified relaxation value as though it were a bound.

**Not yet tried, and the review's first choice:** 574 fixed-cardinality moment equations for the level-3
relaxation — `Σ_{v ∉ T ∪ N(T)} y_{T∪{v}} = (78 − |T|) y_T` for every independent `T` with `|T| ≤ 3`, whose
orbit counts (1, 1, 17, 555) match the level-3 variable set exactly, so no new moment variables are needed.

## Files

| file | what it is |
|---|---|
| `alpha-q19-target78.json` | run 1's record, complete and self-describing (rerun line, edge digest, verified set) |
| `seed-76.txt` | the verified 76-set from `data/fplane/alpha-p19.json`, as the search's start |
| `ud-q19.graph` | the plane in METIS format with unit weights; controls in the generator, see below |
| `struction.log`, `struction-q19.set` | run 4 |
| `l3.log` | run 2's chunk trace (live, unbuffered) |
| `probe/*.log` | the four backend timings |
| `breaks/q19-k115-bench.log` | the three translation breaks against each other at `q = 19`, sequential, two runs each |
| `breaks/q11-k29-bench.log` | the same at `q = 11`, where `α = 28` is known exactly |
| `breaks/q19-frontier.log` | how far CDCL gets at `q = 19`, `k = 170` down to `k = 83` |

`ud-q19.graph` was built here rather than reused, so it carries its own controls: 361 vertices, every degree exactly
20, 3,610 edges, **the independently verified 76-set is independent in it**, and KaMIS's `graphchecker` accepts the
format. The level-3 checkpoint (`l3-q19.ckpt`, 19.6 MB) is regenerable and is not committed.
