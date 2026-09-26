# FS-64 — the adelic window colouring: a ceiling instrument that uses more than one place

**At row 88's close (2026-09-25; `LEDGER.md` rows 111–113).** At four colours over the type-(B) fields, every translation-invariant random four-colouring whose spectrum is carried by `T + A + Fin_S`, `S` finite, is a pullback from the tight place (row 112, extending row 92 from windows to invariant measures of that spectral type), and over ℚ(√47) none exists (row 113); the four-colour remainder is spectra reading infinitely many split places (FS-97) and transient colourings (FS-98). **Carried here, post-ban and Kooshi's call:** the row-88 plan's stage Y2 — `χ_f(ℚ(√59)²)` by an exact LP on layered configurations a derivation fixes first, its dual read back as an identity (`plans/FS86-row88-rigidity.md` §S.3). The five-colour aim at ℚ(√167) is untouched (the count needs every non-tight ratio below `1/k`, and at five the real place's `m₁` exceeds `1/5`, row 92).


**Re-aimed at FS-91's close.** A single character needs eight colours over ℚ(√167) given CLG_7 (row 101), so the one-place, windowless case is closed at five, six and seven; the mixed window — several places, non-linear readings — is the whole remaining question.

**At M3's close (2026-09-25):** at five colours over ℚ(√167) no window reads a finite set of places with no real place and none above 43; thick places are invisible, so every window question reduces to `S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}`; with a real place and only thick finite places it is `χ_B(ℝ²) ≤ 5`. `plans/M3-derivation.md` §5–§6; `LEDGER.md` rows 109, next+2; follow-on FS-96 (`plans/STUB-windows-five-nonmixing.md`).

**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):** G77 (the one-place, windowless case is a character colouring: existence only, row 100) and G76's five-colour mixing sentence (row 110).

**At FS-89's close (2026-09-25):** this stub's one-place, windowless case — one character colouring the whole field (FS-83) — is closed at both exposed fields: no character four-colours ℚ(√47)'s plane and none five-colours ℚ(√167)'s (`LEDGER.md` row 96), since every four- and five-colour band character of a real field is torsion plus archimedean (row 95). With FS-86's row 92 (measurable windows over finitely many places cannot four-colour a type-(B) plane non-periodically), what is left of the five-colour aim over ℚ(√167) is a window colouring over **several** places that is not a character; it is untouched.

**Re-aimed at FS-86's close (2026-09-25):** with any finite set of places and measurable windows it cannot four-colour a type-(B) plane non-periodically (row 92, C14), and over type (A) no such four-colouring exists (FS86-CL1); the five-colour aim at ℚ(√167) is untouched.

> **Routed here at FS-81's close (2026-09-24; close inventory items 12, 18): the plan-phase advisor's one-character question.** Can one
> character of the unit-vector ring `ℤ[U_F]` put every unit vector of a whole field in `[1/k, 1 − 1/k]`? That is a colouring of the whole
> plane local at no prime when its archimedean part is nonzero — this stub's target in its simplest form (one place, no window). At
> `k = 5` over ℚ(√167) a yes falsifies the conjecture; at `k = 4` over ℚ(√47), its five-clause. FS-81's layer method (G74) is the tool,
> and the question now has its own stub, **FS-83** (`plans/STUB-layer-method-five-colours.md`); this stub keeps the mixed-place
> construction (ℝ² × ℝ² × ℚ₃²) of which a character colouring is the degenerate case.

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

**Two configurations, and they differ in kind — run both.**

| | non-archimedean factor | what it contributes alone | why cross it with a real window |
|---|---|---|---|
| **(i) the usable prime, 23** | `F² → UD(𝔽₂₃,2)`, a genuine graph homomorphism | a real bound, `χ ≤ 8` (kernel), `≤ 7` if 23's plane is seven-chromatic | the homomorphism is surjective and throws away *all* geometry; a real window could distinguish points the residue map fuses, letting a colour class be re-used across residue classes that the plane forces apart |
| **(ii) the barrier prime, 3** | **no bound at all** — 167 ≡ 2 (mod 3), so the residue field is `𝔽₉` and 3 is **not usable** | nothing on its own; row 72's barrier only 3-colours the directions integral at 3 | precisely because it is not usable, the 3-adic coordinate is *unused information*: the barrier says every witness must have 3 in a denominator, so the 3-adic coordinate is where the hard directions live and is free to carry colour structure |

**(ii) is the more interesting and the more speculative.** (i) asks whether geometry can improve a bound the arithmetic already
gives; (ii) asks whether a place that gives no bound at all can still carry part of a colouring. **A place that bounds nothing is
not the same as a place that says nothing**, and no instrument here has ever used one.

**Any improvement on 7 there is new.** A 6 would be the first field with `χ(F²) = 6` if its floor can be raised to 6 — which is
FS-56's prediction and FS-59's target — a six-chromatic field with `L ≥ 7`, which refutes the conjecture's bold form and FS-62's
value-omission statement at once. A 5 would refute the conjecture's main clause at the
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

### 3a. A first pass at item 3 — [sketch, 2026-09-19, UNVERIFIED; recorded so it is not lost, not so it is believed]

*Made in passing during a ranking review, in about ten minutes, with no search and no computation. Every step below is owed a check
before anything rests on it.*

**The recognition (G46).** Take configuration (i): a usable prime `𝔭`, target `G = (ℝ²/L) × (O_𝔭/𝔭^m)²`. The image of `F²` is dense
in `G` (each fibre of `F² → (O_𝔭/𝔭^m)²` is dense in `ℝ²`). The unit circle is a rational curve, so by weak approximation at the two
places the unit vectors of `F` are dense in `S¹(ℝ) × C(F_𝔭)`; hence the closure of their image in `G` is the full product
`S̄ × C_m` — the torus's unit circle times the residue plane's connection set, **independently**. So for colour classes that are
*regular* windows (closure of interior, null boundary — the model-set hypothesis, and what this stub proposes), a proper mixed
colouring is exactly a proper open colouring of the **categorical (tensor) product**

> `(torus unit-distance graph) × (residue plane at level m)`.

**What that makes of the instrument.** `χ(A × B) ≤ min(χ(A), χ(B))` always — the two corners. **The mixed colouring beats both
corners iff Hedetniemi's inequality is strict for this pair.** So FS-64 is a search for a Hedetniemi counterexample between a
compact abelian Cayley graph and a finite one — the same object G43/G59 already met for CRT products of two residue planes, with
the archimedean place as one more factor.

**The cap, such as it is.** The only general lower bound is fractional: `χ_f(A × B) = min(χ_f(A), χ_f(B))` (`[Zhu2011]`, finite
graphs; the compact-group form is owed), and `χ_f` of the real factor is at most 4.36 (`[MatolcsiEtAl2025]`'s neighbourhood), so the
cap reads **≥ 5** and no more. *So the stub is not dead on arrival — G60's kind of cap does not kill it — but its success condition
is now named, and it is a strong one:* known Hedetniemi failures (`[Shitov2019]`, `[Tardif2023]`, `[Zhu2025]`) are built from
exponential graphs and look nothing like Cayley graphs of abelian groups; whether the inequality can fail at all in that class is
**the prior-art question this adds to §4**, in those words (*Hedetniemi's conjecture for Cayley graphs / vertex-transitive graphs /
circular and distance graphs*).

**Checks owed, cheapest first.** (1) The density step at a *non-usable* prime — configuration (ii), the barrier prime 3 — is
different in kind: unit vectors with 3 in a denominator leave `O_𝔭²`, the finite level is not a quotient of `F²`, and the target
must be the `S`-arithmetic solenoid; nothing above covers it, and (ii) is the configuration this stub cares most about. (2)
"Regular window" is a real restriction: the residue colouring's own classes are dense and escape this argument entirely, so the
reduction says nothing about non-regular mixed colourings. (3) The corner value `χ` of the torus factor for regular classes is
`6` or `7` (closed-set colourings need six, a classical result — cite before use), which is what makes a strict Hedetniemi gap
necessary for any gain over a seven-chromatic residue plane.

---

## 4. Prior art owed (WORKFLOW 3.2) — shared with FS-63

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
there. It is also the only stub in the set whose *success* would refute the conjecture's bold form rather than support it — which is the
right relationship between an instrument and a belief, and the reason both are worth holding.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M3-exotic-colourings.md` — crunch milestone M3's plan (question 2 is this stub at five colours)
- `plans/M3-S1D-windows-five.md` — job J21's record
- `data/crunch-2026-09-25/briefs/J22-M3-windows-five-verifier.md` — the queued blind verifier's brief (record `plans/M3-S1V-windows-five.md` when it runs)
- `plans/FS91-S1D-six.md` "Proposed edits" — job J08's re-aim of this stub
- `data/crunch-2026-09-25/reports/J06.md`, `J08.md`, `J21.md` — the job reports
- `plans/M3-close-inventory.md` rows 5, 16–26 and `plans/FS91-close-inventory.md` row 85 — items for this stub (row 23 of the first: a stub to mint)
