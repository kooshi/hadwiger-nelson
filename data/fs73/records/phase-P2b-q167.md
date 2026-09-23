# FS-73 phase P2b — ℚ(√167)'s lattice `L3e1c94c6`: a denser ball, or a colouring with no short period

*Implementer C (Opus 5.5), 2026-09-23, desktop (16 physical cores / 32 threads, 128 GB). Brief: the PO's
message of 2026-09-23 (FS-73, after phase P2's table). Tools: `tools/fs73_q167*.py`; data: `data/fs73/q167/`.*

## Theorems this phase proved

*(filled at the end of the phase)*

## Registration (written 2026-09-23 before any solver ran and before FS-61's stored colouring was opened)

**The question.** `L3e1c94c6` (rank 4, 36 unit vectors, covolume 5.154e-05) has no periodic proper 3-colouring at any admissible
period `N ≤ 20` (phase P2, replicated by a second solver on a second encoding), yet FS-61 three-coloured its 1,474,541-point,
average-degree-14 ball in 3.66 s. By compactness the lattice graph is 3-colourable iff every finite ball is.

**P-C1 (registered).** **(B): the priced denser ball (average degree ≥ 18) three-colours.** Confidence **0.75**.
- Why: FS-61's degree-14 ball coloured in 3.66 s on 1.47 M points — near-linear time, the signature of a ball far from its
  threshold; on every refusing lattice on record (G65) the degree-14 ask was slow or refused, never a few seconds of
  propagation. And the quotient refusals were themselves near-instant (0.1–2 s), which is what spurious short cycles created by
  reduction mod `N` look like, not what a global obstruction looks like (G21: the periodic search measures its quotients).
- Sub-prediction **P-C1b** (lower confidence, **0.55**): if it colours, the lattice has a periodic 3-colouring at some longer
  period (a circular/Bohr colouring `c(x) = ⌊3·frac(φ(x))⌋` with rational `φ`, or another finite quotient), i.e. case (B) is
  "long period", not "aperiodic".
- **The informative outcomes, both reachable:** a refusal (reachable: no theorem colours this lattice, and no periodic colouring
  exists at `N ≤ 20`) is χ(ℚ(√167)²) ≥ 4 after certification; a colouring (reachable: the degree-14 ball coloured) extends the
  evidence for (B) and sends the work to the period search.
- **The uninformative outcome:** `UNKNOWN` at the budget on the dense ball (reachable if degree 18 is still at this lattice's
  threshold, the G65 hardness band's upper edge). It would say nothing about the graph (G21).
