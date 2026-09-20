# `χ(ℚ(√191)²) ≥ 4` — a witness, and the one command that re-checks it

**The claim.** The 292 points listed in `witness.json` all lie in `ℚ(√191)²`, and the graph joining the pairs
exactly 1 apart has **no proper 3-colouring**. So the plane over `ℚ(√191)` needs at least four colours.

**Re-check it with one command** (about a second; it needs nothing from this project but Python):

```
python3 tools/fs58_check_witness.py --radicand 191 data/fs61/witness-191/witness.json
```

That checker is **standard library only and imports nothing from `tools/`** — it shares no code with the program that
found this graph. It (1) checks every point is a reduced integer tuple standing for a point of `ℚ(√191)²`; (2)
**re-derives every pair at distance exactly 1 itself, in integer arithmetic**, and refuses unless that set equals the
edge list in the file; (3) checks the pinned pair is a real edge; (4) builds the CNF from *its own* edge set; and (5)
checks the LRAT proof against that CNF with its own checker. Output: `CERTIFIED` and exit 0, or `REFUSED <CODE>` and
exit 1.

**What is not claimed.** The matching **upper** bound is prior art, not ours: the residue plane at 7 ([Moorhouse2010] Thm 8.1) gives
`χ(ℚ(√191)²) ≤ 4`. With it, **chi(Q(sqrt191)^2) = 4**. Nothing here proves the upper bound.

**What else was checked** (all four files are in this directory, each the verbatim output of the command named):

| file | command | result |
|---|---|---|
| `certified.out` | the checker above | `CERTIFIED: 292 points of Q(sqrt191)^2, each a reduced (a, b,…` |
| `controls.out` | `… --controls witness.json` | `CONTROLS ALL PASS` — 13 rows pass, 0 fail: the faithful twin certified, and each planted fault refused **for its named reason** |
| `wrong-radicand.out` | `… --radicand 203 witness.json` | `REFUSED`, exit 1 — the witness is about **this** field |
| `recheck.out` | `tools/fs58_recheck_witness.py 191 witness.json` | every pair re-tested in exact `Fraction` arithmetic, and three solvers outside the generator's refuse it |
| `colouring4.json` | — | an explicit proper **4**-colouring, verified on all 713 edges: four colours suffice for this graph, so it is exactly 4-chromatic |

**The 3-adic barrier, as a check on the object.** 89 of the 713 edges have a direction with 3 in its
reduced denominator. The kernel result (`ThreeAdicBarrier.lean`, `CLAUDE.md` row 72) says a graph over this field that
needs four colours **must** contain such a direction — directions integral at 3 are 3-colourable outright — so a zero
here would be a defect in the search, not a discovery.

**Sizes and hashes.** 292 points, 713 edges, least common denominator
60; pinned edge [0, 2]. `witness.json` sha256 `461a5cc0cb36330eb5e010fc292459ce…`.

**How it was found** — provenance, never evidence. A ball of radius 1.5 about the origin in the saturated
lattice `q1+q5+20+60.1` over `ℚ(√191)` (53177 points) was refused three colours by a solver, and that
refusal was shrunk by `tools/fs58_search.py extract`. **1-minimal: deleting any single vertex leaves a 3-colourable graph.**

None of this is part of the certificate either: the checker re-derives the graph from the coordinates alone.
Regenerate with `./run-all.sh` (read its header first if the deletion was stopped).
