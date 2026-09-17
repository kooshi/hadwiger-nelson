# FS-53 — the window, one row per member, three trust levels per cell

*The milestone's table. `plans/STUB-sixth-colour.md` §S is the plan; `data/fs53/README.md` is the per-file record log.
**Read the trust tag on every cell.** `[exact]` = exact arithmetic here, reproducible from the number `q` alone;
`[cert]` = an exact rational certificate a stranger can re-check with `tools/fplane_cert_check.py`; `[solver]` = a SAT
solver's word, untrusted; `[search]` = a local search's word — a verified object when it says *found*, and a **null at a
budget** when it says *not found*, never a refusal; `[kernel]` = checked by Lean's kernel; `[planner]` = produced during
subplanning and not yet reproducible from a committed tool.*

**The window.** A finite Euclidean plane `UD(𝔽_q, 2)` — the Cayley graph on `𝔽_q²` joining points whose difference has
`x² + y² = 1` — can be exactly six-chromatic only for `q ≡ 3 (mod 4)` of odd degree with `5|λ_min| ≥ q + 1`. Weil's
`|λ_min| ≤ 2√q` caps that at `q ≤ 97`; 71's exact spectrum fails it; 83 was refused by certificate (FS-50). Eight
members remained when this file was written; **79, 67 and 59 have since left it**, each refused six by an exact
certificate on 2026-09-15: `α ≤ 1023` against the 1041 six needs at 79, `α ≤ 745` against 749 at 67, `α ≤ 575` against
581 at 59 — so `χ ≥ 7` at all three. **Five members remain: 23, 27, 31, 43, 47 — none decided.**

| q | n = q² | λ_min `[exact]` | ratio bound α ≤ `[exact]` | α, lower | α, upper | χ ≥ | χ ≤ | six needs α ≥ | frac6 | five needs α ≥ | frac5 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 23 | 529 | −7.9607 | 131.76 | **87** `[search]` | **105** `[cert]` (FS-56, level 3; three-point 108) | **6** `[cert]` (FS-56) | 8 `[kernel]` | 89 | 0.6755 | 106 | 0.8045 |
| **27** | 729 | **−8** | 162.00 | **117** `[search]` (FS-54) | **141** `[cert]` (FS-54, level 3; three-point 147) | **6** `[cert]` | **7** `[search]` | 122 | 0.7531 | 146 | **0.9012** |
| 31 | 961 | −10.6665 | 240.25 | **146** `[search]` | **200** `[cert]` | 5 `[exact]` | 8 `[search]` | 161 | 0.6701 | 193 | 0.8033 |
| 43 | 1849 | −11.9622 | 395.23 | **258** `[search]` | **365** `[cert]` | **6** `[cert]` | 8 `[search]` | 309 | 0.7818 | 370 | **0.9362** |
| 47 | 2209 | −12.8465 | 466.39 | **265** `[search]` | **371** `[cert]` | **6** `[cert]` | 10 `[search]` | 369 | 0.7912 | 442 | **0.9477** |
| ~~59~~ | 3481 | −14.9176 | 693.14 | 363 `[search]` | **575** `[cert]` | **7** `[cert]` | 10 `[search]` | 581 | 0.8382 | (refused) | 1.0056 |
| ~~67~~ | 4489 | −15.0567 | 813.78 | 443 `[search]` | **745** `[cert]` | **7** `[cert]` | 12 `[search]` | 749 | **0.9204** | (refused) | 1.1035 |
| ~~79~~ | 6241 | −17.1019 | 1099.19 | 578 `[search]` | **1023** `[cert]` | **7** `[cert]` | — | 1041 | **0.9471** | (refused) | 1.1363 |

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
`χ(UD(𝔽₇₁,2)) ≥ 7` `[exact]`; `χ(UD(𝔽₈₃,2)) ≥ 7` `[cert]`, `α(83) ≥ 597` `[search]`, `α(83) ≤ 1046` `[cert]`
(`data/fs50/p83-refusal/cert-p83-N1046-polish-208500.json`, CERTIFIED with its exact LDL green and reproduced at six
independent cuts of the same dual — the last, the solves being stopped).

**Every `[exact]` cell above is reproducible from the number `q` alone** by a committed script that shares nothing with
`tools/fplane.py`: `python3 tools/fplane_review_verify.py window` rebuilds each field (at 27 from the modulus
`t³ − t − 1`), computes the spectrum as additive character sums over the unit circle, and reprints this table's
`λ_min`, ratio bound, thresholds and fractions beside the committed ones — reproduced, 2026-09-15, all eight rows, with
the largest eigenvalue equal to the degree `q + 1` at each member as a connectivity control.

**`frac6` and `frac5`** are the fractions of the ratio bound an exact certificate must get **below** to refuse six and
five. The certificate's reach has now been measured five times — **0.8445 at 11** (N = 29.176808 against Hoffman
34.5496), **0.8238 at 23** (108.546075 against 131.7620) and **0.8836 at 83** (1059.834185 against 1199.4588) — so it
should refuse six at 79 and 67, refuse five at 47, 43 and 27, and decide nothing at 23, 31 or 59.

**The worst reach measured anywhere, and the first at a prime power (FS-53 phase A0.4): 0.9110 at `q = 27`** —
`147.578 / 162.000`, a **converged** value (two formulations, three solvers, agreeing to 5 × 10⁻⁴). It is *not* the
first reach at a window member: **23 is in the window** and its 0.8238 is the best of the four. So the four
measurements split two inside the window (23, 27) and two outside (11, 83), and the inside pair alone already spans
0.8238 to 0.9110 — the reach is not a function of "window or not", and reading it as one would be comparing two things
at once.
**FS-54 moved 27 past this: the level-3 relaxation (Gvozdenović–Laurent–Vallentin `L₃`, independent sets of size ≤ 4)
certifies `α ≤ 141` (`data/fs54/cert-q27-l3-N141.json`, N = 141.593, reach 0.8740), so five is refused at 27 and its floor is
six.** The three-point sentences that follow are kept as that instrument's record.
It sits above `frac5` at 27 (0.9012), so **the three-point certificate does not refuse five there and §S6's P3 is falsified at 27**;
`data/fs53/cert-q27-N147.json` is the CERTIFIED artifact, `α ≤ 147` against the 146 five needs. Read against the other
cells, a worst-case reach of 0.9110 leaves `frac5` at 43 (0.9362) and 47 (0.9477) refusable with 2.5 % and 3.7 % of
margin, `frac6` at 79 (0.9471) with 3.6 %, and **`frac6` at 67 (0.9204) with only 0.9 %** — so **Q1's six-refusal at 67
is now marginal**, against an instrument whose reach has ranged from 0.8238 to 0.9110.

**2026-09-16, q = 31, converged, and it does NOT refuse five**: `N = 200.881446 / 240.25` — reach **0.8362**, from a
solve driven to `status solved`. **α(UD(𝔽₃₁,2)) ≤ 200** (`cert-q31-N200.json`, CERTIFIED, re-run by the product owner),
against 201 before. Five needs `α ≥ 193`, so five stands at 31 and **never will be refused by this relaxation**. The
prediction was registered before the run from the observed trajectory (0.036 per 2,000 iterations against 8.2 to go)
and it held. **Three of the five members are now closed on the certificate side — 23, 27 and 31 converged, and 47
converged — leaving only 43 with an `optimal_inaccurate` certificate and therefore any headroom at all.**

**2026-09-16, q = 47, and it is the best reach ever measured: 0.7973** — `N = 371.839576 / 466.39`, from a solve driven
to **convergence** (`status solved`, res_pri 1.9e-07, gap 4.4e-08) rather than stopped at the first certificate, and the
exact bound reproduced at two independent cuts (1e-07 and 1e-06 at gram denominator 1e8). **α(UD(𝔽₄₇,2)) ≤ 371**
(`cert-q47-N371.json`, CERTIFIED by the frozen checker, re-run by the product owner; positive semidefiniteness by exact
rational Gram factorisation). It supersedes `cert-q47-N377.json`, which is kept as the weaker earlier reading.
**What it settles and what it does not:** six at 47 needs `α ≥ 369`, and 371.84 is above it, so **six is NOT refused at
47 — and never will be by this relaxation, because the value is converged rather than stopped.** What it buys is the
narrowest window in the table: **α(47) must be exactly 369, 370 or 371** for the plane to be six-chromatic, against a
best set found of 265. The same lesson applies to 31 and 43, whose certificates are still `optimal_inaccurate` and
therefore still movable; 23 and 27 are already converged and will never move under this relaxation. *(2026-09-17:* the
level-3 relaxation moved both — α ≤ 141 at 27 (FS-54, `data/fs54/cert-q27-l3-N141.json`) and **α ≤ 105 at 23 (FS-56,
`data/fs54/cert-q23-l3-N105.json`, re-run `data/fs56/q0/recheck-po.log`), refusing five at 23**; the row above carries it.*)

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

## What each member would buy: the field it hands us (2026-09-16)

**A six-colouring of a window plane is only worth what it says about a number field**, and until this
section existed no field had been named for any member — the milestone's target statement had no consumer
written down. The residue bound gives `χ(F²) ≤ χ(UD(𝔽_q,2))` whenever `F` has a prime with residue field
`𝔽_q`, so the field to name for member `q` is the smallest whose **first** usable prime is `q`.

**Two conditions, and the second is the one that bites.** The field must (i) have `q` as its first usable
residue plane — every smaller usable plane would give a better bound — and (ii) have the **2-adic wall broken**, which
means **every prime above 2 splits in `F(i)`**: a prime above 2 that is ramified in `F(i)/F` gives `χ(F²) ≤ 2` whatever
its norm (conjugation fixes the residue field, every unit vector reduces to 1, and a linear map to `𝔽₂` sending 1 to 1 is a
two-colouring), and an inert one gives a Cayley graph on `𝔽_{Q²}` that is 4-colourable at every `Q` checked (2 to 32). So
**every field of odd degree is 2-colourable** and never sees anything. Search: `tools/fs54_fields.gp` → `data/fs54/fields.out`
(PARI's `nflist`, every field of degree ≤ 4 and `|disc|` ≤ 20,000, then composita of a cubic with a quadratic field for 27).

| if this plane is six-chromatic | this field gets `χ(F²) ≤ 6` **by theorem** | its usable planes below 100 | wall |
|---|---|---|---|
| 23 | `ℚ(√167)`, disc 668 | 23, 43, 59, 67, 71, 79, 83 | broken (2 splits in F(i)) |
| 27 | needs **even degree ≥ 6**; smallest found: the cubic `x³ + 2x² − 3x − 2` (disc 316) joined with `√79`, disc 31,554,496 | 27, 43, 79 | broken |
| 31 | `ℚ(√1055)`, disc 4220 | 31, 43, 47, 83 | broken |
| **43** | **`ℚ(√4703)`**, disc 18812 | **43, 47, 79** | broken |
| **47** | **`ℚ(√2351)`**, disc 9404 | **47, 67, 71, 83** | broken |

Every field of degree 3 or 4 with `|disc|` ≤ 20,000 fails at 2. For 27, a quadratic field cannot reach `𝔽₂₇`, a quartic that
does also has an `𝔽₃` plane (three-colourable), and an odd-degree field is two-colourable — hence degree ≥ 6.

**Correction record (FS-54).** This section first named `ℚ(√2,√31)`, `ℚ(√5,√51)`, `ℚ(√10,√23)`, `ℚ(√7,√89)` and asserted
that every single-radicand field seeing a member first has the wall standing (the search stopped at small radicands), and it
proposed `ℚ(√3, α)`, `α³ = α + 1`, for 27 (usable planes 11, 23, 27, …: sealed at five by 11). A second version named the
conductor-13 cubic field for 27 and a cyclic quartic for 31, testing only "a fixed prime above 2 of norm ≤ 4" — wrong: both
have a prime above 2 that does not split in `F(i)`, so they are two- or four-colourable. The biquadratic fields still see
their members first and are recorded in `data/fplane/map.md`; they are not the smallest.

**Quadratic fields whose local bound is at least 6, each decided by one or two planes**
(`tools/fs54_quadratic_fields.gp` → `data/fs54/quadratic-fields.out`, rerun 2026-09-17 after FS-56 refused five at 23).
With `d ≤ 30,000`, **44** real quadratic fields have the wall broken and no usable plane in {3, 7, 11, 19, 31}; every one
has 23, 43 or 47 usable, and every other usable plane is ≥ 7 (certificates at 59, 67, 79, 83, the spectrum at 71, Weil from
98). So their local bound is **6 exactly when a usable one of 23, 43, 47 is six-chromatic**, and ≥ 7 otherwise. The
smallest: `ℚ(√167)` (23 or 43), `ℚ(√1319)` (23 or 47), `ℚ(√2351)` (47 alone), `ℚ(√3527)` (23, 43 or 47), `ℚ(√4703)`
(43 or 47); decided by 23 alone first at `ℚ(√5015)`, by 43 alone at `ℚ(√20807)`. *(Until 2026-09-17: 16 fields, filter
{3, 7, 11, 19, 23, 31}, deciders 43 and 47 — 23's floor was then 5.)*

**All three deciding planes are implausible on the measurements** (`data/fs53/CLOSE.md`, `data/fs53/README.md`): six at 23
needs an independent set of 89 against a plateau of 87 over about 96,000 restarts (`data/fs53/alpha-q23-ge87.json`); six at 47 needs the certificate to be 99.4 % tight, a tightness seen only at q = 7; at 43 every instrument came back empty — the independent set stuck at 258 against the 309 six needs through over three hours aimed at exactly that, the six-colour search stalled at 1,016 monochromatic edges for 2 h 52 m, the equivariant sweep 0 of 21. These are nulls at a budget, not refusals; but they mean these fields most likely have local bound ≥ 7, where the conjecture's bold form predicts seven, and their six rests on a plane the evidence argues against.

**At 43 and 47 this would be the whole prize.** Five is refused by certificate at both, so a verified six-colouring
there *is* that plane's exact chromatic number — and it would make `χ(ℚ(√4703)²) ≤ 6`, and at 47 also
`χ(ℚ(√2351)²) ≤ 6`, a theorem: **the first number field with local bound exactly 6**, predicted 6 exactly by
the conjecture. Nowhere else does one result do that.

**And no candidate field holds a Moser spindle** (G57): the spindle needs `√3` *and* `√11`, and no window
member admits both — 3 is a non-square at 31 and 43, 11 at 23, 27 and 47. Every forcer this project holds is
built from spindles or their relatives, so over a window field there is nothing to build *from*, and at 31
and 43 (where 3 is a non-square, so by Krebs `ω = 2`) not even a triangle.

## Why 27 is the only non-prime member, and why 25 and 49 are not (2026-09-16)

A residue field `𝔽_q` is usable iff **`q ≡ 3 (mod 4)`** — exactly the condition that `−1` is not a square,
which is what makes `x² + y² = 1` a non-split conic with `q + 1` points and the graph `(q+1)`-regular. When
`−1` *is* a square the conic degenerates, the circle has `q − 1` points, and the theory does not apply.

For `q = p^f` that congruence unpacks completely:

| | |
|---|---|
| `p ≡ 1 (mod 4)` | `p^f ≡ 1 (mod 4)` for **every** `f` — never usable |
| `p ≡ 3 (mod 4)` | `p^f ≡ p (mod 4)` if `f` is **odd**, `≡ 1` if `f` is even |
| `p = 2` | `q ≡ 0` or `2 (mod 4)` — never usable |

So **usable ⟺ `p ≡ 3 (mod 4)` and `f` odd**, and "odd residue degree" is not an extra hypothesis at all —
**it is the congruence restated.** (It is also why a larger field can *lose* a prime its subfield had: de
Grey's field has 11 at residue degree 2, so 11 is unusable there while it is usable over ℚ(√3,√5,√11).)

Applied to the two natural guesses:

* **`25 = 5²` — no, twice over.** `5 ≡ 1 (mod 4)`, so no power of 5 is ever usable; and `f = 2` is even.
* **`49 = 7²` — no.** `7 ≡ 3 (mod 4)` is fine, but `f = 2` is **even**, so `49 ≡ 1 (mod 4)`. This is the
  odd-degree condition doing its work: the prime is right and the degree kills it.

**And the window is exhausted.** Weil's bound refuses six from `q = 98` up, so the window lives in `q ≤ 97`.
The non-prime prime powers there are 4, 8, 9, 16, 25, 27, 32, 49, 64, 81 — and **only 27 satisfies
`q ≡ 3 (mod 4)`**. The next usable prime powers are `3⁵ = 243` and `7³ = 343`, both far beyond the cap.
**So `q = 27` is the unique non-prime member of the window, now and for good** — which is why the tooling's
prime-only assumption (`--p <PRIME>`) costs exactly one member and no more.

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
