# `χ(ℚ(√119)²) ≥ 4` — a witness, and the one command that re-checks it

**The claim.** The 456 points listed in `witness.json` all lie in `ℚ(√119)²`, and the graph joining the pairs
exactly 1 apart has **no proper 3-colouring**. So the plane over `ℚ(√119)` needs at least four colours.

**Re-check it with one command** (well under a second on the machine that wrote this; it needs nothing from this project but Python):

```
python3 tools/fs58_check_witness.py --radicand 119 data/fs61/witness-119/witness.json
```

That checker is **standard library only and imports nothing from `tools/`** — it shares no code with the program that
found this graph. It (1) checks every point is a reduced integer tuple standing for a point of `ℚ(√119)²`; (2)
**re-derives every pair at distance exactly 1 itself, in integer arithmetic**, and refuses unless that set equals the
edge list in the file; (3) checks the pinned pair is a real edge; (4) builds the CNF from *its own* edge set; and (5)
checks the LRAT proof against that CNF with its own checker. Output: `CERTIFIED` and exit 0, or `REFUSED <CODE>` and
exit 1.

**What is not claimed.** The matching **upper** bound is prior art, not ours: the residue plane at 7 ([Moorhouse2010] Thm 8.1) gives
`χ(ℚ(√119)²) ≤ 4`. With it, **chi(Q(sqrt119)^2) = 4**. Nothing here proves the upper bound.
**And nothing here is checked by the Lean kernel**: the certificate above is the standard-library checker's, and that
is a different and weaker thing.

**What else was checked** (each file below is in this directory, the verbatim output of the command named):

| file | command | result |
|---|---|---|
| `certified.out` | the checker above | `CERTIFIED: 456 points of Q(sqrt119)^2, each a reduced (a, b,…` |
| `controls.out` | `… --controls witness.json` | `CONTROLS ALL PASS` — 13 rows pass, 0 fail: the faithful twin certified, and each planted fault refused **for its named reason** |
| `wrong-radicand.out` | `… --radicand 131 witness.json` | `REFUSED`, exit 1 — the witness is about **this** field |
| `recheck.out` | `tools/fs58_recheck_witness.py 119 witness.json` | **the second opinion** — every pair re-tested in exact `Fraction` arithmetic and three solvers outside the generator's (Lingeling, CaDiCaL 1.5.3, MapleChrono) refusing it: RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse. Its last step is a separate, **minimality** question — does deleting the pinned vertex leave a 3-colouring — and it passes |
| `colouring4.json` | — | an explicit proper **4**-colouring, verified on all 1122 edges: four colours suffice for this graph, so it is exactly 4-chromatic |

**The 3-adic barrier, as a check on the object.** 996 of the 1122 edges have a direction with 3 in its
reduced denominator. The kernel result (`ThreeAdicBarrier.lean`, `CLAUDE.md` row 72) says a graph over this field that
needs four colours **must** contain such a direction — directions integral at 3 are 3-colourable outright — so a zero
here would be a defect in the search, not a discovery.

**Sizes and hashes.** 456 points, 1122 edges, least common denominator
60; pinned edge [0, 4]. `witness.json` sha256 `f61526fc80c6c6cc6519069e6e5c7e83…`.

**How it was found** — provenance, never evidence. A ball of radius 1.5 about the origin in the saturated
lattice `q1+12+60.1` over `ℚ(√119)` (13605 points) was refused three colours by a solver, and that
refusal was shrunk by `tools/fs58_search.py direct-witness`. **1-minimal: deleting any single vertex leaves a 3-colourable graph.**

None of this is part of the certificate either: the checker re-derives the graph from the coordinates alone.
Regenerate with `./run-all.sh` (read its header first if the deletion was stopped).
