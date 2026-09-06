# data/m55 — M55, absorption (2026-09-06; `plans/M55-absorption.md`, results in its §R sections)

The milestone's theorem (`Proofs/HadwigerNelson/Absorb.lean`): a vertex set A EXTENDS at k colours when every
proper k-colouring of the induced subgraph G[A] restricts from one of G; then the pair compulsions of G among
A's vertices are G[A]'s own, and none exist when G[A] is (k−1)-colourable. Sufficient conditions, all one
construction (colour the piece, repaint the clashes with the spare colour): hub absorption
(`extends_of_hubs` — pieces fused at hubs, ≤ 1 base neighbour per piece vertex, non-hub chords a matching
with independent piece endpoints, the piece union plus hubs (k−1)-colourable), greedy absorption
(`extends_of_extensionOrder` — the k-core), symmetric copies (`extends_symCopy`). Every artifact below names
the theorem it instantiates, so a measurement of a theorem is distinguishable from a measurement of the
world. Regenerate with `tools/five_dial.py` (`absorb-self-test` first; 13 planted controls).

* `absorb-<stage>-k5.json` — the hypotheses of `Absorb.extends_of_hubs` on a multi-spindle stage (base = the
  fabric, pieces = the copies with their fused centres as hubs) and the verdict; `absorb --graph … --k 5`.
  **core-star₂ and star₂ (M54's C = ∅ objects) and the three-spindle star are ABSORBED**: every cross chord but
  the spindle chord is a hub chord, so D5 (ν = fewest deletions to 4-colourability) gives ν ≤ number of
  spindles, and with C = ∅ (ν ≥ 2) the two-spindle objects have ν = 2 exactly. The K ≥ 2 flowers are NOT
  absorbed (`hcol` fails: consecutive petals with the fused centre are a rotated copy of the witness).
* `core-<stage>-k5.json` — the 5-core by peeling; the reversed peel order re-checked as an
  `ExtensionOrder`; by `Absorb.extends_of_extensionOrder` the peeled vertices are invisible at five colours.
  `core5 --graph … --k 5`.
* `flower-35_1859-p<powers>.json` — the single-centre flower: petals R^k(core₁ − 35) for the listed powers of
  the spindle rotation about 35 (a `--graph` stage with points and sides);
  `multi-spindle --object <L4> --flower 35,1859 --powers 1,-1[,2,-2[,3,-3]]`. Its centre is critical at every
  K (one deletion ask each, `critical --only`), so by `CriticalSet.lean` any compulsion lives inside the
  centre's unit neighbourhood; the K = 2 flower's exhaustive five-colour sweep reads 0 / 0 complete
  (`data/m55/sweep-flower-…json`, 11 s).
* `spindles-35_1859-813_1939-1205_1442-full.json` — the three-spindle star on the full fabric (7,809 points);
  C = ∅ (the two candidates F₁ ∩ F₃ = {29, 1753} asked, `critical --only`), absorbed, ν ∈ [2, 3].
  `data/m54/forcing-critical-U-1205-1442.json` is the third pair's forcing census (`tools/m54_forcing_census.py`).
* `cross-lattice-depth2-W-core-8over3.json`, `cross-lattice-depth2-crossonly-W-core-8over3.json` — the F₂₄₇
  glue census over W ∪ P₁ (all pairs / pairs not both on one K-coset side), exact; the pools P₂, their fusions,
  the degree profiles; the grown stages `W-plus-cross-depth2[-crossonly].json` (`--graph` stages with points).
  `cross-lattice --exact … --cross … --depth 2 [--cross-only]`.
* `nu-<stage>-k5.json` — ν by the cardinality ladder (two encodings) or implicit hitting sets (re-verified
  cores); EXACT only when a certified lower bound meets a verified colouring. `nu-exact --graph … --method …`.
* `critical-probe-…json` — `critical --only` on a handful of vertices of a grown stage (the full census's
  asks are hard there); only the asked vertices are measured.
