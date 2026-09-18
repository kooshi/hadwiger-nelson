# FS-64 — the adelic window colouring: a ceiling instrument that uses more than one place

*Minted 2026-09-17, from the observation (G64) that six can only hide in the gap between `L(F)` and `χ(F²)`, and that every ceiling
instrument this project owns goes silent exactly there. Read beside: `CLAUDE.md` G60 (the fractional route and its cap), G62 (the
Moiré frame — an incommensurate bilayer is a projection of something periodic upstairs), G64, row 72 (the 3-adic barrier),
`plans/STUB-four-colours-167.md` (FS-59), `plans/STUB-moire-coincidence.md` (FS-63, which shares this stub's literature sweep).*

---

## 1. The gap this is for

Every upper bound this project has ever proved over a field uses **exactly one place**:

| instrument | the place it uses | what it ignores |
|---|---|---|
| the residue colouring (Theorem A, rows 52–57) | one non-archimedean place — `F² → (O/𝔭)²` | the geometry entirely |
| the additive colouring (row 50, G41) | a congruence, i.e. again a non-archimedean quotient | the geometry entirely |
| the hexagonal 7-colouring (row 33) | the archimedean place — position in `ℝ²/L` | the arithmetic entirely |

For a field with no usable small prime — `ℚ(√167)` first, and every field the conjecture predicts to be seven — the
non-archimedean instruments say nothing below 7, and the archimedean one says exactly 7. **So the interval `[3, 7]` over
`ℚ(√167)` has never been attacked from the ceiling side by anything but the hexagonal tiling, which is a bound on all of `ℝ²` and
knows nothing about the field.**

**The proposal: colour the product.** Both existing instruments are the same move — map `F²` into a **compact** group and colour
that. The residue colouring's target is `(O_𝔭/𝔭^m)²`; the hexagonal colouring's is a torus `ℝ²/L`. Nobody has taken the target to
be

> `(ℝ²/L) × (O_𝔭/𝔭^m)²`

with colour classes that are **not products** — thin in one factor where they are thick in the other. That is exactly the
cut-and-project / model-set construction, which is the rigorous form of the Moiré picture G62 records: an incommensurate bilayer is
the shadow of something periodic in a higher-dimensional space, and for a number field that space is the Minkowski embedding
crossed with the relevant `p`-adic completion.

**And the barrier names the place.** Row 72: over `ℚ(√d)` with `d ≡ 2 (mod 3)`, directions integral at 3 are 3-colourable outright,
so every witness needs a direction with 3 in its denominator. The interesting structure sits at `p = 3`, so the natural object is
the ring of `S`-integers for `S = {∞₁, ∞₂, 3}`, which embeds as a genuine lattice in `ℝ² × ℝ² × ℚ₃²`.

---

## 2. The first ask, with its controls

**The question, made finite.** Fix `F`, a real tiling scale, and a 3-adic level `m`. Ask whether the compact target admits a
partition into `k` classes such that no two points differing by a unit vector share a class. Discretised (a fine tiling of the
torus, a finite level `m`), this is a finite constraint problem — SAT or ILP — of exactly the shape this project already solves.

**Run the corners first, because both answers are known:**

| control | expected | what a wrong answer means |
|---|---|---|
| ignore the real factor over `ℚ(√3,√11)` | **4** (Theorem B, row 57) | the encoding is wrong |
| ignore the 3-adic factor, over anything | **7** (row 33's brick/torus certificate) | the encoding is wrong |
| the product, over `ℚ(√3,√11)` | `≤ 4` | if it reads worse than 4, the mixed encoding is losing information the pure one keeps |

**Then the target:** over `ℚ(√167)`, whose bracket is currently `3 ≤ χ ≤ 7` (the ceiling from the hexagonal colouring, and `≤ 8`
from `colorable_finitePlane23_eight` through the usable plane at 23), **does any mixed colouring reach 6 or 5?**

**Any improvement on 7 there is new.** A 6 would be the first field with `χ(F²) = 6` if its floor can be raised to 6 — which is
FS-56's prediction and FS-59's target — and would kill FS-62's dichotomy. A 5 would refute the conjecture's main clause at the
field the conjecture is sharpest about. **Both outcomes are findings**, which is the property that makes this worth building.

---

## 3. Honest assessment

**Confidence this produces anything: low.** Three specific reasons to doubt, each stated so it can be checked early:

1. **It may be a reparametrisation.** If every mixed colouring that works turns out to factor through one place, the instrument is
   the existing two in new clothes. **Cheapest test of this: does the product encoding ever beat both corners on any field where
   we know the answer?** If it never does on the controls, stop.
2. **The unit vectors are dense in the real factor.** Every colour class must avoid all of them. Density is not by itself fatal —
   the residue colouring's classes are dense too and work because the unit vectors miss a subgroup — but it means the real factor
   contributes nothing unless the class has genuine thickness, and thickness is what costs colours.
3. **There may be a cap, as there is for the fractional route.** G60 found the fractional instrument capped by every usable residue
   plane's `χ_f`, so it can never prove more than five. **Derive the analogous cap before building anything** — if a mixed
   colouring is bounded below by something the usable planes already give, the instrument is dead on arrival and the derivation is
   an afternoon.

**Item 3 is the first thing to do.** It is a derivation, not a search, and it either kills the stub cheaply or tells us what the
instrument can reach.

---

## 4. Prior art owed (WORKFLOW 3a) — shared with FS-63

In the discipline's words, never ours:

* **Aperiodic order**: *model set*, *cut-and-project scheme*, *internal space*, *window*, *Meyer set*, *Delone set*. **Has anyone
  coloured a model set to avoid a distance?** The Hadwiger–Nelson question for quasicrystals is the natural phrasing.
* **S-arithmetic / adelic**: *adelic quotient*, *solenoid*, *S-integer lattice*, colourings or independent sets in Cayley graphs of
  `S`-arithmetic groups.
* **The distance-graph literature on ℚⁿ and on rings**: Benda–Perles, Johnson, Chow — does anyone combine places?
* **Bachoc et al.** (`[BachocEtAl2014]`, held as abstract only) for the operator-theoretic framing of colourings of infinite
  geometric graphs; its `L²` setting over a compact group is close to this target and the row owes a reading.

A negative is a finding and goes in §PA.

---

## 5. Where this sits

**Bearing on χ ≥ 6: it is the only ceiling instrument that could decide the value-6 question.** G64 proves six can hide nowhere but
the gap between `L(F)` and `χ(F²)`; closing that gap from above is exactly what this would do, and nothing else we own points
there. It is also the only stub in the set whose *success* would refute FS-62's dichotomy rather than support it — which is the
right relationship between the two, and the reason both are worth holding.
