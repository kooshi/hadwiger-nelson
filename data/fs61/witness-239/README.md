# `χ(ℚ(√239)²) ≥ 4` — a witness, and the one command that re-checks it

**The claim.** The 2360 points listed in `witness.json` all lie in `ℚ(√239)²`, and the graph joining the pairs
exactly 1 apart has **no proper 3-colouring**. So the plane over `ℚ(√239)` needs at least four colours.

**Re-check it with one command** (14 s on the machine that wrote this; it needs nothing from this project but Python):

```
python3 tools/fs58_check_witness.py --radicand 239 data/fs61/witness-239/witness.json
```

That checker is **standard library only and imports nothing from `tools/`** — it shares no code with the program that
found this graph. It (1) checks every point is a reduced integer tuple standing for a point of `ℚ(√239)²`; (2)
**re-derives every pair at distance exactly 1 itself, in integer arithmetic**, and refuses unless that set equals the
edge list in the file; (3) checks the pinned pair is a real edge; (4) builds the CNF from *its own* edge set; and (5)
checks the LRAT proof against that CNF with its own checker. Output: `CERTIFIED` and exit 0, or `REFUSED <CODE>` and
exit 1.

**What is not claimed.** The matching **upper** bound is prior art, not ours: the residue plane at 7 ([Moorhouse2010] Thm 8.1) gives
`χ(ℚ(√239)²) ≤ 4`. With it, **chi(Q(sqrt239)^2) = 4**. Nothing here proves the upper bound.
**And nothing here is checked by the Lean kernel**: the certificate above is the standard-library checker's, and that
is a different and weaker thing.

**What else was checked** (each file below is in this directory, the verbatim output of the command named):

| file | command | result |
|---|---|---|
| `certified.out` | the checker above | `CERTIFIED: 2360 points of Q(sqrt239)^2, each a reduced (a, b…` |
| `controls.out` | `… --controls witness.json` | `CONTROLS ALL PASS` — 13 rows pass, 0 fail: the faithful twin certified, and each planted fault refused **for its named reason** |
| `wrong-radicand.out` | `… --radicand 251 witness.json` | `REFUSED`, exit 1 — the witness is about **this** field |
| `recheck.out` | `tools/fs58_recheck_witness.py 239 witness.json` | **the second opinion** — every pair re-tested in exact `Fraction` arithmetic and three solvers outside the generator's (Lingeling, CaDiCaL 1.5.3, MapleChrono) refusing it: RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse. Its last step is a separate, **minimality** question — does deleting the pinned vertex leave a 3-colouring — and it passes |
| `colouring4.json` | — | an explicit proper **4**-colouring, verified on all 6639 edges: four colours suffice for this graph, so it is exactly 4-chromatic |

**The 3-adic barrier, as a check on the object.** 4328 of the 6639 edges have a direction with 3 in its
reduced denominator. The kernel result (`ThreeAdicBarrier.lean`, `CLAUDE.md` row 72) says a graph over this field that
needs four colours **must** contain such a direction — directions integral at 3 are 3-colourable outright — so a zero
here would be a defect in the search, not a discovery.

**Sizes and hashes.** 2360 points, 6639 edges, least common denominator
120; pinned edge [0, 3]. `witness.json` sha256 `1a49a2a76e7349339db60962bdfc331e…`.

**How it was found** — provenance, never evidence. A ball of radius 1.5181 about the origin in the saturated
lattice `q1+q5+24+60+120.1` over `ℚ(√239)` (710957 points, asked by the census at **tier `1u`**, refused in 197.15 s) was refused three colours by a solver, and that
refusal was shrunk by `tools/fs58_search.py extract`. This directory also holds a parked checkpoint from a DIFFERENT ball of the same lattice — `steps-ball1.2892.jsonl` — which is **not part of this witness** and is not read by anything that re-checks it: the live checkpoint for the R = 1.5181 ball is `steps.jsonl`. Both are gitignored provenance. **Refusing but NOT 1-minimal: the deletion was stopped at position 948 of 4917.**
Minimality is not part of the claim and not part of the certificate: **a witness that is not 1-minimal is not a weaker certificate** — a refusing set refuses whether or not it is smallest, and minimality buys size (the checker time, and the kernel cost of a later formalisation), never soundness.
None of this is part of the certificate either: the checker re-derives the graph from the coordinates alone.
Regenerate with `./run-all.sh` (read its header first if the deletion was stopped).
