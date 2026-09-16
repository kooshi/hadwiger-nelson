# data/fs54 — FS-54, twenty-seven: what each file claims, and how to check it

The plan is `plans/FS54-twenty-seven.md`; the stub `plans/STUB-twenty-seven.md`. Every set below is re-checkable with
`tools/fplane_review_verify.py`, which rebuilds `UD(𝔽₂₇,2)` from the number 27 and the modulus with its own arithmetic
and shares no code with any tool that produced a set:

    python3 tools/fplane_review_verify.py indep --q 27 --modulus t^3-t-1 --json <file> --path <key>

**Verdict words.** *found N* — a verified independent set of N points, a lower bound on α and nothing else. *largest,
exhaustive* — every candidate of the stated shape was examined and the maximum is exact (with the engine named and, where
it matters, a second engine agreeing). *largest, solver's word* — one solver proved it (CP-SAT's `OPTIMAL`), untrusted until
a second engine agrees. *found N, bound B* — CP-SAT's `FEASIBLE`: the best found and the solver's own upper bound, nothing
refuted in between. *undecided at budget* — CaDiCaL's `UNKNOWN`: says nothing about the graph.

| file | what it says | trust |
|---|---|---|
| `structure.out` | output of `tools/fs54_structure.py`: edge digest; every edge in exactly one (collinear) triangle; the 14 directions a cap in `PG(5,3)`; the spectrum with multiplicities and `λ = 3m − 14`; Kloosterman sums and Moisio's elliptic curves (largest has 36 points); `|Aut| = 122,472` by nauty | exact, each line an assertion |
| `fields.out` | output of `tools/fs54_fields.gp`: every number field of degree ≤ 4 and `|disc| ≤ 20,000` (PARI `nflist`), the smallest per window member and degree whose first usable plane is that member with no four-colour bound at 2 — primes above 2 classified in `F(i)/F` (ramified → χ ≤ 2 at any norm, so odd-degree fields are 2-colourable; inert → a 4-colourable residue graph): 23 → `ℚ(√167)`, 31 → `ℚ(√1055)`, 43 → `ℚ(√4703)` (usable 43, 47, 79), 47 → `ℚ(√2351)`; 27 needs even degree ≥ 6, smallest found the disc-316 cubic joined with `√79`; the stub's `ℚ(√3,ρ)` refuted (usable at 11) | exact (PARI 2.17.4) |
| `periodic-alpha-q27.json` | the largest independent set that is a union of cosets of an `𝔽₃`-subspace of dimension 4, 3, 2: **81, 108, 117** — *largest, exhaustive* (every unit-free subspace, orbit-reduced; each orbit's quotient maximum by branch and bound AND re-derived by CaDiCaL, `tools/fs54_periodic_sat.py check`, 0 mismatches over 461 orbits); `by_dim.<k>.best_witness_set` is a witness | exact; witnesses verified |
| `kamis-smoke/alpha-q27-kamis.json` | KaMIS `redumis` (outside code): *found 117* on seven seeds of seven, every set invariant under an order-9 translation; `online_mis` 104 | found; verified |
| `symmetric/prime-order-classes.json` | GAP: the 15 conjugacy classes of subgroups of prime order of `Aut` (orders 2, 3, 7) with their orbits on points; GAP checks `|G| = 122,472` first | exact |
| `symmetric/prime-order-alpha.jsonl` | per class, the largest independent set invariant under it (CP-SAT, one line per class, resumable — `symmetric/RESUME.md`) | *found N, bound B* or *solver's word* |
| `environment.md` | the venv, KaMIS build, versions, and two machine traps (`LIBRARY_PATH` breaks non-Lean C links; OR-Tools and cvxpy clash over `libhighs.so.1`) | — |

**The one number to carry away:** every independent set found by any method so far — exhaustive periodic search, KaMIS,
symmetric CP-SAT — has **at most 117** points. Six colours at 27 need **122**; five need 146; the exact certificate allows
147.
