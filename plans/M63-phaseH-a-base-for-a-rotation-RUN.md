# M63 phase H — stage 1: the five falsifiers, run

*Opened 2026-09-12 by a fresh session working from `plans/M63-phaseH-a-base-for-a-rotation.md`
(commit `448e186`). **Stage 1 only**: the five cheap falsifiers of that document's §7, then stop and
report. No construction past what a falsifier needs.*

**The two sentences carried forward, unchanged.** (1) The new rotation is **un-eliminated, not
alive** — phase G removed an obstruction, it did not produce a result. (2) The residue certificate is
**one-sided**: firing proves four-colourable, silence proves nothing.

---

## §H0 — What I am treating as inherited rather than necessary

The handoff's §4 stamps three of its six requirements INHERITED. My reading of each, before any run:

| # | requirement | handoff status | my reading |
|---|---|---|---|
| H1 | realises a live `σ` | PROVED NECESSARY | agreed, and it is the only requirement with a proof. It is what `u` buys |
| H3 | endpoint radius `≤ 1/\|sin θ\| = 2.124575` | PROVED | agreed; `u` sits at 2.0611, inside |
| H4 | ≥ 2 kinds at this angle | INHERITED (one measurement, one object) | **weaker than the handoff makes it sound, and in a direction the handoff did not notice**: the committed census already reports **2 kinds** for the new rotation on `parts_lattice` (`data/m62/rotations-exact-parts-r2.44.json`), and that arena is four-colourable at every radius. So two-kinds is *already satisfied* on the eliminated base and cannot be what separates alive from dead. The separating property is H1, the live kind. F1 is therefore a much weaker falsifier than §7 presents it as — I run it, and I say so either way |
| H5 | closed under negation and the two Galois flips | INHERITED, tooling | agreed it is tooling. I keep it anyway, because it is free here: `parts_lattice` is closed and a group orbit of `u` is closed by construction. Keeping it costs nothing and keeps the census's class key honest |
| H6 | enough unit-distance structure | INHERITED, unquantified | this is the real question, and the handoff under-rates it. `u` lies outside the ℚ-span of `parts_lattice` (proved in §H2), so nothing in that lattice is forced to be at unit distance from it. A base that contains `u` and nothing near it wins H1 and loses everything else |
| H2 | drawn in `K²` | setting | agreed |

---

## §H1 — Registered predictions (wave 1: witness and module)

| # | prediction | confidence | scored |
|---|---|---|---|
| **P-H1** | the handoff's `u` re-derives: `\|u\|² = (7+√33)/3 = 1/(2−2cos θ)` exactly, and the independent `K[x]/(x²−D)` expansion of `\|u − ρu\|²` returns rational part 1, radical part 0 | high | |
| **P-H1b** | the radical-part check is **vacuous on `v = u`** (the coefficient is `2[uₓv_y − u_yvₓ]`, identically 0 when `v = u`), so a non-collinear control is needed for it to mean anything | high | |
| **P-H2** | the ℤ-module `M = Λ_parts + ℤ⟨σu : σ ∈ Gal⟩` has rank **7**, not 8: every generator has zero `√33`-component in its **y** coordinate, and `Λ_parts` (rank 4) meets the `u`-orbit span (rank 3) only at 0 | 0.85 | |
| **P-H3** | the totally-real disk cut of that rank-7 module at radius 2.44 is **too large to hand a solver** (> 10⁵ points), so the first candidate base of the handoff's §4 is not buildable as stated | 0.7 | |

## §H2 — Registered predictions (wave 2: the falsifiers)

Registered before the runs that test them.

| # | prediction | confidence | scored |
|---|---|---|---|
| **P-H4 (F1)** | the base containing `u` carries **≥ 3** kinds at this angle — the 2 already on `parts_lattice` plus the new equal-radius kind `σ = 2(7+√33)/3` — so F1 does not fire | 0.9 | |
| **P-H5 (F2)** | `u` has **no** unit-distance neighbour in `parts_lattice(2.44)` at all: `u` is outside that lattice's ℚ-span, and a unit vector joining them would have to have a `√3`- and `√11`-component in *both* coordinates, which `Λ_parts − Λ_parts` never does | 0.8 | |
| **P-H6 (F3)** | F3 **cannot fire**, as the handoff says: adding `u` puts `(0,0)` into `Δ` and `parts_lattice` already supplies the other three, so `Δ = 𝔽₄` at both primes and no `δ` is free. I check it once and do not spend an hour on it | 0.95 | |
| **P-H7 (F4)** | the arena on `parts_lattice(2.44) ∪ orbit(u)` is **SAT** (four-colourable), because the `u`-copies are joined to the rest by too little | 0.9 | |
| **P-H8** | the generator-image check: for any family of candidate bases I enumerate, I write the ℚ-span of the generator down and confirm `u` lies inside it, before believing any zero. For `Λ_parts` the span is `{x ∈ ℚ⟨1,√33⟩, y ∈ ℚ⟨√3,√11⟩}` and `u` is **outside** it — which is exactly why the handoff's §6 sweep could not see `u` | high | |

**Honesty note on ordering.** P-H1 and P-H1b were run before this file was written; they verify a
handed-over number rather than decide an experiment, and the predicted values are the handoff's own.
Everything from P-H2 down was registered before its run.

---

## §H3 — The advisor's two corrections, verified and adopted

*Poros (advisor, 2026-09-12), verified here against `data/m62/m63-phaseG-screen-r2.44.json` and
recomputed from the kinds' `σ` rather than read off his quote. His record:
`plans/POROS-2026-09-12-m63-phaseH.md`.*

### H3.1 — F1 is struck as a falsifier, and replaced

Two independent reasons, the second of which I did not have:

1. **Unreachable.** The committed screen reports **2 kinds** for the new rotation on
   `parts_lattice`, at squared radii `5/6+√33/18`, `2+2√33/9`, `19/18+√33/6`, `43/18+5√33/18` —
   radii 1.073, 1.810, 1.419, 1.996, **all inside 2.0612**. So any base containing Parts's lattice
   at a radius large enough to hold `u` already carries two kinds before `u` is added. F1's premise
   cannot hold on the candidate of §4, at any radius it would be built at. A control that cannot
   fire has not been tested by passing (`CLAUDE.md` § "Make the gate fail").
2. **Backwards.** The certificate needs some `δ ∈ 𝔽₄` **missing** from `Δ`. The centre family
   supplies all three nonzero classes and never `(0,0)` (its `d² = 1`). Every pair inside one kind
   shares one `d²`, hence one valuation, so a kind contributes either `(0,0)` or only nonzero
   classes, never both. Surviving at a prime therefore needs **one** non-centre kind monochromatic
   there — and a base whose only non-centre kind is the diagonal is the *minimal surviving
   configuration*. F1 firing would be good news reported as bad.

**Replacement, and it is what I run:** per prime, **the number of non-centre kinds with
`v_𝔭(d²) > 0`**, which must be **≥ 1 at each of the two primes** or the certificate fires there.

### H3.2 — H1 is per-prime, and the handoff's `is_live` is stronger than the theorem

Recomputed from each kind's `σ` through `d² = σ − (σ−1)/cos θ`, then through
`residue_of_coords(d², 0, S)`:

| kind | `σ` | `d²` (at `−cos`) | prime 17 | prime 239 |
|---|---|---|---|---|
| 1 (24 ordered pairs) | `17/6 + 5√33/18` | `25/6 + 13√33/18` | **(0,0) — monochromatic** | (1,0) |
| 2 (12 ordered pairs) | `31/9 + 4√33/9` | `59/9 + 8√33/9` | (1,0) | (1,0) |
| centre family | `1` | `1` | (1,0) | (1,0) |
| `u`'s diagonal | `14/3 + 2√33/3` | `0` | (0,0) | (0,0) |

This matches the artifact's own `residue_report` exactly: at 17 `Δ` is all four classes with 24
monochromatic cross edges and `free_delta = []`; at 239 `Δ` misses `(0,0)` and the certificate
fires. **So prime 17 is already covered at this angle by material the base inherits**, and the
handoff's §5.2 `is_live` — `all(... for S in PRIMES)` — reads that kind as dead.

**The corrected statement.** The certificate fires at `𝔭` iff **no** non-centre kind is
`𝔭`-monochromatic; it is defeated iff **some** kind is monochromatic at each prime — *not
necessarily the same kind*. The handoff's H1 ("live at BOTH primes") is a sufficient condition on
one kind, mistaken for the necessary condition on the set of kinds. Credit: Poros.

**What it changes.** A new base must supply a `239`-monochromatic non-centre kind and nothing else.
Since the diagonal kind is the only one whose `σ` is pinned (`1/(1−cos θ)`, forcing radius exactly
2.0611 and hence a new lattice), and off-diagonal kinds are a one-parameter family in `λ` with free
radii, **there may be a far cheaper base than the one this phase builds**. That is a stage-2
question; it does not change stage 1.

### H3.3 — A control that could have failed: `d²` is sign-dependent, the verdict is not

`d² = σ − (σ−1)/cos θ` is **not** invariant under the sign of `cos θ`: kind 1 reads
`3/2 − √33/6 ≈ 0.543` at `+cos` and `25/6 + 13√33/18 ≈ 8.31` at `−cos`, a factor of 15. The residue
verdict is identical at both signs for every kind at both primes (eight rows checked). Forced, and
worth writing down because `is_live` takes `cos` as an argument: negating the `S` copy is the base
isomorphism between the two angles, `φ` lands in `𝔽₄` which has characteristic 2, so `φ(−v) = φ(v)`
and `Δ` is untouched — equivalently `residue(u+v) = residue(u−v) + residue(2v)` and `residue(2v) = 0`
by ℤ-linearity. **`is_live` is well defined on a rotation class even though its `d²` is not.**

### H3.4 — The unreconciled count in phase G's trust receipt, reconciled

`classes: [1728,1728,1728,1682]` sums to 6866 against `vertices: 6865`. The excess is exactly the
`S`-side copy of the centre: `Arena.full` masks out bit `(n + centre)`, while the certificate builds
its colour list over all `2n = 6866` indices and checks `2·28566 + 96 = 57228` edges — the `S`-block
edges at the `S`-centre included. The check therefore runs on a **superset** of the arena's edges,
which is the conservative direction. Harmless.

---

## §H4 — F5, answered without a run, and the affordability wall it exposes

**F5 as the handoff states it** — *"no ℤ-module in `K²` closed under the three symmetries contains
`u`"* — is false, and the handoff already says so: closure of a finitely generated module under a
finite group is finitely generated, and the totally-real disk cut of any such module is finite
because the trace form is positive definite on `K² ≅ ℚ⁸`. **Exhibited rather than argued:** the
module `M = Λ_parts + ℤ⟨σu : σ ∈ Gal⟩` has rank **7** (not 8), `u` sits in it with an integer
coordinate vector on the derived basis, and its totally-real cut is **finite and small** — 5,317
points at radius 2, 19,921 at radius 2.44 (Fincke–Pohst over the trace form, then an exact `ksign`
filter; `Λ_parts ⊂ cut` with 0 of 3,433 missing, as the positive control). F5 **does not fire**.

**But the nearby statement that IS true, and is the phase's first real constraint.** `ζ₆·u` has
`−1/12` in its `y`-`√33` slot, and every generator of `M` has zero there. So a **`ζ₆`-closed**
module containing `u` has rank **8**, whose totally-real cut at radius 2.44 is ≈ `1.9 × 10⁸` points
(volume estimate: `(πr²)⁴ / |det V|² · 12⁸` with `|det V| = 528`). **Unaffordable by four orders of
magnitude.** So:

> **The witness and the hexagonal six-fold rotation are incompatible inside one ℤ-module at any
> affordable size.** A `ζ₆`-closed *point set* containing `u` is cheap (a 24-point orbit); a
> `ζ₆`-closed *module* is not. Every base this phase can build is therefore **`ζ₆`-asymmetric**,
> and Parts's order-24 group drops to the order-8 group ⟨negation, `√3 ↦ −√3`, `√11 ↦ −√11`⟩.

This is a real loss and it is stated as one: his §5.6 lattice is organised by that six-fold
symmetry, his orbit bookkeeping uses it, and M64's overcompression result is a statement about
rungs of it. Dropping it is deliberate, not an oversight — H5's actual requirement (the census's
class key) needs only negation and the two Galois flips, and those are kept.

---

## §H5 — P-H5, answered exhaustively rather than by sweep

**`u` has NO unit-distance neighbour in Parts's lattice — at any radius, not merely inside the
disk.** An exact search over the lattice's own integer coordinates in the box
`|a| ≤ 40, |b| ≤ 8, |c| ≤ 24, |d| ≤ 14` (122,947 admissible tuples) returns zero, and the identical
search returns **30** unit neighbours of the lattice point `(1,0)` as its positive control.

**Why the box is a proof and not a sweep — the generator-image discipline applied to the search
region.** `|u − λ|² = 1` is an identity in `K`, so applying each `σ ∈ Gal(K/ℚ)` gives
`|σu − σλ|² = 1`: *every* conjugate of `λ` lies within distance 1 of the corresponding conjugate of
`u`, whose norms are 2.0611 and 0.6469. So `|σλ| ≤ 3.0612` for all four `σ`, hence
`2(a² + 33b²) ≤ (12·3.0612)²·2` and `2(3c² + 11d²) ≤` the same, giving
`|a| ≤ 36, |b| ≤ 6, |c| ≤ 21, |d| ≤ 11` — strictly inside the box searched. **The zero is
exhaustive, not empirical**, which is the one thing the handoff's §6 sweep could not say about its
own zero.

**Consequence for H6.** `u`'s unit neighbours cannot come from the inherited fabric. They exist only
in the new cosets `σu + Λ_parts`, i.e. only in material this phase adds. A base is therefore not
"Parts's lattice plus a point"; it is Parts's lattice plus at least one whole translate of it.

---

## §H6 — The base, built, and the falsifiers run at `r² = 17/4` (radius 2.061553)

*`python3 tools/phaseh_base.py --r2 17/4`, desktop, single core, ~11 min (the committed
`typem.unit_edges_fast` is the whole of it; a vectorised exact replacement, cross-checked against it
on this base's own induced subgraphs, is ~200× faster and is what later runs use).*

**The base.** `M = Λ_parts + ℤ⟨σu : σ ∈ Gal⟩`, rank 7, cut by the totally-real disk at `r² = 17/4`
— the smallest exact squared radius that admits `u` (`|u|² = (7+√33)/3 = 4.24819`).

| quantity | value |
|---|---|
| points | **6,493** |
| `u` in the base | yes |
| points of norm 1 | 30 (same as Parts's) |
| symmetry gate C1 | negation and all three Galois flips: **zero images outside** |
| C0: `Λ_parts` at this cut radius ⊆ base | yes (added as a control after this run) |
| unit edges | **27,186**, i.e. **4.19 per point** against Parts's 8.3 |
| `u`'s unit degree | **5**, and all eight points of its symmetry orbit have degree 5 |

**Cross edges at `cos θ = 11/32 + (3/32)√33`: 104 = 60 centre + 36 distinct-radius + 8 same-index.**
Three non-centre kinds, against Parts's two:

| kind | radii² | ordered pairs | `σ` | `d²` | mono @17 | mono @239 |
|---|---|---|---|---|---|---|
| inherited 1 | `5/6+√33/18`, `2+2√33/9` | 24 | `17/6+5√33/18` | `3/2−√33/6` | **yes** | no |
| inherited 2 | `19/18+√33/6`, `43/18+5√33/18` | 12 | `31/9+4√33/9` | `1/3` | no | no |
| **new, `u`'s diagonal** | `7/3+√33/3` twice | **8** | `14/3+2√33/3` | **0** | **yes** | **yes** |

**Monochromatic kinds per prime: 2 at prime 17, 1 at prime 239.** Both ≥ 1, which is the condition
§H3.1 replaced F1 with.

**F3 — the certificate, at both primes.** `Δ = {(0,0),(0,1),(1,0),(1,1)}` — all four classes — at
**both** primes; free `δ` is empty at both; 32 monochromatic cross edges at 17 and 8 at 239 (the
eight diagonal pairs). **The certificate is silent at both primes.** Which proves nothing: it is
one-sided, and this is the removal of an obstruction, not a result.

**Controls that fired.** The `ρ₁₅` calibration reproduced phase G digit for digit (`+7/8` → 60/36/30,
`−7/8` → 60/66/0, both 126). The independent `K[x]/(x²−D)` recount re-verified all 104 cross edges,
and its self-test at a deliberately wrong cosine kept only 60 of 104 — exactly the centre family,
whose condition `|ρv| = 1` does not involve `cos θ`, so the number is right for a reason and not by
luck. The wide-proposal unit-edge control gave identical exact sets at margins `10⁻³` and `10⁻²`,
and the tightened `0.999` self-test dropped all 27,186.

### Predictions scored

| # | prediction | verdict |
|---|---|---|
| **P-H1** | the witness re-derives | **met** — `\|u\|² = (7+√33)/3 = 1/(2−2cos θ)` exactly; the independent expansion gives rational part 1, radical part 0 |
| **P-H1b** | the radical check is vacuous on `v = u` | **met** — the coefficient is `2[uₓv_y − u_yvₓ]`, identically 0 at `v = u`. The check that carries weight is the rational part, and the recount's wrong-cosine self-test is what makes it non-vacuous |
| **P-H2** | the module has rank 7, not 8 | **met** — rank 7, with `y`'s `√33` slot identically zero, `u` at integer coordinates `[4,−1,0,0,0,0,0]`, and `u` provably outside Parts's own rank-4 module |
| **P-H3** | the cut is too large to solve (> 10⁵ points) | **NOT MET, and in the favourable direction** — 5,317 at radius 2, **6,493** at `r² = 17/4`, 19,921 at 2.44. I over-estimated by assuming the cut scales like the full rank-8 lattice; rank 7 in a hyperplane is an order of magnitude cheaper. The handoff's §4 candidate is buildable exactly as written |
| **P-H4 (F1)** | ≥ 3 kinds | **met** — 3, and F1 is struck anyway for the reasons in §H3.1 |
| **P-H5 (F2)** | `u` has no unit neighbour in `Λ_parts` | **met, exhaustively** (§H5). But `u` is **not** isolated in the base: degree 5, all neighbours in the new cosets |
| **P-H6 (F3)** | the certificate cannot fire | **met** — `Δ` is all of `𝔽₄` at both primes |
| **P-H8** | the generator-image check is written down and the target confirmed inside it | **met** — and it is what killed P-H3's premise and what made §H5's zero a proof rather than a sweep |

---

## §H7 — Registered predictions (wave 3: F4, before the run)

*Written while `python3 tools/phaseh_base.py --r2 113/25 --sat --solver-control --wall 3600` is
running, and before any of its output was read.*

`r² = 113/25 = 4.52` is chosen because `1/sin²θ = 4.513817`: **no point outside this radius can carry
a cross edge at this rotation**, so an arena cut here cannot be flattered by a missing cross edge.
At `r² = 17/4 = 4.25` that guarantee does not hold and a SAT would be weaker.

| # | prediction | confidence | basis |
|---|---|---|---|
| **P-H9 (F4)** | the arena is **SAT** (four-colourable) | **0.9** | two independent reasons, both registered: (a) Poros's base rate — of the eleven rotation classes phase G screened on Parts's lattice, **five are killed by the certificate and six defeat it at both primes; of those six, five are `sat` and the single `unsat` is `cos = −7/8`, which is `ρ₁₅` relabelled**. Verified here from `verdict` × `free_delta`, and no row was "not attempted" (every `usable` is `True`). So defeating the certificate produces a refusal one time in six on the only reference set anyone holds, and the one is the record. (b) This base carries **4.19 unit edges per point against Parts's 8.3**, and `u` itself has degree 5 |
| **P-H10** | the base at `r² = 113/25` has **7,500–9,000** points | 0.7 | the rank-7 cut scales close to `r⁷`; 6,493 at 4.25 and 19,921 at 5.95 |
| **P-H11** | the cross-edge count **rises above 104**, because radii in `(4.25, 4.5138]` can now carry cross edges | 0.6 | the endpoint bound is the reason for the radius; if it does not rise, the extra shell is inert and `r² = 17/4` was already complete |
| **P-H12** | the solver positive control (`ρ₁₅` on `parts_lattice(2.44)`) returns **UNSAT** | high | that arena contains Heule-510; phase G measured 12.2 s. **If it does not, no SAT from this pipeline may be believed** |
| **P-H13** | the `--no-u` control base at the same radius **fires the certificate** with free `δ = (0,0)` at prime 239 and nothing free at 17 | high | it is `Λ_parts` re-cut, and phase G's elimination is radius-free. This is the positive control for the certificate instrument: an instrument that cannot reproduce a known firing may not be believed when it goes silent |

**What a SAT means and does not mean.** It eliminates *this base at this radius*, and nothing else.
A missing edge can only make a graph easier, so a SAT is the fragile direction and is reported with
its controls discharged; an UNSAT would be robust and would be the phase's headline. Per Poros: the
informative content of a SAT is **not the verdict** but which `δ` was free at which prime and which
kinds were monochromatic at each — the difference between "this base failed" and "this base never
had a chance".

---

## §H8 — F4, run at the endpoint-bound radius `r² = 113/25` (radius 2.126029)

*`python3 tools/phaseh_base.py --r2 113/25 --sat --solver-control --wall 3600 --out
data/m62/m63-phaseH-base-r452.json`, desktop, single core, ~2 min total.*

| quantity | value |
|---|---|
| points | **7,921** |
| `Λ_parts` at this cut radius ⊆ base (C0) | **1,987 of 1,987** |
| points of norm 1 | 30 |
| symmetry gate C1 | zero images outside |
| unit edges | **34,992** = **4.42 per point** (Parts: 8.32) |
| `u`'s unit degree | **6**, uniform across its 8-point orbit |
| cross edges at the new rotation | **104** = 60 centre + 36 distinct-radius + **8 diagonal** |
| non-centre kinds | **3**; monochromatic kinds per prime: **2 at 17, 1 at 239** |
| **F3 — certificate** | `Δ = 𝔽₄` at **both** primes, free `δ` empty at both. **Silent.** |
| **C4 — solver positive control** | `ρ₁₅` on `parts_lattice(2.44)`: 6,865 vertices → **UNSAT in 10.7 s** (phase G: 12.2 s) |
| **F4 — the ask** | arena 15,841 vertices, 34,992 interior edges per side, 104 cross edges → **SAT in 2.1 s** |

### Predictions scored

| # | prediction | verdict |
|---|---|---|
| **P-H9 (F4)** | SAT | **met** — SAT in 2.1 s |
| **P-H10** | 7,500–9,000 points | **met** — 7,921 |
| **P-H11** | the cross-edge count rises above 104 | **NOT MET** — still exactly 104, the same set as at `r² = 17/4`. The shell between radius 2.0616 and the endpoint bound 2.1246 carries **no** cross edge, so `r² = 17/4` was already cross-complete and the endpoint-bound radius buys only certainty, not edges |
| **P-H12** | the solver control is UNSAT | **met** — 10.7 s, reproducing phase G |
| **P-H13** | the `--no-u` control fires the certificate at 239 | pending (running) |

### What the SAT says, stated at the level its evidence supports

**It eliminates this base at this radius, and nothing more.** The certificate was *defeated* — `Δ` is
all of `𝔽₄` at both primes, so no `δ` is free and the radius-free four-colouring of phase G is
genuinely gone. The solver nevertheless four-coloured the arena in **2.1 seconds**, against 10.7 s
for the positive control's refusal on a graph of comparable size. **A 2.1-second SAT is not a near
miss**; it is an instance nowhere near critical.

**The diagnosis points at H6 — but see §H9, which refutes the naive form of it.** Three numbers:

1. **4.42 unit edges per point against Parts's 8.32** — the base is half as dense as the fabric the
   record is built on, because five of its ~6 cosets are translates that the totally-real cut slices
   thinly.
2. **`u`'s unit degree is 6**, and with four colours a degree-6 vertex is nowhere near forced. By
   absorption (`CLAUDE.md` G40) a vertex whose neighbourhood has a spare colour carries no
   compulsion, so the eight diagonal cross edges — the entire point of the construction — hang off
   vertices that are free to move.
3. **The 8 diagonal pairs are the only new cross edges.** The 36 distinct-radius pairs are inherited
   verbatim from `Λ_parts`; the new cosets contribute no off-diagonal cross pair at all.

So the object built is: Parts's fabric, plus five thin translates of it, joined to the seam by eight
edges hanging on degree-6 vertices. **H1 is satisfied and H6 is not**, which is the configuration
Poros's base rate says produces a SAT five times in six.

---

## §H9 — The calibrated bed, and what it refutes

*The advisor's PH-8, verified here from `data/m62/m63-phaseG-screen-r2.44.json`'s
`cross.equal_radius_ordered` field, then measured further.*

**The reference set for "acquires an equal-radius kind AND defeats the certificate" is n = 2, and one
of the two is a negative.** Exactly two of the eleven rotation classes on Parts's lattice carry an
equal-radius kind at all:

| class | equal-radius ordered pairs | cross total | certificate | **solver** |
|---|---|---|---|---|
| `±7/8` (`ρ₁₅`, the record) | **30** at `\|p\|² = 4` | 126 | defeated at both primes | **UNSAT** |
| `5/16 − 3/16√33` | **18** at `\|p\|² = (7+√33)/6` | 114 | defeated at both primes | **SAT** |
| the other nine | 0 | 84–108 | five killed, four defeated | all SAT |

So **acquiring the diagonal kind is necessary and demonstrably not sufficient** — as an instance on
disk, not as an argument. It also kills a progress measure before anyone forms one: the colourable
class has **54** monochromatic cross edges at prime 239 against `ρ₁₅`'s 30, so neither the count nor
the presence of a diagonal predicts a refusal. (`d² = 0` is not a class invariant — it flips with the
sign representative, as §H3.3 shows; `equal_radii` is the field that reads it invariantly.)

**And the naive density reading of H6 is refuted on the same bed.** Unit degrees of the equal-radius
cross-edge endpoints in `parts_lattice(2.44)` (mean degree 16.64 over 3,433 points):

| class | equal-radius endpoints | radius | their unit degrees | verdict |
|---|---|---|---|---|
| `ρ₁₅` | 30 points | **2.0000** (near the rim) | **11, 12, 13** | **UNSAT** |
| `5/16 − 3/16√33` | 18 points | **1.4574** (deep inside) | **28, 29** | SAT |

**The refusing class's seam endpoints are the sparser ones, by more than a factor of two.** Local
degree at the seam does not discriminate refusal from colourability — it anti-correlates on the only
two instances that exist. Any "make the seam endpoints richer" heuristic is therefore unsupported,
and would have been the obvious next move.

**What survives of the H6 reading, stated at its real strength.** Not "denser is better", but a range
statement: `u`'s unit degree is **5 / 6 / 9** at cut radii 2.0616 / 2.1260 / 2.4495, which is below
**both** reference values (11–13 and 28–29), and this base's mean degree is 8.84 against Parts's
16.64. So the phase-H base sits outside the band in which either reference instance lives. That is a
weaker claim than §H8's first draft made, and it is the one the evidence carries.

**The phase's real open question, now with a bed attached:** *what does `ρ₁₅` have that
`5/16 − 3/16√33` lacks?* Both carry an equal-radius kind, both defeat the certificate at both primes,
one refuses four colours and one does not. Whatever separates them is neither H1 nor the certificate,
and it is the thing a base must be built to supply. One known answer is not a mechanism:
`ρ₁₅`'s arena contains Heule-510, so its refusal is inherited from a graph already known to be
5-chromatic. Credit for the bed: Poros.

---

## §H10 — The two remaining controls, and the radius sweep

*`build/phaseh-rest.sh`, desktop, single core.*

### The certificate's positive control: the same base **without** `u` (P-H13, **met**)

`--r2 113/25 --no-u` builds the rank-4 module — Parts's lattice re-cut at radius 2.126029, 1,987
points, 14,652 unit edges (7.37 per point):

| prime | `Δ` | monochromatic cross | free `δ` |
|---|---|---|---|
| `sqrt33_2adic(17)` | all four classes | 24 | none |
| `sqrt33_2adic(239)` | `{(0,1),(1,0),(1,1)}` | **0** | **`(0,0)`** |

**The certificate fires**, exactly reproducing phase G's elimination, with 2 non-centre kinds and
monochromatic-kind counts `{17: 1, 239: 0}`. Adding `u`'s orbit turns those into `{17: 2, 239: 1}`
and the certificate goes silent. **So the instrument can fire, and the thing that silences it is
precisely `u`.** This is the control that makes the silence worth reporting at all.

### The radius sweep: the verdict is not a radius artefact

| cut `r²` | radius | points | unit edges | per point | `u`'s degree | cross edges | certificate | **solver** |
|---|---|---|---|---|---|---|---|---|
| 17/4 | 2.061553 | 6,493 | 27,186 | 4.19 | 5 | 104 | silent both | (not run) |
| 113/25 | 2.126029 | 7,921 | 34,992 | 4.42 | 6 | 104 | silent both | **SAT, 2.1 s** |
| 6 | 2.449490 | 20,517 | 112,538 | 5.49 | 9 | 104 | silent both | **SAT, 43.3 s** |
| 113/25, **no `u`** | 2.126029 | 1,987 | 14,652 | 7.37 | — | 96 | **FIRES at 239** | SAT, 1.8 s |

**The cross-edge set is 104 at every radius and is the same set** — the endpoint bound
`1/\|sin θ\| = 2.124575` is real geometry, so radius 2.4495 adds 12,596 points and 77,546 unit edges
of pure padding and not one cross edge. Padding that triples the arena does not flip the verdict.

## §H11 — Stage 1, closed. The scorecard

| # | prediction | verdict |
|---|---|---|
| P-H1 | the witness re-derives | **met** |
| P-H1b | the radical check is vacuous at `v = u` | **met** |
| P-H2 | the module has rank 7 | **met** |
| P-H3 | the cut is > 10⁵ points, i.e. unbuildable | **not met** — 6,493 / 7,921 / 20,517 |
| P-H4 (F1) | ≥ 3 kinds | **met**; F1 struck anyway (§H3.1) |
| P-H5 (F2) | `u` has no unit neighbour in `Λ_parts` | **met, exhaustively**; but `u` is not isolated in the base (degree 5/6/9) |
| P-H6 (F3) | the certificate cannot fire | **met** at all three radii |
| P-H8 | the generator's image written down, target confirmed inside | **met** |
| P-H9 (F4) | SAT | **met** — 2.1 s at the endpoint-bound radius, 43.3 s at 2.4495 |
| P-H10 | 7,500–9,000 points at `r² = 113/25` | **met** — 7,921 |
| P-H11 | the cross-edge count rises past 104 | **not met** — identical set at every radius |
| P-H12 | the solver control is UNSAT | **met** — 10.7 s |
| P-H13 | the `--no-u` control fires the certificate | **met** — free `δ = (0,0)` at 239 |

**Falsifier verdicts.** F1 **struck** (unreachable, and backwards — §H3.1). F2 **does not fire** (the
base is rich; `u` is not isolated) but its sharpened form is the phase's finding: `u` has no unit
neighbour in the inherited fabric at all, so a base is that lattice plus at least one whole
translate. F3 **does not fire**, and could not — confirmed once, at both primes, at three radii.
F4 **fires**: the arena is four-colourable, as registered at confidence 0.9. F5 **does not fire** —
the module exists and is small — but the nearby true statement is that a `ζ₆`-closed module holding
`u` costs rank 8 and ≈ 1.9 × 10⁸ points, so every base this route can build is `ζ₆`-asymmetric.

**Where this leaves the direction.** The new rotation is still **un-eliminated, not alive**: the
radius-free four-colouring that killed it on Parts's lattice is genuinely gone on a base containing
`u`, verified against its own positive control, and no other colouring argument has been offered.
What is now *also* known is that removing that obstruction is not close to enough — on the only bed
that exists, a rotation can carry the equal-radius kind, defeat the certificate at both primes, and
still be four-coloured in seconds.
