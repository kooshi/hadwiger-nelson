# FS-81 stage C — independent verification of §F

The verifier's record (de Bruijn, 2026-09-24). Brief: the owner's, in the verifier's scratch. The statements verified are
`plans/FS81-quadratic-four-colours.md` §F (L1–L4, F-T4, §F.5). Until C1's verdicts are committed this record is written blind: the
verifier has read only that plan's §0, §IQ items 1–2 and §F, and not `plans/FS81-F-sketch.md`, Poros's plan record, the close
inventory, or `data/fs81/`.

## §0. C0 — predicted verdicts, written before any derivation is committed

**Honest timing.** These were written after reading the brief and the statements, and after a few minutes of unwritten thought in
which the verifier already sketched L3 and a route to L4 (a limit of `θ(25^{-k}·)` that isolates each layer's torsion part) and the
shape of the layer-to-layer gluing inside L2. They are therefore informed priors, not naive ones. Nothing below was read from the
planner's or the advisor's work.

| statement | predicted verdict | probability | the one thing most likely to break it |
|---|---|---|---|
| L1 (three-colourable ⟹ `Θ₃(F) ≠ ∅`) | proved | 0.85 | the cited form of the three-colour criterion's ⟹ direction may require the finite set to be a basis-like generating set, or may give a band other than `[1/3, 2/3]`; compactness itself is routine |
| L2 (= C1(5), the classification of `Θ(U₅)`) | proved | 0.85 | T40's cell list not reproducing on a second code path, or a layer-to-layer transition (parity ↔ order 3) that the sublattice arithmetic does not exclude |
| L3 (layers lie in `Θ(U₅)`) | proved | 0.97 | nothing foreseen; it looks like one line (`b·U₅ ⊆ U_F`) |
| L4 (gluing) | proved | 0.85 | the parity of `Σ c_j` controlling only the parity-type layers' coefficients, not all of them |
| F-T4 | proved | 0.80 | inherits L1 and L4; the passage from "1/3 ∈ ℤ[U_F] and not bipartite" to a relation meeting L4's hypotheses |
| §F.5 (d ≡ 3, 7 mod 12: only order-3 layers) | proved | 0.75 | the case n odd (d ≡ 3 mod 8), where the relation's parity constraint does not kill a parity layer outright |

Probability that all six are proved as stated: about 0.55.
