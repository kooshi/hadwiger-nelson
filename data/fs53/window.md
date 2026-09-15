# FS-53 — the window, one row per member, three trust levels per cell

*The milestone's table. `plans/STUB-sixth-colour.md` §S is the plan; `data/fs53/README.md` is the per-file record log.
**Read the trust tag on every cell.** `[exact]` = exact arithmetic here, reproducible from the number `q` alone;
`[cert]` = an exact rational certificate a stranger can re-check with `tools/fplane_cert_check.py`; `[solver]` = a SAT
solver's word, untrusted; `[search]` = a local search's word — a verified object when it says *found*, and a **null at a
budget** when it says *not found*, never a refusal; `[kernel]` = checked by Lean's kernel; `[planner]` = produced during
subplanning and not yet reproducible from a committed tool.*

**The window.** A finite Euclidean plane `UD(𝔽_q, 2)` — the Cayley graph on `𝔽_q²` joining points whose difference has
`x² + y² = 1` — can be exactly six-chromatic only for `q ≡ 3 (mod 4)` of odd degree with `5|λ_min| ≥ q + 1`. Weil's
`|λ_min| ≤ 2√q` caps that at `q ≤ 97`; 71's exact spectrum fails it; 83 was refused by certificate (FS-50). **Eight
members remain, none decided.**

| q | n = q² | λ_min `[exact]` | ratio bound α ≤ `[exact]` | α, lower | α, upper | χ ≥ | χ ≤ | six needs α ≥ | frac6 | five needs α ≥ | frac5 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 23 | 529 | −7.9607 | 131.76 | **87** `[search]` | **108** `[cert]` | 5 `[cert]` | 8 `[search]` | 89 | 0.6755 | 106 | 0.8045 |
| **27** | 729 | **−8** | 162.00 | — | **147** `[cert]` | 5 `[exact]` | **7** `[search]` | 122 | 0.7531 | 146 | **0.9012** |
| 31 | 961 | −10.6665 | 240.25 | — | — | 5 `[exact]` | 8 `[search]` | 161 | 0.6701 | 193 | 0.8033 |
| 43 | 1849 | −11.9622 | 395.23 | — | — | 5 `[exact]` | 8 `[search]` | 309 | 0.7818 | 370 | **0.9362** |
| 47 | 2209 | −12.8465 | 466.39 | — | — | 5 `[exact]` | 10 `[search]` | 369 | 0.7912 | 442 | **0.9477** |
| 59 | 3481 | −14.9176 | 693.14 | — | — | 6 `[exact]` | 10 `[search]` | 581 | 0.8382 | (refused) | 1.0056 |
| 67 | 4489 | −15.0567 | 813.78 | — | — | 6 `[exact]` | 12 `[search]` | 749 | **0.9204** | (refused) | 1.1035 |
| 79 | 6241 | −17.1019 | 1099.19 | — | — | 6 `[exact]` | — | 1041 | **0.9471** | (refused) | 1.1363 |

The ceiling 7 at `q = 27` is `data/fs53/colour-q27-k7-quotient.json`: a proper 7-colouring of a 27-vertex quotient of the
plane, pulled back and verified on every edge by an independent rebuild of the field (the sweep record
`data/fs53/periodic-q27.json`, from `tools/fplane_periodic_subgroups.py`, names the subspace but carries no colouring at
`best_k_found` — a defect A0.2 repairs). The same sweep is **exhaustive** at subgroup indices
9 and 27 — 11,011 and 33,880 subspaces, 2,100 and 20,216 of them usable, **none six-colourable** — and a null at 40 DSATUR
restarts at indices 81 and 243. So no six-colouring of `UD(𝔽₂₇,2)` is constant on the cosets of any subgroup of index 9 or
27, and the finding side there must go non-periodic.

At `q = 27` the floor is the ratio bound's, `⌈729/162⌉ = 5`, and **not** the solver's: `data/fplane/chi-q27.json`
records `k = 4` UNSAT in 6.9 s, which is the same number by an untrusted route. Its `k = 5` row is `unknown` at 2,328 s.
That record's graph — 729 vertices, degree 28, 10,206 edges — is reproduced exactly by
`tools/fplane_periodic_subgroups.py`, which rebuilds the field from the body commit `a3adc46` deleted, so the committed
record and the restored producer agree on the object.

*Decided, for scale:* `χ(UD(𝔽₃,2)) = 3`, `χ(UD(𝔽₇,2)) = 4`, `χ(UD(𝔽₁₁,2)) = 5` `[kernel]`, `χ(UD(𝔽₁₉,2)) = 5` `[solver]`;
`χ(UD(𝔽₇₁,2)) ≥ 7` `[exact]`; `χ(UD(𝔽₈₃,2)) ≥ 7` `[cert]`, `α(83) ≥ 597` `[search]`, `α(83) ≤ 1051` `[cert]`
(`data/fs50/p83-refusal/cert-p83-N1051-polish-207500.json`, CERTIFIED with its exact LDL green — the last the polish loop
produced before §S13.3 stopped the solves).

**Every `[exact]` cell above is reproducible from the number `q` alone** by a committed script that shares nothing with
`tools/fplane.py`: `python3 tools/fplane_review_verify.py window` rebuilds each field (at 27 from the modulus
`t³ − t − 1`), computes the spectrum as additive character sums over the unit circle, and reprints this table's
`λ_min`, ratio bound, thresholds and fractions beside the committed ones — reproduced, 2026-09-15, all eight rows, with
the largest eigenvalue equal to the degree `q + 1` at each member as a connectivity control.

**`frac6` and `frac5`** are the fractions of the ratio bound an exact certificate must get **below** to refuse six and
five. The certificate's reach has been measured exactly three times — **0.8445 at 11** (N = 29.176808 against Hoffman
34.5496), **0.8238 at 23** (108.546075 against 131.7620) and **0.8836 at 83** (1059.834185 against 1199.4588) — so it
should refuse six at 79 and 67, refuse five at 47, 43 and 27, and decide nothing at 23, 31 or 59.

**The worst reach measured anywhere, and the first at a prime power (FS-53 phase A0.4): 0.9110 at `q = 27`** —
`147.578 / 162.000`, a **converged** value (two formulations, three solvers, agreeing to 5 × 10⁻⁴). It is *not* the
first reach at a window member: **23 is in the window** and its 0.8238 is the best of the four. So the four
measurements split two inside the window (23, 27) and two outside (11, 83), and the inside pair alone already spans
0.8238 to 0.9110 — the reach is not a function of "window or not", and reading it as one would be comparing two things
at once.
It sits above `frac5` at 27 (0.9012), so **the certificate does not refuse five there and §S6's P3 is falsified at 27**;
`data/fs53/cert-q27-N147.json` is the CERTIFIED artifact, `α ≤ 147` against the 146 five needs. Read against the other
cells, a worst-case reach of 0.9110 leaves `frac5` at 43 (0.9362) and 47 (0.9477) refusable with 2.5 % and 3.7 % of
margin, `frac6` at 79 (0.9471) with 3.6 %, and **`frac6` at 67 (0.9204) with only 0.9 %** — so **Q1's six-refusal at 67
is now marginal**, against an instrument whose reach has ranged from 0.8238 to 0.9110.

**The reach is not a property of the instrument alone: it improves with the compute spent.** At 83 it was 0.8974 at
FS-50's close (N = 1076.366454) and is 0.8836 now (N = 1059.834185, the polish loop's 134,500-iterate, CERTIFIED with its
exact LDL green), from nothing but a longer solve on the same formulation — and the loop is still tightening. So the
margin against `frac5` at 27 is **1.8 %** (0.9012 − 0.8836), not the 0.4 % the close's number gave; the margins are
+5.3 % at 43, +6.4 % at 47, +3.7 % at 67, +6.4 % at 79, and 59 remains **4.5 % out of reach** at `frac6` 0.8382.
**A cell the certificate does not reach is a fact about the instrument and the compute spent on it, never about the
plane** — and a member recorded as out of reach names its converged `N` and its gap, so a later session with more GPU
time knows exactly what it would be buying.

**`α` is the object.** These graphs are vertex-transitive, so `χ_f = q²/α` exactly and `χ ≥ ⌈q²/α⌉`; a `k`-colouring
needs `α ≥ ⌈q²/k⌉`, which is necessary and **never sufficient** — a cleared threshold means six is possible
*fractionally*, and the classes must still partition.

## The file names, fixed now

| file | what |
|---|---|
| `data/fs53/cert-q<q>-N<N>.json` | an exact rational certificate of `α(UD(𝔽_q,2)) ≤ N`, in the FS-50 wire format, accepted by the untouched `tools/fplane_cert_check.py` |
| `data/fs53/alpha-q<q>-ge<size>.json` | a verified independent set, re-verified from the definition |
| `data/fs53/colour-q<q>-k<k>.json` | a colouring run: `found` (verified proper by an independent sweep) or `not_found` with its budget, threads, seed and best conflict count |
| `data/fs53/periodic-q27.json` | the subgroup-quotient sweep at `q = 27` (`tools/fplane_periodic_subgroups.py`) |
| `data/fs53/ckpt/scs-q<q>-real.npz` | the semidefinite solver's iterate, saved every chunk — **outside `build/`**, which is scratch another agent may clean |
| `data/fs53/ckpt/round-q<q>.jsonl` | one line per rounding of that iterate's dual: iterate, float bound, exact `N`, residuals, file |
| `data/fs53/field-q<q>.json` | the designer's output: the radicands, the wall test, every usable prime ≤ 200 with its plane's status, and the exclusions |

## The designer's specification (`tools/fplane_field_design.py`, phase C.1)

**In:** a target `q`. **Out:** squarefree radicand sets `{d₁, …, d_r}` such that the real field `ℚ(√d₁, …, √d_r)` has the
2-adic wall broken (some odd square class `≡ 7 mod 8`), has `q` usable (every `dᵢ` a square or `0` modulo `q`), and has
3, 7, 11, 19 and every usable prime whose plane is known at five colours or fewer **unusable** (some `dᵢ` a non-residue).
Ramified primes count as usable (`[Moorhouse2010]` Lemma 8.2). **Four controls, each of which must be seen to fire:**
`ℚ(√3,√11)` returns `{11, 83, 131, …}`; de Grey's `ℚ(√3,√5,√7,√11)` returns `{131, 479, …}` and **not** 11;
`ℚ(√23)` returns 23, by ramification; and a planted radicand that is a square modulo every prime is refused **by name**,
not silently dropped.
