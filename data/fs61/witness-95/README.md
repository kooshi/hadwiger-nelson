# `χ(ℚ(√95)²) ≥ 4` — a witness, and the one command that re-checks it

**The claim.** The 1004 points listed in `witness.json` all lie in `ℚ(√95)²`, and the graph joining the pairs
exactly 1 apart has **no proper 3-colouring**. So the plane over `ℚ(√95)` needs at least four colours.

**Re-check it with one command** (5 s on the machine that wrote this; it needs nothing from this project but Python):

```
python3 tools/fs58_check_witness.py --radicand 95 data/fs61/witness-95/witness.json
```

That checker is **standard library only and imports nothing from `tools/`** — it shares no code with the program that
found this graph. It (1) checks every point is a reduced integer tuple standing for a point of `ℚ(√95)²`; (2)
**re-derives every pair at distance exactly 1 itself, in integer arithmetic**, and refuses unless that set equals the
edge list in the file; (3) checks the pinned pair is a real edge; (4) builds the CNF from *its own* edge set; and (5)
checks the LRAT proof against that CNF with its own checker. Output: `CERTIFIED` and exit 0, or `REFUSED <CODE>` and
exit 1.

**One gate item did not go green, and it is not about this certificate.** C.4 fails on its MINIMALITY control, not on the refutation: C.1 certified this witness and C.2 passed every plant. The deletion was stopped at 407 of 1737, leaving the pinned vertex redundant. Resume with a larger --deletion-budget (the checkpoint is on disk). The certificate above is unaffected: the frozen checker re-derives the graph from the coordinates and refutes it, and a refusing set refuses whether or not it is smallest.

**What is not claimed.** The matching **upper** bound is prior art, not ours: the residue plane at 7 ([Moorhouse2010] Thm 8.1) gives
`χ(ℚ(√95)²) ≤ 4`. With it, **chi(Q(sqrt95)^2) = 4**. Nothing here proves the upper bound.

**What else was checked** (each file below is in this directory, the verbatim output of the command named):

| file | command | result |
|---|---|---|
| `certified.out` | the checker above | `CERTIFIED: 1004 points of Q(sqrt95)^2, each a reduced (a, b,…` |
| `controls.out` | `… --controls witness.json` | `CONTROLS ALL PASS` — 13 rows pass, 0 fail: the faithful twin certified, and each planted fault refused **for its named reason** |
| `wrong-radicand.out` | `… --radicand 107 witness.json` | `REFUSED`, exit 1 — the witness is about **this** field |
| `recheck.out` | `tools/fs58_recheck_witness.py 95 witness.json` | every pair re-tested in exact `Fraction` arithmetic, and three solvers outside the generator's refuse it |
| `colouring4.json` | — | an explicit proper **4**-colouring, verified on all 2829 edges: four colours suffice for this graph, so it is exactly 4-chromatic |

**The 3-adic barrier, as a check on the object.** 2484 of the 2829 edges have a direction with 3 in its
reduced denominator. The kernel result (`ThreeAdicBarrier.lean`, `CLAUDE.md` row 72) says a graph over this field that
needs four colours **must** contain such a direction — directions integral at 3 are 3-colourable outright — so a zero
here would be a defect in the search, not a discovery.

**Sizes and hashes.** 1004 points, 2829 edges, least common denominator
60; pinned edge [0, 7]. `witness.json` sha256 `a72fbb80d5f5ff8f958e428cf3de1848…`.

**How it was found** — provenance, never evidence. A ball of radius 1.5 about the origin in the saturated
lattice `q1+12+60.2` over `ℚ(√95)` (17169 points) was refused three colours by a solver, and that
refusal was shrunk by `tools/fs58_search.py extract`. **Refusing but NOT 1-minimal: the deletion was stopped at position 407 of 1737.**
Minimality is not part of the claim and not part of the certificate — a refusing set refuses whether or not it is smallest.
None of this is part of the certificate either: the checker re-derives the graph from the coordinates alone.
Regenerate with `./run-all.sh` (read its header first if the deletion was stopped).
