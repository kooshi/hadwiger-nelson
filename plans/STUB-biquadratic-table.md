# FS-48 — Extensions of ℚ(√2,√3): the ℚ(√3,√d) table, explicit rhombus chains, and the fields where the three-colour theorem is non-constructive (STUB, 2026-09-14; Kooshi: explore derivations and extensions of the ℚ(√2,√3) result)

**Re-aimed at FS-91's close.** Three colours are decided for every multiquadratic (indeed every real number) field: `χ = 3` iff non-bipartite and some prime above 3 has residue field `𝔽₃` (row 99). What remains is the four- and five-colour table.

> **Re-aimed at FS-81's close (2026-09-24): extended to multiquadratic fields without √3** (close inventory item 28). FS-81's
> theorem (`LEDGER.md` row 82) decides three colours over every multiquadratic field, with or without √3: residue degrees there are 1 or
> 2, so FS81-T7's residual case cannot occur, and `χ(F²) ≥ 4` iff `1/3 ∈ ℤ[U_F]` and `F²` is not bipartite, `χ ≤ 3` when a prime above 3
> has residue field `𝔽₃`. **First instance: `χ(ℚ(√2,√7)²) ≥ 4`** (relation `1 = 12 + 3u + 3ū − 6v₇ − 6v̄₇`, `u = (−1 + 2√2 i)/3`) — no
> √3, no four-chromatic quadratic subfield (ℚ(√2), ℚ(√14) bipartite; ℚ(√7) three-chromatic), the 2-adic wall broken, and by the
> verifier's reading its first usable planes at 31 and 47, so L ≥ 5 and the conjecture predicts at least five there [reading; re-derive
> the usable-prime list at the opening]. **The table's new columns:** for each ℚ(√a, √b) without √3, `1/3 ∈ ℤ[U]` (prime inversion at 3),
> bipartite or not, the value at three colours (decided), L, and the upper bound. The question the table raises at four colours is
> FS-59's and FS-84's at another field. Solver needs: none for the three-colour columns; SAT for any four-colour refusal. The text below
> is the stub as minted (fields with √3).

*Read beside: `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §5 (the 18-vertex graph) and
§3 (Theorem 3.1); `plans/STUB-chain-theorem.md` (FS-45, the chain lemma every witness here is an instance of),
`plans/STUB-three-colour-classification.md` (FS-46), `plans/STUB-unit-vector-ring-kernel.md` (FS-47, prime inversion, which
decides when the chain closes); `CLAUDE.md` G35 (the 2-adic wall for multiquadratic fields), G48 (the conjecture), G55;
`tools/fplane.py usable`, `tools/wall_break_test.py`; `data/fplane/map.md`.*

## 1. Mission context, in plain language

GPT Astra's 18-vertex graph over `ℚ(√2,√3)` is one instance of a recipe: with `ω = (1 + i√3)/2` and `δ = 1 + ω` (`δδ̄ = 3`), a
unit rhombus forces its apexes equal at three colours, so a chain of rhombi along unit vectors `u₁, …, u_m` with `δ ∑ u_j = 1`
plus one closing edge is a four-chromatic unit-distance graph — **in any field containing `√3` where `1/δ = δ̄/3` is a sum of
unit vectors**, i.e. where `1/3 ∈ R` (`δ̄ = 1 + ω̄` is already a sum of two). By prime inversion (FS-47) `1/3 ∈ R` **iff** no
conjugation-stable prime of `F(i)` lies above 3, i.e. iff every prime of `F` above 3 has even residue degree. And by Theorem
3.1 (FS-46) `χ(F²) ≥ 4` iff no prime of `F` has residue field exactly `𝔽₃`. The two conditions agree on every field whose primes
above 3 have residue degree 1 or 2, and **disagree exactly where some prime above 3 has odd residue degree ≥ 3** — there Theorem
3.1 says four colours are needed and the rhombus chain cannot show it. This stub does three things: writes the table for the
biquadratic fields `ℚ(√3,√d)`, builds the explicit chains, and names the first field where the theorem is non-constructive.

**The table, derived (to be verified by the tools before it is recorded).** Take `d` squarefree, `3 ∤ d` (if `3 ∣ d` the field
is `ℚ(√3, √(d/3))`). The only prime of `ℚ(√3)` above 3 is `(√3)`, residue field `𝔽₃`; in `ℚ(√3,√d)` it splits (two primes, residue
`𝔽₃`) iff `d ≡ 1 (mod 3)` and stays inert (one prime, residue `𝔽₉`) iff `d ≡ 2 (mod 3)`. So:

| `d mod 3` | primes above 3 | `1/3 ∈ R`? | `χ(ℚ(√3,√d)²)` | how |
|---|---|---|---|---|
| 1 | residue `𝔽₃` | no (a stable prime exists) | **3** | Theorem 3.1 (`L = 3`); the unit triangle |
| 2, wall standing (odd `d ≡ 1, 3 (mod 8)`) | residue `𝔽₉` | **yes** | **4** | ≥ 4 by an explicit rhombus chain; ≤ 4 by the dyadic `K₄` (Cor. 6.2's argument) — and at `d ≡ 11 (mod 32)` the upper bound is `[Fischer1994]`'s (1994), by an additive `ℤ/4` colouring of the whole plane, a second colouring beside the dyadic residue one; read with `√3d` as its 2-adic root, his functional colours every `d ≡ 1, 3 (mod 8)` sampled (`tools/fischer1994_check.py`, tools grade; G41) |
| 2, wall broken (odd `d ≡ 5, 7 (mod 8)`) | residue `𝔽₉` | **yes** | `∈ {4, 5, 6, 7}`, `≥ 4` explicit; `= L(F)` under the conjecture | the chain; the usable primes decide `L` |

Instances the record can check today: `d = 2` (Astra's graph; `χ = 4`); `d = 11` (`K`, `χ = 4` by Theorem B, and `1/3 = 2ρ + 2ρ̄ − 3`
from the Moser twist — the Moser spindle is itself a chain, M56 L7); `d = 5`: **`u = (−2 + i√5)/3` is a unit vector with
`1 + u + ū = −1/3`**, so `δ · (−1 − ω̄ − u − ū − ω̄u − ω̄ū) = 1` (checked in exact arithmetic, 2026-09-14) — six rhombi, an
18-or-19-vertex four-chromatic graph over `ℚ(√3,√5)`, the field FS-46 names as the smallest `√3`-field with the five-level open
(`L = 5` through 11); `d = 17, 41` (`≡ 2 (mod 3)`, `≡ 1 (mod 8)`): predicted `χ = 4` exactly, new values, once a chain is found
(no one-vector solution: `1 − a²` for `a ∈ {±1/3, ±2/3}` is never `17b²` or `41b²` with `b` rational, so the sum needs more
terms or other real parts); `d = 23, 47` (wall broken, 11 usable): `L = 5`; `d = 29` (wall broken, 11 not usable, 23 usable):
`L = χ(UD(𝔽₂₃))` — **FS-17's question is this field's local bound**. Even `d` is not covered by the odd-`d` congruence and is
computed, not derived.

## 2. What we know

| fact | trust | where |
|---|---|---|
| the 18-vertex graph over `ℚ(√2,√3)`, `χ = 4`, 25 of 33 edges critical | [C] twice | FS-45; `reference/…/independent_check.py` |
| the six-vector identity over `ℚ(√3,√5)` | [C] (sympy, 2026-09-14) | this stub §1 |
| `1/3 ∈ R(K)` from the Moser twist | derived | M56 §M1.7 L7 |
| prime inversion; Theorem 3.1 | hand, GPT Astra | FS-47, FS-46 |
| usable primes of `ℚ(√3,√d)` for `d = 2, 5, 17, 23, 29, 41, 47` | computed (`fplane.py usable`, 2026-09-14) | phase A records them |
| the wall for multiquadratic fields: stands iff no odd square class `≡ 7 (mod 8)` | hand (G35), kernel over subrings | `tools/wall_break_test.py` |

## 3. Derivations first

**D1 — the table as a theorem.** For `F = ℚ(√3,√d)`, `3 ∤ d`: `χ(F²) = 3` if `d ≡ 1 (mod 3)`; `χ(F²) = 4` if `d ≡ 2 (mod 3)` and
`F` has a stable dyadic prime; `χ(F²) ≥ 4` and `≤ L(F)` otherwise. Each clause names its theorem (3.1; the chain + `K₄`; the
chain + Theorem 1). Verify every `d < 100` against `fplane.py usable` and the wall test before the table is recorded, and record
it in `data/fplane/map.md`'s style under `data/fs48/`.

**D2 — the chain search.** A tool: enumerate unit vectors of `ℚ(√3,√d)(i)` of bounded height (rational points on `x² + Dy² = 1`
for `D ∈ {1, 3, d, 3d}`, by the standard parametrisation, times the sixth roots of unity), and find a shortest multiset summing
to `1/3` (subset-sum over exact coordinates; the answer for `d = 2, 5` is three vectors). Output: the chain, the graph, its
edge list, a three-colour refusal and a four-colouring, in the JSON shape of `example_qsqrt2_qsqrt3.json`. Prime inversion
guarantees existence for `d ≡ 2 (mod 3)`; the tool measures the length.

**D3 — the kernel witnesses.** Each chain is an instance of FS-45's chain lemma with `k = 3`: `four_le_chromaticNumber_planeOver
(ℚ(√3,√d))` for `d = 2, 5, 17, …` from a `decide`d 3-refusal of the finite chain, once FS-45's D2 settles how a drawing over
`ℚ(√3,√d)` is stated (a `UDCert`-like certificate with radicands `3, d`, or a direct drawing with `Real.sqrt`).

**D4 — where Theorem 3.1 is non-constructive, and what the witness is there.** Take `F = ℚ(√3, α)` with `α³ − α − 1 = 0` (`x³ −
x − 1` is irreducible modulo 3, so 3 is inert in `ℚ(α)`); the one prime of `F` above 3 has `e = 2`, `f = 3`, residue `𝔽₂₇`, odd
degree, so it is stable in `F(i)`: `1/3 ∉ R`, no rhombus chain closes, and Theorem 3.1 still says `χ(F²) ≥ 4`. The proof shows
what the witness is: a three-colouring of `F²` descends to `Cay(R/3R, H) ⊇ UD(𝔽₂₇)`, which refuses three colours (729 vertices,
a SAT ask with a proof log); so a finite witness over `F` is **a lift of a 4-critical subgraph of `UD(𝔽₂₇)` plus, for each
quotient edge, a rhombus chain realising the period** — a unit-distance graph in `F` built from the residue plane upward, the
tightness mechanism at 3 (G54) run as a construction. Build it, measure it, and put it in the kernel as the first witness
produced by a residue plane rather than filtered by one.

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| A | D1 verified for every `d < 100` with the tools; the table recorded | half a day | any `d` disagreeing with the derivation is the finding |
| B | D2 the chain tool; chains for `d = 5` (by hand above), `17`, `41`, and the shortest for `2` as the control | a day | a JSON per field, each verified by an independent script as `independent_check.py` was |
| C | D3 the kernel witnesses, after FS-45 | a day per field once the pattern is set | `four_le_chromaticNumber_planeOver` for `ℚ(√3,√5)` first |
| D | D4 the lifted witness over `ℚ(√3, α)` | 2 days | the object built and verified; its size recorded; the kernel form priced |

## 5. Registered predictions (both outcomes reachable)

| id | prediction | falsifier |
|---|---|---|
| P1 | every `d ≡ 2 (mod 3)` below 100 admits a chain of at most six rhombi | a `d` whose shortest `1/3`-sum has more than three unit vectors |
| P2 | `χ(ℚ(√3,√17)²) = 4` and `χ(ℚ(√3,√41)²) = 4`, new exact values | the wall test reading "broken" for either (then the value is open, `≥ 4`) |
| P3 (hunch) | the lifted witness of D4 is smaller than 2,000 vertices | a 4-critical core of `UD(𝔽₂₇)` above ~300 vertices |

## 6. Failure and jackpot clauses

Failure: the chain tool finds no sum for some `d ≡ 2 (mod 3)` within the height bound — then either the bound is too small
(raise it; existence is a theorem) or the derivation of the residue degree is wrong for that `d` (the finding). Jackpot: none
toward six; D4's construction is the first "residue plane upward" witness, a mechanism the record has not run.

## 7. Bearing on 6, honestly

**None on six; medium-low as mechanism, high as a table.** It turns one advisor's example into the classification of every
biquadratic plane over `ℚ(√3)` at three and four colours, names the fields where the conjecture's next level is open (`d ≡ 2
(mod 3)`, wall broken), and builds the first witness from a residue plane upward. Every object it makes is kernel-shaped.

## 8. Addresses

`tools/fplane.py` (`usable`), `tools/wall_break_test.py`, `reference/ChatGPT-local-global-tightness-conjecture/` (the JSON shape
and both verifiers), `Proofs/HadwigerNelson/Copy.lean`/`Homogeneous.lean` (via FS-45), `SquareClass.lean` (`planeOver`); records to
`data/fs48/` with a README row per file.

**Provisional bearings, updated 2026-09-22 (FS-70's close):** G68 and G69 first — for d = 23, 47 the six quartic CM subfields of ℚ(√3,√d,i) classified at 2, 3, 5, 7, 11, 13 (T5's table, `data/fs70/owner/po_cm_subfield.py` parametrised by d), then the quotient and periodic Kempe screens on every candidate lattice before any ball: FS-70 built three phases of balls on lattices the screens close in minutes. The rhombus chain at four colours (this stub's χ = 4 half) is unaffected.

**Provisional bearings, added 2026-09-23 (FS-73's close):** **G71** — the χ = 3 against χ = 4 half of this table is a three-colour question, and on any lattice of the field it is decided by the rotation set `Θ₃` (an exact tree with Farkas leaves, `plans/FS73-derivation.md` T22, T26), never by a ball and a solver; a nonempty `Θ₃` hands over a periodic colouring, an empty one refuses with a certificate far smaller than an LRAT. **The screens this stub asked for have been run for d = 23 and 47** (FS-73's classification table, `LEDGER.md` row 78, `data/fs73/table/`): for every quartic CM subfield of ℚ(√3,√23,i) and ℚ(√3,√47,i), the table's lattice (`Λ₂₄`, the span of its unit vectors of denominator dividing 24) is loose at four colours by a gapped periodic colouring at `N ∈ {2, 3, 5, 7}`, and the fixed-prime gap lemma (T14) extends that to every lattice of a subfield where a conjugation-fixed prime has a gapped target. So the rank-4 CM lattices FS-73 built there are not rigid fabric for the chain route at five colours; a five-level route for 23 and 47 needs another lattice of those subfields, rank ≥ 6 (FS-73's P4: rank 6 can be loose without a gap, L3), or a different mechanism.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/FS91-S0F-three-colours.md` §2.7, §3.1 — job J02's record: three colours over every real number field
- `plans/FS91-S0FV-three-colours-blind.md` §2.5, §3.5 — job J09's record: the blind derivation beside it
- `data/crunch-2026-09-25/reports/J02.md`, `J09.md` — the job reports
- `plans/FS91-close-inventory.md` rows 7, 12, 117 — items for this stub (row 117: its re-aim)

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 123 (`plans/FS100-derivation.md` FS100-Q35, FS100-CTL, FS100-CLS).
