# Handoff — consolidation package P4

*Branch `consolidate/p4`, worktree `/home/kooshi/source/lean-wt-p4`, 2026-09-09. Written for someone
with no memory of this work. The subplan, with all three modeling passes recorded, is
`plans/P4-generalize-and-plane-freedom.md`.*

---

## 1. What landed

**Two things, and the second is the one that matters.**

### G3 — five theorems moved off "the integers modulo a prime" onto "a field where −1 is not a square"

`Proofs/HadwigerNelson/LocalGlobal.lean` holds the mechanism behind milestone M61: a graph that forces
two of its points to share a colour, drawn in a ring that also holds a certain square root, cannot be
reduced modulo a prime whose own plane is well behaved. Five of those theorems were stated about the
integers modulo a prime `p` with `p ≡ 3 (mod 4)`, and their proofs used that congruence for exactly one
thing: to know that `−1` has no square root there.

They now take that field property as their hypothesis. **The five old names and their exact old
statements are unchanged** — each is a one-line corollary of its general form — so nothing downstream
moved and no citation in the project's record broke. Verified by printing all five signatures after the
change.

* general forms: `sq_add_sq_eq_zero_iff_of_not_isSquare_neg_one`,
  `quadrance_eq_zero_iff_of_not_isSquare_neg_one`,
  `no_ringHom_of_spindle_radicand_of_not_isSquare_neg_one`,
  `Forces.no_hom_of_spindle_radicand_of_not_isSquare_neg_one`,
  `Forces.isEmpty_ringHom_of_spindle_radicand_of_not_isSquare_neg_one`
* the bridge: `not_isSquare_neg_one_zmod` (`p % 4 = 3` discharges the field property)

**What it buys.** The plane over a field with `27` elements already exists in this kernel — the
construction has been generic over any commutative ring since M58 — and until now no theorem in that
file could say anything about it, because every one was shaped around `ZMod`. That plane is the
odd-degree face of the project's prime sieve (Haugland's cubic field), and it is now expressible.

### E1 — every finite Euclidean plane at a prime `p ≡ 3 (mod 4)` is forced-pair-free

*New module `Proofs/HadwigerNelson/PlaneRotation.lean`; new instance module
`Proofs/HadwigerNelson/Instances/PlaneFreedom.lean`.*

**In plain English.** Take a prime `p` that leaves remainder 3 when divided by 4. Build the graph whose
points are pairs of integers modulo `p`, joining two points when the sum of the squares of their
coordinate differences is exactly 1 — the finite analogue of "two points one unit apart". Ask: can two
*different* points be trapped, so that every legal colouring with `k` colours gives them the same
colour? **No** — as long as a legal `k`-colouring exists at all. That is
`finitePlane_forces_iff : Forces (finitePlane p) k x y ↔ x = y`.

**Why it matters.** The project's record established this by hand at four primes — 3, 7, 11 and 19 —
each by exhibiting a colouring table and checking a property of it by machine. A central mechanism of
milestone M61 (grokking `G48`) takes *"the plane at `p` has no forced pair"* as a **hypothesis**. So
that mechanism could only ever fire at a prime where somebody had already solved a plane by computer,
and the record prices those computations as possibly out of reach past `p = 23`. It now fires wherever
a colouring is known: `Forces.no_hom_of_spindle_radicand_of_colorable` and
`Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable` take *"the plane at `p` is `k`-colourable"*
in place of the table.

**The proof, and a correction to the plan it came from.** `plans/STUB-explain-the-unexplained.md` set it
out in five steps whose fourth was an orbit–stabiliser count over the `(p+1)/2` lines the unit circle
misses. **That step is not needed.** The argument needs only *one* rotation that moves the period line,
and the quarter turn `(x, y) ↦ (−y, x)` always does. So:

1. A forced pair reduces to the origin: some `d ≠ 0` is a period of **every** proper colouring.
2. The quarter turn is a graph automorphism — over *any* commutative ring, with no hypothesis, since
   `(−y)² + x² = x² + y²`. So `c ∘ quarterTurn` is proper too, and `c` is also `(quarterTurn d)`-periodic.
3. `d` and `quarterTurn d` are a basis (`exists_smul_quarterTurn_eq`) — this is pure linear algebra over
   **any** field where `−1` is not a square, and is where G3's vocabulary is used.
4. Periods are closed under addition and, in a prime field, under scalars. So the circle point `(1, 0)`
   is a period — and the origin is adjacent to it, so the colouring was improper. ∎

**The vacuity guard, shipped as a red.** `Forces G k u v` means *"every proper `k`-colouring gives them
the same colour"*, so on a graph with **no** proper `k`-colouring it is true of every pair. The plane at
`p = 3` refuses two colours (the three points `(0,0), (1,0), (2,0)` form a triangle in characteristic
three), so at `k = 2` every pair of it is vacuously forced — and the module proves exactly that, beside
a positive inhabitant (`finitePlane3_colorable_three`, colouring by `x + y`). **Without the
colourability hypothesis the theorem is false, and the counterexample is in the file.**

**`Instances/PlaneFreedom.lean` re-derives all four of the record's measured primes** — not three, not a
sample. The plane at `7` had no certified colouring in this kernel, so one is built here by the existing
periodic-quotient recipe (`finitePlane7_colorable_four`, a seven-entry table). The module also
cross-checks against the two table-based theorems the record already had: `finitePlane11_forces_iff`
(M60, from one aperiodic table) and `finitePlane3_forces_iff` (M61, from **two** tables with no common
period). Both stand; the general theorem reproduces them.

### The gate

| check | result |
|---|---|
| `flock … ./scripts/build.sh` | **`build: OK`** |
| `sorry` under `Proofs/` | **none** (one match is the word inside a docstring) |
| `./scripts/axioms.sh` | **745 clean, 5 declared purchases** — the purchase count is unchanged; 20 new declarations were added to the audited surface |
| `lake lint` | **`Linting passed for Proofs`** |
| old names | all five print with their old statements |

---

## 2. Amendments I would have made to `CLAUDE.md` — quoted for pasting

*(I did not edit it; package P1 and the coordinator own it. The house rule is applied: the measurement
that found each result stays, and the derivation is added beside it.)*

### 2.1 Ledger row 55 (M60, the five-colour residue obstruction) — amend the "Measured" clause **in place**

Find, in the row's **Measured** sentence:

> the sealing planes at 3, 7, 11, 19 are ALL pairwise free at their own chromatic number (every non-unit class identified by a verified colouring, no solver verdict load-bearing)

Replace with:

> the sealing planes at 3, 7, 11, 19 are ALL pairwise free at their own chromatic number (every non-unit class identified by a verified colouring, no solver verdict load-bearing) — **and that is now a THEOREM at every prime, not four instances (2026-09-09, consolidation package P4): `PlaneRotation.finitePlane_forces_iff` — for every prime `p ≡ 3 (mod 4)` and every `k` the plane ADMITS, `Forces (finitePlane p) k x y ↔ x = y`.** The mechanism is one rotation: the quarter turn `(x, y) ↦ (−y, x)` is an automorphism of `unitQuadrance R` over any commutative ring, so if `d` is a period of every proper colouring then so is `quarterTurn d`, and over a field where `−1` is not a square those two are a **basis** — the period group is everything, the colouring is constant, and a constant colouring of a graph with an edge is improper. **The colourability hypothesis is load-bearing and the module ships its counterexample**: `finitePlane3_not_colorable_two` plus a distinct pair of `UD(𝔽₃,2)` vacuously forced at `k = 2`. `Instances/PlaneFreedom.lean` re-derives all four measured primes (with a new certified 4-colouring at `7`) and cross-checks M60's `finitePlane11_forces_iff` and M61's `finitePlane3_forces_iff`, both of which stand.

### 2.2 Ledger row 56 (M61, local–global tightness) — append to the row

> **AMENDED 2026-09-09 (consolidation package P4): the mechanism's hypothesis is discharged in general.** `Forces.no_hom_of_spindle_radicand` and `Forces.isEmpty_ringHom_of_spindle_radicand` take *"the plane at `p` is `k`-forces-free"* — a table per prime, held at four. `Forces.no_hom_of_spindle_radicand_of_colorable` and `Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable` (`PlaneRotation.lean`) take **`(finitePlane p).Colorable k`** instead, through `finitePlane_forces_eq`. So G48's tightness mechanism no longer fires only where somebody has solved a plane; it fires wherever a colouring is known, and a colouring is the cheap half. **And the same theorems now exist over any field in which `−1` is not a square** (`..._of_not_isSquare_neg_one`, `LocalGlobal.lean`), so the odd-degree face of the sieve — `UD(𝔽₂₇, 2)`, Haugland's cubic field — is expressible in the kernel for the first time.

### 2.3 Grokking G47 — reading (i) is promoted, and its falsifier retired **for one half**

Find, in G47:

> Readings on top, falsifiable: (i) every finite Euclidean plane is pairwise free at its own chromatic number (four instances; falsifier: a 5-chromatic plane among 23–47 with a non-unit class separated by every 5-colouring, or a 6-chromatic plane at 59+ with a compulsion at six — FS-13/FS-15's planes would show it)

Replace with:

> Readings on top: (i) **PROMOTED TO [kernel] 2026-09-09 in its FORCED-PAIR half, and generalized past the four instances that suggested it** — `PlaneRotation.finitePlane_forces_iff` proves that at every prime `p ≡ 3 (mod 4)`, at every colour count the plane admits, no two distinct points are forced to share a colour; the four measurements at 3, 7, 11, 19 are now corollaries (`Instances/PlaneFreedom.lean`). The registered falsifier is retired on that half: no plane at any prime can carry a forced pair, whatever its chromatic number, so long as it is colourable at all. **The VIRTUAL-EDGE half is untouched and keeps its falsifier**: whether every non-unit class is separated by some proper colouring (`Separated`/`CoincidesAtNonedges`) is a different property of a colouring table and is not proved here at any prime beyond the four. **And a boundary the four instances hid**: the theorem covers prime fields only — over `𝔽_{p^n}` with `n > 1` the argument's basis step fails, because an additive subgroup there is a subspace over the *prime* field and two vectors span only two of its `2n` dimensions.

### 2.4 Grokking G30's sixth failure mode — one more instance, and it is a *plan's* instance

Append to the sixth failure mode (*a CORRECT INSTANCE recorded where a THEOREM was available*):

> **A fifteenth instance, and it closed the same day it was minted (2026-09-09, package P4).** The record's *"the sealing planes at 3, 7, 11, 19 are ALL pairwise free"* is four tables where one rotation argument covers every prime. Two things are worth keeping from how it closed. **First, the plan that named it over-specified the proof**: `plans/STUB-explain-the-unexplained.md` §E1 set out five steps whose fourth was an orbit–stabiliser count over the `(p+1)/2` circle-missing lines — correct, numerically verified, and **unnecessary**, because the argument needs one rotation that moves the period line rather than a transitive action on all of them. A derivation written down before it is formalized can carry incidental structure exactly as a measurement can. **Second, the theorem it produced was one hypothesis away from being vacuous** — `Forces` is true of every pair on a graph with no proper colouring — which is the fifth failure mode waiting inside the sixth; the shipped counterexample at `p = 3, k = 2` is what keeps them apart.

### 2.5 Novel-results ledger — a new row (numbering is the coordinator's; drafted as row 60)

> | 60 | **Rotations of the quadrance plane, and the freedom they force** (2026-09-09, consolidation package P4; all on axioms exactly the standard three). **The general layer, over any commutative ring**: rotation by a circle point `a² + b² = 1` is an additive automorphism preserving quadrance (`rotEquiv`, `quadrance_rotMap`) and hence an automorphism of the plane (`rotHom`); the **quarter turn** `(x, y) ↦ (−y, x)` is its instance at `(0, 1)` and needs no hypothesis at all (`quarterTurn`, `quarterTurnHom`). **The field layer**: over any field in which `−1` is not a square, a nonzero vector and its quarter turn are a **basis** (`exists_smul_quarterTurn_eq`) — pure linear algebra, and the only place the plane's arithmetic enters. **The theorem**: over `ZMod p` with `p ≡ 3 (mod 4)`, a proper colouring is never periodic at both a nonzero `d` and its quarter turn (`not_periodic_quarterTurn`), so no nonzero `d` is a period of every colouring (`exists_not_periodic`), so — through M61's own `Forces.eq_of_forall_exists_not_periodic`, which was minted with no general supplier — **`Forces (finitePlane p) k x y ↔ x = y` whenever the plane is `k`-colourable** (`finitePlane_forces_iff`, `finitePlane_forces_eq`). **The consumer**: G48's tightness mechanism with its per-prime table hypothesis replaced by colourability (`Forces.{no_hom,isEmpty_ringHom}_of_spindle_radicand_of_colorable`). **The guard**: `Forces` is vacuously true on a graph refusing `k` colours, so the colourability hypothesis is necessary — `finitePlane3_not_colorable_two` and a distinct vacuously-forced pair ship beside the positive inhabitant `finitePlane3_colorable_three`. **The instances**: `Instances/PlaneFreedom.lean` re-derives ledger row 55's four measured primes 3, 7, 11, 19 — with a new certified 4-colouring of `UD(𝔽₇,2)` by the periodic-quotient recipe (the line through `(1,2)` has non-square quadrance `5`) — and cross-checks M60's and M61's table-based theorems at 11 and 3, which stand. **Also, FS-24 G3**: `LocalGlobal.lean`'s five spindle theorems gain field-level forms taking `¬ IsSquare (-1 : K)` (`..._of_not_isSquare_neg_one`), the `ZMod` statements kept verbatim as one-line corollaries, so `UD(𝔽_{p^n}, 2)` is expressible there for the first time. **Boundary, stated exactly**: prime fields only — over `𝔽_{p^n}`, `n > 1`, an additive subgroup is a subspace over the *prime* field, so `d` and its quarter turn span two of `2n` dimensions; the repair (the period set contains `r·d` for every norm-one `r`, its span is a subfield of `𝔽_{q²}` with more than `q` elements, hence everything) needs `𝔽_{q²}` as a field containing `𝔽_q` with its norm form identified, and is not attempted. **Prior art**: the objects are `[Vinh2005]`, `[Vinh2006]`, `[MedranoEtAl1996]`, `[Krebs2022]`, all held; the rotations-are-automorphisms half is classical (M61 already used arc-transitivity); no source found states the freeness, and the adjacent classical theory — uniquely colourable Cayley graphs — is its opposite extreme. | `Proofs/HadwigerNelson/{PlaneRotation,LocalGlobal}.lean`, `Proofs/HadwigerNelson/Instances/PlaneFreedom.lean`, `plans/P4-generalize-and-plane-freedom.md` | 2026-09-09 |

### 2.6 A correction to FS-25's own headline, for whoever re-ranks the frontier set

`plans/STUB-explain-the-unexplained.md` §E1 is titled *"Every finite Euclidean plane is forced-pair-free,
at every prime and every colour count."* **Both halves of that are too strong** and the stub's own body
does not carry the qualifications: planes at `p ≡ 1 (mod 4)` are finite Euclidean planes and are not
covered, and at a colour count the plane cannot achieve the statement is false (vacuously true, in the
unhelpful direction). I marked the section CLOSED with the corrected statement rather than rewriting the
title, to keep the conflict surface small.

---

## 3. Bibliography additions (`BIBLIOGRAPHY.md` is owned by P1 this round)

Two works, both **adjacent theory, read at abstract level only** — neither is prior art for anything
here, and both are recorded so a future prior-art gate does not re-find them cold:

* **`[LiuEtAlUCC]`** — *Uniquely colorable Cayley graphs*, Ars Mathematica Contemporanea. Establishes
  that for a uniquely colourable Cayley graph over a group `Γ`, `χ` divides `|Γ|` and each colour class
  is a coset of a subgroup of order `|Γ|/χ`. **Role here: the opposite extreme.** A uniquely colourable
  graph has forced pairs in abundance; P4 proves the finite Euclidean planes have none. Not obtained;
  known from the journal listing and a summary. *Read: abstract only.*
* **`[UCC2026]`** — *On uniquely colorable Cayley graphs*, arXiv:2609.03184 (September 2026). Resolves
  two open problems on unique colourability, including an infinite family of uniquely 3-colourable
  integral circulant graphs with clique number 2. **Fetched and read (abstract + results summary) on
  2026-09-09: contains nothing about forced pairs, period groups of colourings, or finite Euclidean
  graphs.** Recorded because it is the most recent work in the nearest neighbourhood.

---

## 4. What I did NOT do, and why

1. **`𝔽_{p^n}` for `n > 1` is not proved.** The boundary is stated exactly in the module's own docstring
   and in §2.5 above, together with the repair. It is a real construction (the plane here is `R × R`;
   the argument needs `𝔽_{q²}` as a field with `𝔽_q` inside and the norm form identified), not a
   re-indentation, and it is days rather than hours. **This is the honest outcome the task prompt
   anticipated** — except that the step which resisted was not the plan's step 4 (which turned out
   unnecessary) but the scalar-closure of periods, which the plan did not flag at all.
2. **The `Separated` half is untouched.** Whether every non-unit class of a finite Euclidean plane is
   separated by some proper colouring (M60's `CoincidesAtNonedges`) is a different property of a
   colouring table, and I have no argument for it. The record's instances there stay instances. G47's
   falsifier on that half stays live, and §2.3 says so.
3. **`three_le_arityFloor_of_aperiodic_coincides` was not decomposed.** M60 packages it as *one table
   with both properties*, so my `Forces` theorem cannot feed it and the arity-floor bound at a general
   prime does not follow. Decomposing it into a `Forces` half and a `Separated` half is perhaps ten
   lines in `ResidueObstruction.lean`, but nothing asks for it yet, so I did not build it.
4. **`Instances/ResidueObstruction11.lean` was not edited.** Its `finitePlane11_forces_iff` is now a
   corollary of the general theorem; I cross-check the two in `Instances/PlaneFreedom.lean` instead of
   rewriting an existing instance file another package might touch.
5. **The `p ≡ 1 (mod 4)` numerical mutation audit did not finish.** I wanted to know whether the
   *conclusion* also fails there or only the *argument*. Two brute-force attempts were killed at their
   caps (300 s and 110 s) on `p = 5, 13`; I did not spend more. What I do have is structural and is
   recorded: at `p ≡ 1 (mod 4)` an isotropic `d` has `quarterTurn d = −i·d` **collinear with `d`**, so
   step 3 provably fails, and a colouring periodic along that line genuinely exists. Whether some other
   argument covers those primes is **open and not claimed either way**.

---

## 5. Things another package owns

* **`scripts/Axioms.lean` — I appended 20 lines** (a P4 section immediately before the
  `=== PURCHASED ===` banner). The clean count rose 725 → 745; the purchase count is **unchanged at 5**.
  If several packages appended there the merges are independent hunks, but the coordinator should
  re-run `./scripts/axioms.sh` after merging and confirm the purchase count is still exactly 5.
* **`Proofs.lean`** gained two import lines, immediately after
  `import Proofs.HadwigerNelson.Instances.LocalGlobal19`.
* **`plans/STUB-generalize-the-kernel.md` and `plans/STUB-explain-the-unexplained.md`** each gained one
  short CLOSED marker, inserted directly under the `### G3` and `### E1` headings. Other packages close
  other items in the same two files; the hunks are far apart and should merge cleanly.
* **`ARCHITECTURE.md` was not touched.** It carries a module DAG and a § Trust section; the two new
  modules (`PlaneRotation.lean`, `Instances/PlaneFreedom.lean`) should be added to the DAG by whoever
  owns that file. Neither adds a trust purchase, so § Trust does not move.
