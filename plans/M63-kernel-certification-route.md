# The kernel-certification route, priced on a real object (M63, 2026-09-11)

**Status: the certification was cancelled before any certificate was built.** Kooshi's call, the
same evening: *"cancel the certification, just record it. It's not really worth much to just thin
his graph."* The object was `[Parts2020a]`'s own 509-vertex graph with 163 of its 2442 edges deleted
— a real measurement, and below the 2406 of `[deGreyParts2023]` footnote 2, but a thinner copy of
his graph rather than a smaller graph of ours. This file is what was learned about the *route*,
which is what will matter when the object is one we found.

Nothing here is a certificate and nothing here was committed as Lean. The generated modules were
produced, measured, and deleted; every number below is measured on this machine (the desktop,
32 cores, 125 GB) unless it says projected.

## 1. The question that was actually open

**Can a 3.7 GB LRAT refutation go through this repository's kernel-checkable pipeline?**

**As produced, no — and the size was self-inflicted.** The refutation on disk
(`build/m63d2/greedy509.lrat`, 3.7 GB, 7,699,212 additions) was solved from an **unpinned** formula.
Its census is **442,007,385 hint entries**. At the repository's measured kernel rate that is 170–360
CPU hours, and as Lean source it is on the order of 1.2 GB — past the elaboration cliff M06 hit at
de Grey's scale (`plans/M06-chi-ge-five.md` § 0: 1.5 × 10⁹ hints ≈ 4 GB of literals, which does not
elaborate at all). A proof that size is not checkable here, and no amount of segmenting fixes it.

**Pinned, yes, comfortably — and this was demonstrated, not argued.** The whole difference is one
lemma. The pinned refutation emits to 468 modules and 81.3 MB, and one of its segments was put
through the kernel and accepted (§ 3). The 3.7 GB figure measures the absence of a pin, not the
difficulty of the graph.

## 2. The levers, measured on this object

| lever | factor here | for comparison |
|---|---|---|
| **naming one triangle's colours** (`exists_perm_apply_eq`) | **31×** — 442,007,385 → 14,251,921 hints | 20× on Heule's 510 (`plans/M07-shrinking.md`) |
| the emitter's own backward trim | **1.67×** on steps, 1.56× on hints → **9,113,753** | 2.04× on de Grey |
| racing solver configurations | **~1.05×** — it did not reproduce | 10.5× on Heule's witnesses |

**The configuration race is the finding worth carrying.** 39 runs over 16 pinned triangles × 4
CaDiCaL configurations spanned 13.9× overall (13,592,632 to 189,491,045 hints), so the choice
*can* cost you an order of magnitude — but the best was only **4.6%** under the first triangle
tried, and the losers were the ones to avoid rather than the winner being worth hunting. Sorted
results: `wide-results-final.txt` in the session scratch (not committed; regenerable in ~20 minutes).
Pin first, race briefly, and do not expect the 10.5× the Heule witnesses gave.

**The transferable rule: pin a triangle before you ever log a proof.** The 3.7 GB file cost 1,250
solver seconds and was 31× larger than it needed to be; the pinned solve takes **11 seconds** and
112 MB. A unit-distance graph always has triangles (786 here) and never a K₄ (four plane points are
never pairwise unit-distant — ledger row 58), so three pinned vertices is the ceiling.

## 3. The shape it would have taken

Mirror of `Instances/Heule510/`, which is the pattern for a witness that refutes whole:

```
Instances/Parts509.lean          hand-written: guards, negative control, geometry claims
Instances/Parts509/Table,Edges   emitted by tools/emit_cert.py   (--chunk 179 --per-module 2)
Instances/Parts509/Diffs,Valid   emitted by tools/emit_diffs.py  (the packed difference witness)
Instances/Parts509/Cnf/          emitted by tools/emit_mask.py   (--segments 450 --table-modules 16)
Instances/Parts509/Bound.lean    hand-written: the pinned-triangle gadget, χ(ℝ²) ≥ 5
```

Emitted and measured: **183,311-clause table, 173,684 kept steps, 9,113,753 hint entries, 468
modules, 81.3 MB of source.** Against de Grey's family (1,240 modules, 397 MB, 15.0 CPU hours) this
is a quarter the size; against Heule-510's (88 modules, 13 MB) it is six times larger.

**Kernel cost: 5.36 CPU hours, measured — and one segment of this certificate really was
kernel-checked.** `Seg200` (18,691 hints, mid-proof) elaborated to `exit 0` in **39.6 CPU seconds**
at a **8.90 GB peak**, which is **2.12 ms per hint entry** and **5.36 CPU hours** over all
9,113,753. So the route is demonstrated on this object rather than projected: the checker accepts
this certificate's segments, and only the remaining 449 were never paid for.

The 2.12 ms lands where the table size said it would — between Heule-510's 1.35 ms at a
33.5k-clause table and de Grey's 2.93 ms at 317k, ours being 183k. **The emitter's own projection of
3.42 h is 1.6× optimistic** because it hardcodes 1.35 ms; read its figure as a lower bound and
scale by your table size.

**Memory, not time, sets the build width — 8.90 GB for one segment.** That is the number that
decides everything about scheduling: `BATCH=10` would ask for ~89 GB and `BATCH=4` for ~36 GB, so on
the 125 GB desktop with other work running the width is 4–8, and the wall clock is about 40–80
minutes rather than 5.4 hours. A segment count above 450 would trade memory for module count if a
narrower machine ever needs it.

## 4. The geometry was free, and the map is worth keeping

**36 distinct edge differences for 2279 edges**, so the packed route (`UDCert.valid_of_diffWitness`)
pays 36 squared lengths and one subtraction per edge. Emitting and elaborating it is minutes, not
hours. Any type-M object will be like this: the construction is a lattice, so the differences are few.

**The object sits inside the existing tower with no new field work.** Parts's lattice point
`(a,b,c,d)` is, in his own convention, `x = (a + b√33)/12`, `y = (c√3 + d√11)/12`; the S half is
that turned by `ρ₁₅ = (7 + i√15)/8`. Since `√15 = √3·√5` and `√165 = √3·√5·√11`, everything lands in
`ℚ(√3,√5,√7,√11)` — the M02 tower — with the √7 slots identically zero, exactly as Heule's witnesses
do. At denominator **96** all sixteen leaves are integers:

```
L half (unrotated):   x[1] = 8a,  x[√33] = 8b        y[√3] = 8c,  y[√11] = 8d
S half (times ρ₁₅):   x[1] = 7a,  x[√5] = -3c,       x[√33] = 7b, x[√165] = -d
                      y[√3] = 7c, y[√11] = 7d,       y[√15] = a,  y[√55] = 3b
```

Basis index is a bitmask over (√3, √5, √7, √11) — bit 0 is √3, so √15 is index 3, √33 index 9,
√55 index 10, √165 index 11.

**The check that makes this trustworthy, and the one to repeat on any future object:** the vertex
ordering was not taken on faith from the search code. The edge list was recovered *from the DIMACS
file the solver actually refuted*, the coordinates were rebuilt independently from the formula
above, and then all 2279 pairs were verified to be exact unit distances — 2279 integer identities
that a wrong ordering could not satisfy. Separately, regenerating the unpinned CNF from the
recovered edge list reproduced `build/m63d2/greedy509.cnf` **byte for byte**, which closes the loop
between "the object I would certify" and "the object that was refuted". Do both on the next one.

## 5. What to do differently on the object we find ourselves

1. **Pin before proving.** Solve pinned from the first refutation you intend to keep; a triangle and
   `exists_perm_apply_eq` cost one lemma and bought 31× here.
2. **Census the proof before emitting.** Hint entries, not file size or step count, are the kernel's
   bill; 3.7 GB and 442M hints is a different object from 112 MB and 14M.
3. **Recover the graph from the refuted DIMACS, not from the search.** It is free, and it converts
   "the generator says so" into an identity the kernel re-checks.
4. **Price the table, not just the hints.** Per-hint cost moved 2.2× with table size in this
   repository's own measurements; a projection quoting 1.35 ms at a 183k-clause table is optimistic.
5. Expect the geometry to be minutes and the refutation to be hours.
