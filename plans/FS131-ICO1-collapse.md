# FS131-ICO1 — the collapse proved: the plane over ℚ(√635087) has the plane's chromatic number

*Implementer's record (de Bruijn, the implementer, on Opus 5.5). Brief: `data/fs131/briefs/FS131-ICO1-collapse.md` (on `main`
at `f1fcc683d`). Worktree `.claude/worktrees/kcl1`, branch `fs131-ico1`, cut at `2e28d8a07` (the planner's `fs131-kcl1` with
`main` merged in). The plan: `plans/FS131-KCL1-collapse-plan.md`. Scripts and logs under `data/fs131/ico1/`.*

## Theorems this phase proved

(Filled as the leaves close; the final list is at the last stage.)

## Stage 1 — SAVED: the readback

**Quotations.** The planner's checker (`data/fs131/kcl1/quote_check.py`, read-only here) run on this brief against this
worktree: five quotations, all verbatim (`data/fs131/ico1/quote_check.out`) — W2 (`data/fs131/REQUEST-2026-10-13.md`), row 128
(`LEDGER.md`), and the three headline statements (`Proofs/HadwigerNelson/Collapse/Headline.lean`). Control: `--plant` changes one
letter of W2 and the checker reports it NOT FOUND at character 134 and exits 1 (`quote_check_plant.out`). Against the main tree the
first two are verbatim and the third source does not exist there (the skeleton is on this branch only), as expected. **No
mismatch.**

**The target, in my words.** Seven skeleton modules under `Proofs/HadwigerNelson/Collapse/` hold 48 `sorry` leaves. Every leaf is
to be proved, no statement changed, so that

- `Collapse.chromaticNumber_planeOver_sqrt635087`: the unit-distance graph of `ℂ` induced on `planeOver ℚ(√635087)` has the
  chromatic number of the unit-distance graph of `ℂ`;
- `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`: the same at every real number field `F` (a `Subfield ℝ` with
  `NumberField F`) all of whose stable primes are uniformly `c`-thick, `0 ≤ c < 1/5`;
- `Collapse.chromaticNumber_planeOver_deGrey`: the same at `ℚ(√3, √5, √7, √11)`;

are kernel theorems on the standard three axioms, `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`,
with no hypothesis of ours; the six-or-seven corollary adds `Outside.OAI158.no_proper_five_coloring`.

**The order of work** (the plan's § 4.4, with the brief's rulings): (1) `Collapse/Thick`, with the approved edits D-E1
(`Arith/FloorPlanes`) and D-E2 (`Rigidity/ClassRatio`) — measuring the rebuild they cost first — and `Collapse/Mixing`'s
`finite_mixing`: the new leaves that decide the price; (2) the copies `Colouring → Dichotomy → Slice`; (3) `tendsto_levelResid`,
`mixing_at_level`, `not_both_ge_of_mixing`, then `Collapse/Selection`; (4) `Collapse/Headline`; (5) the experience pass on the
headline names and docstrings, the gate on one commit, the read-aloud, the drafts.

**The statement baseline, taken before the first rebuild.** `lake build --no-build Proofs` under the slot: all targets
up to date (`uptodate0.log`), so the compiled library is the skeleton's. Every constant of the seven modules and of the two
edited ones, dumped from that build (`data/fs131/ico1/lean/StatementDump.lean`, FS131-IDG1's dumper with this job's module list;
`statements-before.txt.gz`, 331 constants).
