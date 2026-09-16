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
| `cert-q27-l3-N141.json` | **the level-3 certificate**: Gvozdenović–Laurent–Vallentin `L₃` (moment matrices localised at one or two anchors, every sign pattern; 77,238 orbit variables, 102 blocks) rounded from the ADMM iterate at 16,611; `python3 tools/fs54_l3_cert_check.py data/fs54/cert-q27-l3-N141.json` (standard library, 28 s) | **CERTIFIED: α(UD(𝔽₂₇,2)) ≤ 141** (N = 141.593), so **not five-colourable, χ ≥ 6** — re-run by the PO; soundness page `plans/FS54-L3-certificate-soundness.md`; controls `d4/cert-controls.json` (21 of 21) |
| `cert-q7-l3-N14.json`, `cert-q11-l3-N28.json` | the same instrument at the calibration planes | CERTIFIED: N = 14.00000007 and 28.0715, so **α(7) = 14 and α(11) = 28 exactly** with the verified sets |
| `ladder/` | the calibrated Rust `plane-independent` ladder at 27 (free, rotation orders 2/4/7/14/28, line quotient, free again), `RESUME.md` | *found* 117, 117, 117, 106, 99, 85, 81, 117; target 122 `not_found` at every stage |
| `d4/` | the level-3 pricing, the ADMM runs (`runs/`, resume in `runs/RESUME.md`), the certificate logs and controls; `d4/README.md` | readings are floats; the certificate above is the bound |
| `wall-feedback/` | `verify.out`: `tools/fs54_wall_feedback_verify.py`, independent checks of the two outside responses to `reference/wall-at-six/WALL-AT-SIX.md` (char-2 Sidon and common-neighbour law for Q = 2…64; U₃₂'s least eigenspace = μ₃₃, the trace-to-𝔽₄ colouring, the 44 hyperplanes; λ ≡ 1 mod 4 and min \|S∩W\| = 5 at 64; inert towers at q = 3, 7, 11, 19, 23, 27 over GR(9,3), and Q = 2); `responses-appendix-script.out`: the response's own script, rerun | exact (integers; tower eigenvalues as float character sums compared to closed forms at 10⁻⁶); every line an assertion |
| `char2/` | the characteristic-2 targets U_Q = Cay(𝔽_{Q²}, μ_{Q+1}): spectra, colourings for Q ≤ 32, and U₆₄ — \|Aut\| exact, the Delsarte LP (`lp-q64.out`, 768 = Hoffman), KaMIS (`kamis-q64-seed{0..5}.json`, 512 each, verified), the stopped SAT runs; `char2/README.md` | 6 ≤ χ(U₆₄) ≤ 8; *found* 512 only |
| `d4/q47/` | level 3 at q = 47: build, controls, timing, calibration trajectories at 11/19/23/27, projection; resume `setsid data/fs54/d4/q47/solve-q47.sh gpu 0 0 600` (needs approval) | measured price, nothing solved; the 23 calibration checkpoint `d4/ckpt/calib-q23.npz` reads 105.431 < 106 (a reading) |
| `environment.md` | the venv, KaMIS build, versions, and two machine traps (`LIBRARY_PATH` breaks non-Lean C links; OR-Tools and cvxpy clash over `libhighs.so.1`) | — |

**The numbers to carry away:** every independent set found by any method — exhaustive periodic search, KaMIS, symmetric
CP-SAT, the Rust ladder — has **at most 117** points; six colours at 27 need **122**. The level-3 certificate allows **141**,
below the **146** five colours need, so **χ(UD(𝔽₂₇,2)) ∈ {6, 7}**.
