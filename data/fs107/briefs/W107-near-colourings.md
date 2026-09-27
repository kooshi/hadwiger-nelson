*Brief for job **FS107-W**, competitor W of FS-107: build near-colourings whose holes vanish. Opus 5.5. Drafted by the planner FS107-P,
2026-09-27, for the owner to launch beside FS107-R. **`data/fs107/briefs/SHARED-107-competition.md` is part of this brief, word for word identical to
R's; read it first, then `STANDING-RULES.md`.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`.

## Your object and your question

**Your question is claim W of `data/fs107/claims.md` §1** — row 131's (e): "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring
by half-open grid squares, with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered". **Your object is the
sequence object SEQ.** A family of tight polygonal tilings with voids tending to 0 also suffices (A2 §3.3, by TQ-SUP). With five colours it would be
`χ(ℝ²) ≤ 5`; keep that outcome apart from six. A family whose largest uncovered disc shrinks while coverage stays bounded away from 1 refutes C-VOID
(R′) and decides nothing — a result, labelled as such.

## What the re-grokking asks of you (plan §G part 3, X7–X11, X16)

1. **The generator image first (X9).** Before any member is checked, write your family's generator: its parameters, their count, and the set of
   tilings it can produce. Say why vanishing holes lie inside that image — a family whose image misses them cannot succeed, however well its members
   check.
2. **All escape is in the holes (X7).** Without holes, cell-constant colourings need seven at every scale (rows 34–36; G29; G22), so your members'
   whole freedom is where the holes sit and how they shrink. **Your driving parameter is not the grid scale** (G23; W killing test 4). Parts's family has
   none: its voids keep a fixed size, one at every vertex (TQ §4.5 item 6). Every six-colour map has a trichromatic vertex (K-BICH), and complementary
   junction types within distance 2 are where LIM's exceptional set lives (K-C6, K-TAN): say how your family handles its junctions.
3. **The checker (X8), written before the family.** `tools/fs107_w_check.py`: input a member as a file (the period lattice, the tiles with rational
   data, the colours, `ε`); for every pair of same-coloured tiles over the torus's periodic images (G68), the **exact** interval of their distances
   (rational or exact algebraic arithmetic; a corner-circle rule is only sufficient, §PA row 6) against the closed band; output the pairs checked, the
   least margin to the band, the uncovered density exactly, each class's density (K-DENS: `≤ 0.2470`), the junction types present, the least distance
   between complementary types, and the least distance between equal types in `(1, 2)` (K-KILL). A planted monochromatic pair must fire for its own
   reason, beside a faithful stub that must pass; bound the plant's effect on both sides (§ Make the gate fail). A check of a given object: allowed
   under the ban.
4. **The floor (W killing test 2):** your claimed `δ(ε)` is never below `ε²/(6+ε)²` (FS106-EPS2, given V-1.3). A family that claims less is wrong.
5. **An ansatz, if you want one (X10):** central symmetry up to a colour involution fixing a colour (G58).
6. **The checker certifies members; the family is a derivation.** Band-properness for every parameter value is proved by hand; checked members are
   controls (G21). Junction types are read as `claims.md` D-JUNC defines them, with `r_J = h`.
7. **By formula, never by search.** Until 2026-10-01 no optimiser, no SAT, no survivor sweep; after it, no finite-graph search ever. Members are
   given by formula and checked; a parameter is chosen by derivation, never by a scan.

## Stages

1. Quotation check; your restatement of W beside the quotation; your answer to the advisor's question (which step of R's programme fails); the
   checker with its plant and stub, run first on **a known positive**: the slack hexagonal seven-colouring with one class left uncovered (`δ = 1/7`),
   rasterized to grid squares with rational data — accepted; with one monochromatic pair planted — rejected. A second, sharper control if you want one:
   `[Parts2020c]`'s tiling eroded at one `κ` (reconstructed from his paper; its data are [external]).
2. The generator image and the parameter count; the family by formula.
3. Members at a ladder of `(ε, δ)` given by formula, each checked; the four killing tests.
4. The verdict on W — a family meeting it (held under the hold rule), or the named obstruction your families meet: where their holes stop shrinking,
   and why. A lower bound on the void for a class of families is a result.
5. After hand-back only: read R's record, and record every divergence of truth and of route.

## Rules

- **Your record:** `plans/FS107-W-near-colourings.md`; working files and member files `data/fs107/fs107-w/`; tools `tools/fs107_w_*.py`. Touch
  nothing else.
- **Fenced (SHARED § Fences):** R's record `plans/FS107-R-stability.md` and `data/fs107/fs107-r/`, until you have handed back.
- The advisor's id comes from the owner. Report per standing rule 9 to `data/fs107/reports/FS107-W.md`.

Thank you.
