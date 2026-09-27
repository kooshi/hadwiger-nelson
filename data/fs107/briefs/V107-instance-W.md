*Instance block for job **FS107-VW**, a second instance of the blind-verifier brief (`data/fs107/briefs/V107-blind-verifier.md`). Filled in by the
product owner on 2026-09-27, when FS107-W handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS107-VW.
- **Your record** is `plans/FS107-VW-verification.md`.
- **Your working directory** is `data/fs107/fs107-vw/`.
- **Your tools** are `tools/fs107_vw_*.py`.
- **Your commit subjects** are "FS107-VW: stage n".
- **Your report** goes to `data/fs107/reports/FS107-VW.md`.
- **Your scratch** is `<scratchpad>/FS107-VW/`.
- **An extra fence:** another blind verifier, FS107-V, is checking R. Its record `plans/FS107-V-verification.md` and `data/fs107/fs107-v/` are
  fenced for you, together with every path the brief lists.

## What you verify

- **The side:** W (near-colourings). W's verdict on claim W is a GAP, not landed. Do not verify claim W. Verify the results below.
- **W's record** is `plans/FS107-W-near-colourings.md`. It stays fenced until your stage 3 is committed, and so are W's tools
  `tools/fs107_w_*.py` and its data in `data/fs107/fs107-w/`. Write your own checker; never use W's.

## The statements, quoted verbatim from W's "Theorems this phase proved", in priority order

The wording and the grades are W's. The definitions are in `data/fs107/claims.md` and `LEDGER.md` row 131.

1. **W-EQ-K:** "At bounded arc complexity `K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper six-colouring by tiles of
   complexity `≤ K` exists (⟸ with `δ(ε) = O(ε)`)". [hand, one mind]
2. **W-RATE:** "A full tight colouring gives `δ(ε) = O(ε)`; `O(ε²)` if its contacts are isolated and transversal — the floor's order; R's pinhole test
   is the test against these". [hand, one mind]
3. **W-POLY:** "Polygonal designs of bounded complexity have `δ ≥ δ₀(K) > 0` at every slack, bar FS106-AE-POLY's `d = 2` case". [hand, one mind; over
   AE-POLY (two minds, one blind; SV-L3 a sketch)]
4. **HX-STALL:** "Family HX (hexagonal seven-colouring, colour-0 hexagon absorbed by straight triangles, a void of radius `ρ` at its centre):
   band-proper iff `ρ > max(2R − √((1−ε)² − 3R²), √((1+ε)² − 3R²) − R)` against the two named pairs (and the design's other pairs, checked at
   members); its holes stop at `δ*_HX = π/(42√3) = 0.0432`, at `R = 2/√21`, `ρ = R/2`". [hand, one mind; four members checked exactly]
   - Reconstruct the family from this statement alone.
   - Check two or more members with your own exact checker, pairing each planted fault with a faithful stub.
   - Derive the stall value yourself.
5. **W-TAN:** "In a full tight six-colouring by a locally finite map, complementary-type vertices at distance `< 2` are tangent pairs or bowties; off
   those, adjacent tiles' vertex types form an intersecting family". [derived, one mind; over C-T-TAN (one mind)]

## Known positive for your checker

The hexagonal seven-colouring, rasterised, with one class left blank, is band-proper at positive slack with uncovered density `1/7`. Build it
yourself; W's parameters are fenced.
