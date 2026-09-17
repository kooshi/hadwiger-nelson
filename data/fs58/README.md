# data/fs58 — the FS-58 prelude: ℚ(√167)'s seven-cycle, its family, the 3-adic barrier

Record: `plans/FS58-prelude-seven-cycle-gadget.md`. Tool: `tools/fs58_seven_cycle.py` (untrusted; exact integer arithmetic,
colourings verified edge by edge, solver refusals are the solver's claims). Regenerate everything with `./run-all.sh` — resumable:
a finished record is skipped on relaunch, a failed one is left as `<name>.tmp`; the whole run takes about two minutes on the desktop.

| path | what | trust |
|---|---|---|
| `census-140.out`, `census-420.out` | every 7-cycle through the origin of `Cay(Λ_N, W_N)` up to edge order: four multisets, one shape (a run of three unit edges plus two 7–24–25 diamonds) turned by quarter turns; the triangle's exact squared sides and apex angle under each pairing | exact |
| `census-2184.out` | the same at 2184: 32 multisets of seven distinct directions, no straight run | exact |
| `least-denominator.out` | odd girth of `Cay(Λ_N, W_N)` for N ≤ 140 by breadth-first search to 400,000 points: 140 is the least N with a 7-cycle | exact within the cap |
| `family.out` | exact constructions of the isosceles run-plus-diamonds gadget in ℚ(√7), ℚ(√15), ℚ(√31), ℚ(√39), ℚ(√55), ℚ(√71), ℚ(√87), ℚ(√167); the fields D ≡ 7 (mod 8) below 400 holding it with a diamond cosine of denominator ≤ 200,000, against the proved Legendre conditions (7/D), (15/D) | exact constructions; the search is bounded |
| `residue-3.out` | UD(𝔽₉, 2): not 2-colourable, 3-coloured by the linear rule x₀ + x₁ + y₀ (checked on all 324 edges); the pulled-back rule (a + b + c)·m⁻¹ mod 3 nonzero on all 432 unit vectors of W_m for eight 3-free m; UD(𝔽₂₅, 2) and UD(𝔽₄₉, 2) refuse 3 and 4 colours | verified colouring; the refusals are CaDiCaL's claims |
| `union-R140-5000.out`, `union-R420-5000.out`, `union-R84-50000.out`, `union-R420-50000.out` | the gadget in every rotation of W_R, glued along edges to the point cap, with every exact unit edge: counts, directions with 3 in the denominator, additive ℤ/3 colourings, and 3-colourability | SAT models verified on every edge |
| `run-all.sh`, `run-all.log` | the regeneration script and its last log | log |
