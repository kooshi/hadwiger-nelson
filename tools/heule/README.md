# Published 5-chromatic unit-distance graphs — upstream data, untrusted

Vertex and edge lists copied verbatim from Marijn Heule's `CNP-SAT` repository
(<https://github.com/marijnheule/CNP-SAT>, `vtx/` and `edge/`), vendored here so the pipeline runs
without a network and so a reviewer can see exactly what was consumed.

**None of it is trusted, and none of it is load-bearing for the theorem.** `tools/heule.py` reads the
coordinates into the exact field `ℚ(√3,√5,√7,√11)` and re-derives the edge set from scratch; Lean then
re-checks every edge against the same arithmetic and re-proves non-4-colourability from a certificate
of our own. The theorem quantifies over the points *as written*, so what a reader needs is the
coordinates and the checks — never the search that produced them.

| file | vertices | edges | every listed edge exactly unit | unit-distance pairs omitted |
|---|---|---|---|---|
| `510.*` | 510 | 2504 | ✅ | 0 |
| `553.*` | 553 | 2722 | ✅ | 0 |
| `874.*` | 874 | 4461 | — (kept only as a shrinking-search subject) | — |

Radicals occurring in the coordinates: `√3`, `√5`, `√11` and their products — a subfield of the tower
`Field/Quadratic.lean` already provides.

Regenerate the exact-arithmetic form with:

```bash
tools/heule.py tools/heule/510.vtx tools/heule/510.edge -o tools/heule510.json
```
