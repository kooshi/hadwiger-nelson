# The multiquadratic handoff — verified (de Bruijn, 2026-09-11, FS-36)

The three files beside this note:

| file | what it is |
|---|---|
| `handoff.md` | the handoff Kooshi brought from his conversation with ChatGPT (OpenAI) on 2026-09-11, byte-identical to the upload |
| `handoff_check.py` | the main session's exact re-check of the handoff, filed here; one line tidied (below) |
| `independent_check.py` | written for this note; it shares no helper with `handoff_check.py` and encodes the mathematics differently (below) |

Nothing here was taken on trust from the handoff or from the main session's summary of it: each claim was
re-derived by hand, re-measured with this repository's own tools, or both. The plan that consumes this note
is `plans/FS36-multiquadratic-decomposition.md`.

## 1. The runs

Desktop (32 cores, 125 GB), CPU seconds as user + sys.

| script | checks | CPU seconds |
|---|---|---|
| `handoff_check.py`, as received | 43,488 passed (16,288 decomposition instances, 13,288 rule instances) | 67.6, 68.3, **67.1** (three runs) |
| `handoff_check.py`, tidied | 43,488 passed | 67.8 (one run) |
| `independent_check.py` | 36,679 passed (15,288 decomposition instances, 13,287 two-colour instances) | 16.0 (one run, after FS-36's domain pass added §5; 36,673 and 16.5 s before it) |

**The tidy.** `rule16`'s first branch read `return True if not [d for d in ds if d % 2 and d % 8 not in (1, 3)] else False`
inside `if any(d % 8 not in (1, 3) for d in ds if d % 2):`. The branch condition makes that list nonempty, so the
line always returned `False`; it now says so. The rerun is green with the same count.

**How `independent_check.py` differs.** `handoff_check.py` reads a 2-adic square class off `d mod 8` as a tuple of
bits. The independent script instead decides squareness in `ℚ₂` by brute force modulo `2³ … 2¹²`, which
re-verifies the mod-8 criterion on every odd unit below `2¹²` rather than assuming it. It names a local class by its
representative in `{1, 3, 5, 7, 2, 6, 10, 14}`, and it holds square-class groups as `𝔽₂` row spaces over the prime
basis, with ranks from Gaussian elimination. It also checks three things the first script does not:
- the screening rule on all 256 patterns of local classes, which is a proof rather than a sample;
- the ramification step behind the two-colour criterion, on all 16 subgroups of the local group;
- the exact set of fields on which the field-wall note's old two-colour condition and the corrected one disagree;
- (§5, added by FS-36's domain pass) that **the splitting needs only `[2]`**: every one of the 16 local subgroups that
  holds `[2]` is the sum of its parts inside `{1, 3, 2, 6}` and inside `{1, 3, 10, 14}`, and the subgroups that do not
  split are exactly `{1, 5}`, `{1, 7}` and `{1, 3, 5, 7}`.

## 2. The claims, one by one

| # | the handoff's claim | status here | how it was checked |
|---|---|---|---|
| 1 | `χ(K²) = 4`, `K = ℚ(√3, √11)` (§3) | **kernel** — a reproduction | `chromaticNumber_seamPlane`, ledger row 57 |
| 2 | the dyadic bound: `[−1] ∉ V₂(F)` gives `χ(F²) ≤ 4` (§3) | **hand**, already the project's | `plans/FIELD-WALL-THEOREM.md` §6.1–6.2, grokking G35. The sketch is Theorem A(i) plus "a multiquadratic extension of `ℚ₂` has residue degree at most 2", which is right. The kernel holds it only for an explicit valuation subring; the field-level statement is the gap in `plans/A1-theorem-A-kernel.md` §R2 |
| 3 | the coordinates `u = x − y/√3`, `v = 2y/√3` with `x² + y² = u² + uv + v²` (§3) | **hand**, checked | expand: `u² + uv + v² = x² + y²(1/3 − 2/3 + 4/3)`. The form `u² + uv + v²` is anisotropic over `𝔽₂` because `t² + t + 1` has no root there |
| 4 | the two-colour criterion: `[−1], [3] ∉ V₂(F)` gives `χ(F²) = 2` (§3) | **hand**, re-derived; **new to the project**; the valuation-subring mechanism is in FS-36's kernel skeleton | when `[−1] ∉ V`, the extension `E(i)/E` is ramified exactly when `[3] ∉ V`. Checked on all 16 subgroups with `e = \|V\|/f`, where `f = 2` exactly when `[5] ∈ V` (the unique unramified quadratic extension of `ℚ₂` is `ℚ₂(√5)`). The handoff's one-line argument ("an unramified `L/E` would force the *missing* class `[5]` in, hence `[3]`") leaves the case `[5] ∈ V` implicit: there `E` already has residue degree 2, so `L/E` cannot be unramified. The argument is right |
| 4′ | the main session's converse, so an iff: for a real multiquadratic `F`, `χ(F²) = 2` exactly when no odd element of its square-class group is `≡ 3 (mod 4)` | **hand**, re-derived | `[3]` or `[−1]` in `V` means an odd `e ≡ 3 (mod 4)` in `W`, so `ℚ(√e) ⊆ F`, and `[Fischer1990]` Thm 8 says `ℚ(√e)²` is not 2-colourable. Local form = global form on 13,287 square-class groups; local form vs Fischer Thm 8 at every squarefree `N < 1000` |
| 5 | the odd-prime reduction (§3) | **hand**, prior art | `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]`, `[Madore2015]` Cor. 3.4; the same argument as `reference/Chat-analysis/VERIFICATION.md` §1 (ledger row 52) |
| 6 | the screening rule for several roots at once: odd roots `≡ 1, 3 (mod 8)`; even roots all in `{2, 6}` or all in `{10, 14}` mod 16 (§4) | **proved by exhaustion** | on all 256 patterns of local classes, plus the correspondence "class ∈ `{1, 3}` ⟺ `d ≡ 1, 3 (mod 8)`; class ∈ `{2, 6}` ⟺ `d ≡ 2, 6 (mod 16)`; class ∈ `{10, 14}` ⟺ `d ≡ 10, 14 (mod 16)`" on every squarefree `d ≤ 1000`. Also sampled on 13,288 fields by `handoff_check.py` |
| 7 | the mod-11 rule (§4) | **checked** | `handoff_check.py`, 13,288 fields. Writing `d = 11ᵉu` and testing `u` is right only because `√11 ∈ K`, so the class of `u` lies in the group whenever that of `11u` does |
| 8 | the example table (§4) | **all nine rows derived** | the rows with value 4 keep the wall. The rows with value 5 break it, are usable at 11, and contain `√5` or `√247`. Status of each bound: <br>• the upper bound 4 is the dyadic criterion, a hand proof; **no usable odd prime below 100** exists for `K(√35)`, `K(√2,√35)` or `K(√10,√35)` (`tools/fplane.py usable`), so the criterion is their only upper bound; <br>• the lower bound 4 is the Moser spindle (kernel, for every field containing `K`); <br>• the upper bound 5 is the 11-plane reduction (hand; `χ(UD(𝔽₁₁,2)) = 5` is kernel-checked); <br>• the lower bound 5 for a field containing `√5` is Heule-510 (kernel), and for `K(√247)` it is the T20 / `[ExooIsmailescu2019]` witness (ledger row 47, **tools**) |
| 9 | `K(√14)` and `K(√70)` each 4-chromatic, compositum 5-chromatic (§4) | **checked**; **new to the project** | both keep the wall; `√5 = √70/√14`; the compositum is usable at 11 (`fplane.py usable --rads 3,11,14,70` → `[11]`) |
| 10 | de Grey's field `D = K(√5, √7)`: `5 ≤ χ(D²) ≤ 7`; `D = L(√5)`; `AB = D(√2)` with `A = K(√2,√35)`, `B = K(√10,√35)` (§5) | **checked** | the pieces of the square-class group of `D(√2)` are exactly the groups of `A` and `B`; `√5 = √10 · √2/2` and `√7 = √35 · √5/5`; `D` has no usable prime `≡ 3 (mod 4)` below 100 |
| 11 | the decomposition theorem and its proof (§5) | **proof checked by hand; sampled on 16,288 + 15,288 fields**; **new to the project** | the proof is right, and **its two-case split is unnecessary**. If `U_A ⊆ ρ(W)` and `U_A + U_B` is the whole local group, then every `w ∈ W` has `ρ(w) = a + b`; lift `a` to `w_a ∈ W`, and `w − w_a` lands in `U_B`. **Red:** without `√2` the split fails, for example over `K(√7)` (`independent_check.py`) |
| 12 | the six-colour cutoff: `(p+1)² ≤ 4p(k−1)²`, largest usable `p ≡ 3 (mod 4)` for six is 83 (§6) | **checked, and sharpened** | the inequality and 83 are right. The exact Hoffman floors from `tools/fplane.py spectral --all-below 100` are `χ ≥ 6, 6, 7, 6, 6` at `p = 59, 67, 71, 79, 83`. So **`p = 71` already refuses six colours by its exact spectrum**, which the Weil estimate cannot see. This matches `plans/M61-local-global-tightness.md` §S2 |
| 13 | the prime table: 11 and 83 for `K`; only 11 for `K(√5)`; the blocking units 5, 3, 11 (§6) | **checked** | `independent_check.py` and `tools/fplane.py usable`: `K` → `[11, 83]`, `K(√5)` → `[11]`, `K(√7)` → `[83]`, de Grey's field → none. Every blocking unit is a non-residue at every prime of its row, and its root lies in `K(√5)` |
| 14 | `B(F) = 5` or 7 by whether `[−1] ∈ V₁₁(F)`, for `F ⊇ K(√5)` (§6) | **consistent** | de Grey's field is in the second case: 7 is a non-residue mod 11 |
| 15 | reference [3], Brittenham–Pakianathan (§6, §8) | **the paper exists and supports half the sentence** | arXiv:2401.04814 v2, published as *Canad. J. Math.* 77(5) (2025) 1664–1685. Its Theorem 3.1 gives the eigenvalues of the finite Euclidean distance graphs as (twisted) Kloosterman sums, and its §4 quotes `\|K(1, α)\| ≤ 2√q` for `q` an odd prime. It says nothing about colourings or Hoffman's bound, and the bound itself is Weil's (`[Weil1948]`). Read through a fetched HTML rendering of v2 (`BIBLIOGRAPHY.md`) |
| 16 | the five-chromatic graphs' coordinate fields per `[ExooIsmailescu2019]` §5 (§2) | **consistent, §5 not re-read** | de Grey's 1581 in `ℚ(√3,√5,√7,√11)` and Heule-510 in `ℚ(√3,√5,√11)` are kernel facts here (`Instances/FinitePlane11.lean`, `heule510_coordsIn_sevenFree`); the bibliography row for that paper records §2, the conclusion and the references as read, not §5 |

## 3. What this filing found beyond the handoff

- **`plans/FIELD-WALL-THEOREM.md` Proposition 6.4 grants two colours too narrowly** and its example line lists
  `ℚ(√5)` under four colours. The corrected condition is `[−1], [3] ∉ V₂(F)`. The old condition, "residue field
  `𝔽₂`", is still sufficient, and the two differ exactly on the groups containing `[5]` (`independent_check.py`,
  all 16 subgroups). The correction is recorded in that note's §10.2.
- **A latent bug in `tools/fplane.py usable`.** It tests each radicand separately and accepts a radicand
  `≡ 0 (mod p)`. So `--rads 22,33` passes at `p = 11`, although `22 · 33 = 11² · 6` and 6 is a non-residue mod 11.
  The correct test runs over the whole square-class group, as both scripts here do. No field in the record has two
  radicands divisible by the same usable prime, so no recorded result is affected as far as this check found.
  The fix belongs to FS-27's remainder, not to FS-36.
- **The multiquadratic two-colour criterion answers, for one class of fields, two questions posed in print**:
  - `[Krebs2022]` Remark 2.3: *"It might be interesting, however, to try to find necessary and sufficient
    conditions for UD(F, n) to be bipartite for such fields"* (characteristic zero). The same remark quotes
    `[Fischer1990]` Theorem 8 with the wrong congruence: *"N is not congruent to 2 (mod 3)"*, which is Theorem 9's
    hypothesis. Theorem 8's is `N ≢ 3 (mod 4)`.
  - `[Fischer1990]` §1: *"whether some algebraic criterion can be found to determine the chromatic number of F²"*.

  The prior-art position is in FS-36's §PA. Two works that could hold the multiquadratic statement are unread:
  `[AxenovichEtAl2014]` (not held) and `[Johnson2006]`.
- **`[Madore2015]` Proposition 3.9 (`χ(ℚ(√2)²) = 2`) is `[Fischer1990]` Theorem 8 at `N = 2`**, with a proof over
  `ℚ₂(√2)`. Its "slight difficulty", that unit vectors there are not integral coordinate-wise, disappears in `F(i)`,
  where a unit vector is integral. That is the formulation FS-36's two-colour theorem uses.

## 4. What is and is not certified

| statement | status |
|---|---|
| `χ(K²) = 4`; `χ(UD(𝔽₁₁, 2)) = 5`; `χ(Heule-510) = 5` | kernel (rows 57, 53) |
| the two-colour residue criterion in valuation-subring form; the square-class splitting; the field containment `ℚ(√D) ⊆ A · B`; `χ ≥ 4` for each piece's plane; the wall predicate on each piece | skeleton, FS-36 (`plans/FS36-multiquadratic-decomposition.md`); kernel once implemented |
| `χ ≤ 4` for each piece; `χ = 2` for a multiquadratic field meeting the criterion | hand — the 2-adic criterion at the field level, gated on `plans/A1-theorem-A-kernel.md` §R2 (stubbed as FS-37) |
| the converse half of the two-colour iff | hand — `[Fischer1990]` Thm 8 on the quadratic subfield |
| every sampled or exhaustive check in §§1–2 | tools — untrusted, like all of `tools/` |

## 5. Credit

**The decomposition** (handoff §5): *a corollary of the 2-adic four-colour criterion (`plans/FIELD-WALL-THEOREM.md`
§6.2), stated and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11; no prior statement found
(searches in `plans/FS36-multiquadratic-decomposition.md` §PA).* This names the criterion by where it is written
rather than as "the project's", because its mechanism is `[Fischer1990]`'s and `[Madore2015]`'s. It also carries
the search's negative with it.

**Everything else in the handoff** is either a reproduction — `χ(K²) = 4`, the dyadic bound, the odd-prime
reduction, de Grey's field as a candidate for six — or the conversation's working, listed above with its status.
The two-colour criterion (item 4) is the conversation's statement; the iff (item 4′) is the main session's
one-line addition.
