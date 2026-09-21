# data/fs66/planner — the planner's cheap measurements (FS-66, 2026-09-20)

Written by the FS-66 planner while grounding the subplan's cost numbers. **Everything here is `tools`-grade: untrusted scripts,
solver verdicts, nothing kernel-checked.** The plan is `plans/FS66-residue-tower-drop.md`; this file is what its §M cites.
Machine: the desktop, one thread per solve, nothing else heavy running. Times are wall seconds of one run, not
minimum-of-three — they price the asks, they are not benchmarks.

## The headline: the pilot question was answered by the first direct ask

**`UD(ℤ/121, 2)` — 14,641 vertices, degree 132, 966,306 edges — is NOT four-colourable. CaDiCaL refuses the plain encoding
(one at-least-one clause per vertex, one conflict clause per edge and colour, a triangle at the origin pinned to colours 0, 1, 2)
in 1.7 s and 1,535 conflicts.** With the pulled-back five-colouring, `χ(UD(ℤ/121, 2)) = 5`: at 11 the residue ceiling does not
drop at level two.

What the verdict rests on, in the order a sceptic should check it:

1. **A 1,115-vertex, 4,405-edge subgraph that is already not four-colourable** (`core-p11-k4-fixpoint-1115v.json`; vertex id
   `v = a·121 + b` for the point `(a, b)`). Obtained from the refusal's own LRAT proof by backward reachability from the empty
   clause (2,713 vertices / 12,914 edges at round 0, `core-p11-k4-round0-2713v.json`), then re-solving the core and repeating to
   a fixpoint (13 rounds, under a second each). The pinned triangle's three edges are kept in every round — the pin is sound only
   while its triangle is in the graph; the first version of the shrinker dropped them and the round-3 "core" came back
   4-colourable, which is how the bug was caught.
2. **`fs66_planner_recheck_core.py`** re-verifies every core edge from the definition by plain integer arithmetic
   (`(a−c)² + (b−e)² ≡ 1 mod 121`, 4,405 of 4,405) and asks four solver codebases for a 4-colouring of the bare edge list with
   **no pin and no symmetry breaking**: glucose4 0.9 s, minisat22 0.8 s, cadical153 0.9 s, maplechrono 5.2 s — all UNSAT. The
   same edge list is 5-colourable (model verified on every core edge), so the instrument can say SAT on this object.
3. **Positive control at full size, same pipeline:** `fs66_planner_ask.py 11 5` finds a proper 5-colouring of the whole graph in
   251 s (572,161 conflicts, 1.35 GB) **without being handed the pulled-back one** — class sizes 2632, 2701, 2743, 3259, 3306, not
   multiples of 121, so it is not pulled back from level one. `colouring-p11-k5-found.json` is that colouring in the owner's
   format and **`tools/fs66_owner_verify.py colouring` VERIFIES it** (all-pairs sweep from the definition, 966,306 edges, shares
   no code with anything here).
4. **Controls at 7, where the truth is known:** `fs66_planner_ask.py 7 3` → UNSAT in 0.0 s (truth: the certified 297-point graph
   over ℚ(√23) maps into every level); `7 4` → SAT in 0.1 s, colouring verified, class sizes 543, 603, 624, 631 (not pulled back).
5. **The graph is derived from a law, so a refusal is the suspect verdict** (`CLAUDE.md` § "A measured half and a derived half").
   The guards: the directed-edge count 1,932,612 equals FS-38's and the owner's independent all-pairs count; the core's edges are
   re-verified one by one from the definition; the solvers in item 2 see only that edge list.

**Not done, and the plan's first phase:** an LRAT *check* (the proof was generated, never checked — there is no checker in
`tools/` that is not frozen), a vertex-minimal core, and the kernel theorem. Nothing here is a certificate.

## Other measurements in this directory's scripts

* `fs66_planner_g2.py` — builds the circles from the definition and FFTs them: `|S₂| = p(p+1)`; depth-≤1 eigenvalues are exactly
  `p·λ₁` (max deviation 1e-14); depth-2 eigenvalues lie in `[−2p, 2p]` (−21.9926 … 21.9703 at 11); Hoffman's ratio is the same at
  both levels (0.285534 at 11, 0.249077 at 23, 0.275618 at 19, 0.359691 at 7). Agrees with `data/fs66/owner/depth-spectrum.out`.
* `fs66_planner_ask.py P K --quot a,b` — the quotient of level two by the order-`p` translation subgroup `p·(a,b)·ℤ`. At 11 the
  rotation group has two orbits on the twelve such subgroups (tangent type, e.g. `(1,0)`: 1,331 vertices of degree 112; the
  other type, e.g. `(1,1)`: degree 132). **Both refuse four colours in 0.1 s (185 and 188 conflicts)**; the tangent-type quotient
  5-colours in 0.4 s. Subsumed by the headline, kept as a record of what a periodic ask costs.
* `fs66_planner_proj.py` — the largest subset of one fibre `AG(2, p)` using at most `b` lines in each of the `(p+1)/2` tangent
  parallel classes (the only fibre data a level-two edge sees). Exact at 7: 5 points for `b = 3`, 9 for `b = 4`. At 11 HiGHS did
  not close in 120 s: **≥ 10 (dual bound 17) for `b = 5`, ≥ 14 (dual bound 35) for `b = 6`** — against the 30.25 points per fibre
  that four colours need on average. Balanced fibres are far too small; the reading is in the plan §S.

## Regenerate

```bash
cd data/fs66/planner
python3 fs66_planner_ask.py 11 4 --tlim 600 --out /tmp/g2-p11-k4.cnf          # UNSAT, ~2 s (+4 s to build)
CAD=$(ls ~/.elan/toolchains/*/bin/cadical | tail -1)
$CAD --lrat --no-binary -q /tmp/g2-p11-k4.cnf /tmp/g2-p11-k4.lrat               # 1.5 MB text LRAT
python3 fs66_planner_core.py /tmp/g2-p11-k4.cnf /tmp/g2-p11-k4.lrat 4           # -> /tmp/g2-p11-k4.lrat.core.json (2,713 v)
python3 fs66_planner_shrink.py /tmp/g2-p11-k4.lrat.core.json 4                  # -> ….core.shrunk.json (1,115 v at the fixpoint)
python3 fs66_planner_recheck_core.py core-p11-k4-fixpoint-1115v.json 4          # the four-solver recheck, no pins
```
CaDiCaL is deterministic at a fixed seed, so the round-0 core should reproduce; the fixpoint depends on the per-round seeds
(`--seed=round`) and should reproduce too. The `.cnf` and `.lrat` are scratch (60 MB and 1.5 MB) and are not committed.
