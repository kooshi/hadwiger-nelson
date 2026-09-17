# Unit Distance Atlas

Published artifact (private until shared): **https://claude.ai/artifact/3nuVwboAbketNuWw7yRdw2** (Version 2, 2026-09-17).

An exact viewer for unit-distance graphs over the number fields in this project's record: pick a field and a denominator `N`, and
the page enumerates every unit vector whose coordinates have denominator dividing `N`, grows a piece of the plane from them (word
ball or closure, up to 3,000 points), finds every unit edge exactly, and highlights triangles, Moser spindles and a shortest odd
cycle. Built in FS-58's prelude; Kooshi's observation of ℚ(√167)'s seven-cycle in it is `plans/FS58-prelude-seven-cycle-gadget.md`.

## Files

| file | what |
|---|---|
| `core.js` | the exact field core: multiquadratic arithmetic, unit-vector enumeration, lattice growth, edges, triangles, spindles, odd cycles (also a Node module) |
| `page.tmpl.html` | the page, with the field presets (`const FIELDS`) and a `/*CORE*/` marker |
| `build.py` | inlines `core.js` at the marker → `atlas.html` |
| `atlas.html` | the built page, byte-identical to the published Version 2 |
| `test.js`, `test2.js`, `test3.js`, `pickN.js`, `leastN.js` | Node checks: unit-vector counts per field and denominator; growth and edge exactness; **every preset's default and suggested `N` completes** (`test3.js`, reading the presets from the template); the default-`N` survey; ℚ(√167)'s least denominator with an odd cycle (140, girth 7) |

## Build, check, publish

```
python3 visualizations/unit-distance-atlas/build.py
cd visualizations/unit-distance-atlas && node test3.js      # seconds; node test.js ~20 s; node pickN.js ~4 min
```
Then republish `atlas.html` to the URL above.

## Where the χ values on the page come from

The presets' `chi` and `how` texts are statements from the record, not computed by the page. As of 2026-09-17:
- **ℚ(√11): χ = 4** — lower bound in the kernel (`four_le_chromaticNumber_planeOver_eleven`, `Proofs/HadwigerNelson/Instances/SqrtEleven.lean`); **ℚ(√23), ℚ(√71), ℚ(√95), ℚ(√191): χ = 4** and **ℚ(√47): 4 ≤ χ ≤ 5** — certified witnesses in `data/fs58/witness-*/`; upper bounds through the residue planes at 7 and 11. The table with sources is `data/fplane/map.md` (last section).
- **ℚ(√167), ℚ(√1055), ℚ(√2351), ℚ(√4703)** — local bounds from `data/fplane/map.md` and `data/fs53/window.md` (five refused at 23, 43, 47 by exact certificates).
- The fields with two or more square roots — `CLAUDE.md` § Frontier (Theorem B, rows 52–57, 63–64).

**Corrections in Version 2.** The "first new direction" texts of Version 1 were wrong for ℚ(√23) (N = 8, not 12), ℚ(√47) (12, not 24),
ℚ(√1055) (80, not 108), ℚ(√2351) (88, not 1176) and ℚ(√4703) (116, not 2352): they missed directions in which both coordinates
involve √d. Verified by `tools/fs58_local.py`'s `units_d` and by hand (each named vector's squared length computed).
