# FS-70 — five colours over ℚ(√3,√5): the conjecture's last meetable prediction, and forcing five without the Moser spindle

*Minted 2026-09-21 by the product owner of FS-66, at Kooshi's choice for the next milestone ("Let's jump to 3,5 at 5 colors. That
does sound interesting"), over FS-59's R9, which is deferred, not dropped. Written for a reader with no conversation memory: the next
session subplans this from here (WORKFLOW 3 and 3a), with the standing rules of `plans/SESSION-HANDOFF-2026-09-20.md` §0. Read
beside: `CLAUDE.md` § Notation, G48 (the conjecture), G55 (the chain theorem), G57 (no window field holds a Moser spindle), G7 and
G62 (the type-M rotation family), G31 (a χ ≥ 6 gadget must be constructed), rows 64–66; `plans/STUB-biquadratic-table.md` (FS-48,
whose open case this is); `plans/STUB-chain-theorem.md` (FS-45); `plans/M63-phaseH2-the-family.md`, `plans/M63-phaseH3-plan.md`
(the arena machinery and why dropping the coordinate shape at n = 2 died); `reference/ChatGPT-local-global-tightness-conjecture/`.*

## 1. The question, in plain language

The local–global conjecture says a number field's plane needs exactly as many colours as its best finite residue plane allows,
wherever that allowance is at most six. It is proved for every field with allowance ≤ 3, for every field containing √3 with
allowance ≤ 4, and for every multiquadratic field containing K = ℚ(√3,√11) with allowance ≤ 5 (G55). **ℚ(√3,√5) is the smallest field
outside the proved range where the allowance is five**: its usable residue planes are 11, 59, 71 (5 at 11; ≥ 6 from 59 up), and its
2-adic wall is broken (15 ≡ 7 (mod 8)), so nothing at 2 helps. Four colours are proved there by an explicit six-rhombus chain
(FS-48: `u = (−2 + i√5)/3` is a unit vector with `1 + u + ū = −1/3`). So the record reads **χ(ℚ(√3,√5)²) ∈ {4, 5}, predicted 5.**

> **Is there a finite unit-distance graph with coordinates in ℚ(√3,√5) that cannot be four-coloured?**

Every five-chromatic unit-distance graph this project holds or has reproduced is built from Moser spindles: rhombi (which need √3)
twisted by cos θ = 5/6 (which needs √11). **ℚ(√3,√5) has the rhombi and not the twist** — no Moser spindle can be drawn in it (G57's
one-direction transfer). So a refusal here is a five-chromatic graph of a kind this project has never built, in a field where the
conjecture makes a prediction it has never met with an object.

## 2. Why this milestone, stated so it can be pushed back on

* **It is the last band where the conjecture's main clause can be met by an object.** L ≤ 4 with √3 is proved; L ≤ 5 over K is proved;
  L = 6 has no instance if the wall holds; L ≥ 7 is the problem itself. ℚ(√3,√5) at L = 5 is what is left, and its sibling cases
  (ℚ(√3,√23), ℚ(√3,√47), also L = 5 and wall-broken) follow the same route once one lands.
* **It builds the vocabulary the hunt for six needs.** The window fields — the only fields whose allowance could be six — admit no
  Moser spindle (G57). Learning to force a fifth colour without one is the prerequisite for any sixth-colour construction that is
  not "search thick fabric and hope" (G31). This milestone does that in the easiest field that has the rhombi.
* **Its failure is informative and typed.** A five-forcer not found at a stated budget is a null about the instruments; a proof that
  none exists is not on offer. But the conjecture's *prediction* is what is being met or not, and the record says which.
* **What it is not:** it bears on χ(ℝ²) ≥ 6 only through the vocabulary; the programme's honest bearing line is "mechanism, high;
  the sixth colour, indirect".

## 3. What is known, with grades

* **[hand, exact]** `L(ℚ(√3,√5)) = 5`: usable primes below 84 are 11, 59, 71 (p ≡ 3 (mod 4) with 3 and 5 both squares); 7 is not usable
  (3 is a non-square), so no plane gives 4; the 2-adic wall is broken (the odd square classes are 1, 3, 5, 15 and 15 ≡ 7 (mod 8)), so
  the dyadic bound gives nothing. `χ ≥ 4` by the FS-48 chain. Under the conjecture, `χ = 5`.
* **[hand, G55]** The wall is broken, so `1/2 ∈ ℤ[U]` — **a pair forced equal at four colours at distance 2 (or at any δ with
  `1/δ ∈ ℤ[U]`) gives χ ≥ 5 by the chain theorem inside the field**, with two copies for δ = 2 (the spindle case) — and the type-M
  rotation `ρ₁₅ = (7 + i√15)/8` (`n = 4`, spindle distance 2, the 509-record's rotation) lies in ℚ(√3,√5) because √15 = √3·√5. So the
  design target is **four-colour forcing fabric over ℚ(√3,√5) with a forced pair at distance 2**, then ρ₁₅.
* **[measured, M63]** The only four-colour forced pairs this project has produced live over K (M56's 8/3 forcer, 588 vertices, one
  solver refusal; the 791-point de Grey core's six pairs at 4 and 4/√3) and every one uses √11. Over ℚ(√3,√5) nothing of the kind has
  been asked. The residue colouring that kills four-colour forced pairs over K (Theorem B) does not exist here (the wall is broken),
  so nothing forbids them by theorem.
* **[measured, M63 phase H3]** Dropping Parts's coordinate shape at `n = 2` gave a base four-colourable at every radius by an additive
  route that is dead exactly when `4 ∤ n`; `n = 4` is `4 | n` and immune to that route — but Parts's shaped lattice at `n = 4` needs
  √11 (its base is the Moser lattice). A shape-free base over ℚ(√3,√5) at `n = 4` — the ℤ-span of the field's small unit vectors, with
  its ρ₁₅-rotated copy — has never been built.
* **[read, the owner's gate of 2026-09-21 — `data/fs70/owner/gate-2026-09-21-fields.md`]** The known Moser-spindle-free
  five-chromatic graphs do **not** lie in ℚ(√3,√5): `[Voronov2021]`'s series-2 graphs (64,513 vertices) lie in **ℚ(√2,√3,√5)** — the
  base is generated by ζ₂₄ and (√6 + i√3)/3, so √2 is in every base point (his Prop. 5) — and `[Haugland2026]`'s 2,131-vertex graph in
  **ℚ(ζ₈₄)⁺(√5)**, degree 24 (cos(π/21) and cos(π/7) in the fabric). **In both, √5 enters only through the closing rotation ρ₁₅ =
  (7 + i√15)/8** — the stub's target rotation, the type-M spindle at distance 2. A third Moser-free forcer, Heule's 1,441-vertex graph
  (`[Heule2021]`, known from the zbMATH review; paper not held, loan priority raised), has no field on record; the owner's unverified
  reading is a trim of Voronov's, hence ℚ(√2,√3,√5). **So the conjecture's prediction at ℚ(√3,√5) is unmet by anything in print, and the
  question stands as posed.** What the papers hand over instead is the mechanism: Haugland's §3 makes `(0,0)` and `(0,√3)` a four-colour
  virtual edge with 740 points, then two ±π/3 copies leave `(−1,0), (1,0)` the one unconstrained pair among five points — forced equal —
  and ρ₁₅ closes; steps two and three need only √3 and √15, which ℚ(√3,√5) has. **FS-70's first ask is therefore the √3 virtual edge:
  is there a finite ℚ(√3,√5)-graph in which `0` and `i√3` cannot share a colour at four colours?** A refusal closes the milestone by hand.

## 4. Routes, cheapest first (the subplan chooses; price each before committing)

1. **The prior-art gate and the field computation** (WORKFLOW 3a; a morning): the two Moser-free papers' coordinate fields; zbMATH and
   arXiv in the discipline's words (*five-chromatic unit-distance graph without Moser spindle*, *chromatic number of the plane over a
   biquadratic field*, *unit distance graph number field coordinates*); the poser's listing rule (item 8) for Voronov, Haugland, Parts.
2. **The direct ask, before any finder** (G66's lesson), **in Haugland's shape**: saturate a lattice of ℚ(√3,√5)'s small-denominator
   unit vectors (FS-61's `tools/fs61_census.py` machinery does exactly this for real quadratic fields; the field here is biquadratic —
   extend, or take the √3-rhombus lattice with the √5 vectors adjoined), take the fabric of unit-vector paths of length ≤ n between
   `A = 0` and `B = i√3` (his `T_n`; G65's degree law aims n), **pin `A` and `B` to one colour, ask four colours** with a precedence
   constraint. A refusal is the √3 virtual edge and the milestone's headline (two ±π/3 copies, the five-point pigeonhole, one ρ₁₅ copy and
   an edge finish it by hand); a colouring is the fabric for route 3. Beside it, the triangle-pinned ask of the same ball is the
   control that says whether the fabric four-colours at all. **Cheaper still, a screen before either** (his §4, G41): does the
   lattice admit an *additive* four-colouring — a homomorphism to (ℤ/2)² or ℤ/4 nonzero on every unit vector? None means every
   four-colouring of thick fabric is non-additive, which is where compulsions live; one means the fabric is coloured for free at
   every radius and the ask must grow the vector set, not the ball.
3. **The forced-pair dial at four colours** (`tools/five_dial.py`, `tools/fpcompel.py` lineage; M49–M50's instruments): on the coloured
   fabric, sweep for pairs at distance 2 (and at every δ with `1/δ ∈ ℤ[U]` — 1, 2, 4/3, … — the chain theorem's list) forced equal in
   every four-colouring. One forced pair at distance 2 + ρ₁₅ (two copies and an edge) is the theorem; a forced pair at another usable δ
   needs `m` copies. This is exactly M56's 8/3 forcer's shape, one field over.
4. **The type-M arena at n = 4 over a shape-free ℚ(√3,√5) base** (M63's `Arena` machinery with the base swapped): the ρ₁₅ bilayer,
   asked at four colours with the counting compulsion (G53) as the screen before any solve.
5. **If a refusal lands:** shrink to a 1-minimal core (`tools/fs66_minimise.py` lineage), certify exactly (the FS-58/61 checker
   pattern: an independent standard-library checker with its own LRAT replay and planted faults, over `Adjoin`-style coordinates —
   FS-60's certificate type is the missing piece and this is its first biquadratic consumer), and price the kernel form through the
   `UDCert` pipeline (K(√5) = Heule's field already has a certificate type: `Instances/Core122*`; the √11-free sub-case is what is needed).

## 5. Deliverables

* §PA with the two papers' fields settled and the negative or positive recorded.
* Either **a certified five-chromatic unit-distance graph over ℚ(√3,√5)** (exact coordinates, an independent checker, the kernel
  form priced or landed: `five_le_chromaticNumber_planeOver (fieldOfRadicands {3, 5})` would be the first kernel five outside K's
  towers) — **or a typed null**: every instrument's budget, the fabric's four-colouring, the forced-pair sweep's zero with its
  population, and what the null does and does not say.
* The ledger row, the grokking if there is understanding to record (what forces five without a spindle, or why the field's
  vocabulary is too poor), and the re-aim of FS-48's siblings (√23, √47) from the result.

## 6. Bearing on χ(ℝ²) ≥ 6, stated honestly

**None directly.** High on mechanism (the conjecture met or missed at its last meetable band; the first spindle-free five-forcer built
here), and indirect on six through vocabulary — a five-forcer that needs no Moser spindle is the first construction that could have a
window-field analogue. A null leaves the conjecture untested at L = 5 outside K's multiquadratic extensions.

## 7. Failure and jackpot clauses, and registered expectations

*Failure:* the direct ask colours at every affordable degree, the forced-pair sweep reads zero, and the arena four-colours — a typed
null; the conjecture at ℚ(√3,√5) stays untested and the record says the instruments, not the field, were the wall. *Jackpot:* a
refusal at four colours in the direct ask (headline in a day); or a four-colour forced pair at distance 2 (the chain does the rest by
hand). *Registered expectations (owner, 2026-09-21):* (E1) neither Moser-free paper's graph lies in ℚ(√3,√5) — confidence medium
(Haugland's fabric is heptagonal; Voronov's seeds unknown) — **MET the same evening, by reading both papers** (Voronov: ℚ(√2,√3,√5);
Haugland: ℚ(ζ₈₄)⁺(√5); Heule's 1,441 open, paper not held); (E2) the direct ask at degree ≤ 20 colours — confidence medium-high
(the field's small unit vectors are few; FS-61's degree law); (E3) a four-colour forced pair at distance 2 exists in a saturated
ball of radius ≤ 3 — confidence low-medium (nothing forbids it, nothing has ever been asked); (E4) if a five-forcer lands it is
larger than 509 vertices at first — confidence high.
